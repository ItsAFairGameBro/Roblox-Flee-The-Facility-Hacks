local CP = game:GetService("ContentProvider")
local PS = game:GetService("Players")
--[[local RunS = game:GetService("RunService")

local IsStudio = RunS:IsStudio()

local hookfunction = IsStudio and function() return end or hookfunction
local checkcaller,getcallingscript = checkcaller,getcallingscript--]]

local plr = PS.LocalPlayer

local OldRemoteEvent
--local gmatch = string.gmatch

OldRemoteEvent = hookfunction(Instance.new("RemoteEvent").FireServer,function(event,...)
	local arguments = {...}

	if tostring(getcallingscript()) == "BAC_" then
		
		local arg1 = (...)[1]
		if typeof(arg1)=="table" then
			for num, val in pairs(arg1) do
				--print("Key/Val",num,val)
			end
		end
		if tostring(event) == "NewMessage" then--and (typeof(arg1)=="table") then --gmatch(arguments[1],"%u%-%d")()
			print("Prevented BAC_ with",event.Name,...)
			return --error("Nope")
		else
			print("Passed BAC_ with",event.Name,...)
		end
	--[[elseif not checkcaller() and tostring(event) == "WeaponHit" then
		print("Modified Part and Hit")
		local Closest = getClosest()
		arguments[2]["part"] = Closest.Character.Head
		arguments[2]["h"] = Closest.Character.Head
	else
		print("Misc",event,...)--]]
	end

	return OldRemoteEvent(event,unpack(arguments))
end)

local OldPreloadAsync
local Print2 = true

OldPreloadAsync = hookfunction(CP.PreloadAsync,function(CP_2,assets,callerFunction)

	if tostring(getcallingscript()) == "BAC_" then
		if Print2 and typeof(assets[1])=="Instance" then
			Print2 = false
			print("PreloadAsync Instance: "..assets[1]:GetFullName())
		else
			print("Blocked BAC_ from calling",#assets,assets[1]==assets)
		end
		return
	end

	return OldPreloadAsync(CP_2,assets,callerFunction)
end)


--[[function getClosest()
	local closest = nil;
	local distance = math.huge;

	for i, v in pairs(PS:GetPlayers()) do
		if v == PS then continue end
		if v.Team == plr.Team then continue end
		if not v.Character then continue end
		if not v.Character:FindFirstChildOfClass("Humanoid") then continue end

		local d = (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude

		if d < distance then
			distance = d
			closest = v
		end
	end

	return closest
end--]]

print('FlagWars AntiBan V3')
