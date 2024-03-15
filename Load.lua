--SCRIPT GITHUB LINK:
local gitType = "blob"
local scriptName = "Main.lua"
local githubLink = "https://github.com/ItsAFairGameBro/Roblox-Flee-The-Facility-Hacks/%s/main/%s"


--GLOBAL SETTINGS DATA:
GlobalSettings = {
	botModeEnabled = true, -- Whether or not you are using the bots to grind (select accounts only)
	isTeleportingAllowed = true, -- Whether or not teleporting is allowed in the game!
	enHacks = {}, -- The shortcut of the hack and what it defaults to!
	--add more here!
}

local RunS = game:GetService("RunService")
local HS = game:GetService("HttpService")
local RS = game:GetService("ReplicatedStorage")

local PrintName = "[Script Loader]"
local IsStudio = RunS:IsStudio()

local requestCaller = IsStudio and RS:WaitForChild("FakeHttpRequest") or game

local requestFunction = IsStudio and requestCaller.InvokeServer or game.HttpGet

function ReloadFunction()
	local StartTime = os.clock()
	GlobalSettings = GlobalSettings; -- refresh so that all caller functions can see this!
	local URL = githubLink:format(gitType,scriptName);
	local success, response = pcall(requestFunction,requestCaller,URL,false)

	if not success then
		return warn(PrintName.." Error Requesting Script: "..response)
	end
	local success3, codeString
	if gitType=="blob" then
		local success2, decodedJSON = pcall(HS.JSONDecode,HS,response)

		if not success2 then
			return warn(PrintName.." Error Parsing JSON: "..decodedJSON)
		elseif not decodedJSON.payload then
			return warn(PrintName.." Location Error: Payload!")
		elseif not decodedJSON.payload.blob then
			return warn(PrintName.." Location Error: Blob!")
		elseif not decodedJSON.payload.blob.rawLines then
			return warn(PrintName.." Location Error: Raw-Lines!")
		elseif not decodedJSON.payload.blob.displayName then
			return warn(PrintName.." Location Error: Display Name!")
		end

		scriptName = decodedJSON.payload.blob.displayName or scriptName

		success3, codeString = pcall(table.concat, decodedJSON.payload.blob.rawLines, "\n")

		if not success3 then
			return warn(PrintName.." Error Parsing Code: "..codeString)
		end
	elseif gitType=="raw" then
		codeString = response
	end

	local success4, compiledFunction = pcall(loadstring,codeString)

	if not success4 then
		return warn(PrintName.." Error Compiling Code: "..compiledFunction)
	elseif not compiledFunction then
		return warn(PrintName.." Loadstring Failed: Syntax Error!\n\n\t\tCheck Github or DM author!")
	end

	local Callback = compiledFunction()

	print(("%s %s Callback: %s (%.2fs)"):format(PrintName,scriptName,tostring(Callback) or "Exited Mysteriously",os.clock()-StartTime))
end

ReloadFunction()
