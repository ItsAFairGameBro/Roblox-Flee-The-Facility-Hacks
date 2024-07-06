script.Name = "Loading"
local MyTextBox

local PS=game:GetService("Players")
local CS=game:GetService("CollectionService")
local RS=game:GetService("ReplicatedStorage")
local DS=game:GetService("Debris")
local CAS=game:GetService("ContextActionService")
local HS=game:GetService("HttpService")
local UIS=game:GetService("UserInputService")
local RunS=game:GetService("RunService")
local VU=game:GetService('VirtualUser')
local SP=game:GetService("StarterPlayer")
local SG=game:GetService("StarterGui")
local GS=game:GetService("GuiService")
local TS=game:GetService("TweenService")
local LogS=game:GetService("LogService")
local LS=game:GetService("Lighting")
local SC=game:GetService("ScriptContext")
local CP=game:GetService("ContentProvider")
local PathfindingService = game:GetService("PathfindingService")
local TeleportS = game:GetService("TeleportService")
local TCS=game:GetService("TextChatService")
local RF = game:GetService("ReplicatedFirst")

local destroy = RS.Destroy

--[[if game:GetService("ReplicatedStorage").Events.AntiCheatRemotes then
	print("BYE BYE",#game:GetService("ReplicatedStorage").Events.AntiCheatRemotes:GetChildren())
	game:GetService("ReplicatedStorage").Events.AntiCheatRemotes:GetChildren()[1].Parent = script
else
	for num, instance in ipairs(RF:GetChildren()) do
		print("CHILDREN",num,instance.Name)
	end
end--]]

newVector3, newColor3 = Vector3.new, Color3.fromRGB
isStudio=RunS:IsStudio()
--C.functs,C.refreshEnHack = {}, {}

local C={enHacks = {},playerEvents={},objectFuncts={},attributeFuncts={},functs={},refreshEnHack={},
Map=nil,char=nil,Beast=nil,TestPart=nil,ToggleTag=nil,clear=nil,saveIndex=nil,AvailableHacks=nil,ResetEvent=nil,
CommandBarLine=nil,Console=nil,ConsoleButton=nil,PlayerControlModule=nil,textBoxSize=24,isCleared=false,human=nil}
C.PlaceIdsForDebug = {"Bloxburg"}
--local C.Map,C.char,C.Beast,C.TestPart,C.C.ToggleTag,clear,C.saveIndex,C.AvailableHacks,ResetEvent,C.C.C.CommandBarLine,C.Console,C.ConsoleButton,C.PlayerControlModule
--= nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,nil
--C.comma_value=nil
--local clear,C.saveIndex,C.AvailableHacks
C.gameName=((game.PlaceId==1738581510 and "FleeTrade") or (game.PlaceId==893973440 and "FleeMain") 
	or (game.PlaceId==1962086868 and "TowerMain") or (game.PlaceId==3582763398 and "TowerPro")
	or (game.PlaceId==7080389084 and "GlassBridge")
	or (game.PlaceId==5253186791 and "TowerAppeals")
	or (game.PlaceId==16070671286 and "UGCSpin")
	or (game.PlaceId==537413528 and "BuildABoat")
	or (game.PlaceId==15467338598 and "UGCClick")
	or (game.PlaceId==3214114884 and "FlagWars")
	or (game.PlaceId==185655149 and "Bloxburg")
	or (game.PlaceId==2210085102 and "NavalWarefare")
	or "Unknown")
C.gameUniverse=(C.gameName:find("Tower") and "Tower") or (C.gameName:find("Flee") and "Flee") or C.gameName
--C.myTSM,C.mySSM
local plr = PS.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui");
C.isActionProgress=false
local isJumpBeingHeld = false

local lastRunningEnv = getfenv()
local reloadFunction = lastRunningEnv.ReloadFunction--function()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/ItsAFairGameBro/Roblox-Flee-The-Facility-Hacks/main/Load.lua",false))()
--end--
local GlobalSettings = lastRunningEnv.GlobalSettings or {}
local isTeleportingAllowed = GlobalSettings.isTeleportingAllowed~=false
GlobalSettings.MinimumHeight = GlobalSettings.MinimumHeight or 1.5
GlobalSettings.BetterConsole = false
GlobalSettings.AlwaysRefreshModules = false -- Always refreshs Modules on refresh, no caching! May cause errors.

local getID="HackGUI1"
local emojiDesc = {
	["Level"] = "⭐",
	["Money"] = "💰",
	["Heart"] = "❤️",
	["NumberOne"] = "🥇"
}
local defaultOptionsTable = {
	[true]=({
		["Title"]="ENABLED",
		["TextColor"]=Color3.fromRGB(0,255)
	}),
	[false]=({
		["Title"]="DISABLED",
		["TextColor"]=Color3.fromRGB(255)
	})
}
local textFont = Enum.Font.Arial -- fontamento
local textFontBold = Enum.Font.ArialBold -- arialbold
local textFont2 = Enum.Font.SourceSans -- sourcesans
local textFont3 = Enum.Font.Roboto -- roboto
local mainZIndex = 2

--local InstanceFunction = Instance.new
local getscriptfunction = require
local checkcaller = isStudio and (function() return true end) or checkcaller
local getconnections = isStudio and (function(signal) return {} end) or getconnections
local getrenv = isStudio and function() return _G end or getrenv
local getgenv = isStudio and function() return _G end or getgenv
local getsenv = isStudio and (function() return {} end) or getsenv
local loadstring = isStudio and function() return function() end end or loadstring
local getnamecallmethod = isStudio and (function() return "" end) or getnamecallmethod
local getcallingscript = isStudio and (function() return nil end) or getcallingscript
local hookfunction = isStudio and function() return end or hookfunction
local hookmetamethod = isStudio and function() return end or hookmetamethod
local newcclosure = isStudio and function(funct) return funct end or newcclosure
local gethui = isStudio and function() return PlayerGui end or gethui
local firetouchinterest = isStudio and function() return end or firetouchinterest
local fireclickdetector = isStudio and function() return end or fireclickdetector
local getloadedmodules = isStudio and function() return {game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule.ControlModule} end or getloadedmodules
local request = not isStudio and request
local isfolder = not isStudio and isfolder
local readfile = not isStudio and readfile
local isfile = not isStudio and isfile
local makefolder = not isStudio and makefolder
local writefile = not isStudio and writefile

--DEBUG--
local _SETTINGS={
	botModeEnabled=GlobalSettings.botModeEnabled;
	myBots={--has faster default walkspeed for all my bot's and their usernames
		["itsafairgamebro"]=true,
		["molliethetroller"]=true,
		["calorytr"]=true,
		["averynotafkbot3"]=true,
		["suitedforbans"]=true,
		["suitedforbans8"]=true,
		["sonicehecksbro"]=true,
		["sonicehecksbro1"]=true,
		["sonicehecksbro2"]=true,
		["sonicehecksbro3"]=true,
		["sonicehecksbro4"]=true,
		["sonicehecksbro5"]=true,

		["theweirdspook"]=true,
		["lifeisoofs"]=true,
		["lexxy4life"]=true,
		["itsagoodgamebro"]=true,
		["itsagoodgamebros"]=true,
	};
	whitelistedUsers={
		["facilitystorage"]=true,
		["4evernIove"]=true,
		["kitcat4681"]=true,
		["goldenbear25"]=true,
		['biglugger2017']=true,
		['suitedforbans6']=true,
		['suitedforbans11']=true,
	};
	owernshipUsers={
		["suitedforbans3"]=true,
	};
	developerUsers={
		["suitedforbans6"]=true,
		['suiteforbans10']=true,
	},
	MyDefaults = {BotFarmRunner = (GlobalSettings.botModeEnabled and "Freeze")},
	hitBoxesEnabled=((GlobalSettings.botModeEnabled and false) or GlobalSettings.hitBoxesEnabled),
	minSpeedBetweenPCs=18, --minimum time to hack between computers is 6 sec otherwise kick
	absMinTimeBetweenPCs=15, --abs min time to hack, overrides minspeed
	botBeastBreakMin=13.5, --in minutes
	waitForChildTimout = 20,
	max_tpStackSize = 1,
	minTimeBetweenTeleport = .005,
	defaultCharacterWalkSpeed=SP.CharacterWalkSpeed,
	defaultCharacterJumpPower=SP.CharacterJumpPower,
	developer=true,
	ExactCallerName=false,--not working right now, but its CheckCaller before overriding name functions!
}

if not _SETTINGS.myBots[plr.Name:lower()] then
	if not _SETTINGS.botModeEnabled and not GlobalSettings.ForceBotMode then
		_SETTINGS.myBots={};
		_SETTINGS.botModeEnabled = false;
	else
		_SETTINGS.botModeEnabled = true;
	end
end

if not _SETTINGS.developerUsers[plr.Name:lower()] then
	GlobalSettings.BetterConsole = false
	_SETTINGS.developer = false
end

--local NameTagEx,HackGUI


--INTERFACE/GUI CREATION
--local MainListEx,myList,PropertiesEx,Properties,ServerCreditsGained,Main;
--local TextBoxExamples, CreditsGained,ServerXPGained,XPGained;
local GuiElements = {}
C.hackGUIParent = gethui()
--MODULE LOADER
C.Modules = {}
if not getgenv().SavedHttp or GlobalSettings.AlwaysRefreshModules then
	getgenv().SavedHttp = {}
end
function C.LoadModules()
	local ModuleLoaderLink = "https://github.com/ItsAFairGameBro/Roblox-Flee-The-Facility-Hacks/raw/main/Modules/%s"

	local ModuleNames = {"GuiCreation","BetterConsole","DraggableModule","Env","SimplePathfinding","Raycast"}
	if C.gameName == "FleeMain" or C.gameName == "NavalWarefare" then
		table.insert(ModuleNames,C.gameName)
		if C.gameName == "FleeMain" then
			table.insert(ModuleNames,"LocalClubScript")
		end
	end
	if _SETTINGS.developer then
		table.insert(ModuleNames,"Developer")
	end
	local ModulesLoaded = 0
	for num, moduleName in ipairs(ModuleNames) do
		task.spawn(function()
			if isStudio then
				C.Modules[moduleName] = require(script:WaitForChild(moduleName))
			else
				local TheURL = ModuleLoaderLink:format(moduleName)
				if not getgenv().SavedHttp[TheURL] then
					local success, result = pcall(request,{Url=TheURL,Method="GET",Headers={["Cache-Control"]="no-cache"}})
					local failMessage = (not success and result) or (not result.Success and "HttpReq Fail")
					if failMessage then
						warn("FLEEMASTERHACKV1: Failed to load module "..moduleName.." because "..failMessage)
						if C.clear then
							C.clear()
						end
						return
					end
					getgenv().SavedHttp[TheURL] = result.Body
				end
				C.Modules[moduleName] = loadstring(getgenv().SavedHttp[TheURL])()
			end
			--print("✅Module "..moduleName..": "..tostring(C.Modules[moduleName]))
			ModulesLoaded += 1
		end)
	end
	while (ModulesLoaded < #ModuleNames) and not C.isCleared do
		RunS.RenderStepped:Wait()
	end
	if C.isCleared then
		return "Cleared During Module Loading"
	end
end
C.LoadModules()

local function createToggleButton(Toggle, ExTextButton)
	Toggle["AnchorPoint"] = Vector2.new(1, 0);
	Toggle.Position = UDim2.new(1, 0, 0, 0);
	Toggle.Parent = ExTextButton;
	Toggle.BackgroundTransparency = 1;
	Toggle.Font = textFont2;
	Toggle.Name = "Toggle";
	Toggle.TextColor3 = (Color3.new(0, 1, 0));
	Toggle.TextScaled = (true);
	Toggle.TextStrokeTransparency = (0);
	Toggle.TextWrapped = true;
	Toggle.Size = UDim2.new(0.443029076, 0, 1, 0);
end;
C.RichTextEscapeCharacters = {
	{"&","&amp;"},
	{"<","&lt;"},
	{">","&gt;"},
	{'"',"&quot;"},
	{"'","&apos;"},
}
C.DefaultStringEscapeCharacters = {
	{"$","%$"},
	{"%","%%"},
	{"^","%^"},
	{"*","%*"},
	{"(","%("},
	{")","%)"},
	{".","%."},
	{"[","%["},
	{"]","%]"},
	{"+","%+"},
	{"-","%-"},
	{"?","%?"},

}
C.AllowedCameraEnums = {
	[Enum.CameraType.Track] = true,
	[Enum.CameraType.Custom] = true,
}
local camera=workspace:WaitForChild("Camera")
function C.ApplyRichTextEscapeCharacters(str,toEscaped,escapelist)
	local fromIndex = toEscaped and 1 or 2
	local toIndex = toEscaped and 2 or 1
	local format = {IgnoreRichText = true,NoUndoFormat=true}
	for _,escapeData in ipairs(escapelist or C.RichTextEscapeCharacters) do
		str = C.BetterGSub(str,escapeData[fromIndex],escapeData[toIndex],format)
	end
	return str
end
function C.StringStartsWith(tbl,name)
	if name == "" or not name then
		return
	end
	name = name:lower()
	local closestMatch, results = math.huge, {}
	for index, theirValue in pairs(tbl) do
		local itsIndex = tostring((typeof(theirValue)=="table" and theirValue.SortName) or (typeof(index)=="number" and theirValue) or index)
		local canPass = itsIndex:lower():sub(1,name:len()) == name
		if not canPass then
			itsIndex = (typeof(theirValue)=="Instance" and theirValue.ClassName=="Player" and theirValue.DisplayName) or itsIndex
			canPass = itsIndex:lower():sub(1,name:len()) == name
		end
		if canPass then
			if itsIndex:len() < closestMatch then
				closestMatch = itsIndex:len() / (typeof(theirValue)=="table" and theirValue.Priority or 1)
				results = {index,theirValue}
			end
		end
	end
	return table.unpack(results);
end
function C.BetterGSub(orgString,searchString,replacement,settings)
	if not settings or not settings.NoUndoFormat then
		orgString = C.ApplyRichTextEscapeCharacters(orgString,false)
	end
	local lastChars = ""
	local newText = ""
	local totalReplacements = 0
	local canReplace = true
	for s = 1, orgString:len(),1 do
		local char = orgString:sub(s,s)
		if settings and settings.IgnoreRichText then
			if char=="<" and orgString:sub(s+1,s+130):find(">") then
				canReplace = false
			end
		end
		--if canReplace then
		local combined = lastChars..char
		local combinedComparator = (settings and settings.IgnoreCase and combined:lower() or combined)
		if combinedComparator == searchString:sub(1,combined:len()) and canReplace then
			lastChars = combined
			if combinedComparator == searchString then
				if typeof(replacement) == "string" then
					newText..=replacement
				elseif typeof(replacement) == "table" then
					newText..=replacement[1]..combined..replacement[2]
				else
					error("Unknown Replacement '"..replacement.."' for gsub function!");
				end
				lastChars=""
				totalReplacements+=1
			end
		else
			newText..=combined
			lastChars = ""
		end
		--else
		--	newText..=char
		--end
		if char == ">" then
			canReplace = true
		end
	end
	if not settings or not settings.NoUndoFormat then
		newText = C.ApplyRichTextEscapeCharacters(newText,true)
	end
	return newText, totalReplacements
end
function C.CreateSysMessage(message,color,typeText)
	if TCS.ChatVersion == Enum.ChatVersion.TextChatService then
		(TCS:FindFirstChild("RBXGeneral",true) or TCS:FindFirstChildWhichIsA("TextChannel",true)):DisplaySystemMessage(message)
	else
		SG:SetCore("ChatMakeSystemMessage",  { Text = `[{typeText or "Sys"}] {message}`, Color = color or Color3.fromRGB(255), 
			Font = Enum.Font.SourceSansBold, FontSize = Enum.FontSize.Size24 } )
	end
end
local RBXHooks = getgenv().RBXHooks
if not RBXHooks then
	RBXHooks = {}
	getgenv().RBXHooks = RBXHooks
end
function C.Hook(root,method,functName,functData)
	local tblPack,tblUnpack = table.pack,table.unpack

	if not RBXHooks[root] then
		RBXHooks[root] = {}
	end
	if not RBXHooks[root][method] then
		local getnamecallmethod, newcclosure, checkcaller, stringlower = getnamecallmethod, newcclosure, checkcaller, string.lower
		local inPairs = pairs
		--print("New2 Hook",root)
		local myData = {}
		--myData.List = {}
		RBXHooks[root][method] = myData
		--local myData_List = myData.List
		local MethodFunction = (method == "__namecall" or method == "__index") and hookmetamethod or hookfunction
		local OldFunction
		if MethodFunction == hookmetamethod then
			OldFunction = MethodFunction==hookmetamethod and MethodFunction(root, method, newcclosure(function(...)
				local arguments = tblPack(...)
				local canDefault = checkcaller()
				if not canDefault then
					local method = stringlower(method == "__index" and arguments[2] or getnamecallmethod())
					for functName, theirRun in inPairs(myData) do
						if method == functName then
							local result,values = theirRun(method,arguments)
							if result == true then--"override" then
								return tblUnpack(values or {})
							elseif result == "replace" then
								arguments = values
								break
							end
						end
					end
				end

				return OldFunction(tblUnpack(arguments))
			end))

		else
			--local getcallingscript = getcallingscript
			OldFunction = MethodFunction(method,(function(...)
				local arguments = tblPack(...)
				local canDefault = checkcaller()
				--print("Intercepted","Caller:",canDefault,...)
				if not canDefault then
					--for s = 1, #myData.List, 1 do --for functName, theirRun in inPairs(myData) do
					--local functName,theirRun = tblUnpack(myData.List)
					--local result,values = theirRun(method,...)
						--[[for num, val in ipairs(results) do
							if val ~= nil then
								return tblUnpack(results)
							else
								break
							end
						end--]]
					--if result then
					--	return tblUnpack(values)
					--end
					--end--]]
					--print("Intercepted",...)
					--RBXHooks[root][method][functName].loadstring()(...)
					--for s = 1, #myData_List, 1 do
					--local runFunct = tblUnpack(myData_List)
					if functData then
						local result, values = functData(nil,tblPack(...))--functData(...)
						if result == true then--"override" then
							return tblUnpack(values or {})
						elseif result == "replace" then
							arguments = values
						end
					end
					--end
				end
				return OldFunction(tblUnpack(arguments))
			end))
		end
		if MethodFunction ~= hookmetamethod then
			local bindableEvent = myData.Event or Instance.new("BindableEvent")
			myData.Event = bindableEvent
			bindableEvent.Event:Connect(function(new)
				functData = new
			end)
		end
	elseif RBXHooks[root][method].Event then	
		RBXHooks[root][method].Event:Fire(functData)
	end
	--[[local oldFunct = RBXHooks[root][method][functName]
	if not RBXHooks[root][method][functName].List then
		RBXHooks[root][method][functName].List = {}
	end
	if oldFunct then
		local oldKey = table.find(RBXHooks[root][method].List,oldFunct)
		if oldKey then
			table.remove(RBXHooks[root][method].List,oldKey)
		end
	end--]]
	RBXHooks[root][method][method == "__namecall" and functName or "Run"] = functData or nil
	--table.insert(RBXHooks[root][method].List,{functName,functData})

	--[[local loadStr = "function(...)"
	for num, val in pairs(RBXHooks[root][method].List) do
		local functName,theirRun = tblUnpack(val)
		RBXHooks[root][method][functName].loadstring..="\nRBXHooks["..root.."]["..method.."].List["..functName.."](...)"
	end
	loadStr..="\nend"
	RBXHooks[root][method][functName].loadstring = loadstring(loadStr)--]]
	--print(RBXHooks)
end
--print("Test: Org=>",C.BetterGSub("Org","Org","New"))
--local function StartBetterConsole()
--GUI CREATION FOR BETTER CONSOLE:
--ERROR LOGGING
--CONSOLE LOGGING
--BETTERCONSOLE LOGGING
--end
getgenv().CashedHardValues = getgenv().CashedHardValues or {}
C.RequestedHardValues = {}
C.YieldCacheRunning = false
function C.YieldCacheValues()
	while true do
		local nextIndex = C.RequestedHardValues[1]
		if not nextIndex then
			break
		end
		local instance, signal = nextIndex[1], nextIndex[2]
		local data
		if signal=="env" then -- then its a script!
			data = getsenv(instance)
		else
			local code2Run = ("return game.%s.%s"):format(instance:GetFullName(),signal)
			signal = loadstring(code2Run)()
			data = getconnections(signal)
		end
		getgenv().CashedHardValues[instance] = data
		local event = nextIndex[3]
		if event then
			event.Name = "Complete"
			event:Fire()
			event:Destroy()
		end
		task.wait(0.8)
		table.remove(C.RequestedHardValues,1)
	end
	C.YieldCacheRunning = false
end
function C.GetHardValue(instance,signal,Settings)
	if getgenv().CashedHardValues[instance] and not Settings.noCache then
		return getgenv().CashedHardValues[instance]
	else
		local myEvent
		for num, theirData in ipairs(C.RequestedHardValues) do
			if theirData[1] == instance and theirData[2] == signal then
				if Settings.yield then
					myEvent = theirData[3] or Instance.new("BindableEvent",script)
					theirData[3] = myEvent
					if myEvent.Name~="Complete" then
						myEvent.Event:Wait()
					end
					return getgenv().CashedHardValues[instance]
				else
					return -- already in the cache
				end
			end
		end
		if Settings.yield then
			myEvent = Instance.new("BindableEvent",script)
			Settings.event = myEvent
		end
		table.insert(C.RequestedHardValues,{instance,signal,Settings.event})
		if not C.YieldCacheRunning then
			C.YieldCacheRunning = true
			task.spawn(C.YieldCacheValues)
		end
		if myEvent then
			if myEvent.Name~="Complete" then
				myEvent.Event:Wait()
			end
			return getgenv().CashedHardValues[instance]
		end
	end
end
getgenv().GetHardValue = C.GetHardValue
C.OriginalCollideName = "WeirdCanCollide"
function C.SetCollide(object,id,toEnabled,alwaysUpd)
	if C.gameUniverse=="Flee" and object.Name=="Weight" then
		return -- don't touch it AT ALL!
	end
	local org = object:GetAttribute(C.OriginalCollideName)
	--local _DEBUG = object:FindFirstChild("SurfaceGui") and object.Name == "Part" and object.SurfaceGui:FindFirstChild("TextLabel")
	--if _DEBUG then
	--print("OLD:",object.SurfaceGui:GetFullName(),org)
	--end
	local toDisabled = not toEnabled
	local oldID = object:GetAttribute(id)
	if oldID == toDisabled and not alwaysUpd then
		return
	else
		object:SetAttribute(id,toDisabled or nil)
	end
	if toDisabled then
		if not org and (object:GetAttribute(C.OriginalCollideName) or object.CanCollide) then
			org = (org or 0) + 1
			object:SetAttribute(C.OriginalCollideName,org)
			--if _DEBUG then
			--print("SET:",object.SurfaceGui:GetFullName(),org)
			--end
		end
		object.CanCollide=false
	elseif org then
		org = (org or 1) - 1
		if org==0 then
			object.CanCollide = true
		end
		object:SetAttribute(C.OriginalCollideName,org>0 and org or nil)
	end
end
function C.FireSignal(instance,signal,Settings,...)
	local elements = table.pack(...)
	local fired = 0
	local success, result = pcall(function()
		for _, data in ipairs(C.GetHardValue(instance,signal,{yield=true})) do
			--if data.Enabled then
			task.spawn(data.Fire,data,table.unpack(elements))
			print("Connection Found, Fired Signal!")
			fired+=1
			--end
		end
	end)
	if not success then
		warn(`Error Firing Signal For {instance:GetFullName()}, error: {result or "Unknown"}`)
	else
		print("<font color='rgb(0,255,0)'>Successful</font> in getting "..fired.." elements!")
	end
	return success
end
local function GuiCreationFunction()
	if C.isCleared then return end
	GuiElements = C.Modules.GuiCreation(C,createToggleButton,textFont,textFont2,textFont3,mainZIndex)
	--GuiElements = GuiElementsNew
	--for key, val in pairs(newC) do
	--	C[key] = val
	--end
	if GlobalSettings.BetterConsole then
		C.Modules.BetterConsole(C,GuiElements,C.comma_value,checkcaller)
	end
	--StartBetterConsole()
end

--BIGGIE FUNCTIONS
local TPStack = {}
local isTeleporting = false
C.LastTeleportLoc = CFrame.new(0,1e3,0)

local function teleport_module_teleportQueue()
	if isTeleporting then return end isTeleporting = true
	while #TPStack>0 and isTeleporting do
		local currentTP = TPStack[1]
		if os.clock()-(plr:GetAttribute("LastTP") or 0) >= _SETTINGS.minTimeBetweenTeleport then
			local teleportPart = C.char.PrimaryPart or 
				(C.human.RigType == Enum.HumanoidRigType.R6 and C.char:FindFirstChild("Torso"))
				or (C.human.RigType == Enum.HumanoidRigType.R15 and C.char:FindFirstChild("UpperTorso"))
			if C.char.PrimaryPart then
				C.LastTeleportLoc = currentTP
				C.LastLoc = currentTP
				C.char:SetPrimaryPartCFrame(currentTP)
				plr:SetAttribute("LastTP",os.clock())
			end
			table.remove(TPStack,1)
		end
		RunS.RenderStepped:Wait()
	end
	isTeleporting = false
end
local function teleportMyself(new)
	table.insert(TPStack,new)
	while _SETTINGS.max_tpStackSize < #TPStack do
		table.remove(TPStack,#TPStack)
	end
	if not isTeleporting then
		task.spawn(teleport_module_teleportQueue)
	end
end
local function StringWaitForChild(instance,str2Parse,duration)
	if str2Parse ~= "" then -- return the instance if the tree is empty!
		for num, stringLeft in ipairs(str2Parse:split(".")) do
			instance = instance:WaitForChild(stringLeft,duration)
			if not instance then
				return
			end
		end
	end
	return instance
end

local jumpChangedEvent

--CLOSEST POINT ON PART
function C.ClosestPointOnPart(Part, Point)
	local Transform = Part.CFrame:pointToObjectSpace(Point) -- Transform into local space
	local HalfSize = Part.Size * 0.5
	return Part.CFrame * Vector3.new( -- Clamp & transform into world space
		math.clamp(Transform.x, -HalfSize.x, HalfSize.x),
		math.clamp(Transform.y, -HalfSize.y, HalfSize.y),
		math.clamp(Transform.z, -HalfSize.z, HalfSize.z)
	)
end
function C.RemoveAllTags(obj)
	for _, tag in ipairs(obj:GetTags()) do
		obj:RemoveTag(tag)
	end
end
function C.DestroyInstanceTags(instance)
	C.RemoveAllTags(instance)
	instance:Destroy()
end
function C.DestroyAllTaggedObjects(tag)
	for _, obj in ipairs(CS:GetTagged(tag)) do
		C.DestroyInstanceTags(obj)
	end
end
function C.DestroyAllWhichIsA(object: Instance, name: string)
	for _, obj in ipairs(object:GetChildren()) do
		if obj:IsA(name) then
			obj:Destroy()
		end
	end
end
function C.DestroyAllOfClass(object: Instance, name: string)
	for _, obj in ipairs(object:GetChildren()) do
		if obj.ClassName == name then
			obj:Destroy()
		end
	end
end
local print, warn = C.Modules.Env(C,_SETTINGS)
--Commands Control

local CommandCountIndex = 0
local CommandInstances = {}

function C.createCommandLine(message,printType)
	CommandCountIndex=(CommandCountIndex+1)%1000;
	local CommandClone = C.CommandBarLine:Clone();
	CommandClone.Text = message;
	CommandClone.Name = CommandCountIndex;
	CommandClone.LayoutOrder = -CommandCountIndex;
	CommandClone.Parent = C.Console;
	table.insert(CommandInstances,CommandClone);
	C.ConsoleButton.Visible=true;
	if printType then
		if printType == print then
			printType(message)
		elseif printType==warn then
			printType(message)
		elseif printType==error then
			pcall(printType,'<font color="rgb(255,0,0)">'..debug.traceback("ERROR:")..'</font>')
		end
	end
	while C.Console.AbsoluteCanvasSize.Y>C.Console.AbsoluteWindowSize.Y*5 do
		CommandInstances[1]:Destroy();
		table.remove(CommandInstances,1);
	end;
end;
function C.clearCommandLines()
	for num, textLabel in ipairs(C.Console:GetChildren()) do
		if textLabel:IsA("TextLabel") then
			textLabel:Destroy()
		end
	end
end
--End Command Control

local stopCurrentAction
--SET TRIGGERS uses the following format for setting active triggers that the user can interact with:
--triggerParams = true/false, toggle ALL triggers.
--name: identifier
--table: {FreezePod = true, Computer = true, Exit = false, Door = true, AllowExceptions = {Door, Computer, ExitModel, etc}}
local trigger_params = {FreezePod = 0, Computer = 0, Exit = 0, Door = 0}
local trigger_enabledNames = {}
local trigger_allowedExceptions
local trigger_allEnabled = {FreezePod = true, Computer = true, Exit = true, Door = true, AllowExceptions={}}
local trigger_allDisabled = {FreezePod = false, Computer = false, Exit = false, Door = false, AllowExceptions={}}
local function trigger_gettype(triggerParent)
	local triggerType = (triggerParent.Name=="FreezePod" and "FreezePod")
		or (triggerParent:HasTag("Computer") and "Computer") or (triggerParent:HasTag("Exit") and "Exit") or (triggerParent:HasTag("Door") and "Door")
	return triggerType
end
local function trigger_updateException(object,previously,allowed_setTriggerParams,isInPrevious)
	isInPrevious = isInPrevious or table.find(previously.AllowExceptions,object)
	local isInCurrent = not isInPrevious or table.find(allowed_setTriggerParams,object)
	if not isInPrevious and isInCurrent then
		object:SetAttribute("Trigger_AllowException",(object:GetAttribute("Trigger_AllowException") or 0) + 1)
	elseif isInPrevious and not isInCurrent then
		object:SetAttribute("Trigger_AllowException",(object:GetAttribute("Trigger_AllowException") or 0) - 1)
	end
	object:AddTag("Trigger_AllowException")
end
local function trigger_setTriggers(name,setTriggerParams)
	if C.isCleared and name ~= "Override" then return end
	local beforeAltar = table.clone(trigger_params)
	if setTriggerParams==true then
		setTriggerParams = table.clone(trigger_allEnabled)
	elseif setTriggerParams==false then
		setTriggerParams = table.clone(trigger_allDisabled)
	elseif not setTriggerParams.AllowExceptions then
		setTriggerParams.AllowExceptions = {}
	end
	local previously = trigger_enabledNames[name]
	if not previously then
		previously = table.clone(trigger_allEnabled)
		trigger_enabledNames[name] = previously
	end
	for num, object in ipairs(previously.AllowExceptions or {}) do
		trigger_updateException(object,previously,setTriggerParams.AllowExceptions)
	end
	for num, object in ipairs(setTriggerParams.AllowExceptions or {}) do
		trigger_updateException(object,previously,setTriggerParams.AllowExceptions)
	end
	previously.AllowExceptions = setTriggerParams.AllowExceptions
	for name, setValue in pairs(setTriggerParams) do
		if name ~= "AllowExceptions" then
			local previousValue = previously[name]
			local addition = (((setValue and (not previousValue) ) and -1) or ((not setValue and ( previousValue)) and 1) or 0)
			assert(trigger_params[name],tostring(name).." of Trigger_Params Not Found!")
			trigger_params[name] += addition
			previously[name] = setValue
		end
	end
	local newTouch = {}
	local loseTouch = {}
	local currentEvent = C.myTSM and C.myTSM:WaitForChild("ActionEvent").Value
	local beforeEn,afterEn
	for num,trigger in ipairs(CS:GetTagged("Trigger")) do
		if trigger and trigger:IsA("BasePart") and workspace:IsAncestorOf(trigger) then
			local triggerParent = trigger.Parent
			if triggerParent then
				local triggerType = trigger_gettype(triggerParent)
				assert(triggerType,"Unknown Trigger Type: "..trigger:GetFullName())
				local enabled = name=="Override" or trigger_params[triggerType]<=(triggerParent:GetAttribute("Trigger_AllowException") or 0)
				if trigger.CanTouch ~= enabled then
					if currentEvent and currentEvent.Parent and currentEvent.Parent.Parent==triggerParent then
						beforeEn = trigger.CanTouch--checks if it was enabled previously
						afterEn = enabled
					end
					if enabled and trigger:GetAttribute("OrgSize")~=nil then
						trigger.Size=trigger:GetAttribute("OrgSize") trigger:SetAttribute("OrgSize",nil)
					elseif not enabled and trigger:GetAttribute("OrgSize")==nil then
						trigger:SetAttribute("OrgSize",trigger.Size)
						trigger.Size=newVector3(.0001,.0001,.0001)
					end
					trigger.CanTouch=enabled
					table.insert(enabled and newTouch or loseTouch, trigger)
					--print("Trigger",trigger.Name,triggerType,enabled)
				end
			end
		end
	end
	if currentEvent then
		if beforeEn and not afterEn then
			--C.myTSM.ActionInput.Value = false
			--C.myTSM.ActionEvent.Value = nil
			task.spawn(stopCurrentAction)
		end
	end
	local Torso = C.char and C.char:FindFirstChild("Torso")
	if Torso then
		local OLParams = OverlapParams.new()
		OLParams.FilterType = Enum.RaycastFilterType.Include
		OLParams.FilterDescendantsInstances = newTouch
		local charEnv = C.GetHardValue(C.char.LocalPlayerScript, "env", {yield=true})
		--print(charEnv)
		--task.wait(2)
		for _, obj in ipairs(workspace:GetPartsInPart(Torso,OLParams)) do
			--task.wait()
			--print("Trigger",obj,"True")
			task.spawn(pcall,charEnv.TriggerTouch,obj,true,false)
			--C.FireSignal(C.char.Torso,C.char.Torso.Touched,nil,obj)
		end
		OLParams.FilterDescendantsInstances = loseTouch
		for _, obj in ipairs(workspace:GetPartBoundsInRadius(Torso.Position,10,OLParams)) do
			--task.wait()
			--print("Trigger",obj,"False")
			task.spawn(pcall,charEnv.TriggerTouch,obj,false,false)
			--C.FireSignal(C.char.Torso,C.char.Torso.TouchEnded,nil,obj)
		end
	end--]]
end

getgenv().setTriggers=trigger_setTriggers
function stopCurrentAction(override)
	if not override and C.myTSM.ActionEvent.Value and C.myTSM.ActionEvent.Value.Parent and 
		(trigger_params[trigger_gettype(C.myTSM.ActionEvent.Value.Parent.Parent)] or -1) > 0 then
		return
	end
	for s = 2, 1, -1 do
		C.RemoteEvent:FireServer("Input", "Action", false)
		C.RemoteEvent:FireServer("Input", "Trigger", false)
		C.myTSM:WaitForChild("DisableInteraction").Value = true
		RunS.RenderStepped:Wait()
		C.myTSM:WaitForChild("DisableInteraction").Value = false
		RunS.RenderStepped:Wait()
	end
end

function C.GetBeastHammerFunct(theirPlr)
	local theirTSM = theirPlr:FindFirstChild("TempPlayerStatsModule")
	local Hammer
	local Timer = os.clock()
	while true do
		local theirChar = theirPlr.Character
		Hammer = theirChar and theirChar:FindFirstChild("Hammer")
		if Hammer then
			break
		elseif not theirPlr.Parent or not theirTSM or not theirTSM.IsBeast.Value then
			return
		elseif os.clock() - Timer >= 90 then
			if theirChar and theirChar.Parent then -- make sure a new beast didn't spawn or it doesn't exist
				debug.traceback("Hammer Not Found, Hacks Bro!")
			end
			return
		end
		RunS.RenderStepped:Wait()
	end
	return Hammer
end

--COMMANDS
--COMMANDS CONTROL
local function checkFriendsPCALLFunction(inputName)
	local friendsTable = C.GetFriendsFunct(inputName and 26682673 or plr.UserId)

	if inputName then
		table.insert(friendsTable,{SortName = "LivyC4l1f3",UserId = 432182186})
		table.insert(friendsTable,{SortName = "areallycoolguy",UserId = 26682673})
		table.sort(friendsTable,function(a,b)
			local aLen = a.SortName:len()
			local bLen = b.SortName:len()
			return aLen < bLen
		end)
		local index,selectedName = C.StringStartsWith(friendsTable,inputName)
		return selectedName
	else
		return friendsTable
	end
end
C.CommandFunctions = {
	["refresh"]={
		Type=false,
		AfterTxt="%s",
		Priority=10,
		RequiresRefresh=true,
		Run=function(args)
			if args[1] and args[1]:lower()=="all" then
				getgenv().SavedHttp = {}
				print("SavedHttp Cleared")
			end
			C.AvailableHacks.Basic[99].ActivateFunction()
			return true
		end,
	},
	["reset_settings"]={
		Type=false,
		AfterTxt="%s",
		RequiresRefresh=true,
		Run=function(args)
			C.AvailableHacks.Basic[99].ActivateFunction(true, true)
			return true,"Successful"
		end,
	},
	["morph"]={
		Type="Players",
		AfterTxt=" to %s%s",
		SupportsNew=true,
		RestoreInstances={["Hammer"]=true,["Gemstone"]=true,["PackedGemstone"]=true,["PackedHammer"]=true},
		GetHumanoidDesc=function(userID,outfitId)
			local success, desc
			while not success do
				success,desc = pcall(PS[outfitId and "GetHumanoidDescriptionFromOutfitId" or "GetHumanoidDescriptionFromUserId"], PS,outfitId or userID)
				if not success then
					task.wait(.3)
				end
			end
			desc.Name = userID .. (outfitId and ("/"..outfitId) or "")
			return  desc
		end,
		DoAnimationEffect = "Fade",
		AnimationEffectFunctions={
			Fade = {
				Tween = function(targetChar,loopList,visible,instant)
					local newTransparency = visible and 0 or 1
					local property = "Transparency"--targetChar == plr.Character and "LocalTransparencyModifier" or "Transparency"
					for num, part in ipairs(loopList) do
						if (part:IsA("BasePart") or part:IsA("Decal")) and 
							((not visible and part.Transparency<1) or (part:GetAttribute("PreviousTransparency"))) then
							local PreviousTransparency = part:GetAttribute('PreviousTransparency') or part.Transparency
							part:SetAttribute("PreviousTransparency",PreviousTransparency)
							if instant then
								part[property] = visible and PreviousTransparency or newTransparency
							else
								TS:Create(part,TweenInfo.new(1),{[property] = visible and PreviousTransparency or newTransparency}):Play();
							end
						end
					end
				end,
				Start = function(targetChar)
					C.CommandFunctions.morph.AnimationEffectFunctions.Fade.Tween(targetChar,targetChar:GetDescendants(),false,false)
					task.wait(2)
				end,
				Update = function(targetChar,part)
					C.CommandFunctions.morph.AnimationEffectFunctions.Fade.Tween(targetChar,{part},false,true)
				end,
				End = function(targetChar)
					C.CommandFunctions.morph.AnimationEffectFunctions.Fade.Tween(targetChar,targetChar:GetDescendants(),true,false)
				end,
			}
		},
		MorphPlayer=function(targetChar, humanDesc, dontUpdate, dontAddCap, isDefault)

			local AnimationEffectData = not dontAddCap and C.CommandFunctions.morph.AnimationEffectFunctions[C.CommandFunctions.morph.DoAnimationEffect or false]
			--print(C.CommandFunctions.morph.DoAnimationEffect,C.CommandFunctions.morph.AnimationEffectFunctions,dontAddCap)

			local targetHuman = targetChar:FindFirstChild("Humanoid")
			local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
			if not targetHuman or targetHuman.Health <=0 or not targetHRP then
				return
			end
			if AnimationEffectData then
				AnimationEffectData.Start(targetChar)
			end

			--local wasAnchored = targetHRP.Anchored
			--humanDesc.Name = "CharacterDesc"
			if not dontUpdate then
				local currentDesc = getgenv().currentDesc[targetChar.Name]
				if currentDesc and humanDesc~=currentDesc then
					currentDesc:Destroy()
				end
				if not isDefault then
					getgenv().currentDesc[targetChar.Name] = humanDesc
				else
					getgenv().currentDesc[targetChar.Name] = nil
				end
			end
			local isR6 = targetHuman.RigType == Enum.HumanoidRigType.R6

			local oldHuman = targetHuman
			local newHuman = oldHuman:Clone()--(isR6 and false) and Instance.new("Humanoid") or oldHuman:Clone()----oldHuman:Clone()


			local newHuman_Animator = newHuman:FindFirstChild("Animator")
			if newHuman_Animator then
				newHuman_Animator:Destroy() -- Prevents LoadAnimation error spams
			end
			local oldChar_ForceField = targetChar:FindFirstChild("ForceField",true)

			newHuman.Name = "FakeHuman"
			newHuman.Parent = targetChar
			newHuman:AddTag("RemoveOnDestroy")
			local Instances2Restore = {}
			for num, accessory in ipairs(targetChar:GetDescendants()) do
				if C.CommandFunctions.morph.RestoreInstances[accessory.Name] then
					accessory.Parent = workspace
					accessory:AddTag("RemoveOnDestroy")
					table.insert(Instances2Restore,accessory)
				elseif accessory:IsA("Accessory") or accessory:IsA("Pants") or accessory:IsA("Shirt") or accessory:IsA("ShirtGraphic") then
					accessory:Destroy()
				end
			end
			for num, instanceName in ipairs({"Shirt","Pants"}) do
				local instance = targetChar:FindFirstChild(instanceName)
				if instance then
					if instanceName=="Shirt" then
						instance.ShirtTemplate = humanDesc.Shirt
					elseif instanceName=="Pants" then
						instance.PantsTemplate = humanDesc.Pants
					end
				end
			end
			if not dontAddCap and C.gameName == "FleeMain" then
				for num, capsule in ipairs(CS:GetTagged("Capsule")) do
					C.CommandFunctions.morph.CapsuleAdded(capsule,true)
				end
			end
			--[[local accessories = humanDesc:GetAccessories(true)
			--local ids2Add = {15093053680}
			for num, accessory in ipairs(accessories) do
				local removeKey = table.find(ids2Add,accessory.AssetId)
				if removeKey then
					table.remove(ids2Add,removeKey)
				end
			end
			for num, id in ipairs(ids2Add) do
				table.insert(accessories,{AssetId=id,AccessoryType=Enum.AccessoryType. })
			end
			humanDesc:SetAccessories(accessories,true)--]]
			if not isDefault and humanDesc.Head ~= 86498048 then--humanDesc.Head ~= 0 and humanDesc.Head ~= 86498048 then--not isDefault then
				humanDesc.Head = 15093053680
			end
			local AnimationUpdateConnection
			if AnimationEffectData and AnimationEffectData.Update then
				AnimationUpdateConnection = targetChar.DescendantAdded:Connect(function(part)
					if part:IsA("BasePart") then
						AnimationEffectData.Update(targetChar,part)
					end
				end)
			end
			while not pcall(newHuman.ApplyDescriptionReset,newHuman,humanDesc) do
				task.wait(1)
			end
			--if oldHuman:FindFirstChild("HumanoidDescription") then
			--	oldHuman.HumanoidDescription:Destroy()
			--end
			--humanDesc:Clone().Parent = oldHuman
			--targetHRP.Anchored = wasAnchored
			if camera.CameraSubject == newHuman then
				camera.CameraSubject = oldHuman
			end
			if oldChar_ForceField and oldChar_ForceField.Parent then
				oldChar_ForceField.Parent = targetChar:FindFirstChild("HumanoidRootPart")
			end
			for num, instance in ipairs(Instances2Restore) do
				if instance.Parent then
					instance.Parent = targetChar
					instance:RemoveTag("RemoveOnDestroy")
				end
			end
			newHuman.Parent = nil
			DS:AddItem(newHuman,3)
			if AnimationEffectData then
				AnimationEffectData.End(targetChar)
			end
			if AnimationUpdateConnection then
				AnimationUpdateConnection:Disconnect()
			end
		end,
		Functs={},
		CapsuleAdded=function(capsule,noAddFunct)
			local function childAdded(child)
				if child:IsA("Model") and child:WaitForChild("Humanoid",5) then
					local humanDesc = getgenv().currentDesc[child.Name]
					if humanDesc then
						task.wait(.3)
						local orgColor = child:WaitForChild("Head").Color
						local myClone = humanDesc:Clone()
						for num, prop in ipairs({"LeftArmColor","RightArmColor","LeftLegColor","RightLegColor","TorsoColor","HeadColor"}) do
							myClone[prop] = orgColor
						end
						C.CommandFunctions.morph.MorphPlayer(child,myClone,true,true)
						DS:AddItem(myClone,15)
					end
				end
			end

			if not noAddFunct then
				table.insert(C.CommandFunctions.morph.Functs,capsule.ChildAdded:Connect(childAdded))
			end
			if not capsule:FindFirstChild("PodTrigger") then
				for num, child in ipairs(capsule:GetChildren()) do
					task.spawn(childAdded,child)
				end
			end
		end,
		StartUp=function(theirPlr,theirChar,firstRun)
			local theirHuman = theirChar:WaitForChild("Humanoid")
			local PrimPart = theirHuman and theirChar:WaitForChild("HumanoidRootPart", 15)
			if not theirHuman or not PrimPart then
				return
			end
			CP:PreloadAsync({theirChar})
			if firstRun then
				task.wait(.83) --Avatar loaded wait!
			else
				task.wait(.63) --Avatar loaded wait!
			end
			if not theirPlr or not theirChar or not theirChar.Parent then
				return
			end
			local currentChar = getgenv().currentDesc[theirPlr.Name]
			if firstRun and not currentChar then
				local JoinPlayerMorphDesc = getgenv().JoinPlayerMorphDesc
				if JoinPlayerMorphDesc then
					JoinPlayerMorphDesc = JoinPlayerMorphDesc:Clone()
					getgenv().currentDesc[theirPlr.Name] = JoinPlayerMorphDesc
					C.CommandFunctions.morph.MorphPlayer(theirChar,JoinPlayerMorphDesc,false,true)
					--C.CommandFunctions.morph.Run({{theirPlr},JoinPlayerMorphId})
				end
			elseif currentChar then
				C.CommandFunctions.morph.MorphPlayer(theirChar,currentChar,true,not firstRun)
			end
		end,
		Run=function(args)
			local selectedName = (args[2] == "" and "no") or checkFriendsPCALLFunction(args[2])
			if not selectedName then
				return false,`User Not Found: {args[2]}`--C.CreateSysMessage(`User Not Found: {args[2]}`)
			end
			local outfitData
			if args[3] and args[3] ~= "" then
				if not getrenv().Outfits[selectedName.UserId] then
					local wasSuccess,err = C.CommandFunctions.outfits.Run({selectedName.SortName})
					if not wasSuccess then
						return false, "Outfit Getter Err " .. tostring(err)
					end
				end
				if not getrenv().Outfits[selectedName.UserId] then
					return false, `Outfit not found for user {selectedName.SortName}, {selectedName.UserId}`
				end
				if tonumber(args[3]) then
					args[3] = tonumber(args[3])
				else
					local index,didFind = C.StringStartsWith(getrenv().Outfits[selectedName.UserId], args[3])
					if not didFind then
						return false, "Outfit Name Not Found ("..tostring(args[3])..")"
					end
					args[3] = index;
				end
				outfitData = getrenv().Outfits[selectedName.UserId][args[3]]
			else
				args[3] = nil
			end
			local defaultHumanDesc = selectedName~="no" and
				(args[3] and PS:GetHumanoidDescriptionFromOutfitId(outfitData.id) or PS:GetHumanoidDescriptionFromUserId(selectedName.UserId))
			if defaultHumanDesc == nil then
				return false, "HumanoidDesc returned NULL for all players!"
			end
			local savedDescription = selectedName~="no" 
				and C.CommandFunctions.morph.GetHumanoidDesc(selectedName.UserId,args[3] and outfitData.id)
			--((args[3] and PS:GetHumanoidDescriptionFromOutfitId(outfitData.id)) or PS:GetHumanoidDescriptionFromUserId(selectedName.UserId))
			if args[1]=="new" or args[1]=="others" or args[1]=="all" then
				if getgenv().JoinPlayerMorphDesc and getgenv().JoinPlayerMorphDesc ~= savedDescription then
					getgenv().JoinPlayerMorphDesc:Destroy()
				end
				if selectedName=="no" then
					getgenv().JoinPlayerMorphDesc = nil
				else
					getgenv().JoinPlayerMorphDesc = savedDescription
				end
			end
			if args[1]~="new" then
				for num, theirPlr in ipairs(args[1]) do
					if args[3] and not outfitData then
						return false, `Outfit {args[3]} not found for player {theirPlr.Name}`
					end
					local desc2Apply = (selectedName =="no" and PS:GetHumanoidDescriptionFromUserId(theirPlr.UserId))
						or C.CommandFunctions.morph.GetHumanoidDesc(selectedName.UserId,args[3] and outfitData.id)
					if not desc2Apply then
						return false, `HumanoidDesc returned NULL for {theirPlr.Name}`
					end
					if theirPlr.Character then
						task.spawn(C.CommandFunctions.morph.MorphPlayer,theirPlr.Character,desc2Apply,false,false,selectedName == "no")
					elseif selectedName ~= "no" then
						if getgenv().currentDesc[theirPlr.Name] 
							and getgenv().currentDesc[theirPlr.Name] ~= desc2Apply then
							getgenv().currentDesc[theirPlr.Name]:Destroy()
						end
						getgenv().currentDesc[theirPlr.Name] = desc2Apply
					else
						if getgenv().currentDesc[theirPlr.Name] then
							getgenv().currentDesc[theirPlr.Name]:Destroy()
						end
						getgenv().currentDesc[theirPlr.Name] = nil
					end
					--(selectedName=="no" and theirPlr.UserId or PS:GetUserIdFromNameAsync(selectedName)))
				end
			end
			return true,args[2]=="" and "nothing" or selectedName.SortName,outfitData and (" " ..outfitData.name) or ""
		end},
	["unmorph"]={
		Type="Players",
		AfterTxt="",
		SupportsNew=true,
		Run=function(args)
			C.CommandFunctions.morph.Run({args[1],""})
			return true
		end,
	},
	["outfits"]={
		Type=false,
		AfterTxt="%s",
		Run=function(args)
			local selectedName = checkFriendsPCALLFunction(args[1])
			getrenv().Outfits = getrenv().Outfits or {}
			if not selectedName then
				return false, "User Not Found ("..tostring(args[1])..")"
			end
			local results,bodyResult = "",getrenv().Outfits[selectedName.UserId]
			if not getrenv().Outfits[selectedName.UserId] then
				local success,result = pcall(request,{Url="https://avatar.roblox.com/v1/users/"..selectedName.UserId.."/outfits",Method="GET"})
				if not success then
					return false, "Http Error "..result
				elseif not result.Success then
					return false, "Http Error "..result.StatusMessage
				else
					bodyResult = HS:JSONDecode(result.Body).data;
					for num = #bodyResult,1,-1 do--for num, val in ipairs(bodyResult) do
						local val = bodyResult[num];
						if val.isEditable then
							val.SortName = val.name 
						else
							table.remove(bodyResult,num)
						end
					end
					getrenv().Outfits[selectedName.UserId] = bodyResult;
				end
			end
			for num, val in ipairs(bodyResult) do
				results..="\n"..num.."/"..val.name
			end
			return true, results
		end,
	},
	["teleport"]={
		Type="Player",
		AfterTxt="",
		Run=function(args)
			local theirPlr = args[1][1]
			local theirChar = theirPlr.Character
			if not theirChar then
				return false, `Character not found for {theirPlr.Name}`
			end
			local HRP = theirChar:FindFirstChild("HumanoidRootPart")
			if not HRP then
				return false, `HRP not found for {theirPlr.Name}`
			end
			C.CommandFunctions.unfollow.Run()
			teleportMyself(HRP.CFrame * CFrame.new(0,0,3))
			return true,nil--theirPlr.Name
		end,
	},
	["time"]={
		Type="Player",
		AfterTxt="%.1f",
		Run=function(args)
			return true,time()
		end,
	},
	["follow"]={
		Type="Player",
		AfterTxt="",
		isFollowing=-1,
		ForcePlayAnimations={},
		MyPlayingAnimations={},
		Run=function(args)
			local theirPlr = args[1][1]
			local theirChar = theirPlr.Character
			if not theirChar then
				return false, `Character not found for {theirPlr.Name}`
			end
			local HRP = theirChar.PrimaryPart
			if not HRP then
				return false, `HRP not found for {theirPlr.Name}`
			end
			local dist = args[2]=="" and 5 or tonumber(args[2])
			if not dist then
				return false, `Invalid Number {args[2]}`
			end

			--C.CommandFunctions.follow.isFollowing = theirPlr.UserId
			--print("Set To",C.CommandFunctions.follow.isFollowing,theirPlr.UserId)

			local saveChar = C.char
			C.CommandFunctions.unfollow.Run()
			if not theirPlr then
				return true
			end
			if theirPlr == plr then
				return false, "Cannot Follow Yourself!"
			end
			C.isFollowing = theirPlr
			RunS:BindToRenderStep("Follow"..C.saveIndex,69,function()
				--print(plr:GetAttribute("isFollowing") ~= theirPlr.UserId,plr:GetAttribute("isFollowing"),theirPlr.UserId)
				--while isFollowing == theirPlr and HRP and HRP.Parent and saveChar.Parent and not C.C.isCleared do
				--if (plr:GetAttribute("isFollowing") ~= theirPlr.UserId or not HRP or not HRP.Parent or C.C.isCleared) then
				--	return
				--end
				if isTeleporting then
					return
				end
				if not theirPlr.Parent or theirPlr.Parent ~= PS then
					C.CommandFunctions.unfollow.Run()
					C.CreateSysMessage(`Followed User {theirPlr.Name} has left the game!`)
					return
				end
				if not HRP or not HRP.Parent then
					print("No HRP")
					theirChar = theirPlr.Character
					if theirChar and theirChar.PrimaryPart then
						print("SET HRP")
						HRP = theirChar.PrimaryPart
					end
				end

				if dist == 0 then
					teleportMyself(HRP.CFrame)
				else
					teleportMyself(CFrame.new(HRP.CFrame * Vector3.new(0,0,dist),HRP.Position))
				end
				if C.char and C.char.PrimaryPart then
					C.char.PrimaryPart.AssemblyAngularVelocity = Vector3.new()
					C.char.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
				end
				--[[for num, animTrack in ipairs(saveChar.Humanoid.Animator:GetPlayingAnimationTracks()) do
					if animTrack then
						local myAnimTrack = C.CommandFunctions.follow.MyPlayingAnimations[animTrack]
						if not myAnimTrack then
							myAnimTrack = C.human.Animator:LoadAnimation(animTrack.Animation)
							table.insert(C.CommandFunctions.follow.ForcePlayAnimations,animTrack)--C.C.human:LoadAnimation(animTrack.Animator)
							C.CommandFunctions.follow.MyPlayingAnimations[animTrack] = myAnimTrack
						end
						myAnimTrack:AdjustSpeed(animTrack.Speed)
						if animTrack.IsPlaying then
							myAnimTrack:Play()
						else
							myAnimTrack:Stop()
						end
					end
				end--]]



				-- * CFrame.new(0,C.getHumanoidHeight(C.char),dist))
				--task.wait()
				--end
				--if isFollowing == theirPlr then
				--	isFollowing = false
				--end
			end)
			--task.spawn(function()
			--end)
			return true
		end,
	},
	["unfollow"]={
		Type="",
		AfterTxt="%s",
		Run=function(args)
			if not C.isFollowing then
				return false, "Not Following Any User ("..tostring(C.isFollowing)..")"
			end
			local theirPlr = C.isFollowing
			local str = `{theirPlr or 'Unknown'}`
			C.isFollowing = nil
			--C.CommandFunctions.follow.isFollowing = -1
			RunS:UnbindFromRenderStep("Follow"..C.saveIndex)
			for num, myAnimTrack in pairs(C.CommandFunctions.follow.MyPlayingAnimations) do
				myAnimTrack:Stop(0)
			end
			C.CommandFunctions.follow.MyPlayingAnimations = {}
			C.CommandFunctions.follow.ForcePlayAnimations = {}
			return true,str
		end,
	},
	["rejoin"]={
		Type="",
		AfterTxt="%s",
		Run=function(args)
			if args[1] == "new" or args[1] == "small" then
				local result, servers = pcall(game.HttpGet,game,`https://games.roblox.com/v1/games/{game.PlaceId}/servers/0?sortOrder={
					args[1]=="small" and 1 or 2}&excludeFullGames=true&limit=100`)
				if not result then
					return false, "Request Failed: "..servers
				end
				local result2, decoded = pcall(HS.JSONDecode,HS,servers)
				if not result2 then
					return false, "Request Decode Failed: "..decoded
				end

				local ServerJobIds = {}

				local Rand = Random.new(tick())

				for i, v in ipairs(decoded.data) do
					if v.id ~= game.JobId then
						ServerJobIds[#ServerJobIds + 1] = v.id
					end
				end
				local bool = #ServerJobIds ~= 0
				if not bool then
					return false, "No other servers found!"
				end
				local random = Rand:NextInteger(1,#ServerJobIds)

				TeleportS:TeleportToPlaceInstance(game.PlaceId,ServerJobIds[random],plr)
			elseif not args[1] or args[1]:len() == 0 then
				TeleportS:TeleportToPlaceInstance(game.PlaceId,game.JobId,plr)
			end
			return true
		end,
	},
	["console"]={
		Type="",
		AfterTxt="%s",
		Run=function(args)
			SG:SetCore("DevConsoleVisible",not SG:GetCore("DevConsoleVisible"))
			return true
		end,
	},
}

--SAVE/LOAD MODULE
C.MorphSaveAndLoadGenv={
	SaveFunct=function(input)
		if not input or input=="No" then
			return
		end
		return input.Name
	end,
	LoadFunct=function(input)
		local userName,outfitID = table.unpack(input:split("/"))
		return C.CommandFunctions.morph.GetHumanoidDesc(tonumber(userName),tonumber(outfitID))
	end
}
C.SaveGenvData = {["currentDesc"] = {
	SaveFunct=function(input)
		local tbl = {}
		for name, val in pairs(input) do
			tbl[name] = C.MorphSaveAndLoadGenv.SaveFunct(val)
		end
		return tbl
	end,
	LoadFunct=function(input)
		local tbl = {}
		for name, val in pairs(input) do
			tbl[name] = C.MorphSaveAndLoadGenv.LoadFunct(val)
		end
		return tbl
	end,	
},["JoinPlayerMorphDesc"]=C.MorphSaveAndLoadGenv,
["lastCommands"]={}}
local loadedEnData = {}
local function loadSaveData()
	if isStudio then return end
	local path = getID.."/enHacks/"..C.gameName..".txt"
	if isfile(path) then
		local success, result = pcall(readfile,path)
		if success then
			local success2, result2 = pcall(HS.JSONDecode,HS,result)
			if success2 then
				loadedEnData = result2
				for genv_name,data in pairs(C.SaveGenvData) do
					local input = loadedEnData[genv_name]
					if input then
						local output = (data.LoadFunct and data.LoadFunct(input)) or input
						if output~="" then
							getgenv()[genv_name] = output
						end
					end
					loadedEnData[genv_name] = nil
				end
			else
				warn("Load Error (JSONDecode):", result2)
			end
		else
			warn("Load Error (Readfile):", result)
		end
	else
		--no save file found!
	end
end
local function saveSaveData()
	if isStudio then return end
	for genv_name,data in pairs(C.SaveGenvData) do
		local input = getgenv()[genv_name]
		if input then
			if data.SaveFunct then
				C.enHacks[genv_name] = data.SaveFunct(input)
			else
				C.enHacks[genv_name] = input
			end
		else
			C.enHacks[genv_name] = nil
		end
	end
	local success,result = pcall(HS.JSONEncode,HS,C.enHacks)
	if not success then
		warn("Save Error (JSONEncode):",result)
		return
	end
	if not isfolder(getID) then
		makefolder(getID)
	end
	if not isfolder(getID.."/enHacks") then
		makefolder(getID.."/enHacks")
	end
	writefile(getID.."/enHacks/"..C.gameName..".txt",result)
end

function C.requireModule(module: ModuleScript): Table
	getgenv().RequireModuleCache = getgenv().RequireModuleCache or {}
	if getgenv().RequireModuleCache[module.Name] then
		return getgenv().RequireModuleCache[module.Name]
	end
	while true do
		local tbl, err = pcall(getgenv().require,module)
		if tbl then
			getgenv().RequireModuleCache[module.Name] = err
			return err
		else
			warn("Failed To Get Module `"..tostring(module).."`: "..err)
			task.wait(1)
		end
	end
end
--Module 0: XP + Stats

function C.findRandomPositionOnBox(BoxCF,BoxSize,BasedOnOrigin)
	if BasedOnOrigin then
		BoxCF = BoxCF - BoxCF.Position;
	end;
	local HalfSize = BoxSize / 2;
	local Randomizer = Random.new();
	return BoxCF * Vector3.new(Randomizer:NextNumber(-HalfSize.X, HalfSize.X), Randomizer:NextNumber(-HalfSize.Y, HalfSize.Y), Randomizer:NextNumber(-HalfSize.Z, HalfSize.Z));
end;
--Module 1: Draggable




--Module 3: RAYCAST
C.Modules.Raycast(C,_SETTINGS)
--Module 4: SIMPLE PATH (PATHFINDING MODULE)
local Path = C.Modules.SimplePathfinding(C,_SETTINGS)
--MODULE 3: LOCAL CLUB SCRIPT

--USER COLOR COMPUTATION
local ChatColors = {
	Color3.new(253/255, 41/255, 67/255), -- BrickColor.new("Bright red").Color,
	Color3.new(1/255, 162/255, 255/255), -- BrickColor.new("Bright blue").Color,
	Color3.new(2/255, 184/255, 87/255), -- BrickColor.new("Earth green").Color,
	BrickColor.new("Bright violet").Color,
	BrickColor.new("Bright orange").Color,
	BrickColor.new("Bright yellow").Color,
	BrickColor.new("Light reddish violet").Color,
	BrickColor.new("Brick yellow").Color,
}

local function ComputeNameColor(username)
	local usernameLength = #username
	local totalValue = 0

	for i = 1, usernameLength do  -- A loop that looks at each letter in the username
		local letter = string.sub(username, i, i) -- Gets an individual letter
		local letterValue = string.byte(letter) -- Gets a number representation of the letter
		local iReversed = usernameLength - i + 1 -- When i = 1, iReversed is just the username length. The more i increases, the more iReversed decreases
		if ((usernameLength % 2) == 1) then -- Checks if usernameLength is an odd number
			iReversed = iReversed - 1			
		end
		if ((iReversed % 4) >= 2) then -- Some more gibberish to make the algorithm more complex
			letterValue = -letterValue 			
		end 
		totalValue = totalValue + letterValue -- Same as doing: totalValue = totalValue + letterValue
	end 

	local index = (totalValue % #ChatColors) + 1 -- Makes a number from 1 to 8 depending on totalValue, because there are 8 colors
	return ChatColors[index]
end

local function GetAbsoluteWorldSize(object)
	local worldsize = object.CFrame:VectorToWorldSpace(object.Size)
	return Vector3.new(math.abs(worldsize.X),math.abs(worldsize.Y),math.abs(worldsize.Z))
end
--Important Variables:
plr=PS.LocalPlayer
C.char=plr.Character or plr.CharacterAdded:Wait()
C.human=C.char:WaitForChild("Humanoid")
local hackChanged=Instance.new("BindableEvent")
local computerHackStartTime=os.clock()
local lastHackedPC,lastHackedPosition=nil,Vector3.new(100,100,100)


if C.gameUniverse=="Flee" then
	C.myTSM=plr:WaitForChild("TempPlayerStatsModule");
	C.mySSM=plr:WaitForChild("SavedPlayerStatsModule");
	local myTSM_Module = require(C.myTSM);
	C.myTSM_Get_Hooks = getgenv().TSMGetHooks
	if not C.myTSM_Get_Hooks then
		C.myTSM_Get_Hooks = {}
		--C.myTSM_Module.GetHooks = getgenv().TSMGetHooks
	end
	function C.ConnectPlrTSM(theirPlr,theTSM_Module)
		local function TempPlayerStatsModule(instance_name)
			local instance = C.myTSM:FindFirstChild(instance_name)
			if not instance then
				return
			end
			local caller = getcallingscript()
			local instance_value = instance.Value

			for str, funct in pairs(C.myTSM_Get_Hooks) do
				local result = funct(theirPlr,caller,instance_name,instance_value)
				if result ~= nil then
					return result
				end
			end
			return instance_value
		end
		theTSM_Module.GetValue = TempPlayerStatsModule
		--[[theTSM_Module.GetValue = function(val)
			local instance = TempPlayerStatsModule(val)
			return instance and instance.Value or nil
		end--]]
	end
	function C.SetTempValue(identification,funct)
		C.myTSM_Get_Hooks[identification] = funct or nil
	end
end;
if C.gameName=="FleeMain" then
	if plr:WaitForChild("IsCheckingLoadData").Value then
		local WaitEvent=Instance.new("BindableEvent");
		local function FinishedCheckingDataFunction()
			WaitEvent:Fire(true);
		end;
		plr.IsCheckingLoadData.Changed:Connect(FinishedCheckingDataFunction);
		local function offsetDelayFunction()
			if WaitEvent then
				WaitEvent:Fire(false);
			end;
		end;
		task.delay(10,offsetDelayFunction);
		if not WaitEvent.Event:Wait() then
			warn("Player data has failed to load; waited max time, continuing..") ;
		end;
		WaitEvent:Destroy();
	end;
end;

local function setChangedProperty(object,value,funct,index)
	if object==nil or object.Parent==nil then
		return
	end
	index = index or object
	--index = index and (index..value) or value
	if not C.objectFuncts[object] then
		C.objectFuncts[object] = {};
	end
	if not C.objectFuncts[object][value] then
		C.objectFuncts[object][value] = {};
	end
	local connectionsList = C.objectFuncts[object][value]
	if connectionsList[index] then
		connectionsList[index]:Disconnect();
	end
	if funct then
		local signal = (typeof(funct)=="RBXScriptConnection" and funct) or object:GetPropertyChangedSignal(value):Connect(funct);
		--if value=="Value" and object:IsA("ValueBase") then
		--	C.objectFuncts[object][index] = object.Changed:Connect(funct);
		--else
		--	C.objectFuncts[object][index] = object:GetPropertyChangedSignal(value):Connect(funct);
		--end
		connectionsList[index] = signal;
	else
		connectionsList[index]=nil;
	end
end
local function setChangedAttribute(object,value,funct,index)
	if object==nil or object.Parent==nil then
		return
	end
	--index = "ATTR_"..(index and (tostring(index)..value) or value)
	index = index or GS
	local storeValue = "ATTR_"..value
	if not C.objectFuncts[object] then
		C.objectFuncts[object] = {};
	end
	if not C.objectFuncts[object][storeValue] then
		C.objectFuncts[object][storeValue] = {};
	end
	local connectionsList = C.objectFuncts[object][storeValue]
	if connectionsList[index] then
		connectionsList[index]:Disconnect();
	end
	if funct then
		local signal = (typeof(funct)=="RBXScriptConnection" and funct) or object:GetAttributeChangedSignal(value):Connect(funct);

		connectionsList[index] = signal;
	else
		connectionsList[index]=nil;
	end
end

--Settings:
C.AvailableHacks ={
	["Render"]={
		[1]={
			["Type"]="ExTextButton",
			["Title"]="ESP Players",
			["Universes"] = {"Global"},
			["Desc"]="See players through walls",
			["Shortcut"]="ESP_Players",
			["Default"]=true,
			["ActivateFunction"]=(function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays")) do
					tag.Enabled=newValue
					if tag.Parent.Parent:FindFirstChild("Humanoid")~=nil then
						tag.Parent.Parent.Humanoid.DisplayDistanceType=(newValue and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer)
					end
				end
			end),
			["OthersStartUp"]=(function(theirPlr,theirChar)
				local HRP=theirChar:WaitForChild("HumanoidRootPart",1e5) 
				if not HRP or not theirPlr then
					return
				end
				local newTag=GuiElements.NameTagEx:Clone()
				newTag.Name = "PlayerTag"
				newTag.Username.Text=theirPlr.Name
				newTag.Distance.Visible=C.enHacks.ESP_Distance
				newTag.Parent=HRP
				newTag.Enabled=C.enHacks.ESP_Players
				theirChar.Humanoid.DisplayDistanceType=(C.enHacks.ESP_Players and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer)
				CS:AddTag(newTag,"HackDisplays")
				CS:AddTag(newTag,"RemoveOnDestroy")
				local function childChanged(child)
					if not newTag:FindFirstChild("Username") then
						return
					end
					local setColor3 = C.gameName == "FleeMain" and select(2,C.isInGame(theirChar)) --or "Runner"
					newTag.Username.TextColor3=(setColor3=="Beast" and newColor3(255)) or (setColor3=="Runner" and newColor3(0,0,255))
						or (theirPlr.Team and theirPlr.Team.TeamColor.Color) or newColor3(255,255,0)
				end
				table.insert(C.playerEvents[theirPlr.UserId],(theirChar.ChildAdded:Connect(childChanged)))
				table.insert(C.playerEvents[theirPlr.UserId],(theirChar.ChildRemoved:Connect(childChanged)))
				if C.gameName=="FleeMain" then
					local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule",60)
					if not theirTSM then
						return
					end
					table.insert(C.playerEvents[theirPlr.UserId],(RS.IsGameActive.Changed:Connect(childChanged)))
					table.insert(C.playerEvents[theirPlr.UserId],(theirTSM.Health.Changed:Connect(childChanged)))
				end
				childChanged()
			end),
		},
		[2]={
			["Type"]="ExTextButton",
			["Title"]="ESP Display Distance",
			["Desc"]="Displays distance in studs",
			["Universes"] = {"Global"},
			["Shortcut"]="ESP_Distance",
			["Default"]=true,
			["ActivateFunction"] = (function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays")) do
					tag.Distance.Visible=newValue
				end
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					tag.Distance.Visible=newValue
				end
			end),
			["UpdateDistFunct"]=(function(NameTag,CenterObject)
				local function leFunction()
					local DistanceTag = NameTag:WaitForChild("Distance",10)
					if not DistanceTag then
						return
					end
					while (NameTag~=nil and NameTag.Parent~=nil and NameTag.Parent.Parent~=nil and DistanceTag~=nil and not C.isCleared) do
						local dist=math.round((camera.CFrame.p-(CenterObject.Position+NameTag.StudsOffset)).Magnitude)
						DistanceTag.Text=(dist.."m")
						if C.gameName ~= "FleeMain" or C.isInGame(NameTag.Parent.Parent)==C.isInGame(camera.CameraSubject.Parent) then
							NameTag.PlayerToHideFrom=nil
						else
							NameTag.PlayerToHideFrom=plr
						end
						RunS.RenderStepped:Wait()
					end
				end
				task.spawn(leFunction)
			end),
			["OthersStartUp"]=function(theirPlr,theirChar)
				local HRP=theirChar:WaitForChild("HumanoidRootPart",1e5) 
				if not HRP then 
					return 
				end
				local NameTag=HRP:WaitForChild("PlayerTag",1e5) 
				if not NameTag then 
					return 
				end
				NameTag.Distance.Visible=C.enHacks.ESP_Distance
				C.AvailableHacks.Render[2].UpdateDistFunct(NameTag,HRP)
			end,
			["ComputerAdded"]=function(computer)
				local PrimPart=computer.PrimaryPart
				local NameTag=PrimPart:WaitForChild("NameTagEx")
				C.AvailableHacks.Render[2].UpdateDistFunct(NameTag,PrimPart)
			end,
		},
		[3]={
			["Type"]="ExTextButton",
			["Title"]="ESP Computers",
			["Desc"]="See computers through walls",
			["Shortcut"]="ESP_PC",
			["Default"]=false,
			--[[["ScreenColors"]={
				["Bright blue"]="",
				["Bright red"]="[FAILED]",
				["Dark green"]="[HACKED]"
			},--]]
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					tag.Enabled=newValue
				end
			end,
			["ComputerAdded"]=function(computerTable)
				--if computerTable.ClassName=="Model" and computerTable.Name=="ComputerTable" then
				--if not C.objectFuncts[computerTable] then
				--	C.objectFuncts[computerTable] = {};
				--end
				local primPart,Screen=computerTable.PrimaryPart,computerTable:FindFirstChild("Screen",true);
				local newTag=GuiElements.NameTagEx:Clone();
				newTag.Username.TextColor3=newColor3(84, 84, 84);
				newTag.Distance.Visible=C.enHacks.ESP_Distance;
				newTag.ExtentsOffsetWorldSpace = newTag.ExtentsOffsetWorldSpace + newVector3(0,4,0);
				newTag.Parent=primPart;
				newTag.Enabled=C.enHacks.ESP_PC;

				CS:AddTag(newTag,"RemoveOnDestroy");
				CS:AddTag(newTag,"HackDisplays2");
				local function updateText()
					if not workspace:IsAncestorOf(newTag) then
						return
					end
					newTag.Username.Text="Computer"..string.sub(computerTable.Name,14);
					-- ..(
					--C.AvailableHacks.Render[3].ScreenColors[Screen.BrickColor.Name]
					--	or "[INTERNAL ERROR]")
					newTag.Username.TextColor3=Screen.BrickColor.Color
					newTag.ExpandingBar.Visible=Screen.BrickColor.Name~="Dark green" and (math.abs(newTag.ExpandingBar.AmtFinished.Size.X.Scale%1)<=.00001) and C.enHacks.ESP_PCProg
				end
				setChangedProperty(Screen,"Color",updateText,"ESP_PC")
				updateText()
				--end
			end,
		},

		[4] = {
			["Type"]="ExTextButton",
			["Title"]="ESP Player Highlight",
			["Desc"]="Highlight other players",
			["Shortcut"]="ESP_Highlight",
			["Universes"] = {"Global"},
			["Default"]=true,
			["ActivateFunction"]=function(newValue)
				local VPF=GuiElements.HackGUI:FindFirstChild("ViewportFrame")
				if VPF~=nil then
					VPF.Visible=newValue
				end
			end,
			["OthersStartUp"]=function(theirPlr,theirChar)
				local HRP=theirChar:WaitForChild("HumanoidRootPart",1e5)
				if not HRP then
					return
				end
				local nameTag=HRP:WaitForChild("PlayerTag",1e5) 
				if not nameTag then
					return
				end
				local nameTag_UserName = nameTag:WaitForChild("Username",1e5)
				if not nameTag_UserName then
					return
				end
				local function changeVisibility(Place,Trans,Color)
					Place.FillTransparency = Trans
					Place.OutlineTransparency = Trans>.99 and 1 or 0
					if Color then
						Place.FillColor = Color
					end
				end
				local robloxHighlight = Instance.new("Highlight")
				robloxHighlight.Parent = theirChar
				CS:AddTag(robloxHighlight,"RemoveOnDestroy")
				--local theirViewportChar=VPF:WaitForChild("Model")
				--if not C.enHacks.ESP_Highlight then
				changeVisibility(robloxHighlight,1)	--changeRenderVisibility(theirViewportChar,1)
				--end
				local key
				delay(.25,function()
					--C.objectFuncts[theirChar]=C.objectFuncts[theirChar] or {}
					local theirHumanoid = theirChar:WaitForChild("Humanoid",1000)
					while not C.isCleared and theirChar~=nil and theirChar.Parent~=nil and theirHumanoid and HRP do
						--if C.enHacks.ESP_Highlight then
						--key=#C.objectFuncts[theirChar]+1
						while C.enHacks.ESP_Highlight and nameTag.Parent and nameTag.Parent.Parent and HRP and not C.isCleared do--table.insert(C.objectFuncts[theirChar],key,RunS.RenderStepped:Connect(function(dt)
							if (HRP.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance and (C.gameName~="FleeMain" or (({C.isInGame(theirChar)})[1])==({C.isInGame(camera.CameraSubject.Parent)})[1]) then
								--local didHit,instance=true,theirChar.PrimaryPart
								local didHit,instance=C.raycast(camera.CFrame.p, HRP.Position, {"Blacklist",camera.CameraSubject.Parent}, 300, 0.01,nil,function(result)
									local instance = result and result.Instance
									local Character = instance and instance.Parent and instance.Parent.Parent and instance.Parent.Parent.Parent
										and ((instance.Parent:FindFirstChild("Humanoid") and instance.Parent)
											or (instance.Parent.Parent:FindFirstChild("Humanoid") and instance.Parent.Parent)
											or (instance.Parent.Parent.Parent:FindFirstChild("Humanoid") and instance.Parent.Parent.Parent))
									if Character and Character ~= theirChar then
										return true
									end
									return false
								end)
								--print("Instance",instance)
								changeVisibility(robloxHighlight,(didHit and theirChar:IsAncestorOf(instance)) and 1 or 0,nameTag_UserName.TextColor3)
								--(C.Beast==theirChar and newColor3(255) or newColor3(0,0,255)))--changeRenderVisibility(theirViewportChar,(didHit and theirChar:IsAncestorOf(instance)) and 1 or 0, (theirChar:FindFirstChild("Hammer")==nil and newColor3(0,0,255) or newColor3(255)))
								--myRenderer:step(0)
							else
								changeVisibility(robloxHighlight,1)
								--changeRenderVisibility(theirViewportChar,1,(theirChar:FindFirstChild("Hammer")==nil and newColor3(0,0,255) or newColor3(255)))
							end
							task.wait()
							while theirHumanoid==camera.CameraSubject do
								changeVisibility(robloxHighlight,1) --changeRenderVisibility(theirViewportChar,1)
								camera:GetPropertyChangedSignal("CameraSubject"):Wait()
							end
						end
						--end))
						--elseif C.objectFuncts[theirChar][key]~=nil then
						--C.objectFuncts[theirChar][key]:Disconnect()
						--table.remove(C.objectFuncts[theirChar],key) task.wait()
						changeVisibility(robloxHighlight,1)--changeRenderVisibility(theirViewportChar,1)
						--end
						hackChanged.Event:Wait()
					end
					--if C.objectFuncts[theirChar][key] ~=nil then
					--	C.objectFuncts[theirChar][key]:Disconnect()--do a favor
					--end
				end)
			end,
		},
		[5] = ({
			["Type"]="ExTextButton",
			["Title"]="ESP Computer Highlight",
			["Desc"]="Highlight computers",
			["Shortcut"]="ESP_PCHighlight",
			["ScreenColors"]={
				["Bright blue"]="",
				["Bright red"]="[FAILED]",
				["Dark green"]="[HACKED]"
			},
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				local VPF=GuiElements.HackGUI:FindFirstChild("ViewportFrame")
				if VPF~=nil then
					VPF.Visible=newValue
				end
			end,
			["CleanUp"]=function()
				--[[if C.isCleared then return end
				for num, computerElement in pairs(HackGUI:GetChildren()) do
					if string.sub(computerElement.Name,1,13)=="ComputerTable" then
						C.DestroyInstancelTags(computerElement)
					end
				end--]]
			end,
			["ComputerAdded"]=function(Computer)
				local primPart,Screen=Computer.PrimaryPart,Computer:FindFirstChild("Screen")
				local nameTag = primPart:WaitForChild("NameTagEx")
				--[[local function changeRenderVisibility(Place,Trans,Color)
					if Place:GetAttribute("Color")==Color and Place:GetAttribute("Trans")==Trans then
						--print("returned") wait(.25)
						return
					end
					for num,part in pairs(Place:GetDescendants()) do
						if part:IsA("BasePart") or part:IsA("Decal") then
							if part:GetAttribute("OrgTrans")==nil then
								part:SetAttribute("OrgTrans",part.Transparency)
							end
							if part:GetAttribute("OrgTrans")<.9999 then
								part.Transparency=Trans
							end
							if part:IsA("BasePart") then
								part.Color=Color or part.Color
							end
						end
					end
					Place:SetAttribute("Color",Color)
					Place:SetAttribute("Trans",Trans)
				end--]]
				local function changeVisibility(Place,Trans,Color)
					Place.FillTransparency = Trans
					Place.OutlineTransparency = (Trans>.99 and 1 or 0)
					if Color then
						Place.FillColor = Color
					end
				end
				local robloxHighlight = Instance.new("Highlight",Computer)
				CS:AddTag(robloxHighlight,"RemoveOnDestroy")

				local function ESP_PC_Task_Spawn()
					while not C.isCleared and Computer~=nil and Computer.Parent~=nil do
						while C.enHacks.ESP_PCHighlight and not C.isCleared do
							if (((primPart.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance) and C.isInGame(camera.CameraSubject.Parent)) then
								local didHit = false
								local instance = primPart
								if (C.Map~=nil and Screen~=nil) then    
									local castArgument = camera.CameraSubject~=nil and camera.CameraSubject.Parent
									local castArray = {"Blacklist", castArgument}
									didHit,instance=C.raycast(camera.CFrame.p, Screen.Position, castArray, 100, 0.001)
								end 
								changeVisibility(robloxHighlight,(didHit and Computer:IsAncestorOf(instance) and 1 or 0),Screen.Color)
							else
								changeVisibility(robloxHighlight,1)
							end
							task.wait()
						end
						changeVisibility(robloxHighlight,1)
						hackChanged.Event:Wait()
					end
				end
				task.spawn(ESP_PC_Task_Spawn)


			end,
		}),

		[6]={

			["Type"] = "ExTextButton",
			["Title"] = "ESP Player Progress",
			["Desc"] = "See player's progress",
			["Shortcut"] = "ESP_PlayerProg",
			["Default"] = false,
			["ActivateFunction"] = function(newValue)

				local hackDisplayTags = (CS:GetTagged("HackDisplays"));
				for num, tag in ipairs(hackDisplayTags) do
					local theirChar = tag.Parent.Parent;
					local Plr = PS:GetPlayerFromCharacter(theirChar);
					local TSM = Plr:WaitForChild("TempPlayerStatsModule");
					local condition1 = newValue;
					local condition2 = TSM.ActionProgress.Value~=0;
					local condition3 = TSM.CurrentAnimation.Value~="Typing";
					local isVisible = condition1 and condition2 and condition3;
					tag.ExpandingBar.Visible = isVisible;
				end;
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				local ActionProgress=TSM:WaitForChild("ActionProgress")
				local function ActionChanged()
					local theirChar=theirPlr.Character 
					if not theirChar then
						return
					end
					local HRP=theirChar:FindFirstChild("HumanoidRootPart") 
					if not HRP then 
						return
					end
					local nameTag=HRP:WaitForChild("PlayerTag", _SETTINGS.waitForChildTimout)
					if not nameTag then
						return
					end
					if not nameTag:WaitForChild("ExpandingBar",30) then
						return
					end
					nameTag.ExpandingBar.Visible=(C.enHacks.ESP_PlayerProg and ActionProgress.Value~=0 and TSM.CurrentAnimation.Value~="Typing")
					if TSM.CurrentAnimation.Value=="Typing" then
						C.AvailableHacks.Render[7].RefreshBar(theirPlr,HRP,ActionProgress)
					else
						nameTag.ExpandingBar.AmtFinished.Size=UDim2.new(ActionProgress.Value, 0, 1, 0)
					end
				end
				setChangedProperty(ActionProgress,"Value",ActionChanged)
				ActionChanged()
			end,
		},
		[7]={
			["Type"]="ExTextButton",
			["Title"]="ESP Computer Progress",
			["Desc"]="Works under most conditions",
			["Shortcut"]="ESP_PCProg",
			["Default"]=false,
			["RefreshBar"]=function(theirPlr,CenterPoso,ActionProgress,lastEvent)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				if (TSM.ActionEvent.Value==nil or (TSM.CurrentAnimation.Value~=("Typing")) or (string.sub(TSM.ActionEvent.Value.Parent.Name,1,15)~=("ComputerTrigger"))) then
					return
				end
				local function checkPC()
					local closestPC,dist=nil,150
					for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
						local Screen=tag.Parent
						local PC=Screen.Parent
						local newDist=(Screen.Position-CenterPoso.Position).magnitude
						if newDist<dist then
							closestPC,dist=PC,newDist
						end
					end
					return closestPC
				end

				local closestPC = lastEvent and lastEvent.Parent and lastEvent.Parent.Parent
				if not closestPC then
					closestPC = checkPC()
				end
				if (closestPC~=nil and closestPC.PrimaryPart and closestPC.PrimaryPart:FindFirstChild("NameTagEx")) then
					C.AvailableHacks.Render[7].SetBar(closestPC,ActionProgress.Value)
				end
			end,
			["SetBar"]=function(PC,Progress)
				local ExpandingBar=PC.PrimaryPart:WaitForChild("NameTagEx"):WaitForChild("ExpandingBar")
				ExpandingBar.AmtFinished.Size=UDim2.new(Progress, 0, 1, 0)
				ExpandingBar.Visible=((PC.Screen.BrickColor.Name~=("Dark green")) and Progress>0.001 and C.enHacks.ESP_PCProg)
				PC:SetAttribute("Progress",Progress)
			end,
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					tag.ExpandingBar.Visible = (newValue and tag.ExpandingBar.AmtFinished.Size.X.Scale>0.0001)
				end
			end,
			["ComputerAdded"]=function(PC)
				local progress=PC:GetAttribute("Progress") or 0 -- Implement Zero to indicate no progress
				if progress~=nil then
					C.AvailableHacks.Render[7].SetBar(PC,progress)
				end
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local ActionProgress=TSM:WaitForChild("ActionProgress")
				local ActionEvent = TSM:WaitForChild("ActionEvent")
				--local lastEvent
				local function ActionChanged()
					local theirChar=plr.Character 
					if theirChar==nil then
						return
					end
					local HRP=theirChar:FindFirstChild("HumanoidRootPart")
					if not HRP then
						return
					end
					if TSM.CurrentAnimation.Value=="Typing" then
						--lastEvent = ActionEvent.Value or lastEvent
						C.AvailableHacks.Render[7].RefreshBar(plr,HRP,ActionProgress,ActionEvent.Value)
					end
					--[[local function SetMiniGameResultFunction()
						for s=1,1,-1 do
							if not C.enHacks.Util_AutoHack then
								return
							end
							RS.C.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
							task.wait((0.05))
						end
					end
					task.spawn(SetMiniGameResultFunction)--]]
				end
				setChangedProperty(ActionProgress,"Value",ActionChanged)

				ActionChanged()
			end,
		},
		[30]={
			["Type"]="ExTextButton",
			["Title"]="Freezing Pods",
			["Desc"]="Interactable Freezing Pods",
			["Shortcut"]="Render_FreezingPods",
			["Default"]=false,
			["Funct"]=nil,
			["Event"]=nil,
			["SetEnabled"]=function(tag)
				local isInGame=C.isInGame(camera.CameraSubject.Parent)
				local newValue = C.enHacks.Render_FreezingPods

				local canBeActive = newValue == true
				tag.Enabled=canBeActive and C.AllowedCameraEnums[camera.CameraType] and isInGame
				if tag:FindFirstChild("Toggle") then
					tag.Toggle.Text = C.myTSM.IsBeast.Value and "Capture" or "Rescue"
				end
			end,
			["ActivateFunction"]=function(newValue)
				local hackDisplayList = CS:GetTagged("HackDisplay3")
				for num,tag in ipairs(hackDisplayList) do
					C.AvailableHacks.Render[30].SetEnabled(tag)
				end
			end,
			["CleanUp"]=function()
				C.DestroyAllTaggedObjects("HackDisplay3")
				--if C.AvailableHacks.Render[30].Event then
				--	C.AvailableHacks.Render[30].Event:Destroy()
				--end
				--C.AvailableHacks.Render[30].Event=nil
				--[[if C.objectFuncts[C.AvailableHacks.Render[30].Event] then
					C.objectFuncts[C.AvailableHacks.Render[30].Event][1]:Disconnect()
					C.objectFuncts[C.AvailableHacks.Render[30].Event] = nil
				end--]]
			end,
			["UpdateDisplays"]=function()
				C.AvailableHacks.Render[30].ActivateFunction(C.enHacks.RemotelyHackComputers)
			end,
			--CHECKED UNDER REMOTE DOORS HACK!
			["CapsuleAdded"]=function(Capsule)
				local CapsulePrimaryPart = Capsule.PrimaryPart
				local PodTriggerPart = Capsule:WaitForChild("PodTrigger",30)
				if not PodTriggerPart then
					return
				end
				local CapturedTorso = Capsule:WaitForChild("PodTrigger"):WaitForChild("CapturedTorso")
				local ActionSign = Capsule:WaitForChild("PodTrigger"):WaitForChild("ActionSign")
				local carriedTorso = workspace:WaitForChild("CarriedTorsoChanged",30)
				if not carriedTorso then
					--if C.Map then
					print("uh oh! not found: CarriedTorsoChanged.Event")
					--end
					return
				end
				local isBeast = C.myTSM:WaitForChild("IsBeast")

				local newTag=C.ToggleTag:Clone()
				newTag.Name = "Pod"
				newTag.Parent=GuiElements.HackGUI
				newTag.ExtentsOffsetWorldSpace = Vector3.new(0, 12, 0)
				newTag.Adornee=CapsulePrimaryPart
				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplay3")
				task.wait()
				if newTag==nil or newTag.Parent==nil or newTag:FindFirstChild("Toggle")==nil then
					return
				end
				local ToggleButton = newTag.Toggle
				ToggleButton.BackgroundColor3 = Color3.fromRGB(255,0,255)
				ToggleButton.Text = C.myTSM.IsBeast.Value and "Capture" or "Rescue"
				C.AvailableHacks.Render[30].SetEnabled(newTag)
				local function setToggleFunction()
					if isBeast.Value then
						local theirChar = C.Beast.CarriedTorso.Value.Parent
						C.AvailableHacks.Beast[60].CaptureSurvivor(PS:GetPlayerFromCharacter(theirChar),theirChar, Capsule, true)
					else
						if C.myTSM.Health.Value > 0 then
							C.AvailableHacks.Runner[80].RescueSurvivor(Capsule,true)
						else
							print("You aren't a runner, so you can't rescue!")
						end
					end
				end
				local function setVisible()
					if isBeast.Value and ActionSign.Value == 30 
						and C.Beast and C.Beast:FindFirstChild("CarriedTorso") and C.Beast.CarriedTorso.Value then--30: TRAP
						ToggleButton.Visible = true
					elseif not isBeast.Value and ActionSign.Value == 31 and CapturedTorso.Value then--31: FREE
						ToggleButton.Visible = true
					else
						ToggleButton.Visible = false
					end
				end
				C.objectFuncts[ToggleButton]={MouseButton1Up={ToggleButton.MouseButton1Up:Connect(setToggleFunction)},
				CapturedTorso={CapturedTorso.Changed:Connect(setVisible)},
				ActionSign={ActionSign.Changed:Connect(setVisible)},
				CarriedTorso={carriedTorso.Event:Connect(setVisible)},
				}
				setVisible()
			end,
			["MyPlayerAdded"]=function()
				C.AvailableHacks.Render[30].Event = C.AvailableHacks.Render[30].Event or Instance.new("BindableEvent")
				C.AvailableHacks.Render[30].Event:AddTag("RemoveOnDestroy")
				C.AvailableHacks.Render[30].Event.Name="CarriedTorsoChanged"
				C.AvailableHacks.Render[30].Event.Parent = workspace
			end,
			["MyBeastAdded"]=function()
				repeat
					RunS.RenderStepped:Wait()
				until C.AvailableHacks.Render[30].Event
				if not C.Beast then error("Where the dog go") return end
				setChangedProperty(C.Beast:WaitForChild("CarriedTorso"),"Value",function(newValue)
					C.AvailableHacks.Render[30].Event:Fire(newValue)
				end,"CarriedTorsoChanged")
			end,
			["OthersBeastAdded"]=function()
				C.AvailableHacks.Render[30].MyBeastAdded()
			end,
		},
		[29]={
			["Type"]="ExTextButton",
			["Title"]="Interactable Downed Runners",
			["Desc"]="Attach/Unattach Rope To Downed Runners",
			["Shortcut"]="Render_DownedRunner",
			["Default"]=false,
			["SetEnabled"]=function(tag)
				local isInGame=C.isInGame(camera.CameraSubject.Parent)
				local newValue = C.enHacks.Render_DownedRunner

				local canBeActive = newValue == true
				tag.Enabled=canBeActive and C.AllowedCameraEnums[camera.CameraType] and isInGame
			end,
			["ActivateFunction"]=function(newValue)
				local hackDisplayList = CS:GetTagged("HackDisplay5")
				for num,tag in ipairs(hackDisplayList) do
					C.AvailableHacks.Render[29].SetEnabled(tag)
				end
			end,
			["UpdateDisplays"]=function()
				C.AvailableHacks.Render[29].ActivateFunction(C.enHacks.Render_DownedRunner)
			end,
			["StartUp"]=function(theirPlr,theirChar)
				local carriedTorso = workspace:WaitForChild("CarriedTorsoChanged",math.huge)
				local theirPrimPart = theirChar:WaitForChild("Torso",30)
				if not carriedTorso or not theirPrimPart then
					if C.Map and not C.isCleared then
						print("uh oh! CarriedTorsoChanged.Event found")
					end
					return
				end
				local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule",30)
				local theirRagdollValue = theirTSM and theirTSM:WaitForChild("Ragdoll",30)
				if not theirRagdollValue then
					print("Ragdoll Not Found For",theirPlr)
					return
				end

				local newTag=C.ToggleTag:Clone()
				newTag.Name = "Player"
				newTag.Parent=GuiElements.HackGUI
				newTag.ExtentsOffsetWorldSpace = Vector3.new(0, 0, 0)
				newTag.Adornee=theirPrimPart
				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplay5")
				task.wait()
				if newTag==nil or newTag.Parent==nil or newTag:FindFirstChild("Toggle")==nil then
					return
				end
				local ToggleButton = newTag.Toggle
				ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
				ToggleButton.Text = C.myTSM.IsBeast.Value and "Capture" or "Rescue"
				C.AvailableHacks.Render[29].SetEnabled(newTag)
				local function setToggleFunction()
					if C.Beast:FindFirstChild("CarriedTorso") and C.Beast.CarriedTorso.Value ~= theirPrimPart then
						C.AvailableHacks.Beast[55].RopeSurvivor(theirTSM,theirPlr,true) -- Rope the survivor
					else
						C.AvailableHacks.Runner[3].ChangedFunction(theirPrimPart,true) -- Unrope him!
					end
				end
				local function setVisible()
					if C.Beast and C.Beast:FindFirstChild("CarriedTorso") and C.Beast.CarriedTorso.Value == theirPrimPart then
						ToggleButton.Text = "rem"
					else
						ToggleButton.Text = "add"
					end
					ToggleButton.Visible = theirRagdollValue.Value
				end
				C.objectFuncts[ToggleButton]={MouseButton1Up={ToggleButton.MouseButton1Up:Connect(setToggleFunction)},
				CarriedTorso={carriedTorso.Event:Connect(setVisible)},
				RagdollChanged={theirRagdollValue.Changed:Connect(setVisible)},
				}
				setVisible()
			end,
			--[[["MyStartUp"]=function(...)
				C.AvailableHacks.Render[29].StartUp(...)
			end,
			["OthersStartUp"]=function(...)
				C.AvailableHacks.Render[29].StartUp(...)
			end,
			["BeastAdded"]=function(beastPlr,beastChar)

			end,
			["MyBeastAdded"]=function(...)
				C.AvailableHacks.Render[29].BeastAdded(...)
			end,
			["OthersBeastAdded"]=function(...)
				C.AvailableHacks.Render[29].BeastAdded(...)
			end,--]]
		},
		[28]={
			["Type"]="ExTextButton",
			["Title"]="Remote Computers",
			["Desc"]="Interactable Computers",
			["Shortcut"]="Render_HackComputers",
			["Default"]=false,
			["SetEnabled"]=function(tag)
				local isInGame=C.isInGame(camera.CameraSubject.Parent)
				local newValue = C.enHacks.Render_HackComputers

				local canBeActive = newValue == true
				tag.Enabled=canBeActive and C.AllowedCameraEnums[camera.CameraType] and isInGame
			end,
			["ActivateFunction"]=function(newValue)
				local hackDisplayList = CS:GetTagged("HackDisplay4")
				for num,tag in ipairs(hackDisplayList) do
					C.AvailableHacks.Render[28].SetEnabled(tag)
				end
			end,
			["CleanUp"]=function()
				C.DestroyAllTaggedObjects("HackDisplay4")
				C.AvailableHacks.Render[28].ComputerTeleportFunctions={}
			end,
			["UpdateDisplays"]=function()
				C.AvailableHacks.Render[28].ActivateFunction(C.enHacks.Render_HackComputers)
			end,
			["ComputerTeleportFunctions"]={},
			--CHECKED UNDER REMOTE DOORS HACK!
			["ComputerAdded"]=function(Computer)
				local Screen = Computer:WaitForChild("Screen")
				local ComputerBase = Computer.PrimaryPart
				local BestTrigger
				local bestAngle = 3
				for trigger_index = 1, 3, 1 do -- loop through ComputerTrigger 1 through 3
					local trigger_name = "ComputerTrigger"..trigger_index
					local trigger = Computer:WaitForChild(trigger_name, 20)
					if not trigger then
						return
					end
					local angle = math.abs(math.acos(ComputerBase.CFrame.LookVector:Dot((trigger.Position - ComputerBase.Position).Unit)))
					if math.abs(angle - 1.57) < bestAngle then
						bestAngle = angle
						BestTrigger = trigger
					end
				end

				local newTag=C.ToggleTag:Clone()
				local isInGame=C.isInGame(workspace.Camera.CameraSubject.Parent)
				newTag.Name = "PCTrigger"
				newTag.Parent=GuiElements.HackGUI
				newTag.ExtentsOffsetWorldSpace = Vector3.new(0, 12, 0)
				newTag.Adornee=ComputerBase
				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplay4")
				task.wait()
				if newTag==nil or newTag.Parent==nil or newTag:FindFirstChild("Toggle")==nil then
					return
				end
				local ToggleButton = newTag.Toggle
				ToggleButton.Text = "Teleport"
				local function setToggleFunction()
					local ActionEventVal = C.myTSM:WaitForChild("ActionEvent").Value
					local TriggerType = ActionEventVal and trigger_gettype(ActionEventVal.Parent.Parent)
					if ActionEventVal and TriggerType=="Computer" then
						task.spawn(stopCurrentAction)
					end
					local goodTriggers = C.AvailableHacks.Bot[15].getGoodTriggers(Computer)
					if #goodTriggers>0 then
						local selectedTriggerKey = table.find(goodTriggers,BestTrigger) or 1
						teleportMyself(goodTriggers[selectedTriggerKey]:GetPivot())
					else
						teleportMyself(BestTrigger:GetPivot())
					end
				end
				local function hackedTeleportFunction()
					if ((Screen.Color.G*255)<128) and ((Screen.Color.G*255)>126) then--check if its green, meaning no hack hecked pcs!
						ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
					else
						ToggleButton.BackgroundColor3 = Color3.fromRGB(0,0,170)
					end
				end
				ToggleButton.MouseButton1Up:Connect(setToggleFunction)
				C.AvailableHacks.Render[28].ComputerTeleportFunctions[Computer] = setToggleFunction
				C.AvailableHacks.Render[28].SetEnabled(newTag)
				setChangedProperty(Screen, "Color", hackedTeleportFunction,"Render_HackComputers")
				hackedTeleportFunction()
			end,
		},
		[33]={
			["Type"]="ExTextButton",
			["Title"]="ESP Island Capture",
			["Desc"]="Auto captures from wherever you are",
			["Shortcut"]="Render_IslandCaptureButton",
			["Default"]=false,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("GameHackDisplays")) do
					tag.Enabled=newValue
				end
			end,
			["IslandAdded"]=function(island)
				local newTag=C.ToggleTag:Clone()
				newTag.Name = "Island"
				newTag.Parent=GuiElements.HackGUI
				newTag.StudsOffsetWorldSpace = Vector3.new(0, 45, 0)
				newTag.ExtentsOffsetWorldSpace = Vector3.zero

				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"GameHackDisplays")
				setChangedProperty(island,"Parent",function()
					newTag:Destroy()
				end)
				local TeamVal = island:WaitForChild("Team")
				local HPVal = island:WaitForChild("HP")
				local IslandCode = island:WaitForChild("IslandCode").Value
				local FlagPad = island:WaitForChild("Flag"):WaitForChild("FlagPad")
				local button = newTag:WaitForChild("Toggle")
				local isEn = false
				local Info = {Name="Capturing "..IslandCode,Tags={"RemoveOnDestroy"}}
				local function activate(new)
					isEn = new
					button.Text = isEn and "Pause" or "Capture"
					button.BackgroundColor3 = isEn and Color3.fromRGB(255) or Color3.fromRGB(170,0,255)
					if new then
						local ActionClone = C.AddAction(Info)
						local Touching = false
						while Info.Enabled and TeamVal.Value == "" and ActionClone and ActionClone.Parent do
							ActionClone.Time.Text = ("%.2f%%"):format(100 * (HPVal.Value / (8000)))
							Touching = not Touching
							local PrimaryPart = C.char and C.char.PrimaryPart
							if PrimaryPart then
								firetouchinterest(FlagPad, C.char.PrimaryPart, Touching and 0 or 1)
							end
							RunS.RenderStepped:Wait()
						end
						return activate(false) -- Disable it
					end
					C.RemoveAction(Info.Name)
				end
				button.MouseButton1Up:Connect(function()
					activate(not isEn)
				end)
				activate(isEn)
				local function UpdVisibiltiy()
					button.Visible = TeamVal.Value == ""
				end
				setChangedProperty(TeamVal,"Value",UpdVisibiltiy,"Render_IslandCaptureButton")
				UpdVisibiltiy()
				newTag.Adornee=FlagPad
				newTag.Enabled = C.enHacks.Render_IslandCaptureButton
			end,
		},
		[36]={
			["Type"]="ExTextButton",
			["Title"]="ESP Loop Bomb",
			["Desc"]="Continuously Bombs",
			["Shortcut"]="Render_IslandBombBase",
			["Default"]=false,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("GameHackDisplays2")) do
					C.AvailableHacks.Render[36].RefreshEn(tag)
				end
			end,
			["RefreshEn"]=function(tag)
				if not tag.Adornee then
					return
				end
				local Base = tag.Adornee.Parent
				if Base then 
					local Team, HP = Base:WaitForChild("Team",5), Base:WaitForChild("HP")
					if Team and HP and HP.Value > 0 then
						local Plane = C.human and C.human.SeatPart and C.human.SeatPart.Parent
						if Plane and C.human.SeatPart.Name == "Seat" then
							local HitCode = Plane:FindFirstChild("HitCode")
							if HitCode and HitCode.Value == "Plane" then
								tag.Enabled = C.enHacks.Render_IslandBombBase and Team.Value ~= plr.Team.Name and Team.Value ~= ""
								return
							end
						end
					end
				end
				tag.Enabled = false
			end,
			["MyPlayerAdded"]=function()
				C.AvailableHacks.Render[36].Funct = plr:GetPropertyChangedSignal("Team"):Connect(C.AvailableHacks.Render[36].ActivateFunction)
			end,
			["MySeatAdded"]=function()
				C.AvailableHacks.Render[36].ActivateFunction()
			end,
			["MySeatRemoved"]=function()
				C.AvailableHacks.Render[36].ActivateFunction()
			end,
			["IslandAdded"]=function(island)
				local DropOffset = 250
				local TimeFromDropToExpl = math.sqrt(DropOffset/workspace.Gravity)
				
				
				
				local newTag=C.ToggleTag:Clone()
				newTag.Name = "LoopBombESP"
				newTag.Parent=GuiElements.HackGUI
				newTag.ExtentsOffsetWorldSpace = Vector3.zero

				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"GameHackDisplays2")
				setChangedProperty(island,"Parent",function()
					newTag:Destroy()
				end)
				local IslandData = C.DataStorage[island.Name]
				local TeamVal = island:WaitForChild("Team")
				local HPVal = island:WaitForChild("HP")
				local HitCode = island:WaitForChild("HitCode").Value
				local IslandBody = island:WaitForChild("MainBody")
				local button = newTag:WaitForChild("Toggle")
				local isEn = false
				local Info = {Name="LoopBomb",Title="Bombing "..HitCode,Tags={"RemoveOnDestroy"}}
				newTag.StudsOffsetWorldSpace = Vector3.new(0, HitCode=="Dock" and 120 or 60, 0)
				local function basebomb_activate(new)
					button.Text = new and "Pause" or "Bomb"
					button.BackgroundColor3 = new and Color3.fromRGB(255) or (HitCode=="Dock" and Color3.fromRGB(170,0,255) or Color3.fromRGB(170,255))
					if new then
						if C.GetAction(Info.Name) then
							C.RemoveAction(Info.Name)
							RunS.RenderStepped:Wait()
						end
						
						
						local Plane = C.human.SeatPart.Parent
						local PlaneMB = Plane:WaitForChild("MainBody")
						local BombC = Plane:WaitForChild("BombC")
						local ActionClone = C.AddAction(Info)
						
						local IslandLoc
						
						local HalfSize = IslandBody.Size/4 -- Make it a quarter so it doesn't miss!
						local Randomizer = Random.new()
						
						local XOfffset,ZOffset
						local TargetCF
						
						local function CalculateNew(Regenerate)
							if Regenerate or not XOfffset then
								XOfffset,ZOffset = Randomizer:NextNumber(-HalfSize.X,HalfSize.X), Randomizer:NextNumber(-HalfSize.Z,HalfSize.Z)
							end
							IslandLoc = IslandBody:GetPivot() + (IslandBody.AssemblyLinearVelocity * TimeFromDropToExpl)
							TargetCF = IslandLoc * CFrame.new(XOfffset,0,ZOffset) + Vector3.new(0,DropOffset,0)
						end
												
						local WhileIn = 0
						while Info.Enabled and TeamVal.Value ~= "" and TeamVal.Value ~= plr.Team.Name and ActionClone and ActionClone.Parent and island.Parent
							and C.human.SeatPart and C.human.SeatPart.Parent == Plane and HPVal.Value > 0 do
							CalculateNew(Randomizer:NextInteger(1,5) == 1)
							if not C.GetAction("Plane Refuel") and BombC.Value > 0 then
								PlaneMB.AssemblyLinearVelocity = TargetCF.Position - PlaneMB.Position
								--PlaneMB.AssemblyAngularVelocity = Vector3.zero
								if BombC.Value > 0 and WhileIn>.5 then
									WhileIn = 0
									C.RemoteEvent:FireServer("bomb")
								end
							elseif BombC.Value == 0 and not C.enHacks.Blatant_NavalInstantRefuel then
								break
							end
							ActionClone.Time.Text = ("%.2f%%"):format(100-100 * (HPVal.Value / IslandData.Health))
							local Distance = ((PlaneMB:GetPivot().Position - TargetCF.Position)/Vector3.new(1,1000,1)).Magnitude
							if Distance > 30 and not C.GetAction("Plane Refuel") then
								PlaneMB:PivotTo(TargetCF)
							end
							if Distance < 300 then
								WhileIn += RunS.RenderStepped:Wait()
							else
								WhileIn = 0
								RunS.RenderStepped:Wait()
							end
						end
						isEn = true
						return basebomb_activate(false) -- Disable it
					elseif isEn then -- Disable only if we WERE bombing earlier!
						C.RemoveAction(Info.Name)
					end
					isEn = new
				end
				button.MouseButton1Up:Connect(function()
					basebomb_activate(not isEn)
				end)
				basebomb_activate(isEn)
				local function UpdVisibiltiy()
					C.AvailableHacks.Render[36].RefreshEn(newTag)
				end
				setChangedProperty(TeamVal,"Value",UpdVisibiltiy)
				setChangedProperty(HPVal,"Value",UpdVisibiltiy)
				UpdVisibiltiy()
				newTag.Adornee=IslandBody
			end,
			["DockAdded"]=function(dock)
				C.AvailableHacks.Render[36].IslandAdded(dock)
			end,
			["ShipAdded"]=function(ship)
				C.AvailableHacks.Render[36].IslandAdded(ship)
			end,
		},

	},
	["Blatant"]={
		--[[[1]={
			["Type"]="ExTextBox",
			["Title"]="Jump Height",
			["Desc"]="Set to 16 to default",
			["Shortcut"]="WalkSpeed",
			["Default"]=16,
			["MinBound"]=0,
			["MaxBound"]=1e3,
			["ActivateFunction"]=function(newValue)
				local function setSpeed()
					C.human.WalkSpeed=newValue==16 and plr.TempPlayerStatsModule.NormalWalkSpeed.Value or newValue
				end

				if newValue==16 then
					setChangedProperty(C.human,"WalkSpeed",false)
				else
					setChangedProperty(C.human,"WalkSpeed",setSpeed)
				end
				setSpeed()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				C.AvailableHacks.Blatant[1].ActivateFunction(C.enHacks.WalkSpeed)
			end,
		},--]]

		--[[[4]={
			["Type"]="ExTextButton",
			["Title"]="Prevent Ragdoll",
			["Desc"]="Unknown use",
			["Shortcut"]="PreventRagdoll",
			["EnableScript"]=function()
				wait(.075)
				plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("Ragdoll").Value=false
			end,
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				setChangedProperty(plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("Ragdoll"),"Value",newValue and 
					C.AvailableHacks.Blatant[4].EnableScript or false)
				if newValue then
					spawn(C.AvailableHacks.Blatant[4].EnableScript)
				end
			end,
		},--]]
		[5]={
			["Type"]="ExTextButton",
			["Title"]="Auto Teleport Back",
			["Desc"]="Instantly teleport back",
			["Shortcut"]="Blatant_TeleportBack",
			["Default"]=false,
			["Functs"]={},
			["DontActivate"]=true,
			["BlockTeleports"]=false,
			["Universes"]={"Global"},
			["Deb"]=0,
			["ActivateFunction"]=function(newValue)
				for num, funct in ipairs(C.AvailableHacks.Blatant[5].Functs) do
					funct:Disconnect()
				end C.AvailableHacks.Blatant[5].Functs = {}
				C.AvailableHacks.Blatant[5].Deb += 1 local SaveDeb = C.AvailableHacks.Blatant[5].Deb
				if not C.enHacks.Blatant_TeleportBack then
					return
				end
				local CenterPart = (C.gameName == "FleeMain" and C.char:FindFirstChild("HumanoidRootPart")) 
					or (C.human.RigType == Enum.HumanoidRigType.R6 and C.char:WaitForChild("Torso",2)) or C.char:WaitForChild("HumanoidRootPart")
				local newInput = nil
				C.LastLoc = C.char:GetPivot() -- Inital Starting Position
				C.AvailableHacks.Blatant[5].BlockTeleports = C.gameUniverse ~= "NavalWarefare" or (C.isInGame and C.isInGame(C.char))
				local function CanRun()
					return C.AvailableHacks.Blatant[5].Deb == SaveDeb and C.char and CenterPart and C.enHacks.Blatant_TeleportBack
				end
				task.spawn(function()
					while CanRun() do
						C.LastLoc = C.char:GetPivot()
						RunS.RenderStepped:Wait()
					end
				end)
				local function TeleportDetected()
					newInput = C.char:GetPivot()
					if C.AvailableHacks.Blatant[5].BlockTeleports then
						if (newInput.Position - C.LastLoc.Position).Magnitude > 16 then
							C.LastTeleportLoc = C.LastLoc
							C.char:PivotTo(C.LastLoc)
						end
					elseif (C.isInGame and C.isInGame(C.char)) then
						task.wait(.5)
						C.AvailableHacks.Blatant[5].BlockTeleports = true
					end
				end
				local function AddToCFrameDetection(part)
					table.insert(C.AvailableHacks.Blatant[5].Functs,part:GetPropertyChangedSignal("Position"):Connect(TeleportDetected))
					--table.insert(C.AvailableHacks.Blatant[5].Functs,part:GetPropertyChangedSignal("CFrame"):Connect(TeleportDetected))
				end
				for num, part in ipairs(C.char:GetChildren()) do
					if part:IsA("BasePart") then--and part.Name == "Head" then
						AddToCFrameDetection(part)
					end
				end
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Blatant[5].ActivateFunction(C.enHacks.Blatant_TeleportBack)
			end,
		},
		[10]={
			["Type"]="ExTextButton",
			["Title"]="Auto Close",
			["Desc"]="Instantly close doors!",
			["Shortcut"]="AutoDoorClose",
			["CloseDoor"]=function(Trigger)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local ActionEventVal=TSM:WaitForChild("ActionEvent") 
				local CurrentActionEvent=ActionEventVal.Value
				C.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
				task.wait()
				C.RemoteEvent:FireServer("Input", "Action", true)
				C.RemoteEvent:FireServer("Input", "Trigger", false, Trigger.Event)
				ActionEventVal.Value=nil
				while Trigger.ActionSign.Value~=10 do--wait for it to be opened
					Trigger.ActionSign.Changed:Wait()
				end
				for s=5,1,-1 do
					if Trigger.ActionSign.Value==11 then
						break
					end
					C.RemoteEvent:FireServer("Trigger", "Input", true, Trigger.Event)
					C.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
					ActionEventVal.Value=CurrentActionEvent
					TSM.OnTrigger.Value=true
					wait(.05)
				end
			end,
			["EnableScript"]=function()
				local TSM = plr:WaitForChild("TempPlayerStatsModule")
				local ActionEventVal = TSM:WaitForChild("ActionEvent") 
				if ((ActionEventVal==nil) or ((TSM.ActionProgress.Value % 1)~=0) or (ActionEventVal.Value==nil)) then
					return nil
				end 
				if (not TSM.ActionInput.Value and plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("ActionBox").Visible) then
					return nil
				end
				local ActionEvent = ActionEventVal.Value
				local Trigger = ActionEvent.Parent
				local isOpened = (Trigger.ActionSign.Value==11 or Trigger.ActionSign.Value==0)

				if (isOpened) then
					C.AvailableHacks.Blatant[10].CloseDoor(Trigger)
				end
			end,
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				setChangedProperty(plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("ActionInput"),"Value",(newValue and C.AvailableHacks.Blatant[10].EnableScript or false))
				if newValue then
					C.AvailableHacks.Blatant[10].EnableScript()
				end
			end,
		},
		[15]={
			["Type"]="ExTextButton",
			["Title"]="Remote Doors",
			["Desc"]="Remotely open doors!",
			["Shortcut"]="RemotelyOpenDoors",
			["Default"]=false,
			["DifferentColors"] = {

				[12] = {
					"Exit",
					newColor3(255,170)
				},
				[11] = {
					"Close",
					newColor3(0,255)
				},
				[10] = {
					"Open",
					newColor3(255,255)
				},
				[0] = {
					"...",
					newColor3(255)
				},
			},
			["DoorFuncts"]={},
			["ChangedFunction"] = function(door,tag,doorType)
				local myDoorTrigger = door:FindFirstChild("DoorTrigger");
				if not myDoorTrigger then
					myDoorTrigger = door:FindFirstChild("ExitDoorTrigger");
				end;
				local Toggle = tag:WaitForChild("Toggle", _SETTINGS.waitForChildTimout);
				if Toggle==nil then
					return
				end
				--local tag=doorTrigger.C.ToggleTag
				local ActionSign = myDoorTrigger:WaitForChild("ActionSign",1e5)
				if not ActionSign then
					return
				end
				ActionSign = ActionSign.Value
				local currentSign = ((ActionSign==10 and door.Name=="ExitDoor") and 12 or ActionSign)
				Toggle.Text = C.AvailableHacks.Blatant[15].DifferentColors[currentSign][1]
				Toggle.BackgroundColor3 = C.AvailableHacks.Blatant[15].DifferentColors[currentSign][2]
				Toggle.Visible = (door.Name~="ExitDoor" or currentSign~=0)
				if ActionSign == 10 or ActionSign == 11 then
					door:SetAttribute("Opened",ActionSign == 11)
				end
				local modifier=door:WaitForChild("WalkThru",20)
				if modifier~=nil then
					modifier.PathfindingModifier.Label = ((currentSign==10 or currentSign==12) and "DoorPath" or "DoorOpened")
				end
			end,
			["ActivateFunction"]=function(newValue)
				local isInGame=C.isInGame(camera.CameraSubject.Parent)
				local hackDisplayList = CS:GetTagged("HackDisplay2")
				for num,tag in ipairs(hackDisplayList) do
					tag.Enabled=newValue and C.AllowedCameraEnums[camera.CameraType] and isInGame
				end
			end,
			["CleanUp"]=function()
				C.DestroyAllTaggedObjects("HackDisplay2")
				C.AvailableHacks.Blatant[15].DoorFuncts = {}
			end,
			["UpdateDisplays"]=function()
				C.AvailableHacks.Blatant[15].ActivateFunction(C.enHacks.RemotelyOpenDoors)
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local function updateDisplays()
					C.AvailableHacks.Blatant[15].UpdateDisplays()
					C.AvailableHacks.Render[28].UpdateDisplays()
					C.AvailableHacks.Render[29].UpdateDisplays()
					C.AvailableHacks.Render[30].UpdateDisplays()					
				end
				table.insert(C.functs,RS:WaitForChild("AnnouncementEvent").OnClientEvent:Connect(function(...)
					--print(...)
					if not ... then
						updateDisplays()
					end
				end))--]]
				setChangedProperty(RS.IsGameActive,"Value",updateDisplays)
				setChangedProperty(camera,"CameraSubject",updateDisplays)
				setChangedProperty(TSM:WaitForChild("Escaped"),"Value",updateDisplays)
			end,
			["DoorAdded"]=function(door,doorType)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local doorTrigger=doorType~="ExitDoor" and door:WaitForChild("DoorTrigger",100) or door:WaitForChild("ExitDoorTrigger",(15*60)+20)
				if not doorTrigger then
					return
				end
				local actionSign=doorTrigger:WaitForChild("ActionSign",1e5)
				if not actionSign then
					return
				end
				local WalkThru = door:WaitForChild("WalkThru",69)
				if not WalkThru then
					return
				end
				local newTag=C.ToggleTag:Clone()
				local isInGame=C.isInGame(workspace.Camera.CameraSubject.Parent)
				newTag.Parent=GuiElements.HackGUI
				newTag.ExtentsOffsetWorldSpace = Vector3.new(0, 1, 0)
				newTag.Adornee=WalkThru
				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplay2")
				task.wait()
				if newTag==nil or newTag.Parent==nil or newTag:FindFirstChild("Toggle")==nil then
					return
				end
				local function getState()
					return actionSign.Value==11--returns true if opened!
				end
				local function setToggleFunction(noWait,noTriggers)
					if noWait~=true and actionSign.Value==0 then
						for s=3,1,-1 do
							if actionSign.Value~=0 then
								break
							end
							wait(.075)
						end
					end
					if actionSign.Value==0 then
						return
					end
					local saveActionSign = actionSign.Value
					local doorTriggerEvent = doorTrigger:FindFirstChild("Event")
					if not doorTriggerEvent then
						return
					end
					local isOpened,currentEvent=getState(),TSM.ActionEvent.Value
					if noTriggers~=true then
						trigger_setTriggers("RemoteDoorControl",false)
					end
					for s=5,1,-1 do
						if isOpened~=getState() or not doorTriggerEvent or not doorTriggerEvent.Parent or (saveActionSign ~= actionSign.Value and actionSign.Value ~= 0) then
							break
						end
						C.RemoteEvent:FireServer("Input", "Trigger", true, doorTrigger.Event)
						--RunS.RenderStepped:Wait()
						C.RemoteEvent:FireServer("Input", "Action", true)
						RunS.RenderStepped:Wait()
						if isOpened then
							C.RemoteEvent:FireServer("Input", "Trigger", false)
							RunS.RenderStepped:Wait()
						end
					end
					if noTriggers~=true then
						local function TaskSpawnDelayedFunction()
							while actionSign.Value==0 do
								actionSign.Changed:Wait()
							end
							trigger_setTriggers("RemoteDoorControl",true)
						end
						task.spawn(TaskSpawnDelayedFunction)
					end
					--wait()
					if currentEvent~=nil and not isOpened and false then--and saveActionSign == actionSign.Value then
						C.RemoteEvent:FireServer("Input", "Trigger", true, currentEvent)
						--wait()
						--C.RemoteEvent:FireServer("Input", "Action", true)
					end
				end
				C.AvailableHacks.Blatant[15].DoorFuncts[door] = setToggleFunction
				newTag.Toggle.MouseButton1Up:Connect(setToggleFunction)
				C.AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				newTag.Enabled=(C.enHacks.RemotelyOpenDoors and (C.AllowedCameraEnums[camera.CameraType] and isInGame))
				local function actionSignChangedFunct()
					C.AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				end
				setChangedProperty(actionSign,"Value", (actionSignChangedFunct))
			end,
		},
		[18]={
			["Type"]="ExTextButton",
			["Title"]="Keep Doors Opened",
			["Desc"]="Keep on for doors always to be opened!",
			["Shortcut"]="Blatant_KeepDoorsOpen",
			["Default"]=false,
			["DontActivate"]=true,
			["SaveDeb"]=0,
			["Functs"]={},
			["ActivateFunction"]=function()
				C.AvailableHacks.Blatant[18].SaveDeb += 1
				local saveDeb = C.AvailableHacks.Blatant[18].SaveDeb

				for _, funct in ipairs(C.AvailableHacks.Blatant[18].Functs) do
					funct:Disconnect()
				end
				C.AvailableHacks.Blatant[18].Functs = {}

				if C.Map and (C.enHacks.Blatant_KeepDoorsOpen or C.enHacks.Blatant_KeepDoorsClosed) then
					local function doorAdded(door)
						local saveDoorFunct = C.AvailableHacks.Blatant[15].DoorFuncts[door]
						while not saveDoorFunct and C.AvailableHacks.Blatant[18].SaveDeb == saveDeb and C.Map and C.human and C.human.Parent and C.human.Health>0
							and not C.isCleared do
							RunS.RenderStepped:Wait()
							saveDoorFunct = C.AvailableHacks.Blatant[15].DoorFuncts[door]
						end
						if C.AvailableHacks.Blatant[18].SaveDeb ~= saveDeb or C.isCleared then
							return
						end
						local actionSign = StringWaitForChild(door,"DoorTrigger.ActionSign")
						local function updateFunct()
							if C.isCleared or actionSign.Value == 0 then
								return
							end
							if (C.enHacks.Blatant_KeepDoorsOpen and actionSign.Value == 10) or (C.enHacks.Blatant_KeepDoorsClosed and actionSign.Value == 11) then
								saveDoorFunct(true, true)
							end
							task.wait(.5)
						end
						if actionSign then
							table.insert(C.AvailableHacks.Blatant[18].Functs,actionSign.Changed:Connect(updateFunct))
							updateFunct()
						end
					end
					table.insert(C.AvailableHacks.Blatant[18].Functs,CS:GetInstanceAddedSignal("Door"):Connect(doorAdded))
					for num, door in ipairs(C.Map:GetChildren()) do
						if door.Name == "SingleDoor" or door.Name=="DoubleDoor" then
							task.spawn(doorAdded,door)
						end
					end
				end
			end,
			["MapAdded"]=function()
				C.AvailableHacks.Blatant[18].ActivateFunction()
			end,
		},
		[19]={
			["Type"]="ExTextButton",
			["Title"]="Keep Doors Closed",
			["Desc"]="Keep on for doors always to be closed!",
			["Shortcut"]="Blatant_KeepDoorsClosed",
			["DontActivate"]=false,
			["Default"]=false,
			["ActivateFunction"]=function()
				C.AvailableHacks.Blatant[18].ActivateFunction()
			end,
		},

		[25]={
			["Type"]="ExTextButton",
			["Title"]="Walk Through Doors",
			["Desc"]="Walk Through All Doors and Exits, even if they're closed!\nRequires Basic/InviWalls",
			["Shortcut"]="Blatant_WalkThruDoors",
			["Default"]=true,
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Basic[20].ActivateFunction(C.enHacks.Basic_InviWalls)
			end,
		},
		[26]={
			["Type"]="ExTextButton",
			["Title"]="Walk Through Walls",
			["Desc"]="Walk Through All Walls!\nRequires Basic/InviWalls",
			["Shortcut"]="Blatant_WalkThruWalls",
			["Default"]=true,
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Basic[20].ActivateFunction(C.enHacks.Basic_InviWalls)
			end,
		},
		[250]={
			["Type"]="ExTextButton",
			["Title"]="Disable Death",
			["Desc"]="Disables killparts locally (just for you)",
			["Shortcut"]="Blatant_NoDeath",
			["Default"]=false,
			["DontActivate"]=true,
			["Universes"]={"Tower"},
			["ActivateFunction"]=function()
				local killScript = C.char:WaitForChild("KillScript")
				if killScript then
					killScript.Disabled = C.enHacks.Blatant_NoDeath
				end
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Blatant[250].ActivateFunction()
			end,
		},
		[251]={
			["Type"]="ExTextButton",
			["Title"]="Disable Bunny Jump",
			["Desc"]="Disables forced bunny jump locally (just for you)",
			["Shortcut"]="Blatant_NoBunnyJump",
			["Default"]=false,
			["DontActivate"]=true,
			["Universes"]={"Tower"},
			["ActivateFunction"]=function()
				local bunnyJump = C.char:WaitForChild("bunnyJump",30)
				if bunnyJump then
					bunnyJump.Disabled = C.enHacks.Blatant_NoBunnyJump
				end
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Blatant[251].ActivateFunction()
			end,
		},
		[252]={
			["Type"]="ExTextButton",
			["Title"]="Disable ToH Client AntiCheat (experimental)",
			["Desc"]="Disables Anticheat",
			["Shortcut"]="Blatant_DisableToHAntiCheat",
			["Default"]=false,
			["Universes"]={"Tower"},
			["ActivateFunction"]=function(newValue)
				if not C.enHacks.Blatant_DisableToHAntiCheat then
					return
				end
				local localScript1 = StringWaitForChild(plr,"PlayerScripts.LocalScript",30)
				local localScript2 = StringWaitForChild(plr,"PlayerScripts.LocalScript2",30)
				if not localScript1 or not localScript2 then
					return
				end
				for num, connection in ipairs(C.GetHardValue(localScript1,"Changed",{yield=true})) do
					connection:Disconnect()
				end
				local oldParent = localScript1.Parent
				localScript1.Parent = nil
				localScript2.Parent = nil
				localScript1.Disabled = true
				DS:AddItem(localScript1,3)
				DS:AddItem(localScript2,3)
				localScript1 = Instance.new("LocalScript")
				localScript1.Parent = oldParent
				localScript2 = Instance.new("LocalScript")
				localScript2.Name = "LocalScript2"
				localScript2.Parent = oldParent

				Instance.new("Folder",localScript1).Name = "FakeDummy"
				Instance.new("Folder",localScript2).Name = "FakeDummy"
			end,
		},
		[253]={
			["Type"]="ExTextButton",
			["Title"]="ToH Force Infinite Jump",
			["Desc"]="Forces Inf Jump",
			["Shortcut"]="Blatant_ToHInfJump",
			["Default"]=false,
			["DontActivate"]=true,
			["Universes"]={"Tower"},
			["ActivateFunction"]=function()
				local multiJumpCount = StringWaitForChild(C.char,"ExtraJumper.multiJumpCount")
				if multiJumpCount then
					multiJumpCount.Value = C.enHacks.Blatant_ToHInfJump and math.huge or 0
				end
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Blatant[253].ActivateFunction()
			end,
		},
		[255]={
			["Type"]="ExTextButton",
			["Title"]="Freeze ToH Client",
			["Desc"]="Stops moving objects. This has the same effect as the hour glass",
			["Shortcut"]="Blatant_ToHFreezeTime",
			["Default"]=false,
			["Universes"]={"Tower"},
			["ActivateFunction"]=function(newValue)
				local val = StringWaitForChild(plr,"PlayerScripts.timefreeze",30)
				if val then
					val.Value = C.enHacks.Blatant_ToHFreezeTime
				end
			end,
		},
		[300]={
			["Type"]="ExTextButton",
			["Title"]="Weapon Stats Hack",
			["Desc"]="Inf Ammo, Firerate, and Accuracy",
			["Shortcut"]="Blatant_FlagWarsStatsHack",
			["Default"]=false,
			["DontActivate"]=true,
			["Funct"]=nil,
			["Universes"]={"FlagWars"},
			["RunStats"]=function(list)
				local function SetStat(parent,name,riggedValue,doInsert)
					local instance = parent:FindFirstChild(name)
					if not instance then
						if not doInsert then
							return -- don't insert if unnecessary
						end
						instance = Instance.new((typeof(riggedValue)=="string" and "StringValue")
							or (typeof(riggedValue)=="boolean" and "BoolValue")
							or (typeof(riggedValue)=="number" and "NumberValue"), workspace)
						instance.Name = name
						instance:SetAttribute("Org","nil")
					end
					local Org = instance:GetAttribute("Org")
					if C.enHacks.Blatant_FlagWarsStatsHack then
						if not Org then
							instance:SetAttribute("Org",instance.Value)
						end
						instance.Value = riggedValue
						setChangedProperty(instance,"Value",function()
							if instance.Value ~= riggedValue then
								instance:SetAttribute("Org",instance.Value)
							end
							instance.Value = riggedValue
						end)
					elseif Org then
						if Org == "nil" then
							instance:Destroy()
						else
							setChangedProperty(instance,"Value",nil)
							instance.Value = Org
						end
					end
					if instance.Parent and parent.Parent and parent.Parent.Parent then
						instance.Parent = parent
					end
				end
				for num, config in ipairs(list) do
					SetStat(config,"RecoilMin",0)
					SetStat(config,"RecoilMax",0)
					SetStat(config,"RecoilDecay",0)
					SetStat(config,"TotalRecoilMax",0)
					SetStat(config,"MinSpread",0)
					SetStat(config,"MaxSpread",0)
					SetStat(config,"ShotCooldown",0)
					SetStat(config,"Cooldown",0)
					SetStat(config,"SwingCooldown",0)
					SetStat(config,"HitRate",0)
					--SetStat(config,"HasScope",false)

					SetStat(config,"FireMode","Automatic",true)
					SetStat(config.Parent,"CurrentAmmo",69)
					--SetStat(config,"AmmoCapacity",69)
					config.Parent:SetAttribute("Modded",true)
				end
			end,
			["AddInstance"]=function(list,tool)
				local Configuration = tool:FindFirstChild("Configuration")
				if Configuration then
					table.insert(list,Configuration)
				end
			end,
			["ActivateFunction"]=function(newValue)				
				local list = {}
				for num, tool in ipairs(plr:WaitForChild("Backpack"):GetChildren()) do
					C.AvailableHacks.Blatant[300].AddInstance(list,tool)
				end
				local myTool = C.char:FindFirstChildWhichIsA("Tool")
				if myTool then
					C.AvailableHacks.Blatant[300].AddInstance(list,myTool)
				end
				C.AvailableHacks.Blatant[300].RunStats(list)
			end,
			["MyStartUp"]=function()
				--	task.delay(2.5,C.AvailableHacks.Blatant[300].ActivateFunction)
				table.insert(C.functs,plr:WaitForChild("Backpack").ChildAdded:Connect(function(newTool)
					if newTool:GetAttribute("Modded") then
						return
					end
					if not newTool:WaitForChild("Configuration",5) then
						return
					end
					local list = {}
					C.AvailableHacks.Blatant[300].AddInstance(list,newTool)
					C.AvailableHacks.Blatant[300].RunStats(list)
				end))
				task.delay(0.5,C.AvailableHacks.Blatant[300].ActivateFunction)
			end,
			--]]
			--["ActivateFunction"] = function(newValue)
				--[[local to0 = {"ShotCooldown", "HeadshotCooldown", "MinSpread", "MaxSpread", "TotalRecoilMax", "RecoilMin", "RecoilMax", "RecoilDecay"}
				local toInf = {"CurrentAmmo", "AmmoCapacity", "HeadshotDamage"}
				
				C.Hook(game,"__index","value",newValue and function(this,index)
					print(this,index)
					if table.find(toInf, tostring(this)) then
						return true,{math.huge}
					end
					if table.find(to0, tostring(this)) then
						return true,{0}
					end
					return false
				end)--]]


			-- retarded gun mods (re-equip your weapon)
			--local old2; old2 = hookmetamethod(game, "__index", function(this, index)
			--end)
			--end,
		},
		[301]={
			["Type"]="ExTextButton",
			["Title"]="Hit Hack",
			["Desc"]="Automatically hits closest person!",
			["Shortcut"]="Blatant_FlagWarsGunHack",
			["Default"]=false,
			["Universes"]={"FlagWars"},
			["ActivateFunction"]=function(newValue)
				local function getClosest()
					local myHRP = C.char and C.char.PrimaryPart
					if not C.human or C.human.Health <= 0 or not myHRP then return end


					local closest = nil;
					local distance = math.huge;


					for i, v in pairs(PS.GetPlayers(PS)) do
						if v == plr then continue end
						if v.Team == plr.Team then continue end
						local theirChar = v.Character
						if not theirChar then continue end
						local theirHumanoid = theirChar.FindFirstChildOfClass(theirChar,"Humanoid")
						if not theirHumanoid or theirHumanoid.Health <= 0 then continue end
						local theirHead = theirChar.FindFirstChild(theirChar,"Head")
						if not theirHead then continue end
						local ForceField = theirChar.FindFirstChildWhichIsA(theirChar,"ForceField")
						if ForceField and ForceField.Visible then continue end

						local d = (theirHead.Position - myHRP.Position).Magnitude

						if d < distance then
							distance = d
							closest = theirHead
						end
					end

					return closest, distance
				end
				local tblPack, tblUnpack = table.pack,table.unpack
				C.Hook(game,"__namecall","fireserver",newValue and (function(method,args)
					local event = args[1]
					if tostring(event) == "WeaponHit" then
						local ClosestHead, Distance = getClosest()
						if ClosestHead then
							local dataTbl = args[3]
							dataTbl["part"] = ClosestHead
							dataTbl["h"] = ClosestHead

							--[[dataTbl["p"] = ClosestHead.Position
							dataTbl["d"] = Distance
							dataTbl["m"] = ClosestHead.Material
							dataTbl['n'] = -(ClosestHead.Position - C.char.PrimaryPart.Position).Unit
							dataTbl["maxDist"] = Distance + .3
							dataTbl["t"] = 1--]]

							--dataTbl[""] = ClosestHead
							--print("DataTbl",dataTbl)
							return "replace", args
						else
							--print("did nothing")
							return true--do nothing lol, don't kill yaself!
						end
					end
					return false -- do not change!
				end))
				--[[C.Hook(workspace, workspace.Raycast,"raycast",newValue and (function(method,args)
					print("Raycast")
					local workspace,origin,direction,raycastParams = tblUnpack(args)
					
					local ClosestHead, Distance = getClosest()
					
					if ClosestHead then
						direction = -(ClosestHead.Position - origin).Unit * (Distance + 5)
						raycastParams.FilterDescendantsInstances = {ClosestHead}
						raycastParams.FilterType = Enum.RaycastFilterType.Include
						print("Hit")
						return true, {workspace,origin,direction,raycastParams}
					end
					
					return false
				end))--]]
			end,
		},
		[302]={
			["Type"]="ExTextButton",
			["Title"]="Raycast Hacks",
			["Desc"]="Bullets go through walls",
			["Shortcut"]="Blatant_GoThroughWalls",
			["Default"]=false,
			["Universes"]={"FlagWars"},
			["Funct"] = nil,
			["ActivateFunction"]=function(newValue)
				if C.AvailableHacks.Blatant[302].Funct then
					C.AvailableHacks.Blatant[302].Funct:Disconnect()
				end
				if newValue then
					C.AvailableHacks.Blatant[302].Funct = workspace.Camera.ChildAdded:Connect(function(bullet)
						if bullet.Name == "Bullet" then
							print("Bullet",bullet:GetChildren())
							--print(bullet.Attachment0.Part0,bullet.Attachment0.Part1,bullet.Attachment1.Part0,bullet.Attachment1.Part1)
						end
					end)
				end
			end,
		},
		[315]={
			["Type"]="ExTextButton",
			["Title"]="Kill Aura", ["CategoryAlias"] = "Weapon",
			["Desc"]="Maximum Dist of ~450, Must Equip Rifle",
			["Shortcut"]="Blatant_NavalKillAura",
			["Default"]=false,
			["DontActivate"]=true,
			["Universes"]={"NavalWarefare"},
			["Deb"]=0,
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Blatant[315].Deb += 1
				local saveDeb = C.AvailableHacks.Blatant[315].Deb
				local Tool = C.char:FindFirstChildWhichIsA("Tool")
				while C.AvailableHacks.Blatant[315].Deb == saveDeb and not C.isCleared do
					local Target, Distance = C.getClosest()
					if Target and Distance <= 450 then
						C.RemoteEvent:FireServer("shootRifle","",{Target}) 
						C.RemoteEvent:FireServer("shootRifle","hit",{Target.Parent:FindFirstChild("Humanoid")})
					end
					RunS.RenderStepped:Wait()
					while not Tool or not Tool:IsA("Tool") or not Tool.Parent or not Tool.Parent.Parent do
						Tool = C.char.ChildAdded:Wait() -- Wait for new tool!
					end
				end
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Blatant[315].ActivateFunction(C.enHacks.Blatant_NavalKillAura)
			end,
		},
		[316]={
			["Type"]="ExTextButton",
			["Title"]="Auto Aim", ["CategoryAlias"] = "Weapon",
			["Desc"]="Aims wielded turrets to the nearest enemey",
			["Shortcut"]="Blatant_NavalAutoAim",
			["Default"]=false,
			["Universes"]={"NavalWarefare"},
			["Funct"]=nil,
			["ActivateFunction"]=function(newValue)
				local c = 800 -- bullet velocity you can put between 799-800
				local function l(m, n)
					if not m then return m.Position end
					local o = m.Velocity
					return m.Position + (o * n)
				end
				local function p(q)
					local r = plr.Character
					if not r or not r:FindFirstChild("HumanoidRootPart") then return 0 end
					local s = r.HumanoidRootPart.Position
					local t = (q - s).Magnitude
					return t / c
				end
				if C.AvailableHacks.Blatant[316].Funct then
					C.AvailableHacks.Blatant[316].Funct:Disconnect()
				end
				if newValue then
					C.AvailableHacks.Blatant[316].Funct = UIS.InputBegan:Connect(function(inputObject,gameProcessed)
						if inputObject.KeyCode == Enum.KeyCode.F then
							while UIS:IsKeyDown(Enum.KeyCode.F) and C.enHacks.Blatant_NavalAutoAim do
								local u = C.getClosest()
								if u then
									local v = u.Parent:FindFirstChild("HumanoidRootPart")
									if v then
										local w = p(v.Position)
										local x = l(v, w)
										C.RemoteEvent:FireServer("aim", {x})
									end
								end
								RunS.RenderStepped:Wait()
							end
						end
					end)
				end
			end,
		},
		[317]={
			["Type"]="ExTextButton",
			["Title"]="Loop Kill Enemies", ["CategoryAlias"] = "Weapon",
			["Desc"]="Make sure you equip Rifle and have Kill Aura enabled",
			["Shortcut"]="Blatant_NavalLoopKill",
			["Default"]=false,
			["LastSpotted"]=nil,
			["DontActivate"]=true,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function(newValue)
				local Title = "Loop Kill Enemies"
				if newValue then
					local actionClone = C.AddAction({Name=Title,Tags={"RemoveOnDestroy"},Stop=function(onRequest)
						C.refreshEnHack["Blatant_NavalLoopKill"](false)
					end,})
					if not actionClone then
						return
					end
					if not C.AvailableHacks.Blatant[317].LastSpotted and C.char and C.char.PrimaryPart then
						C.AvailableHacks.Blatant[317].LastSpotted = C.char:GetPivot()
					end
					local Time = actionClone:FindFirstChild("Time")
					local saveChar = C.char
					while Time and C.enHacks.Blatant_NavalLoopKill and C.char == saveChar and C.char.PrimaryPart and C.human and C.human.Health>0 do
						local theirHead, dist = C.getClosest()
						if theirHead then
							teleportMyself(theirHead.Parent:GetPivot() * CFrame.new(0,100,0))
							Time.Text = theirHead.Parent.Name
						else
							Time.Text = "(Waiting)"
						end
						--C.char.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
						--C.char.PrimaryPart.AssemblyAngularVelocity = Vector3.new()
						RunS.RenderStepped:Wait()
					end
				else
					C.RemoveAction(Title)
					if C.AvailableHacks.Blatant[317].LastSpotted then
						teleportMyself(C.AvailableHacks.Blatant[317].LastSpotted)
					end
				end
			end,
			["MyStartUp"]=function(_,_,firstRun)
				if C.enHacks.Blatant_NavalLoopKill and not firstRun then
					local Rifle = plr:WaitForChild("Backpack"):WaitForChild("M1 Garand",5)
					if Rifle then
						C.human:EquipTool(Rifle)
					end
				end
				C.AvailableHacks.Blatant[317].ActivateFunction(C.enHacks.Blatant_NavalLoopKill)
			end,
		},
		[320]={
			["Type"]="ExTextBox",
			["Title"]="Vehicle Speed Multiplier", ["CategoryAlias"] = "Vehicle",
			["Desc"]="How much faster vehicles that you drive go. Max For Ships Is x1.4 Unless Vehicle.AutoTeleportBack is enabled",
			["Shortcut"]="Blatant_NavalVehicleSpeed",
			["Default"]=1,
			["MinBound"]=-100,
			["MaxBound"]=100,
			["Universes"]={"NavalWarefare"},
			["Functs"]={},
			["ActivateFunction"]=function()
				if C.human and C.human.SeatPart then
					C.AvailableHacks.Blatant[320].MySeatAdded(C.human.SeatPart)
				end
			end,
			["MySeatAdded"]=function(seatPart)
				C.AvailableHacks.Blatant[320].MySeatRemoved(seatPart)
				local Vehicle = seatPart.Parent
				local HitCode = Vehicle:WaitForChild("HitCode",5)
				local FlyButton = StringWaitForChild(PlayerGui,"ScreenGui.InfoFrame.Fly")
				--The "BodyVelocity" is actually "LineVelocity"
				if HitCode and (HitCode.Value == "Ship" or HitCode.Value == "Plane") then
					local MainBody = Vehicle:WaitForChild("MainBody")
					local LineVelocity = MainBody:WaitForChild("BodyVelocity")
					local VehicleType = Vehicle:WaitForChild("HitCode").Value
					local FuelLeft = HitCode.Value == "Plane" and Vehicle:WaitForChild("Fuel")
					local AlignOrientation = LineVelocity.Parent:FindFirstChildWhichIsA("AlignOrientation")
					local lastSet
					local function Upd()
						if lastSet and (LineVelocity.VectorVelocity - lastSet).Magnitude < 0.3 then
							return
						end
						local SpeedMult = (VehicleType=="Plane" and C.enHacks.Blatant_NavalVehicleSpeed 
							or math.min(C.enHacks.Blatant_NavalAutoTeleportBack and math.huge or 1.8,C.enHacks.Blatant_NavalVehicleSpeed))
						local TurnMult = C.enHacks.Blatant_NavalVehicleTurnSpeed or 1
						if C.GetAction("LoopBomb") or C.GetAction("Plane Refuel") then
							SpeedMult,TurnMult = 0, 0 -- Override to stop it from moving!
						end
						lastSet = SpeedMult * LineVelocity.VectorVelocity
						if FuelLeft then
							if C.enHacks.Blatant_NavalInfPlaneFuel then
								if FuelLeft.Value < 500 then
									FuelLeft:SetAttribute("RealFuel",FuelLeft.Value)
								end
								FuelLeft.Value = math.huge
							elseif FuelLeft:GetAttribute("RealFuel") then
								FuelLeft.Value = FuelLeft:GetAttribute("RealFuel")
							end
						end
						local isOn = (LineVelocity.MaxForce > 10 and (not FuelLeft or (FuelLeft:GetAttribute("RealFuel") or FuelLeft.Value) > 0)) or 
							(FlyButton.BackgroundColor3.R*255>250 and C.enHacks.Blatant_NavalInfPlaneFuel) or VehicleType == "Ship"
						LineVelocity.VectorVelocity = lastSet

						LineVelocity.MaxAxesForce = Vector3.new(1000,1000,1000) * SpeedMult
						LineVelocity.MaxForce = isOn and ((VehicleType=="Ship" and 49.281604e6 or 31.148e3) * math.max(1,SpeedMult/6)) or 0 --* SpeedMult/8) or 0
						AlignOrientation.Responsiveness = 20 * (TurnMult/16)
						AlignOrientation.MaxTorque = isOn and (33.5e3 * TurnMult) or 0
					end
					table.insert(C.AvailableHacks.Blatant[320].Functs,LineVelocity:GetPropertyChangedSignal("VectorVelocity"):Connect(Upd))
					Upd()
				end
			end,
			["MySeatRemoved"]=function(seatPart)
				local Vehicle = seatPart.Parent
				if Vehicle and Vehicle.PrimaryPart then
					Vehicle.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
					Vehicle.PrimaryPart.AssemblyAngularVelocity = Vector3.zero
				end
				for num, funct in ipairs(C.AvailableHacks.Blatant[320].Functs) do
					funct:Disconnect()
				end C.AvailableHacks.Blatant[320].Functs = {}
			end,
		},
		[321]={
			["Type"]="ExTextBox",
			["Title"]="Vehicle Turn Multiplier",["CategoryAlias"] = "Vehicle",
			["Desc"]="How much faster vehicles that you drive turn",
			["Shortcut"]="Blatant_NavalVehicleTurnSpeed",
			["Default"]=1,
			["MinBound"]=0,
			["MaxBound"]=100,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function()
				if C.human and C.human.SeatPart then
					C.AvailableHacks.Blatant[320].MySeatAdded(C.human.SeatPart)
				end
			end,
		},
		[322]={
			["Type"]="ExTextButton",
			["Title"]="Anti Bounds", ["CategoryAlias"] = "Vehicle",
			["Desc"]="Prevents your plane from going into the Pacific or exiting!",
			["Shortcut"]="Blatant_NavalAntiWater",
			["Default"]=false,
			["Universes"]={"NavalWarefare"},
			["Funct"]=nil,
			["ToggleColliders"]=function(Vehicle,Enabled)
				if not Vehicle then
					return
				end
				for num, part in ipairs(Vehicle:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanTouch = Enabled
					end
				end
				--[[local MainPart, Colliders = Vehicle:FindFirstChild("MainBody"), Vehicle:FindFirstChild("Collider")
				if MainPart then
					MainPart.CanTouch = not Enabled
					print("Set MainPart",MainPart.CanTouch)
				end
				if Colliders then
					for num, collider in ipairs(Colliders:GetChildren()) do
						collider.CanTouch = not Enabled
						print("Set Collder",collider.Name,collider.CanTouch)
					end
				end--]]
			end,
			["MySeatAdded"]=function(seatPart)
				local Vehicle = seatPart.Parent
				local HitCode = Vehicle:WaitForChild("HitCode",5)
				if not HitCode then return end
				local VehicleType = HitCode.Value
				local EnemyHarbor = workspace:WaitForChild(plr.Team.Name=="Japan" and "USDock" or "JapanDock") 
				local HarborMainBody = EnemyHarbor:WaitForChild("MainBody")
				local LineVelocity = Vehicle:FindFirstChild("BodyVelocity",true)
				local MainVelocity = LineVelocity.Parent
				local LowestAcceptablePoint = 10
				local PullUpSpeed = 30

				local BoundingSize = Vector3.new(10240,20e3,16384)
				local BoundingCF = CFrame.new(0, BoundingSize.Y/2 + LowestAcceptablePoint, 0)

				local HarborSize = HarborMainBody.Size+Vector3.new(60,220,60)
				local HarborCF = HarborMainBody.CFrame*CFrame.new(0,-40,0)
				C.createTestBlock("EnemyHarborBoundingBox",HarborCF,HarborSize)
				--The "BodyVelocity" is actually "LineVelocity"
				if VehicleType=="Plane" or VehicleType == "Ship" then
					C.AvailableHacks.Blatant[322].ToggleColliders(Vehicle,false) -- Disable CanTouch colliders
					while C.human and C.human.SeatPart == seatPart do
						if C.enHacks.Blatant_NavalAntiWater then
							local OldVelocity = MainVelocity.AssemblyLinearVelocity
							local GetOutSpeed = Vector3.zero
							--{PartCF,PartSize,isBlacklist} (All Three Arguments Required)
							local ListedAreas = {{BoundingCF,BoundingSize,false},{HarborCF,HarborSize,true}}
							for num, data in ipairs(ListedAreas) do
								if not C.IsInBox then
									warn("C.iSinbox not found/loaded!")
									continue
								end
								if C.IsInBox(data[1],data[2],seatPart.Position) == data[3] then
									GetOutSpeed += 
										((data[3] and C.ClosestPointOnPartSurface or C.ClosestPointOnPart)(data[1], data[2], seatPart.Position) 
											- seatPart.Position) * (data[3] and PullUpSpeed/3 or PullUpSpeed)
								end
							end
							if GetOutSpeed.Magnitude > .3 then
								local NewX, NewY, NewZ = OldVelocity.X, OldVelocity.Y, OldVelocity.Z
								if math.abs(GetOutSpeed.X) > .5 then
									NewX = GetOutSpeed.X
								end
								if math.abs(GetOutSpeed.Y) > .5 then
									NewY = GetOutSpeed.Y
								end
								if math.abs(GetOutSpeed.Z) > .5 then
									NewZ = GetOutSpeed.Z
								end
								MainVelocity.AssemblyLinearVelocity = Vector3.new(NewX,NewY,NewZ)
							end
						end
						RunS.RenderStepped:Wait()
					end
				end
			end,
			["MySeatRemoved"]=function(seatPart)
				local Vehicle = seatPart.Parent
				C.AvailableHacks.Blatant[322].ToggleColliders(Vehicle,true) -- Disable CanTouch colliders
			end,
		},
		[323]={
			["Type"]="ExTextButton",
			["Title"]="Plane Infinite Fuel", ["CategoryAlias"] = "Vehicle",
			["Desc"]="You may need to turn back on your engine if you run out",
			["Shortcut"]="Blatant_NavalInfPlaneFuel",
			["Default"]=false,
			["Universes"]={"NavalWarefare"},			
		},
		[325]={
			["Type"]="ExTextButton",
			["Title"]="Plane Instant Restock", ["CategoryAlias"] = "Vehicle",
			["Desc"]="Auto Re-Fuels at Harbor after bombs run out. Teleports back as well.",
			["Shortcut"]="Blatant_NavalInstantRefuel",
			["Default"]=false,
			["DontActivate"]=true,
			["Universes"]={"NavalWarefare"},
			["Functs"]={},
			["ActivateFunction"]=function(newValue)
				if not newValue then
					C.RemoveAction("Plane Refuel") -- Cancel the action
				elseif C.human.SeatPart then
					C.AvailableHacks.Blatant[325].MySeatAdded(C.human.SeatPart)
				end
			end,
			["MySeatAdded"]=function(seatPart)
				C.AvailableHacks.Blatant[325].MySeatRemoved()
				local Plane = seatPart.Parent
				local HitCode = Plane:WaitForChild("HitCode",5)
				if HitCode and HitCode.Value == "Plane" then
					local HP = Plane:WaitForChild("HP")
					--local AmmoC = Plane:WaitForChild("Ammo")
					local BombC = Plane:WaitForChild("BombC")
					local function canRun(toRun)
						return Plane and Plane.Parent and C.human and seatPart == C.human.SeatPart and not C.isCleared
							and (not toRun or 
								((C.enHacks.Blatant_NavalInstantRefuel and BombC.Value == 0) 
									or (C.enHacks.Blatant_NavalInstantRepair and (C.enHacks.Blatant_NavalInstantRepair*C.DataStorage[Plane.Name].Health/100>=HP.Value))))
					end
					local function HarborRefuel()
						local Harbor = workspace:WaitForChild(plr.Team.Name:gsub("USA","US").."Dock")
						local HarborMain = Harbor:WaitForChild("MainBody")
						local MainBody = Plane:WaitForChild("MainBody")
						local Origin = Plane:GetPivot()
						local Info = {Name="Plane Refuel",Tags={"RemoveOnDestroy"},Stop=function(onRequest)
							if not C.GetAction("LoopBomb") then
								Plane:PivotTo(Origin)
							end
						end,}
						local actionClone = C.AddAction(Info)
						if actionClone then
							actionClone:WaitForChild("Time").Text = "~2s"
						end
						while canRun(true) and Info.Enabled do
							if (Plane:GetPivot().Position - HarborMain.Position).Magnitude > 30 then
								Plane:PivotTo(HarborMain:GetPivot() * CFrame.new(0,45,15))
							end
							MainBody.AssemblyLinearVelocity = Vector3.new()
							MainBody.AssemblyAngularVelocity = Vector3.new()
							RunS.RenderStepped:Wait()
						end
					end
					local function CheckDORefuel(newBomb)
						if newBomb ~= nil then
							task.wait(1/3) -- wait for the bomb to spawn!
						end
						if not canRun() then
							return
						end
						if canRun(true) then
							HarborRefuel()
						else -- Refueled!
							C.RemoveAction("Plane Refuel")
						end
					end
					table.insert(C.AvailableHacks.Blatant[325].Functs,BombC.Changed:Connect(CheckDORefuel))
					table.insert(C.AvailableHacks.Blatant[325].Functs,HP.Changed:Connect(CheckDORefuel))
					table.insert(C.AvailableHacks.Blatant[325].Functs,HP.Changed:Connect(CheckDORefuel))
					CheckDORefuel()
				end
			end,
			["MySeatRemoved"]=function()
				for num, funct in ipairs(C.AvailableHacks.Blatant[325].Functs) do
					funct:Disconnect()
				end C.AvailableHacks.Blatant[325].Functs = {}
				C.RemoveAction("Plane Refuel")
			end,
		},
		[324]={
			["Type"]="ExTextButton",
			["Title"]="Plane Instant Repair", ["CategoryAlias"] = "Vehicle",
			["Desc"]="Repairs when this health or lower is reached on a Plane. Requires NavalInstantRefuel.",
			["Shortcut"]="Blatant_NavalInstantRepair",
			["Default"]=false,
			["Options"]={
				[false]={
					["Title"]="OFF",
					["TextColor"]=Color3.fromRGB(170,0,170),
				},
				[25]={
					["Title"]="50%",
					["TextColor"]=Color3.fromRGB(170, 0, 3),
				},
				[50]={
					["Title"]="75%",
					["TextColor"]=Color3.fromRGB(223, 208, 0),
				},
				[99]={
					["Title"]="99%",
					["TextColor"]=Color3.fromRGB(0, 216, 25),
				},
			},
			["DontActivate"]=true,
			["Universes"]={"NavalWarefare"},
			["Funct"]=nil,
		},
		[326]={
			["Type"]="ExTextBox",
			["Title"]="Vehicle Levitation Height", ["CategoryAlias"] = "Vehicle",
			["Desc"]="How high off the ground the ships float",
			["Shortcut"]="Blatant_NavalLevitationHeight",
			["Default"]=0,
			["MinBound"]=-100,
			["MaxBound"]=200,
			["LevitationPart"]=nil,
			["Universes"]={"NavalWarefare"},
			["Enabled"]=false,
			["ActivateFunction"]=function()
				for num, part in ipairs(StringWaitForChild(workspace,"Setting.WaterColliders"):GetChildren()) do
					if part:IsA("BasePart") then
						TS:Create(part,TweenInfo.new(C.enHacks.Blatant_NavalLevitationHeight/23),{Position=Vector3.new(part.Position.X, -52 
							+ (C.AvailableHacks.Blatant[326].Enabled and C.enHacks.Blatant_NavalLevitationHeight or 0), part.Position.Z)}):Play()
					end
				end
			end,
			["MySeatAdded"]=function(seatPart)
				local Ship = seatPart.Parent
				local HitCode = Ship:WaitForChild("HitCode",5)
				if HitCode and HitCode.Value ~= "Ship" and seatPart.Name=="Seat" then
					C.AvailableHacks.Blatant[326].Enabled = false
				else
					C.AvailableHacks.Blatant[326].Enabled = true
				end
				C.AvailableHacks.Blatant[326].ActivateFunction()
			end,
			["MySeatRemoved"]=function()
				C.AvailableHacks.Blatant[326].Enabled = false
				C.AvailableHacks.Blatant[326].ActivateFunction()
			end,
		},
		[327]={
			["Type"]="ExTextButton",
			["Title"]="Ship Auto Teleport Back", ["CategoryAlias"] = "Vehicle",
			["Desc"]="Automatically Teleports Your Ship Back To Where It Was",
			["Shortcut"]="Blatant_NavalAutoTeleportBack",
			["Default"]=false,
			["Funct"]=nil,
			["Universes"]={"NavalWarefare"},
			["MySeatAdded"]=function(seatPart)
				C.AvailableHacks.Blatant[327].MySeatRemoved()
				local Ship = seatPart.Parent
				local HitCode = Ship:WaitForChild("HitCode",5)
				if not HitCode or HitCode.Value ~= "Ship" then
					return
				end
				local function CanRun()
					return C.human and seatPart == C.human.SeatPart and not C.isCleared
				end
				local lastInput
				task.spawn(function()
					while CanRun() do
						lastInput = Ship:GetPivot()
						RunS.RenderStepped:Wait()
					end
				end)
				C.AvailableHacks.Blatant[327].Funct = Ship:WaitForChild("MainBody"):GetPropertyChangedSignal("CFrame"):Connect(function()
					if not CanRun() then return end
					local newInput = Ship:GetPivot()
					if (newInput.Position - lastInput.Position).Magnitude > 10 and C.enHacks.Blatant_NavalAutoTeleportBack then
						Ship:PivotTo(lastInput)
					end
				end)
			end,
			["MySeatRemoved"]=function(seatPart)
				if C.AvailableHacks.Blatant[327].Funct then
					C.AvailableHacks.Blatant[327].Funct:Disconnect()
				end C.AvailableHacks.Blatant[327].Funct = nil
			end,
		},
		[328]={
			["Type"]="ExTextButton",
			["Title"]="Free Tools",
			["Desc"]="Invisible & Free Tools",
			["Shortcut"]="Blatant_NavalWarefareFreeTools",
			["Default"]=false,
			["DontActivate"]=true,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function(newValue)
				if newValue then
					for num, tool in ipairs(RS:GetDescendants()) do
						if tool:IsA("Tool") and tool.Name ~= "RPG" then
							local clonedTool = tool:Clone()
							task.delay(2,C.DestroyAllWhichIsA,clonedTool, "BasePart")
							C.DestroyAllOfClass(clonedTool, "Script")
							clonedTool:AddTag("RemoveOnDestroy")
							clonedTool:AddTag("FakeTool")
							clonedTool.RequiresHandle = false
							clonedTool.Parent = plr.Backpack
						end
					end
				else
					C.DestroyAllTaggedObjects("FakeTool")
				end
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Blatant[328].ActivateFunction(C.enHacks.Blatant_NavalWarefareFreeTools)
			end,
		},
		[330]={
			["Type"]="ExTextButton",
			["Title"]=({"OP","Balanced","NEENOO's","NotAVirus","Easy"})[math.random(1,5)].." God Mode",
			["Desc"]="Only works in planes and when unseated",
			["Shortcut"]="Blatant_NavalWarefareGodMode",
			["Default"]=false,
			["DontActivate"]=true,
			["Universes"]={"NavalWarefare"},
			["Deb"]=0,
			["ActivateFunction"]=function()
				C.AvailableHacks.Blatant[330].Deb += 1
				local saveDeb = C.AvailableHacks.Blatant[330].Deb
				local function canRun()
					return saveDeb == C.AvailableHacks.Blatant[330].Deb and C.enHacks.Blatant_NavalWarefareGodMode 
						and not C.isCleared and C.char and C.human and C.human.Health>0
				end
				while canRun() do
					if canRun() and not C.isInGame(C.char) then
						while canRun() and not C.isInGame(C.char) do
							task.wait(4) -- FF lasts for 20 seconds so we good
						end
					end
					if canRun() then
						local FF = C.char:FindFirstChildWhichIsA("ForceField")
						if FF then
							FF.Visible = false
							DS:AddItem(FF,15) -- Delete it after 15 seconds!
							FF.AncestryChanged:Wait() -- Wait until we're defenseless!
						elseif C.human.SeatPart then
							C.human:GetPropertyChangedSignal("SeatPart"):Wait()
						else
							C.RemoteEvent:FireServer("Teleport", {
								[1] = "Harbour",
								[2] = ""
							})
							task.wait(2) -- Wait a bit so it doesn't lag!
						end
					else
						break
					end
				end
			end,
			["MyStartUp"]=function()
				task.delay(2,C.AvailableHacks.Blatant[330].ActivateFunction)
			end,
		},
		[335]={
			["Type"]="ExTextButton",
			["Title"]="Bomb Instant Hit", ["CategoryAlias"] = "Weapon",
			["Desc"]="Makes all bombs instantly hit a target",
			["Shortcut"]="Blatant_NavalInstantHit",
			["Default"]=false,
			["Funct"]=nil,
			["Universes"]={"NavalWarefare"},
			["Options"]={
				[false] = ({
					["Title"] = "OFF",
					["TextColor"] = newColor3(255),
				}),
				["Base"] = ({
					["Title"] = "BASE",
					["TextColor"] = newColor3(0,0,255),
				}),
				--[[["User"] = ({
					["Title"] = "USERS",
					["TextColor"] = newColor3(0,0,255),
				}),
				["Ship"] = ({
					["Title"] = "USERS",
					["TextColor"] = newColor3(0,0,255),
				}),--]]
			},
			["ActivateFunction"]=function(newValue)
				-- Disconnect funct and set up childadded workspace event for the projectiles
				if C.AvailableHacks.Blatant[335].Funct then
					C.AvailableHacks.Blatant[335].Funct:Disconnect()
					C.AvailableHacks.Blatant[335].Funct=nil
				end	
				if newValue then
					C.AvailableHacks.Blatant[335].Funct = workspace.ChildAdded:Connect(function(instance)
						task.wait(.2)
						if instance.Name == "Bomb" and instance.Parent then
							local closestBasePart = 
								(C.enHacks.Blatant_NavalInstantHit=="Base" and C.getClosestBase()
									or C.enHacks.Blatant_NavalInstantHit=="User" and C.getClosest()
								)
							if closestBasePart then
								--closestBasePart = game:GetService("Workspace").JapanDock.Decoration.ConcreteBases.ConcreteBase
								for s = 0, 1, 1 do
									firetouchinterest(instance,closestBasePart,0)
									task.wait()
									firetouchinterest(instance,closestBasePart,1)
									task.wait()
								end
							end
						end
					end)
				end
			end,
		},
		[339]={
			["Type"]="ExTextButton",
			["Title"]="Projectile Instant Hit", ["CategoryAlias"] = "Weapon",
			["Desc"]="Makes all projectiles instantly hit a target",
			["Shortcut"]="Blatant_NavalProjectileInstantHit",
			["Default"]=false,
			["DontActivate"]=true,
			["Funct"]=nil,
			["Universes"]={"NavalWarefare"},
			["Options"]={
				[false] = ({
					["Title"] = "OFF",
					["TextColor"] = newColor3(255),
				}),
				["User"] = ({
					["Title"] = "USERS",
					["TextColor"] = newColor3(0,0,255),
				}),
				["AllUser"] = ({
					["Title"] = "ALL USERS",
					["TextColor"] = newColor3(255,0,255),
				}),
			},
			["ActivateFunction"]=function(newValue)
				-- Disconnect funct and set up childadded workspace event for the projectiles
				if C.AvailableHacks.Blatant[335].Funct then
					C.AvailableHacks.Blatant[335].Funct:Disconnect()
					C.AvailableHacks.Blatant[335].Funct=nil
				end	
				if newValue then
					C.AvailableHacks.Blatant[335].Funct = workspace.ChildAdded:Connect(function(instance)
						task.wait(.1)
						if instance.Name == "bullet" and instance.Parent and UIS:IsKeyDown(Enum.KeyCode.F) then
							local closestBasePart = (C.enHacks.Blatant_NavalProjectileInstantHit=="User" and C.getClosest(false,true))
								or (C.enHacks.Blatant_NavalProjectileInstantHit=="AllUser" and C.getClosest(true,true))
							if closestBasePart then
								if C.enHacks.Blatant_NavalProjectileDyingEnemies then
									workspace.Camera.CameraSubject = closestBasePart.Parent.Humanoid
								end
								--closestBasePart = game:GetService("Workspace").JapanDock.Decoration.ConcreteBases.ConcreteBase
								for s = 0, 1, 1 do
									firetouchinterest(instance,closestBasePart,0)
									task.wait()
									firetouchinterest(instance,closestBasePart,1)
									task.wait()
								end
							end
						end
					end)
				else
					workspace.Camera.CameraSubject = C.human
				end
			end,
			["MyStartUp"]=function(myPlr,myChar,firstRun)
				if firstRun then
					task.wait(2)
					C.AvailableHacks.Blatant[339].ActivateFunction(C.enHacks.Blatant_NavalProjectileDyingEnemies)
				end
			end,
		},
		[340]={
			["Type"]="ExTextButton",
			["Title"]="Spectate Dying Enemies", ["CategoryAlias"] = "Weapon",
			["Desc"]="Watch all enemies you kill with Projectile Instant Kill",
			["Shortcut"]="Blatant_NavalProjectileDyingEnemies",
			["Default"]=false,
			["Funct"]=nil,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function(newValue)
				if C.AvailableHacks.Blatant[340].Funct then
					C.AvailableHacks.Blatant[340].Funct:Disconnect()
					C.AvailableHacks.Blatant[340].Funct=nil
				end	
				if newValue then
					C.AvailableHacks.Blatant[340].Funct = UIS.InputEnded:Connect(function(inputobject, gameProcessedEvent)
						if not gameProcessedEvent and inputobject.KeyCode == Enum.KeyCode.F then
							workspace.Camera.CameraSubject = C.human
						end
					end)
				end
			end,
		},
		[352]={
			["Type"]="ExTextBox",
			["Title"]="Enemy Ship Hitbox Expander",
			["Desc"]="",
			["Shortcut"]="Blatant_NavalHitboxExpander",
			["Default"]=0,
			["MinBound"]=-20,
			["MaxBound"]=20,
			["Universes"]={"NavalWarefare"},
			["ShipAdded"]=function(ship)
				if not C.enHacks.Blatant_NavalHitboxExpander then
					return
				end
				local MainBody = ship:WaitForChild("MainBody")
				local Team = ship:WaitForChild("Team")
				local ExpandSize = Team.Value == plr.Team.Name and 0 or C.enHacks.Blatant_NavalHitboxExpander
				local DefaultSize = MainBody:GetAttribute("OrgSize")
				if not DefaultSize then
					DefaultSize = MainBody.Size
					MainBody:SetAttribute("OrgSize",DefaultSize)
				end
				MainBody.Size = DefaultSize + 2 * Vector3.one * ExpandSize -- Times two in order to expand in EVERY direction
			end,
			["ActivateFunction"]=function(newValue)
				for num, ship in ipairs(C.Ships) do
					C.AvailableHacks.Blatant[352].ShipAdded(ship)
				end
			end,
			["MyTeamAdded"]=function(newTeam)
				C.AvailableHacks.Blatant[352].ActivateFunction()
			end,
		},
		--]]
		--game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:PivotTo(game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:GetPivot()+Vector3.new(0,30,0))
		[350]={
			["Type"]="ExTextButton",
			["Title"]="No Killbricks",
			["Desc"]="Attempts to disable all new killbricks",
			["Shortcut"]="Blatant_NavalWarefareKillBricks",
			["Default"]=false,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function(newValue)
				local SeaFloorGroup = StringWaitForChild(workspace,"Setting.SeaFloor")
				for num, seaFloorPart in ipairs(SeaFloorGroup:GetChildren()) do
					if seaFloorPart:IsA("BasePart") then
						seaFloorPart.CanTouch = not newValue
					end
				end
			end
		},	
		--[[[351]={
			["Type"]="ExTextButton", ["CategoryAlias"]="Vehicle",
			["Title"]="[WIP] NO FLY ZONE",
			["Desc"]="Absorbs all enemy planes to your ship",
			["Shortcut"]="Blatant_NavalWarefareNoFlyZone",
			["Default"]=false,
			['DontActivate']=true,
			["Deb"]=0,
			["Universes"]={"NavalWarefare"},
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Blatant[351].Deb += 1
				local saveDeb = C.AvailableHacks.Blatant[351].Deb
				local function CanRun()
					return saveDeb == C.AvailableHacks.Blatant[351].Deb and C.enHacks.Blatant_NavalWarefareNoFlyZone
				end
				while CanRun() do
					for num, plane in ipairs(C.Planes) do
						local PlaneMainBody = plane:WaitForChild("MainBody",5)
						local PlaneTeamVal = plane:WaitForChild("Team",5)

						if PlaneMainBody and PlaneTeamVal.Value ~= plr.Team.Name then
							for num2, ship in ipairs(C.Ships) do
								local ShipMainBody = ship:WaitForChild("MainBody",5)
								local ShipTeamVal = ship:WaitForChild("Team",5)
								if ShipTeamVal and ShipTeamVal.Value ~= PlaneTeamVal.Value then
									local HP = ship:WaitForChild("HP")
									if HP and HP.Value > 2000 then
										print("Fired On Plane",plane.Owner.Value)
										firetouchinterest(ShipMainBody,PlaneMainBody,0)
										RunS.RenderStepped:Wait()
										firetouchinterest(ShipMainBody,PlaneMainBody,1)
										break
									end
								end
							end
						end
					end
					RunS.RenderStepped:Wait()
				end
			end,
			['MyStartUp']=function()
				C.AvailableHacks.Blatant[351].ActivateFunction()
			end,
		},--]]	
	},
	["Utility"]={
		[1]={
			["Type"]="ExTextButton",
			["Title"]="Auto Hack PC",
			["Desc"]="Automatically does PC hack",
			["Shortcut"]="Util_AutoHack",
			["Default"]=true,
			["DontActivate"]=true,
			["ActivateFunction"]=function(newValue)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				while C.enHacks.Util_AutoHack do
					while C.enHacks.Util_AutoHack and not plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle").Visible do
						plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle"):GetPropertyChangedSignal("Visible"):Wait()
					end
					while C.enHacks.Util_AutoHack and plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle").Visible do
						--plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle"):GetPropertyChangedSignal("Visible"):Wait()
						--TSM.OnTrigger.Value=false
						--print(plr.PlayerGui.ScreenGui.TimingCircle.TimingPin.Rotation,plr.PlayerGui.ScreenGui.TimingCircle.TimingBase.Rotation)
						if plr.PlayerGui.ScreenGui.TimingCircle.TimingPin.Rotation>=plr.PlayerGui.ScreenGui.TimingCircle.TimingBase.Rotation+45 then
							TSM.ActionInput.Value=true
							if not TSM.MinigameResult.Value then
								--RS.C.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
							end
						end
						task.wait()
					end	
					for s=3,1,-1 do
						if not C.enHacks.Util_AutoHack then
							return
						end
						if not TSM.MinigameResult.Value then
							--RS.C.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
						end 	
						task.wait()
					end
					if not C.enHacks.Util_AutoHack then
						return
					end
					--TSM.OnTrigger.Value=true
					TSM.ActionInput.Value=false
					--for s=1,1,-1 dof

					--end

				end
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Utility[1].ActivateFunction(C.enHacks.Util_AutoHack)
			end,
			["MyPlayerAdded"] = function()
				local minigameResult = C.myTSM:WaitForChild("MinigameResult")
				local function updateMiniGameResult()
					if minigameResult and C.enHacks.Util_AutoHack then
						C.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
					end
				end
				setChangedProperty(minigameResult,"Value",updateMiniGameResult)
				updateMiniGameResult()


			end,
		},
		[2]={
			["Type"]="ExTextButton",
			["Title"]="Override Zooming",
			["Desc"]="Allows you to zoom at any time",
			["Shortcut"]="Util_CanZoom",
			["Universes"]={"Global"},
			["Default"]=true,
			["UpdateZoom"]=function(void,reset)--NOT e-learning!
				if reset then
					plr.CameraMinZoomDistance=SP.CameraMinZoomDistance
					plr.CameraMaxZoomDistance=(SP.CameraMaxZoomDistance)
					plr.CameraMode=(C.char==C.Beast and Enum.CameraMode.LockFirstPerson or Enum.CameraMode[SP.CameraMode.Name])
				else
					--plr:SetAttribute("CameraMinZoomDistance",plr.CameraMinZoomDistance)
					plr.CameraMinZoomDistance=.5--minimum
					--plr:SetAttribute("CameraMaxZoomDistance",plr.CameraMaxZoomDistance)
					plr.CameraMaxZoomDistance=1e4--maximum
					--plr:SetAttribute("CameraMode",plr.CameraMode.Name)
					plr.CameraMode=Enum.CameraMode.Classic
				end
			end,
			["ActivateFunction"]=function(newValue)
				local updateZoom=C.AvailableHacks.Utility[2].UpdateZoom
				if newValue then
					setChangedProperty(plr,"CameraMinZoomDistance",updateZoom)
					setChangedProperty(plr,"CameraMaxZoomDistance",updateZoom)
					setChangedProperty(plr,"CameraMode",updateZoom)
				else
					setChangedProperty(plr,"CameraMinZoomDistance",false)
					setChangedProperty(plr,"CameraMaxZoomDistance",false)
					setChangedProperty(plr,"CameraMode",false)
				end
				updateZoom(nil,not newValue)
			end,
		},
		[5]={
			["Type"]="ExTextButton",
			["Title"]="Force Allow Spectate",
			["Desc"]="Allows you to spectate at any time",
			["Shortcut"]="Util_ForceAllowSpectate",
			["Default"]=true,
			["DontActivate"]=true,
			["Functs"]={},
			["ActivateFunction"]=function(newValue)
				--local TSMModule = require(C.myTSM)
				local spectatorName = StringWaitForChild(PlayerGui,"ScreenGui.SpectatorFrame.SpectatorName")

				local allowedEndValues = {
					"PlayerGui.ScreenGui.LocalGuiScript:704\n",
					"PlayerGui.ScreenGui.LocalGuiScript:712\n",
					"PlayerGui.ScreenGui.LocalGuiScript:726\n",
				}
				local allowedEndValues2 = {
					"PlayerGui.ScreenGui.LocalGuiScript:712\n",
					"PlayerGui.ScreenGui.LocalGuiScript:735\n",
					"PlayerGui.ScreenGui.LocalGuiScript:739\n",
				}




				C.SetTempValue("Util_ForceAllowSpectate",newValue and function(theirPlr,caller,instance_name,instance_value)
					local canContinue = false
					if not canContinue and C.enHacks.Util_ForceAllowSpectate and (not _SETTINGS.ExactCallerName or tostring(caller)=="LocalGuiScript") then
						local debugTraceBack = debug.traceback("",1)

						for num, str in ipairs(theirPlr == plr and allowedEndValues or allowedEndValues2) do
							if debugTraceBack:sub(debugTraceBack:len()-str:len()+1) == str then
								canContinue = true
								break
							end
						end
					end

					if (not _SETTINGS.ExactCallerName or tostring(caller)=="LocalGuiScript") then
						if canContinue then
							if theirPlr == plr then
								if instance_name=="Health" then
									return 0
								elseif instance_name=="IsBeast" then
									return false
								end
							elseif not theirPlr.Character or not theirPlr.Character:FindFirstChild("Torso") or not theirPlr.Character:FindFirstChild("Head") then
								if instance_name=="Health" then
									return 0
								elseif instance_name=="IsBeast" then
									return false
								end
							else
								if instance_name=="Health" then
									return 100
								elseif instance_name=="IsBeast" then
									return true
								end
							end
						end
					end
				end)

				--[[local function NormalFunction(valName)
					return C.myTSM:FindFirstChild(valName).Value
				end

				TSMModule.GetValue = newValue and function(valName)
					local caller = getcallingscript()

					return NormalFunction(valName)
				end or NormalFunction

				for num, theirPlr in ipairs(PS:GetPlayers()) do
					if theirPlr ~= plr then
						local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule")
						local theirTSMMod = require(theirTSM)
						local function TheirPlayerNormalFunction(valName)
							return theirTSM:FindFirstChild(valName).Value
						end
						theirTSMMod.GetValue = newValue and function(valName)
							local caller = getcallingscript()
							--print(caller,valName)
							if caller.Name == "LocalGuiScript" then
								local canContinue = false
								if not canContinue and C.enHacks.Util_ForceAllowSpectate then
									local debugTraceBack = debug.traceback("",1)
									for num, str in ipairs(allowedEndValues2) do
										if debugTraceBack:sub(debugTraceBack:len()-str:len()+1) == str then
											canContinue = true
											break
										end
									end
								end
								if canContinue and not RS.IsGameActive.Value then
									local canContinue2 = true
									for num, theirPlr in ipairs(PS:GetPlayers()) do
										if theirPlr ~= plr then
											local theirTSM2 = theirPlr:WaitForChild("TempPlayerStatsModule")
											if theirTSM2 and (theirTSM2.Health.Value > 0 or theirTSM2.IsBeast.Value) then
												canContinue2 = false
												if theirTSM2 == theirTSM then
													if valName == "Health" then
														return 100
													elseif valName == "IsBeast" then
														return true
													end
												end
											end
										end
									end
									if valName=="Health" and canContinue2 
										and (not spectatorName.Parent.Visible or spectatorName.TextColor3.G > .9) then
										local MapLighting = C.Map and (C.Map:FindFirstChild("_LightingSettings") or C.Map:FindFirstChild("NotLightingSettings"))
										if MapLighting then
											MapLighting.Name = "NotLightingSettings"
										end
										return 100
									end
								end
							end

							return TheirPlayerNormalFunction(valName)
						end or TheirPlayerNormalFunction
					end
				end--]]

				--TODO HERE C.GetTempValue(identification,funct)
			end,
			["MyPlayerAdded"]=function()
				local DefaultLightning = game.ReplicatedStorage:FindFirstChild("DefaultLightingSettings") or game.ReplicatedStorage:FindFirstChild("NotDefaultLightingSettings")


				local function upd()
					if (C.myTSM.IsBeast.Value or C.myTSM.Health.Value > 0) and math.abs(game.Lighting.ClockTime - 14) > .2 then
						DefaultLightning.Name = "NotDefaultLightingSettings"
					else
						DefaultLightning.Name = "DefaultLightingSettings"
					end
				end
				local function updMap()
					local MapLighting = C.Map and (C.Map:FindFirstChild("_LightingSettings") or C.Map:FindFirstChild("NotLightingSettings"))
					if not MapLighting then return end
					if RS.IsGameActive.Value then
						MapLighting.Name = "_LightingSettings"
					else
						MapLighting.Name = "NotLightingSettings"
					end
				end
				table.insert(C.AvailableHacks.Utility[5].Functs,C.myTSM.Health.Changed:Connect(upd))
				table.insert(C.AvailableHacks.Utility[5].Functs,C.myTSM.IsBeast.Changed:Connect(upd))
				table.insert(C.AvailableHacks.Utility[5].Functs,LS:GetPropertyChangedSignal("ClockTime"):Connect(upd))
				table.insert(C.AvailableHacks.Utility[5].Functs,RS.IsGameActive.Changed:Connect(updMap))
				upd() updMap()
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Utility[5].ActivateFunction(C.enHacks.Util_ForceAllowSpectate)

				local spectatorName = StringWaitForChild(PlayerGui,"ScreenGui.SpectatorFrame.SpectatorName")
				local function updateSpectatorFrameColor3()
					local theirPlr = PS:FindFirstChild(spectatorName.Text)
					if theirPlr then
						local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule")
						if theirTSM then
							if theirTSM.IsBeast.Value then
								spectatorName.TextColor3 = Color3.fromRGB(255)
								return
							elseif theirTSM.Health.Value>0 then
								spectatorName.TextColor3 = Color3.fromRGB(0,0,255)
								return
							end
						end
					end
					spectatorName.TextColor3 = Color3.fromRGB(255,255,255)
				end
				table.insert(C.AvailableHacks.Utility[5].Functs,spectatorName:GetPropertyChangedSignal("Text"):Connect(updateSpectatorFrameColor3))
				table.insert(C.AvailableHacks.Utility[5].Functs,RS.IsGameActive.Changed:Connect(updateSpectatorFrameColor3))
				updateSpectatorFrameColor3()

			end,
			["MapAdded"]=function()
				C.AvailableHacks.Utility[5].MyPlayerAdded()
			end,
		},
		[3]=({
			["Type"]="ExTextButton",
			["Title"]="Client Improvements",
			["Desc"]="Fixes elements",
			["Shortcut"]="Util_Fix",
			["Default"]=true,
			["Functs"]={},
			["DontActivate"] = true,
			["Universes"]={"Global"},
			["ActivateFunction"]=function(newValue)
				for num, funct in ipairs(C.AvailableHacks.Utility[3].Functs) do
					funct:Disconnect()
				end
				C.AvailableHacks.Utility[3].Functs = {}

				--[[local textScaledTL = C.AvailableHacks.Utility[3].DummyTextBox
				if textScaledTL then
					textScaledTL:Destroy()
				end
				textScaledTL = Instance.new("TextBox",HackGUI)
				textScaledTL.Visible = true
				textScaledTL.Position = UDim2.fromScale(5,0)
				textScaledTL:AddTag("RemoveOnDestroy")
				C.AvailableHacks.Utility[3].DummyTextBox = textScaledTL--]]

				if C.gameUniverse=="Flee" then
					local ScreenGui = PlayerGui:WaitForChild("ScreenGui");
					local MenusTabFrame = ScreenGui:WaitForChild("MenusTabFrame");
					local BeastPowerMenuFrame = C.gameName=="FleeMain" and ScreenGui:WaitForChild("BeastPowerMenuFrame")
					local SurvivorStartFrame = C.gameName=="FleeMain" and  ScreenGui:WaitForChild("SurvivorStartFrame")
					local IsCheckingLoadData = C.gameName=="FleeMain" and plr:WaitForChild("IsCheckingLoadData");
					if IsCheckingLoadData then
						local function changedFunct()
							if C.enHacks.Util_Fix then
								MenusTabFrame.Visible=not IsCheckingLoadData.Value;
							end
						end
						setChangedProperty(MenusTabFrame,"Visible", (newValue and changedFunct or nil));
						changedFunct()
					end
					if BeastPowerMenuFrame then
						local function beastScreen()
							if C.enHacks.Util_Fix then
								BeastPowerMenuFrame.Visible=false;
							end
						end
						setChangedProperty(BeastPowerMenuFrame, "Visible", (newValue and beastScreen or nil));
						beastScreen()
					end
					if SurvivorStartFrame then
						local function survivorScreen()
							if C.enHacks.Util_Fix then
								SurvivorStartFrame.Visible=false;
							end
						end
						setChangedProperty(SurvivorStartFrame, "Visible", (newValue and survivorScreen or nil));
						survivorScreen()
					end
				end

				local chatTextLabel = C.gameUniverse=="Flee" and StringWaitForChild(PlayerGui,"Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.TextLabel")

				if (UIS.TouchEnabled and newValue) and not C.AvailableHacks.Utility[3].Active and TCS.ChatVersion == Enum.ChatVersion.LegacyChatService then
					local chatButton = C.gameUniverse=="Flee" and StringWaitForChild(PlayerGui,"ScreenGui.ChatIconFrame.Button")
					--local chatMain = C.requireModule(StringWaitForChild(plr,"PlayerScripts.ChatScript.ChatMain"))
					local chatBar = StringWaitForChild(PlayerGui,"Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar")
					local action1 = (UIS.MouseEnabled and UIS.TouchEnabled  and "select") 
						or (UIS.MouseEnabled and "click") or (UIS.TouchEnabled and "tap") or "<idk>"
					if chatTextLabel then
						chatTextLabel.Text = "To chat ".. action1 .." here".. (UIS.KeyboardEnabled and ' or press "/" key' or "")
					end
					--print("CHATMAIN",chatMain)
					local function slashPressed(name,state)
						if state == Enum.UserInputState.Begin and not UIS:GetFocusedTextBox() then
							--chatMain.ChatBarFocusChanged:fire(true)
							SG:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
							SG:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
							--task.wait(1)
							if C.AvailableHacks.Utility[3].Funct then
								C.AvailableHacks.Utility[3].Funct:Disconnect()
							end
							local saveConnection = chatBar:GetPropertyChangedSignal("TextTransparency"):Connect(function()
								chatBar.TextTransparency = 0
							end)
							chatBar.TextTransparency = 0
							C.AvailableHacks.Utility[3].Funct=saveConnection
							RunS.RenderStepped:Wait()
							if chatButton then
								chatButton.Image = "rbxassetid://5227476720"--set the image to visible!
							end
							chatBar:CaptureFocus()
							task.wait(2.5)
							if C.AvailableHacks.Utility[3].Funct==saveConnection then
								saveConnection:Disconnect()
								C.AvailableHacks.Utility[3].Funct=nil
							end

							--for s = 1, 1, -1 do RunS.RenderStepped:Wait() end
							--chatBar:ReleaseFocus()
							--for s = 5, 1, -1 do RunS.RenderStepped:Wait() end
							--v553:SetVisible(true)
							--InstantFadeIn()
							--v145:CaptureFocus()
							--v1.ChatBarFocusChanged:fire(true)
							--chatMain.FocusChatBar()
							--chatMain.SpecialKeyPressed(nil,Enum.SpecialKey.ChatHotkey,nil)

							--chatBar:CaptureFocus()
							--print("Trans",chatBar.TextTransparency)
						end
					end
					C.AvailableHacks.Utility[3].Active=true
					CAS:BindActionAtPriority("PushSlash"..C.saveIndex,slashPressed,false,10000,Enum.KeyCode.Slash)
				elseif (not UIS.TouchEnabled or not newValue) and C.AvailableHacks.Utility[3].Active then
					C.AvailableHacks.Utility[3].Active=nil
					if C.AvailableHacks.Utility[3].Funct then
						C.AvailableHacks.Utility[3].Funct:Disconnect()
						C.AvailableHacks.Utility[3].Funct=nil
					end
					CAS:UnbindAction("PushSlash"..C.saveIndex)
					if chatTextLabel then
						if UIS.TouchEnabled then
							chatTextLabel.Text = "Tap here to chat"
						else
							chatTextLabel.Text = 'To chat click here or press "/" key'
						end
					end
				end
				local function cameraChanged()
					task.wait(.5)
					local newCameraType = camera.CameraType
					if newCameraType == Enum.CameraType.Custom and C.enHacks.Util_Fix then
						camera.CameraType = Enum.CameraType.Track
					elseif newCameraType == Enum.CameraType.Track and not C.enHacks.Util_Fix then
						camera.CameraType = Enum.CameraType.Custom
					end
				end
				setChangedProperty(camera,"CameraType", (newValue and cameraChanged or nil));
				task.delay(1.5,cameraChanged)
				--[[local function textBoxSelected(TextBox)
					if TextBox.TextScaled then
						textScaledTL.Font = TextBox.Font
						textScaledTL.Size = TextBox.Size
						textScaledTL.Text = TextBox.PlaceholderText
						textScaledTL.Position = TextBox.Position - UDim2.fromOffset(0,100)
						local setSize = 8 
						for size = 64, setSize, -1 do
							textScaledTL.TextSize = size
							RunS.RenderStepped:Wait()
							if textScaledTL.TextFits then
								setSize = size
								break
							end
						end
						print("Best Predicted Value",setSize)
						TextBox.TextSize = setSize
					end
				end
				table.insert(C.AvailableHacks.Utility[3].Functs,UIS.TextBoxFocused:Connect(textBoxSelected))--]]
				--if (newValue and not C.AvailableHacks.Utility[3].Funct) then
					--[[C.AvailableHacks.Utility[3].Funct = UIS.InputBegan:Connect(function(input, gameprocesssed)
						if gameprocesssed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS.TouchEnabled then
							triggerConnection(UIS.TouchTapInWorld)
						end
					end)--]]
					--[[local ChatMain = StringWaitForChild(plr,"PlayerScripts.ChatScript.ChatMain")
					if ChatMain then
						local MainChatFrame = StringWaitForChild(PlayerGui,"Chat.Frame")
						local ChatMainMod = getscriptfunction(ChatMain)
						if ChatMainMod then
							ChatMainMod.VisibilityStateChanged.Event:Connect(function(isVisible)
								print("VisibilityStateChanged Fired!",isVisible)
								if isVisible then
									MainChatFrame.Visible = true
								end
							end)
						end
					else
						warn("[Client Improvement]: Chat Main Not Found!")
					end
				elseif ((not newValue) and C.AvailableHacks.Utility[3].Funct) then
					C.AvailableHacks.Utility[3].Funct:Disconnect()
					C.AvailableHacks.Utility[3].Funct = nil
				end--]]
			end,
			["ChatBarAdded"]=function(chatBar,firstRun)
				if firstRun then return end
				C.AvailableHacks.Utility[3].Active=nil
				if C.AvailableHacks.Utility[3].Funct then
					C.AvailableHacks.Utility[3].Funct:Disconnect()
					C.AvailableHacks.Utility[3].Funct=nil
				end
				CAS:UnbindAction("PushSlash"..C.saveIndex)
				C.AvailableHacks.Utility[3].ActivateFunction(C.enHacks.Util_Fix)
			end,
			["MyBeastAdded"]=function()
				C.AvailableHacks.Utility[3].ActivateFunction(C.enHacks.Util_Fix)
			end,
			["CleanUp"]=function()
				C.AvailableHacks.Utility[3].ActivateFunction(C.enHacks.Util_Fix)
				C.AvailableHacks.Utility[3].YieldFix()
			end,
			["YieldFix"]=function()
				task.wait(2)
				for s = 300, 1, -1 do
					if not SG:GetCore("ChatActive") then
						pcall(SG.SetCore,SG,"ChatActive",true)
						pcall(SG.SetCoreGuiEnabled,SG,Enum.CoreGuiType.Chat, false)
						pcall(function()
							C.requireModule(((game:GetService("Chat")):WaitForChild("ClientChatModules")):WaitForChild("ChatSettings")).ChatOnWithTopBarOff = true
						end)
						task.spawn(error,"[client improvement]: Fix Enabled")
					end
					RunS.RenderStepped:Wait()
				end
			end,
			["MyStartUp"]=function()
				RunS.RenderStepped:Wait()--Delay it
				C.AvailableHacks.Utility[3].ActivateFunction(C.enHacks.Util_Fix)
				if C.gameUniverse ~= "Flee" then
					return
				end
				C.AvailableHacks.Utility[3].YieldFix()
			end,
			["MyPlayerAdded"]=function()
				if C.saveIndex == 1 then -- it's first execute, let's fix keyboard input!
					local randoTB = Instance.new("TextBox",PlayerGui)
					--[[while true do
						rando = :FindFirstChildWhichIsA("TextBox",true)
						print("Searching")
						if rando then
							break
						else
							RunS.RenderStepped:Wait()
						end
					end--]]
					randoTB:CaptureFocus()
					RunS.RenderStepped:Wait()
					if randoTB and randoTB.Parent then

						if randoTB:IsFocused() then
							randoTB:ReleaseFocus()
						end
						randoTB:Destroy()
					end
				end
			end,
		}),
		[4]={
			["Type"]="ExTextButton",
			["Title"]="Crawl Type",
			["Desc"]="Changes the method for crawling",
			["Shortcut"]="Util_CrawlType",
			["Default"]="Default",
			["Options"] = {
				["Default"]={
					["Title"]="DEFAULT",
					["TextColor"]=newColor3(255,255,255),
				},
				["Hold"] = {
					["Title"]="HOLD",
					["TextColor"]=newColor3(0,0,255),
				},
				["Toggle"] = {
					["Title"]="TOGGLE",
					["TextColor"]=newColor3(255,255,0)
				},
			},
		},
		[7]=(UIS.TouchEnabled and {
			["Type"]="ExTextButton",
			["Title"]="Hide Touchscreen",
			["Desc"]="Prevents Touchscreen from appearing!",
			["Shortcut"]="Util_HideTouchscreen",
			["Default"]=true,
			["Universes"]={"Global"},
			["ActivateFunction"]=function(newValue,override)
				if C.isCleared and not override then return end
				local ContextActionGui = PlayerGui:WaitForChild("ContextActionGui")
				local TouchGui = PlayerGui:WaitForChild("TouchGui");
				local TouchGui2 = C.gameName == "FlagWars" and PlayerGui:WaitForChild("Mobile UI")
				local function updateTouchScreenEnability()
					TouchGui.Enabled = not C.enHacks.Util_HideTouchscreen
					ContextActionGui.Enabled = not C.enHacks.Util_HideTouchscreen
					if TouchGui2 then
						TouchGui2.Enabled = not C.enHacks.Util_HideTouchscreen
					end
				end
				setChangedProperty(TouchGui,"Enabled",(C.enHacks.Util_HideTouchscreen and updateTouchScreenEnability))
				setChangedProperty(ContextActionGui,"Enabled",(C.enHacks.Util_HideTouchscreen and updateTouchScreenEnability))
				if TouchGui2 then
					setChangedProperty(TouchGui2,"Enabled",(C.enHacks.Util_HideTouchscreen and updateTouchScreenEnability))
				end
				C.human.AutoJumpEnabled = not C.enHacks.Util_HideTouchscreen
				updateTouchScreenEnability()
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Utility[7].ActivateFunction()
			end,
		}),
		[8] = {
			["Type"]="ExTextButton",
			["Title"]="Mobile Hammer Fix",
			["Desc"]="Fixes an aspect of the hammer",
			["Shortcut"]="Util_Hammer",
			["ClubFuncts"] = {},
			["ShowFreezeConnections"]={},
			["Default"]=true,
			["CleanUp"]=function()
				for s = #C.AvailableHacks.Utility[8].ClubFuncts, 1, -1 do
					local funct = C.AvailableHacks.Utility[8].ClubFuncts[s]
					if funct then
						funct:Disconnect()
					end
					table.remove(C.AvailableHacks.Utility[8].ClubFuncts,s)
				end
				if C.AvailableHacks.Utility[8].ClubFuncts.ClearFreezePodBillboardIcons then
					C.AvailableHacks.Utility[8].ClubFuncts.ClearFreezePodBillboardIcons()
				end
				local hammerAnims = {"AnimSwing","AnimWipe","AnimArmIdle"}
				local Animator = C.human and C.human:FindFirstChild("Animator")
				if Animator then
					for _, track in ipairs(C.human:WaitForChild("Animator"):GetPlayingAnimationTracks()) do
						if table.find(hammerAnims,track.Animation.Name) then
							track:Stop(0)
							track:Destroy()
						end
					end
				end
			end,
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Utility[8].CleanUp()
				if not C.myTSM.IsBeast.Value then
					return
				end
				local Hammer = C.GetBeastHammerFunct(plr)
				if not Hammer then
					return
				end
				local LocalClubScript = Hammer:WaitForChild("LocalClubScript",5)
				if not LocalClubScript then
					return warn("LocalClubScript Not Found, Hacks Bro!")
				end
				newValue = C.enHacks.Util_Hammer--reset it because we yielded!

				LocalClubScript.Disabled = newValue
				if newValue then
					while not C.AvailableHacks.Utility[8].ClubFuncts.LocalClubScriptFunction and not C.isCleared do
						task.wait()
					end
					task.delay(0,C.AvailableHacks.Utility[8].ClubFuncts.LocalClubScriptFunction,LocalClubScript)
				end
			end,
			["MyPlayerAdded"] = function()
				if not C.enHacks.Util_Hammer then
					return
				end
				C.AvailableHacks.Utility[8].ClubFuncts = C.Modules.LocalClubScript(C,_SETTINGS)
				C.AvailableHacks.Utility[8].Funct = C.myTSM:WaitForChild("IsBeast").Changed:Connect(function()
					C.AvailableHacks.Utility[8].ActivateFunction(C.enHacks.Util_Hammer)
				end)
			end,
		},
		[9]={
			["Type"]="ExTextButton",
			["Title"]="Auto Mute Music",
			["Desc"]="Activate To Force Stop Lobby and/or Beast Music",
			["Shortcut"]="Util_MuteMusic",
			["Default"]=((C.gameName~="FleeMain" and "Lobby") or (_SETTINGS.botModeEnabled and "Both")),
			["DontActivate"]=true,
			["Options"]={
				[false] = ({
					["Title"] = "OFF",
					["TextColor"] = newColor3(255),
				}),
				["Lobby"] = ({
					["Title"] = "LOBBY",
					["TextColor"] = newColor3(0,0,255),
				}),
				["Beast"] = (C.gameName=="FleeMain" and {
					["Title"] = "BEAST",
					["TextColor"] = newColor3(0,255,255),
				} or nil),
				["Both"]=(C.gameName=="FleeMain" and {
					["Title"] = "BOTH",
					["TextColor"] = newColor3(255,255,0),
				} or nil),
			},
			["Universes"]={"Flee"},
			["Funct"]=nil,
			["MusicValue"] = nil,
			["MusicValue2"] = nil,
			["MusicValue3"] = nil,
			["ActivateFunction"]=function()
				local newValue = C.enHacks.Util_MuteMusic
				local function stopSound(musicSound)
					if musicSound:IsDescendantOf(C.char) then
						musicSound:Stop()
					else
						if not musicSound:GetAttribute("SaveVolume") then
							musicSound:SetAttribute("SaveVolume",musicSound.Volume)
						end
						musicSound.Volume = 0
					end
				end
				local function startSound(musicSound)
					if musicSound:IsDescendantOf(C.char) then
						musicSound:Resume()
					else
						musicSound.Volume = musicSound:GetAttribute("SaveVolume") or musicSound.Volume
					end
				end
				local function applyToSound(musicSound,needs)
					if musicSound then
						local shouldBe = newValue == needs or newValue == "Both"
						if shouldBe and musicSound.IsPlaying then
							stopSound(musicSound)
						elseif not shouldBe and not musicSound.IsPlaying then
							startSound(musicSound)
						end
					end
				end
				local lobbyMusicSound = C.AvailableHacks.Utility[9].MusicValue
				applyToSound(lobbyMusicSound,"Lobby")
				applyToSound(C.AvailableHacks.Utility[9].MusicValue2,"Beast")
				applyToSound(C.AvailableHacks.Utility[9].MusicValue3,"Beast")

				local musicButton = StringWaitForChild(PlayerGui,"MenusScreenGui.MainMenuWindow.Body.InfoFrame.MuteBGMusicButton")
				musicButton.Image = lobbyMusicSound and lobbyMusicSound.IsPlaying and "rbxassetid://2973636234" or "rbxassetid://2973636435"
			end,
			["BeastAdded"]=function(theirPlr,theirChar)
				local theirHammer = theirChar:WaitForChild("Hammer",30)
				if not theirHammer then
					return
				end
				local hammerHandle = theirHammer:WaitForChild("Handle")
				if C.gameName == "FleeMain" then
					C.AvailableHacks.Utility[9].MusicValue2 = hammerHandle:WaitForChild("SoundHeartBeat")
					C.AvailableHacks.Utility[9].MusicValue3 = hammerHandle:WaitForChild("SoundChaseMusic")
				end
				C.AvailableHacks.Utility[9].ActivateFunction()
			end,

			["MyStartUp"] = function()
				if C.AvailableHacks.Utility[9].Funct then
					C.AvailableHacks.Utility[9].Funct:Disconnect()
				end
				local musicSound
				if C.gameName=="FleeMain" then
					musicSound = StringWaitForChild(C.char,"BackgroundMusicLocalScript.Sound",15)
				elseif C.gameName=="FleeTrade" then
					musicSound = StringWaitForChild(C.char,"PlayerScripts.BackgroundMusicLocalScript.Sound",15)
				end
				if not musicSound then
					return
				end
				C.AvailableHacks.Utility[9].MusicValue = musicSound
				setChangedProperty(musicSound,"Playing",C.AvailableHacks.Utility[9].ActivateFunction)
				setChangedProperty(musicSound,"IsPlaying",C.AvailableHacks.Utility[9].ActivateFunction)
				setChangedProperty(musicSound,"Volume",C.AvailableHacks.Utility[9].ActivateFunction)
				C.AvailableHacks.Utility[9].ActivateFunction()
				C.AvailableHacks.Utility[9].Funct = musicSound.Played:Connect(C.AvailableHacks.Utility[9].ActivateFunction)
			end,
		},

		[15]={
			["Type"]="ExTextBox",
			["Title"]="Insta Trade Amount",
			["Desc"]="Set to 1 for default",
			["Places"]={"FleeTrade"},
			["Shortcut"]="Util_InstaTradeAmnt",
			["Default"]=4,
			["MinBound"]=1,
			["MaxBound"]=20,
		},
		[10]={
			["Type"]="ExTextButton",
			["Title"]="Insta Trade",
			["Desc"]="Automatically accepts trades from whitelisted bots!",
			["Shortcut"]="Util_InstaTrade",
			["Places"]={"FleeTrade"},--only works in 1 place, no universes
			["Default"]=_SETTINGS.botModeEnabled,
			["CurrentNum"]=0,
			["ActivateFunction"]=function(en)
				local TradeSpyEn=false

				plr:FindFirstChild("TradeMenuLocalScript",true).Enabled=not en

				--BuyShopBundle, "Solar Witch Bundle"
				--SendMyTradeOffer, {items}
				--GetPlayerInventory
				local ReceiveEvent=Instance.new("BindableEvent")
				local waitForThing
				local function waitForReceive(thing2Wait,args,shouldntSend)
					while waitForThing do
						ReceiveEvent.Event:Wait()
					end
					waitForThing=thing2Wait
					if not shouldntSend then
						task.delay(.15,function()
							C.RemoteEvent:FireServer(C.RemoteEvent,thing2Wait,table.unpack(args or {}))
						end)
					end
					return ReceiveEvent.Event:Wait()
				end
				local canTrade=true
				local lastSend=0
				if C.AvailableHacks.Utility[10].Funct then
					C.AvailableHacks.Utility[10].Funct:Disconnect()
				end
				if en then
					local function RemoteEventReceivedFunction(main,sec,third)
						if main=="StartTradeCoolDown" then
							lastSend=os.clock()
						end
						if main=="RecieveTradeRequest" then
							local user=PS:GetPlayerByUserId(sec)
							if ((_SETTINGS.myBots[user.Name:lower()] or _SETTINGS.whitelistedUsers[user.Name:lower()]) and canTrade) then
								C.RemoteEvent:FireServer("AcceptTradeRequest")
								print("Accepted")
								local theirItems,theirUser=waitForReceive("GetOtherPlayerInventory",{user.UserId})
								local items2Trade=waitForReceive("GetPlayerInventory")
								local theirItemsCount={}
								table.remove(items2Trade,table.find(items2Trade,"H0001"))
								table.remove(items2Trade,table.find(items2Trade,"G0001"))
								for num, item in ipairs(theirItems) do
									theirItemsCount[item]=(theirItemsCount[item] or 0)+1
									if theirItemsCount[item]>=10 then
										local Occurances = 0
										while true do --for num2, item2Remove in ipairs(items2Trade) do
											local KeyFind = table.find(items2Trade,item)
											if KeyFind then
												table.remove(items2Trade,KeyFind)
												Occurances = Occurances + 1
											else
												break
											end
										end
										print(theirUser.." has max limit of "..(item:sub(1,1)=="H" and "Hammer" or "Gem") .." "..RS.ItemDatabase[item]:GetAttribute("ItemName").."! ("..C.comma_value(Occurances).." Removed)")
									end
								end
								for s=1,#items2Trade-C.enHacks.Util_InstaTradeAmnt do
									table.remove(items2Trade,Random.new():NextInteger(1,#items2Trade))
								end
								local isStillSending=true
								task.spawn(function()
									waitForReceive("UpdateMyTradeOfferResult",nil,true)
									isStillSending=false
								end)
								--while isStillSending or not isStillSending do
								print("Sending "..C.comma_value(#items2Trade).." items: ", table.concat(items2Trade,", "))
								C.RemoteEvent:FireServer("SendMyTradeOffer",items2Trade)
								task.wait(1/4)
								--end
								lastSend=os.clock()>3 and os.clock() or lastSend
								while os.clock()-lastSend<3.1 do
									task.wait(1/4)
								end
								local isWaiting=true
								task.spawn(function()
									waitForReceive("TradeAccepted",nil,true)
									isWaiting=false
								end)
								while isWaiting do
									if os.clock()-lastSend>=30 then
										print("Trade complete timeout!")
										C.RemoteEvent:FireServer("CancelTrade")
										return
									end
									C.RemoteEvent:FireServer("AcceptTradeOffer")
									task.wait()
								end
								print("Trade Successfully Complete!")
							else
								C.RemoteEvent:FireServer("CancelTrade")
							end
						elseif waitForThing==main then
							waitForThing=nil
							ReceiveEvent:Fire(sec,third)
						elseif (TradeSpyEn and string.find(main:lower(),"trade")~=nil and main~="UpdateOpenTradePlayersList" and main~= "PlayerListJoined" and main~= "PlayerListRemoved") then
							print("Spy;",table.unpack({main,sec,third}))
						end
					end
					C.AvailableHacks.Utility[10].Funct = C.RemoteEvent.OnClientEvent:Connect(C.RemoteEventReceivedFunction)
					C.RemoteEvent:FireServer("CancelTrade")
				else
					C.AvailableHacks.Utility[10].Funct = false
				end
			end
		},
		[14] = {
			["Type"]="ExTextButton",
			["Title"]="Disable Error Logging",
			["Desc"]="Prevents Errors From Being Detected!",
			["Default"]=true,
			["Shortcut"]="Utility_DisableErrorLogging",
			["Universes"]={"FlagWars","Global"},
			["ActivateFunction"]=(function(newValue)
				local Connections = getconnections(SC.Error)
				for num, connection in ipairs(Connections) do--C.GetHardValue(SC,"Error",{yield=true})) do
					if connection.ForeignState then
						--warn(`Connection {num} is a ForeignState!`)
						continue
					end
					if connection.Function ~= C.BetterConsoleErrorFunction and newValue then
						--warn("FunctDiff:",connection.Function,C.BetterConsoleErrorFunction)
						if connection.Enabled then
							connection:Disable()
							--warn("Disabled "..num.."/"..#Connections)
						end
					else
						if not connection.Enabled then
							connection:Enable()
							--warn("Enabled "..num.."/"..#Connections)
						end
					end
				end
			end),
		},
		[22]={
			["Type"]="ExTextButton",
			["Title"]="Rescue In Range",
			["Desc"]="Automatically rescues when in range",
			["Shortcut"]="Util_Macro_Rescue",--TODO HERE
			["Default"]=true,
			["Funct"]=nil,
			["ActivateFunction"]=function(en)
				if C.AvailableHacks.Utility[22].Funct then
					C.AvailableHacks.Utility[22].Funct:Disconnect()
					C.AvailableHacks.Utility[22].Funct = nil
				end
				if en then
					C.AvailableHacks.Utility[22].Funct = C.myTSM:WaitForChild("ActionEvent").Changed:Connect(function(newEvent)
						local topParent = newEvent
						while topParent and topParent.Parent ~= C.Map do
							topParent = topParent.Parent
						end
						if not topParent then
							return
						end
						if not topParent:HasTag("Capsule") then
							return
						end

						C.RemoteEvent:FireServer("Input", "Action", true)
						C.myTSM.ActionInput.Value = true
						RunS.RenderStepped:Wait()
						C.RemoteEvent:FireServer("Input", "Action", false)
						C.myTSM.ActionInput.Value = false
					end)
				end
			end
		},
		[26]={
			["Type"]="ExTextButton",
			["Title"]="Chat Spy",
			["Desc"]="Spies for private messages",
			["Shortcut"]="Utility_ChatSpy",
			["Universes"]={"Global"},
			["Default"]=true,
			["OthersPlayerAdded"]=function(theirPlr)
				local Config = {public = false}
				local DefaultChatSystemChatEvents = RS:WaitForChild("DefaultChatSystemChatEvents",10)
				if not DefaultChatSystemChatEvents then
					return
				end
				local getmsg = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering")
				table.insert(C.playerEvents[theirPlr.UserId],theirPlr.Chatted:Connect(function(msg)
					if C.enHacks.Utility_ChatSpy then
						msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ') -- CLIP THE MESSAGE (important!)
						local hidden = true
						local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
							if (packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All") and packet.SpeakerUserId==theirPlr.UserId)
								or (channel=="Team" and Config.public==false and PS[packet.FromSpeaker].Team==plr.Team) then
								hidden = false
							end
						end)
						task.wait(1)
						conn:Disconnect()
						if hidden then
							C.CreateSysMessage("["..theirPlr.Name.."]: "..msg,Color3.fromRGB(0,175),"Chat Spy")
						end
					end
				end))
			end,
			--[[["MyPlayerAdded"]=function(myPlr)
				C.AvailableHacks.Utility[26].PlayerAdded(myPlr)
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				C.AvailableHacks.Utility[26].PlayerAdded(theirPlr)
			end,--]]
		},
		[200]={
			["Type"]="ExTextButton",
			["Title"]="Disable Favorite Game",
			["Desc"]="Disables favorite game prompt",
			["Shortcut"]="Utility_DisableFavoriteGame",
			["Universes"]={"UGCClick"},
			["Default"]=true,
			["DontActivate"]=true,
			["ActivateFunction"]=function() 
				C.AvailableHacks.Utility[200].MyStartUp()
			end,
			["MyStartUp"]=function()
				local FavoriteGame = StringWaitForChild(PlayerGui,"FavoriteGameScript")
				FavoriteGame.Enabled = not C.enHacks.Utility_DisableFavoriteGame
			end,
		},
	},
	["Basic"]={
		[1]={
			["Type"]="ExTextBox",
			["Title"]="Walkspeed",
			["Desc"]="Set to 16 to default",
			["Shortcut"]="WalkSpeed",
			["Default"]= _SETTINGS.defaultCharacterWalkSpeed,--(_SETTINGS.botModeEnabled and false or defaultCharacterWalkSpeed),
			["MinBound"]=0,
			["MaxBound"]=1e3,
			["DontActivate"]=true,
			["UpdateSpeed"]=function()
				local crawlSlowDown = 1/2
				local newSpeed = C.human:GetAttribute("OverrideSpeed")
				if (C.isCleared and C.myTSM and C.myTSM:FindFirstChild("NormalWalkSpeed")) or
					(not newSpeed and C.gameUniverse=="Flee" and C.enHacks.WalkSpeed==_SETTINGS.defaultCharacterWalkSpeed and C.myTSM:WaitForChild("NormalWalkSpeed",1/4)) then
					newSpeed=C.myTSM.NormalWalkSpeed.Value
				elseif C.isCleared then
					newSpeed=SP.CharacterWalkSpeed
				else
					newSpeed=C.enHacks.WalkSpeed or C.AvailableHacks.Basic[1].Default
				end
				if C.gameUniverse=="Flee" then
					newSpeed = newSpeed * (1-((C.myTSM.IsCrawling.Value and crawlSlowDown) or 0))
				end
				C.human.WalkSpeed=newSpeed
			end,
			["ActivateFunction"]=function(newValue)
				if newValue==_SETTINGS.defaultCharacterWalkSpeed or C.isCleared then
					setChangedProperty(C.human,"WalkSpeed",false)
				else
					setChangedProperty(C.human,"WalkSpeed",C.AvailableHacks.Basic[1].UpdateSpeed)
				end 
				C.AvailableHacks.Basic[1].UpdateSpeed()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				RunS.RenderStepped:Wait()
				C.AvailableHacks.Basic[1].Funct=C.human:GetAttributeChangedSignal("OverrideSpeed"):Connect(C.AvailableHacks.Basic[1].UpdateSpeed)
				if C.enHacks.WalkSpeed ~= _SETTINGS.defaultCharacterWalkSpeed then
					C.AvailableHacks.Basic[1].ActivateFunction(C.enHacks.WalkSpeed)
				end
			end,
			["MyPlayerAdded"]=function()
				if C.gameUniverse~="Flee" then
					return
				end
				table.insert(C.functs,C.myTSM:WaitForChild("IsCrawling").Changed:Connect(C.AvailableHacks.Basic[1].UpdateSpeed))
			end,
		},
		[2]={
			["Type"]="ExTextBox",
			["Title"]="JumpPower",
			["Desc"]="Set to 36 to default",
			["Shortcut"]="JumpPower",
			["Default"]=(C.gameUniverse=="Flee" and 36 or SP.CharacterJumpPower),
			["MinBound"]=0,
			["MaxBound"]=5e4,
			["DontActivate"]=true,
			["ActivateFunction"]=function(newValue)
				local function setJump()
					--print("Set Jump",C.isCleared)
					C.human.JumpPower=newValue;
				end;

				setJump();

				if ((newValue) == (SP.CharacterJumpPower)) then
					setChangedProperty(C.human,"JumpPower",false);
				else
					setChangedProperty(C.human,"JumpPower",setJump);
				end;
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				C.AvailableHacks.Basic[2].ActivateFunction(C.enHacks.JumpPower);
			end,
		},
		[3]={
			["Type"] = "ExTextBox",
			["Title"] = "Gravity",
			["Desc"] = "Set to 196.2 to default",
			["Shortcut"] = "Gravity",
			["Default"] = math.round(workspace.Gravity * 100)/100,
			["MinBound"] = 0,
			["MaxBound"] = 1000,
			["ActivateFunction"] = (function(newValue)
				local function setSpeed()
					workspace.Gravity=newValue
				end
				local absVal = math.abs(newValue-196.2)
				if ((absVal) < 0.0001) then
					setChangedProperty(workspace,"Gravity",false)
				else
					setChangedProperty(workspace,"Gravity",setSpeed)
				end
				setSpeed()
			end),
		},
		[4] = {
			["Type"]="ExTextButton",
			["Options"]={
				[false] = ({
					["Title"] = "OFF",
					["TextColor"] = newColor3(255),
				}),
				["Fly"] = ({
					["Title"] = "FLY",
					["TextColor"] = newColor3(0,0,255),
				}),
				["InfJump"] = ({
					["Title"] = "INFINITE JUMP",
					["TextColor"] = newColor3(0,255,255),
				}),
				["Jetpack"]={
					["Title"] = "JETPACK",
					["TextColor"] = newColor3(255,255,0),
				},
				["Float"]=({
					["Title"] = "FLOAT",
					["TextColor"] = newColor3(0,255),
				}),
				["Noclip"]={
					["Title"] = "NOCLIP",
					["TextColor"] = newColor3(255,0,255),
				}
				--[[(
					C.gameUniverse~="Flee" and 
					{
						["Title"]="NOCLIP",
						["TextColor"]=newColor3(255,0,255)
					} or nil
				)--]]
			},
			["Title"]="Special Movement Type",
			["Desc"]="Z to Toggle, F and G to control",
			["Shortcut"]="Movement",
			["Default"]="Fly",
			["IsActive"]=false,
			["ToggleFunct"]=nil,
			["MovementFuncts"]={},
			["FlyScript"]=function()
				local speed = 4
				local allowedID={
					["rbxassetid://1416947241"]=true,
					["rbxassetid://939025537"]=true,
					["rbxassetid://894494203"]=true,
					["rbxassetid://894494919"]=true,
					["rbxassetid://961932719"]=true,
					["rbxassetid://6802445333"]=true,
				}

				local hrp = C.char:WaitForChild("HumanoidRootPart",15)
				if not hrp then return end
				local animator = C.human:WaitForChild("Animator")

				while (not C.char.Parent) do
					C.char.AncestryChanged:Wait()
				end

				local bodyGyro = Instance.new("BodyGyro")
				bodyGyro.maxTorque = newVector3(1, 1, 1)*10^6
				bodyGyro.P = 10^6

				local bodyVel = Instance.new("BodyVelocity")
				bodyVel.maxForce = newVector3(1, 1, 1)*10^6
				bodyVel.P = 10^4

				local Attach = Instance.new("Attachment")
				local Attack2 = Attach:Clone()

				C.AvailableHacks.Basic[4].IsActive=false

				local IsActive = C.AvailableHacks.Basic[4].IsActive
				local movement = {forward = 0, backward = 0, right = 0, left = 0, down = 0, up = 0}
				local mouse = plr:GetMouse()
				local i = 0
				C.AvailableHacks.Basic[4].ToggleFunct=function(flying)
					C.AvailableHacks.Basic[4].IsActive = flying
					bodyGyro.Parent = C.AvailableHacks.Basic[4].IsActive and C.char.HumanoidRootPart or nil
					bodyVel.Parent = C.AvailableHacks.Basic[4].IsActive and C.char.HumanoidRootPart or nil
					bodyGyro.CFrame = hrp.CFrame
					bodyVel.Velocity = newVector3()
					C.human:SetStateEnabled(Enum.HumanoidStateType.Seated,not flying)
					--setCollisionGroupRecursive(character,flying and groupName or "Original")

					for i, v in pairs(animator:GetPlayingAnimationTracks()) do
						if allowedID[v.Animation.AnimationId]==nil then
							v:Stop()
						end
					end
					if C.char:FindFirstChild("Animate") ~=nil and game.GameId~=372226183 and C.gameName ~= "NavalWarefare" then
						C.char.Animate.Disabled=C.AvailableHacks.Basic[4].IsActive
					end
				end
				--local ActionSettings={
				--	["forward"]="MovementHorizontalSpeed",
				--	["backward"]="MovementHorizontalSpeed",
				--	["left"]="MovementHorizontalSpeed",
				--	["right"]="MovementHorizontalSpeed",
				--	["up"]="MovementVerticalSpeed",
				--}
				local function onUpdate(dt)
					if (C.AvailableHacks.Basic[4].IsActive) then
						local cf = camera.CFrame

						local charCF = C.char:GetPivot()
						local MoveDirection = C.PlayerControlModule and C.PlayerControlModule:GetMoveVector() or C.human.MoveDirection
						local right = MoveDirection.X;
						local up = MoveDirection.Y;
						local forward = -MoveDirection.Z;
						if (UIS:IsKeyDown(Enum.KeyCode.Space)) then
							up += 1
						end
						if (UIS:IsKeyDown(Enum.KeyCode.E)) then
							up += 1
						end
						if (UIS:IsKeyDown(Enum.KeyCode.Q)) then
							up -= 1
						end
						local direction = cf.RightVector * right + cf.LookVector * forward + cf.UpVector * up; 

						if (direction:Dot(direction) > 0) then
							direction = direction.unit
						end
						bodyGyro.CFrame = cf
						bodyVel.Velocity = (direction * newVector3(C.enHacks.MovementHorizontalSpeed,C.enHacks.MovementVerticalSpeed,C.enHacks.MovementHorizontalSpeed)) * C.human.WalkSpeed * speed
					end
				end

				--CAS:BindAction("forward", movementBind, false, Enum.PlayerActions.CharacterForward)
				--CAS:BindAction("backward", movementBind, false, Enum.PlayerActions.CharacterBackward)
				--CAS:BindAction("left", movementBind, false, Enum.PlayerActions.CharacterLeft)
				--CAS:BindAction("right", movementBind, false, Enum.PlayerActions.CharacterRight)
				--CAS:BindAction("up", movementBind, false, Enum.PlayerActions.CharacterJump)
				--table.insert(C.AvailableHacks.Basic[4].MovementFuncts,C.human:GetPropertyChangedSignal("MoveDirection"))
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,RunS.RenderStepped:Connect(onUpdate))
				local function animatorPlayedFunction(animTrack)
					if C.AvailableHacks.Basic[4].IsActive
						and allowedID[animTrack.Animation.AnimationId]==nil then
						animTrack:Stop(0)
					end
				end
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,animator.AnimationPlayed:Connect(animatorPlayedFunction))
			end,
			["NoclipScript"] = (function()
				local speed = 4
				local i = 0

				local function setCollisionGroupRecursive(object,flying)
					if object:IsA("BasePart") and not object:HasTag("InviWalls") then
						if not flying then
							--object.CanCollide=not object:GetAttribute(C.OriginalCollideName) or object.CanCollide
						else

						end
						C.SetCollide(object,"noclip",not flying)
					end
					for _, child in ipairs(object:GetChildren()) do
						setCollisionGroupRecursive(child,flying)
					end
					i = i + 1
					if i==1250 then
						i=0
						RunS.RenderStepped:Wait()
					end
				end

				local allowedID={
					["rbxassetid://1416947241"]=true,
					["rbxassetid://939025537"]=true,
					["rbxassetid://894494203"]=true,
					["rbxassetid://894494919"]=true,
					["rbxassetid://961932719"]=true,
					["rbxassetid://6802445333"]=true,
				}
				local RunS = game:GetService("RunService")

				local hrp = C.char:WaitForChild("HumanoidRootPart",15)
				if not hrp then return end
				local animator = C.human:WaitForChild("Animator")

				while (not C.char.Parent) do
					C.char.AncestryChanged:Wait()
				end

				local bodyGyro = Instance.new("BodyGyro")
				bodyGyro.maxTorque = newVector3(1, 1, 1)*10^6
				bodyGyro.P = 10^6

				local bodyVel = Instance.new("BodyVelocity")
				bodyVel.maxForce = newVector3(1, 1, 1)*10^6
				bodyVel.P = 10^4

				local Attach = Instance.new("Attachment")
				local Attack2 = Attach:Clone()

				C.AvailableHacks.Basic[4].IsActive=false
				local IsActive = C.AvailableHacks.Basic[4].IsActive
				local movement = {forward = 0, backward = 0, right = 0, left = 0, down = 0, up = 0}
				local mouse = plr:GetMouse()
				local i = 0
				C.AvailableHacks.Basic[4].ToggleFunct=function(flying)
					if not flying then
						setCollisionGroupRecursive(workspace, false)
					end
					C.AvailableHacks.Basic[4].IsActive = flying
					bodyGyro.Parent = (C.AvailableHacks.Basic[4].IsActive and C.char.HumanoidRootPart or nil)
					bodyVel.Parent = (C.AvailableHacks.Basic[4].IsActive and C.char.HumanoidRootPart or nil)
					bodyGyro.CFrame = hrp.CFrame
					bodyVel.Velocity = newVector3()
					C.human:SetStateEnabled(Enum.HumanoidStateType.Seated,not flying)
					--setCollisionGroupRecursive(character,flying and groupName or "Original")

					local getPlayingAnimationTracks = animator:GetPlayingAnimationTracks();

					for i, v in ipairs(getPlayingAnimationTracks) do
						if (allowedID[v.Animation.AnimationId]==nil) then
							print("Stopped",v.Animation.AnimationId)
							v:Stop()
						end
					end
					local shouldActivate = (C.char:FindFirstChild("Animate") ~=nil and game.GameId~=372226183 and C.gameName ~= "NavalWarefare")
					if shouldActivate then
						C.char.Animate.Disabled = C.AvailableHacks.Basic[4].IsActive
					end
					if flying then
						setCollisionGroupRecursive(workspace, true)
					end
				end
				--local ActionSettings={
				--	["forward"]="MovementHorizontalSpeed",
				--	["backward"]="MovementHorizontalSpeed",
				--	["left"]="MovementHorizontalSpeed",
				--	["right"]="MovementHorizontalSpeed",
				--	["up"]="MovementVerticalSpeed",
				--}
				local function onUpdate(dt)
					if (C.AvailableHacks.Basic[4].IsActive) then
						local cf = camera.CFrame

						local charCF = C.char:GetPivot()
						local MoveDirection = C.PlayerControlModule and C.PlayerControlModule:GetMoveVector() or C.human.MoveDirection
						local right = MoveDirection.X;
						local up = MoveDirection.Y;
						local forward = -MoveDirection.Z;
						if (UIS:IsKeyDown(Enum.KeyCode.Space)) then
							up += 1
						end
						if (UIS:IsKeyDown(Enum.KeyCode.E)) then
							up += 1
						end
						if (UIS:IsKeyDown(Enum.KeyCode.Q)) then
							up -= 1
						end
						local direction = cf.RightVector * right + cf.LookVector * forward + cf.UpVector * up; 

						if (direction:Dot(direction) > 0) then
							direction = direction.unit
						end
						bodyGyro.CFrame = cf
						bodyVel.Velocity = ((direction * newVector3(C.enHacks.MovementHorizontalSpeed,C.enHacks.MovementVerticalSpeed,C.enHacks.MovementHorizontalSpeed)) * C.human.WalkSpeed * speed)
					end
				end



				local function movementBind(actionName, inputState, inputObject)

					if (inputState == Enum.UserInputState.Begin) then
						movement[actionName] = 1
					elseif (inputState == Enum.UserInputState.End) then
						movement[actionName] = 0
					end
					--if (C.AvailableHacks.Basic[4].IsActive) then
					--	local isMoving = movement.right + movement.left + movement.forward + movement.backward > 0
					--end
					return Enum.ContextActionResult.Pass
				end

				--CAS:BindAction("forward", movementBind, false, Enum.PlayerActions.CharacterForward)
				--CAS:BindAction("backward", movementBind, false, Enum.PlayerActions.CharacterBackward)
				--CAS:BindAction("left", movementBind, false, Enum.PlayerActions.CharacterLeft)
				--CAS:BindAction("right", movementBind, false, Enum.PlayerActions.CharacterRight)
				--CAS:BindAction("up", movementBind, false, Enum.PlayerActions.CharacterJump)
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,RunS.RenderStepped:Connect(onUpdate))
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,animator.AnimationPlayed:Connect(function(animTrack)
					if C.AvailableHacks.Basic[4].IsActive and allowedID[animTrack.Animation.AnimationId]==nil then
						animTrack:Stop(0)
					end
				end))
			end),
			["InfJumpScript"]=function()
				local index=0
				local myConnections = {}
				local function forceJump()
					local JumpSaveIndex=index
					while (JumpSaveIndex==index and C.AvailableHacks.Basic[4].IsActive and C.enHacks.Movement=="InfJump" and (isJumpBeingHeld)) do
						C.human:ChangeState(Enum.HumanoidStateType.Jumping)
						task.wait((1.5/(C.enHacks.MovementVerticalSpeed)))
					end
				end
				C.AvailableHacks.Basic[4].ToggleFunct=function(isActive)
					if isActive then
						table.insert(myConnections, UIS.JumpRequest:Connect(forceJump));
						if isJumpBeingHeld then
							forceJump("up",Enum.UserInputState.Begin);
						end
						table.insert(C.AvailableHacks.Basic[4].MovementFuncts, jumpChangedEvent.Event:Connect(forceJump))
					elseif #myConnections>0 then
						for num, myConn in ipairs(myConnections) do
							myConn:Disconnect()
						end
						myConnections = {}
					end
				end
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,jumpChangedEvent.Event:Connect(forceJump))
				C.AvailableHacks.Basic[4].ToggleFunct(C.AvailableHacks.Basic[4].IsActive)
			end,
			["JetpackScript"]=function()
				local inputBegan, inputEnded, v167, jumpBoost

				local jetpackGui= Instance.new("ScreenGui")
				local Jetpack = Instance.new("Frame")
				local Frame = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local UICorner_2 = Instance.new("UICorner")

				--Properties:

				jetpackGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
				jetpackGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				jetpackGui.Name="JetpackGUI"

				Jetpack.Name = "Jetpack"
				Jetpack.Parent = jetpackGui
				Jetpack.BackgroundColor3 = newColor3(0, 0, 0)
				Jetpack.BackgroundTransparency = 0.300
				Jetpack.Position = UDim2.new(0.978341579, 0, 0.251152068, 0)
				Jetpack.Size = UDim2.new(0.0147277517, 0, 0.369124442, 0)

				Frame.Parent = Jetpack
				Frame.BackgroundColor3 = newColor3(255, 255, 0)
				Frame.Size = UDim2.new(1, 0, 1, 0)

				UICorner.Parent = Frame

				UICorner_2.Parent = Jetpack

				local SpaceKeyCodeTable = {
					["KeyCode"] = Enum.KeyCode.Space
				};
				local v5 = C.char:WaitForChild("HumanoidRootPart")
				local v7 = game:GetService("UserInputService")
				local v14 = Instance.new("BodyVelocity", v5.Parent.HumanoidRootPart)
				v14.MaxForce = newVector3(0, 0, 0)
				v14.Name="JetpackVelocity"
				local v32 = 7
				local v39 = Frame
				local fadePerc = function(p1, p2)
					if v39.Parent then
						v39:TweenSizeAndPosition(UDim2.new(1, 0, p1, 0), UDim2.new(0, 0, 1 - p1, 0), "Out", "Linear", p2, true);
					end
				end
				local stopFade = function()
					local v74 = 1
					fadePerc(v74, 0)
					return v74
				end
				local function isOnLand_1()
					local v86 = {}
					v86[1] = v5.Parent
					v86[2] = plr.Character
					local v91, v87 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v5.Position, newVector3(0, -4, 0)), v86)
					if not v91 then
						return true
					end
					return false
				end
				local isOnLand = isOnLand_1
				isOnLand_1 = true
				local v98 = 0
				local jumpEnd = function()
					v98 = v98 + 1
					local v120 = v98
					v14.MaxForce = newVector3(0, 0, 0)
					local v112 = .25
					local v130 = v112 * stopFade()
					v32 = v130
					while not C.isCleared and C.enHacks.Movement=="Jetpack" do
						v130 = isOnLand
						local v113 = v130()
						if v113 then
							break
						end
						v113 = v98
						if v120 ~= v113 then
							return
						end
						v113 = wait
						v112 = 0.3
						v113(v112)
					end
					local v114 = v98
					if v120 ~= v114 then
						return
					end
					v114 = fadePerc
					v114(1, 0.8 - v32)
					isOnLand_1 = true
				end
				local function JetpackToggleFunction(isActive)
					Jetpack.Visible=isActive
					if not isActive then
						jumpEnd()
					elseif isActive and (isJumpBeingHeld) then
						local function spawnFunction()
							inputBegan(({["KeyCode"] = (Enum.KeyCode.Space)}))
						end
						task.spawn(spawnFunction)
					end
				end
				C.AvailableHacks.Basic[4].ToggleFunct=(JetpackToggleFunction)
				local function jumpBoost()
					if not C.AvailableHacks.Basic[4].IsActive then
						return
					end
					v98 = v98 + .1
					local v149 = v98
					local v150 = isOnLand_1
					if not v150 then
						v150 = wait
						v150(0.2)
					end
					local v135 = v98
					if v149 ~= v135 then
						return
					end
					v135 = false
					isOnLand_1 = v135
					v32 = 8 * stopFade()
					v14.MaxForce = newVector3(12000, 12000, 12000)
					fadePerc(0, v32)
					wait(v32)
					local v148 = v98
					if v149 ~= v148 then
						return
					end
					v148 = jumpEnd
					v148()
				end
				inputBegan = function(p3)
					if v7:GetFocusedTextBox()~=nil or C.isCleared then
						return
					end
					v167 = p3.KeyCode
					local v168 = Enum.KeyCode.Space
					if v167 == v168 then
						v168 = jumpBoost
						v168()
					end
				end
				local function inputEnded_1(p4)
					if C.isCleared then
						return
					end
					local v171 = Enum.KeyCode.Space
					if (p4.KeyCode == v171) then
						v171 = jumpEnd
						v171()
					end
				end
				inputEnded = inputEnded_1
				inputEnded_1 = v7.InputBegan
				local Funct2Run = C.AvailableHacks.Basic[4].ToggleFunct;
				Funct2Run(C.AvailableHacks.Basic[4].IsActive);
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,inputEnded_1:connect(inputBegan));
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,v7.InputEnded:connect(inputEnded));
				local function taskSpawnJetpackUpdateVelFunction()
					while not C.isCleared and C.enHacks.Movement=="Jetpack" and workspace:IsAncestorOf(v14) do
						v14.Velocity=(v5.CFrame-v5.Position)*newVector3(0,60*C.enHacks.MovementVerticalSpeed,-60*C.enHacks.MovementHorizontalSpeed);
						task.wait();
					end
				end
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,jumpChangedEvent.Event:Connect(function(jumping)
					if jumping then
						inputBegan(SpaceKeyCodeTable)
					else
						inputEnded(SpaceKeyCodeTable)
					end
				end))

				task.spawn(taskSpawnJetpackUpdateVelFunction)
			end,
			["FloatScript"]=function()
				local v14 = Instance.new("BodyPosition", C.char:WaitForChild("HumanoidRootPart"))
				v14.MaxForce = newVector3(0, 0, 0) v14.Name="JetpackVelocity"
				local height=0
				local baseHeight=0
				local isR6=C.human.RigType==Enum.HumanoidRigType.R6
				local function update(new,saveHeight)
					local blackListTable = {"Blacklist",C.char}
					local directionPosition1 = C.char.PrimaryPart.Size.Y/2+(isR6 and C.char["Right Leg"] or C.char["LeftLowerLeg"]).Size.Y/2+3.03
					local directionPosition2 = C.getHumanoidHeight(C.char)
					local directionPosition
					if isR6 then
						directionPosition = directionPosition1
					else
						directionPosition = directionPosition2
					end
					local characterOffsetStartingPosition = (C.char.PrimaryPart.Position-newVector3(0,3,0))
					local didHit,hitPart=C.raycast(C.char.PrimaryPart.Position,characterOffsetStartingPosition,blackListTable,directionPosition,false,true)
					if (didHit) then
						baseHeight=C.char.HumanoidRootPart.Position.Y
						local absHeight = math.abs(height)
						if ((absHeight)>0) then
							height=0
						else
							height=math.max(0,new)
						end
					else
						height=new
					end
					v14.Position = newVector3(0, (baseHeight+height), 0)
					if height<.1 and height>-.1 then
						v14.MaxForce = newVector3(0,0,0)
					else
						v14.MaxForce = newVector3(0, 12000000e9, 0)
						local saveHeight=saveHeight or height
						local function delayedUpdateFunction()
							if saveHeight==height then
								update(height)
							end
						end
						task.delay(.1,delayedUpdateFunction)
					end
				end
				local index = 0;
				local function ascend(actionName, inputState, _inputObject)
					if inputState ~= Enum.UserInputState.Begin and inputState ~= Enum.UserInputState.End then
						return
					end
					index += 1;
					local FloatSaveIndex = index;
					if inputState == Enum.UserInputState.Begin then
						while FloatSaveIndex == index do
							update(height+2);
							task.wait(.05);
						end
					end
				end
				local function descend(actionName, inputState, _inputObject)
					if inputState ~= Enum.UserInputState.Begin and inputState ~= Enum.UserInputState.End then
						return
					end
					index += 1;
					local FloatSaveIndex = index;
					if inputState == Enum.UserInputState.Begin then
						while FloatSaveIndex == index do
							update(height-2);
							task.wait(.05);
						end
					end
				end
				CAS:BindAction("up"..C.saveIndex, ascend, true, Enum.KeyCode.F, Enum.KeyCode.ButtonY);
				CAS:BindAction("down"..C.saveIndex, descend, true, Enum.KeyCode.G, Enum.KeyCode.ButtonX);
				CAS:SetPosition("up"..C.saveIndex,UDim2.new(.3));
				CAS:SetPosition("down"..C.saveIndex,UDim2.new(.7));
				CAS:SetTitle("up"..C.saveIndex,"up");
				CAS:SetTitle("down"..C.saveIndex,"down");
				update(0)
			end,
			["DisableMovement"] = (function()
				if (C.AvailableHacks.Basic[4].IsActive and C.AvailableHacks.Basic[4].ToggleFunct) then
					C.AvailableHacks.Basic[4].ToggleFunct()
					C.AvailableHacks.Basic[4].ToggleFunct=nil
				end
				for num,funct in pairs(C.AvailableHacks.Basic[4].MovementFuncts) do
					funct:Disconnect()
				end
				C.AvailableHacks.Basic[4].MovementFuncts = {}
				C.AvailableHacks.Basic[4].ToggleFunct = nil
				CAS:UnbindAction("foward"..C.saveIndex)
				CAS:UnbindAction("backward"..C.saveIndex)
				CAS:UnbindAction("left"..C.saveIndex)
				CAS:UnbindAction("right"..C.saveIndex)
				CAS:UnbindAction("up"..C.saveIndex)
				CAS:UnbindAction("down"..C.saveIndex)
				C.human:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
				local JetpackGUI=plr.PlayerGui:FindFirstChild("JetpackGUI")
				if JetpackGUI~=nil then 
					JetpackGUI:Destroy()
				end
				if C.char:FindFirstChild("HumanoidRootPart") then
					local JetpackVelocity = C.char.HumanoidRootPart:FindFirstChild("JetpackVelocity")
					if JetpackVelocity then 
						JetpackVelocity:Destroy()
					end
				end
			end),
			["ActivateFunction"]=(function(newValue)
				local function onKeyPress(actionName, inputState, _inputObject)
					if inputState == Enum.UserInputState.Begin and C.enHacks.Movement and not C.isCleared then
						if (not C.human or C.human:GetState() == Enum.HumanoidStateType.Dead) then
							return
						end
						local isActive = not C.AvailableHacks.Basic[4].IsActive
						C.AvailableHacks.Basic[4].IsActive=isActive
						if C.AvailableHacks.Basic[4].ToggleFunct~=nil then
							C.AvailableHacks.Basic[4].ToggleFunct(isActive)
						end
					end
				end
				if newValue and newValue~="Float" then
					CAS:BindAction("en_movement"..C.saveIndex, onKeyPress, true, Enum.KeyCode.Z, Enum.KeyCode.ButtonA);
					CAS:SetPosition("en_movement"..C.saveIndex,UDim2.fromScale(.8, 0.3));
					CAS:SetTitle("en_movement"..C.saveIndex,newValue);
					table.insert(C.functs,UIS.InputBegan:Connect(onKeyPress));
				else
					CAS:UnbindAction("en_movement"..C.saveIndex);
				end

				C.AvailableHacks.Basic[4].DisableMovement()
				if C.enHacks.Movement then
					C.AvailableHacks.Basic[4].IsActive=true
					C.AvailableHacks.Basic[4][C.enHacks.Movement.."Script"]()
				end
			end),
			["MyStartUp"]=function(myPlr,myChar)
				C.AvailableHacks.Basic[4].DisableMovement()
				if C.enHacks.Movement then
					C.AvailableHacks.Basic[4].IsActive=true
					C.AvailableHacks.Basic[4][C.enHacks.Movement.."Script"]()
				end
			end,
			["MyPlayerAdded"]=function(plr)

			end,
		},
		[5]={
			["Type"]="ExTextBox",
			["Title"]="Movement Vertical",
			["Desc"]="Set to 1 for default",
			["Shortcut"]="MovementVerticalSpeed",
			["Default"]=1,
			["MinBound"]=0.01,
			["MaxBound"]=100.00,
		},
		[6]={
			["Type"]="ExTextBox",
			["Title"]="Movement Horizontal",
			["Desc"]="Set to 1 for default",
			["Shortcut"]="MovementHorizontalSpeed",
			["Default"]=1,
			["MinBound"]=0.01,
			["MaxBound"]=100.00,
		},
		[12]={
			["Type"]="ExTextButton",
			["Title"]="Teleport",
			["Desc"]='Keybind: "T"',
			["Shortcut"]="Teleport",
			["Default"]=true,
			["Functs"]={},
			["TeleportFunction"]=function(target,newOrien)
				local isCFrame=typeof(target)=="CFrame"
				local primPart=C.char.PrimaryPart
				if primPart==nil then
					return
				end
				local position1=(C.char:FindFirstChild("Torso") or C.char:FindFirstChild("UpperTorso")).Position
				local position2=target+ newVector3(0,C.getHumanoidHeight(C.char)+(C.gameUniverse=="Flee" and 1.85 or 0),0)
				position2=isCFrame and position2.Position or position2
				local result,hitPart
				if GlobalSettings.discreteTeleportsOnly then
					result,hitPart = C.raycast(position1,position2,{"Blacklist",C.char},(position1-position2).magnitude,1,true)
					if not result then
						result=({["Position"]=position2})
					end
				else
					result = {["Position"] = position2}
				end
				--if not isCFrame then
				local orientation
				if not isCFrame then
					orientation=newOrien~=nil and newVector3(newOrien.X,primPart.Orientation.Z,primPart.Orientation.Z) or primPart.Orientation
				else
					orientation=newVector3(target:ToOrientation())
				end
				teleportMyself(CFrame.new(result.Position) * CFrame.Angles(math.rad(orientation.X),math.rad(orientation.Y),math.rad(orientation.Z)))
			end,
			["ActivateFunction"]=function(newValue)
				local mouse=plr:GetMouse();
				--C.objectFuncts[mouse]=C.objectFuncts[mouse] or {};
				for num,funct in pairs(C.AvailableHacks.Basic[12].Functs) do--C.objectFuncts[mouse]) do
					funct:Disconnect();
				end;--]]
				C.AvailableHacks.Basic[12].Functs = {};
				if newValue then
					local function keyDownFunction(key)
						if key == "t" or key == "n" then
							local inputPosition;
							local TPFunction = C.AvailableHacks.Basic[12].TeleportFunction;
							if UIS:IsKeyDown(Enum.KeyCode.LeftControl) and C.gameName == "FleeMain" then
								local closestPC, closestDist = nil, 0
								for num,pc in ipairs(CS:GetTagged("Computer")) do
									local newDist = (pc:GetPivot().Position - C.char:GetPivot().Position).Magnitude;
									if newDist > closestDist then
										closestPC,closestDist = pc, newDist;
									end;
								end;
								if not closestPC then
									return
								end
								return C.AvailableHacks.Render[28].ComputerTeleportFunctions[closestPC]()
							else
								inputPosition = mouse.Hit.Position;
								local result,hitPart = C.raycast(camera.CFrame.Position,inputPosition,{"Blacklist",C.char},15e3,1,C.AvailableHacks.Basic[4].IsActive and C.enHacks.Movement=="Noclip")
								if not result then
									return
								else
									inputPosition = result.Position
								end
							end
							TPFunction(inputPosition);
						end;
					end;
					--local objectFuncts_ADD = C.objectFuncts[mouse];
					local connection_1 = mouse.KeyDown:Connect(keyDownFunction);
					table.insert(C.AvailableHacks.Basic[12].Functs, connection_1);
					local lastTouch = 0;
					local function TouchTapFunction(touchPositions,gameProcessedEvent)
						if gameProcessedEvent or not PlayerGui.TouchGui.Enabled then
							return;
						end;
						if os.clock() - lastTouch <= .3 then
							lastTouch = 0;
							keyDownFunction("t");
						else
							lastTouch = os.clock();
						end;
					end;
					local connection_2 = UIS.TouchTap:Connect(TouchTapFunction);
					table.insert(C.AvailableHacks.Basic[12].Functs,connection_2);
				end;

			end,
			["MyStartUp"]=function()
				local HRP = C.char:WaitForChild("HumanoidRootPart",30)
				if not C.char.PrimaryPart and HRP then
					C.char.PrimaryPart=HRP
				end
			end,
		},
		[20]={
			["Type"]="ExTextButton",
			["Title"]="Walk Through Invisible Walls",
			["Desc"]="Walk Through All Invisible Walls In The Game",
			["Shortcut"]="Basic_InviWalls",
			["Default"]=false,
			["Options"]={
				[false]={
					["Title"]="DISABLED",
					["TextColor"]=newColor3(255, 0, 0),
				},
				["Visible"]={
					["Title"]="VISIBLE",
					["TextColor"]=newColor3(0,170,170),
				},
				["Invisible"]={
					["Title"]="INVISIBLE",
					["TextColor"]=newColor3(255, 255, 255),
				},
			},
			["Universes"]={"Global"},
			["FirstClean"]=false,
			["GetStructure"]=function(object)
				local doorNames = {"Door","DoorL","DoorR"}

				if table.find(doorNames,object.Parent.Name) and object.Parent.Parent~=workspace then--or object.Name=="WalkThru" then
					return "Door", object.Parent.Parent
				elseif table.find(doorNames,object.Parent.Parent.Name) then
					return "Door", object.Parent.Parent.Parent
				else
					local worldSize = GetAbsoluteWorldSize(object)
					if (((worldSize.X >= 9 and worldSize.Z <=9) or (worldSize.X <= 9 and worldSize.Z >= 9)) or worldSize.Y > 18) 
						and (worldSize.Y >= 2 or worldSize.X < 9 or worldSize.Z < 9)
						and (object:GetAttribute("OrgTrans") or object.Transparency) < .1 then
						return "Wall"
					end
				end					
			end,
			["InstanceRemoved"]=function(object)
				local structure, instance = C.AvailableHacks.Basic[20].GetStructure(object)
				--print(object.Name,structure)
				--[[if object.Name=="WalkThru" and structure == "Door" then
					local DoorTrigger = StringWaitForChild(object.Parent,"DoorTrigger.ActionSign",0)
					print(object.Name,DoorTrigger and DoorTrigger.Value)
					object.CanCollide = DoorTrigger and DoorTrigger.Value == 10
				else--]]
				if structure == "Door" then
					setChangedProperty(object,"CanCollide",false)--Disable this first!
					setChangedAttribute(instance,"Opened",nil,object)
				end
				if structure == "Door" then
					object.CanCollide = not instance:GetAttribute("Opened")
				elseif object:HasTag("InviWalls") then
					--[[local current = object:GetAttribute("WeirdCanCollide") or 1
					current -= 1
					if current == 0 then
						object.CanCollide = true-- and not object:GetAttribute("OriginalCollide")
					end
					object:SetAttribute("WeirdCanCollide",current>0 and current or nil)--]]
					C.SetCollide(object,"inviwalls",true)
				end
				--object:SetAttribute("WeirdCanCollide",nil)
				--end
				object.Color = object:GetAttribute("OrgColor") or object.Color
				object.Transparency = object:GetAttribute("OrgTrans") or object.Transparency
				object.CastShadow = true
				object:RemoveTag("InviWalls")
			end,
			["InstanceAdded"]=function(object)
				if not object:IsA("BasePart") or not object.Parent or not object.Parent.Parent then 
					return
				end
				local structure, stuctureParent = C.AvailableHacks.Basic[20].GetStructure(object)
				local isDoor,isWall = structure=="Door",structure=="Wall"
				if not object.Parent then
					return
				elseif (isDoor and not C.enHacks.Blatant_WalkThruDoors) or (isWall and not C.enHacks.Blatant_WalkThruWalls) then
					return C.AvailableHacks.Basic[20].InstanceRemoved(object)	
				end
				local isCollision = (object:GetAttribute("WeirdCanCollide") or object.CanCollide)
				local shouldBeInvi = ((object:GetAttribute("OrgTrans") or object.Transparency)>=.95 and isCollision) 
					or (C.enHacks.Blatant_WalkThruDoors and isDoor) or (C.enHacks.Blatant_WalkThruWalls and isWall)
				if (shouldBeInvi) and (GlobalSettings.MinimumHeight<=GetAbsoluteWorldSize(object).Y or isDoor or isWall)
					and not object.Parent:FindFirstChild("Humanoid") and not object.Parent.Parent:FindFirstChild("Humanoid") then
					if object:GetAttribute("OrgColor")==nil then
						object:SetAttribute("OrgColor",object.Color)
					end
					if object:GetAttribute("OrgTrans")==nil then
						object:SetAttribute("OrgTrans",object.Transparency)
					end
					if not isDoor then
						if isCollision then
							--if object:GetAttribute("OriginalCollide") and not isDoor then
							--	object:SetAttribute("WeirdCanCollide",object:GetAttribute("OriginalCollide"))
							--else
							--local org = object:GetAttribute("WeirdCanCollide") or 0
							--object:SetAttribute("WeirdCanCollide",org + 1)
							--print("Added to",object,object:HasTag("InviWalls"))
							C.SetCollide(object,"inviwalls",false)
							--end
						end
					else
						object.CanCollide = false
					end
					--object:SetAttribute("WeirdCanCollide",not object.CanCollide)
					object:AddTag("InviWalls")

					object.CastShadow = false
					object.Transparency = C.enHacks.Basic_InviWalls=="Invisible" and 1 or .6
					if isDoor then
						--object:SetAttribute("OriginalCollide",object.CanCollide)
						local function refreshColor()
							object.Color = stuctureParent:GetAttribute("Opened") and Color3.fromRGB(0,200) or Color3.fromRGB(200)
						end
						setChangedProperty(object,"CanCollide",function()
							--object:SetAttribute("WeirdCanCollide",not object.CanCollide)
							setChangedProperty(object,"CanCollide",nil)
							setChangedAttribute(stuctureParent,"Opened",nil,object)
							C.AvailableHacks.Basic[20].InstanceAdded(object)
						end)
						setChangedAttribute(stuctureParent,"Opened",function()
							refreshColor()
						end,object)--]]
						refreshColor()
					else
						object.Color = Color3.fromRGB(0,0,200)
					end--]]
				end
			end,
			["ApplyInvi"]=function(instance)
				--local start = os.clock()
				local saveEn = C.enHacks.Basic_InviWalls
				for num, object in ipairs(instance:GetDescendants()) do
					C.AvailableHacks.Basic[20].InstanceAdded(object)
					if num%250==0 then
						RunS.RenderStepped:Wait()
					end
					if saveEn ~= C.enHacks.Basic_InviWalls then
						return
					end
				end
				--print(("search completed after %.2f"):format(os.clock()-start))
			end,
			["MapAdded"]=function(newMap)
				local BasePlate = workspace:FindFirstChild("MapBaseplate")
				if BasePlate then
					BasePlate.CanCollide = true
				end

				if not C.AvailableHacks.Basic[20].FirstClean then
					C.AvailableHacks.Basic[20].FirstClean=true
					C.AvailableHacks.Basic[20].ActivateFunction(false)
					if C.enHacks.Basic_InviWalls then
						C.AvailableHacks.Basic[20].ActivateFunction(C.enHacks.Basic_InviWalls)
					end
				end
				local GameStatus = RS:WaitForChild("GameStatus")
				while GameStatus.Value:find("LOADING:") do
					GameStatus.Changed:Wait()
					task.wait(1/2)--wait a bit!
				end
				if not C.enHacks.Basic_InviWalls or not newMap.Parent then
					return
				end
				C.AvailableHacks.Basic[20].ApplyInvi(newMap)
			end,
			["ActivateFunction"]=function(newValue)
				if newValue then
					C.AvailableHacks.Basic[20].ApplyInvi(workspace)
				else
					for num, object in ipairs(CS:GetTagged("InviWalls")) do
						C.AvailableHacks.Basic[20].InstanceRemoved(object)
					end
				end
			end,
		},
		[24]={
			["Type"]="ExTextButton",
			["Title"]="Better Wall Clip",
			["Desc"]="Allows walking through walls; disabled while crawl; hold R to temp disable",
			["Shortcut"]="Basic_NoClip",
			["Default"]="Toggle",
			["Options"] = {
				[false]={
					["Title"]="OFF",
					["TextColor"]=newColor3(255,255,255),
				},
				["Hold"] = {
					["Title"]="HOLD",
					["TextColor"]=newColor3(0,0,255),
				},
				["Toggle"] = {
					["Title"]="TOGGLE",
					["TextColor"]=newColor3(255,255,0)
				},
			},
			["Universes"]={"Global"},
			["Funct"]=nil,
			["IsHoldingF"]=false,
			["ActivateFunction"]=function(newValue)
				if C.AvailableHacks.Basic[24].Funct then
					C.AvailableHacks.Basic[24].Funct:Disconnect()
					C.AvailableHacks.Basic[24].Funct=nil
				end
				if newValue then
					C.AvailableHacks.Basic[24].IsHoldingF = false --local isHoldF = false
					local wasLastFrameHolding = false
					C.AvailableHacks.Basic[24].Funct=RunS.Stepped:Connect(function()
						if C.char then
							if C.human and C.human.Health>0 then
								local state = C.human:GetState()

								local hasRDown = UIS:IsKeyDown(Enum.KeyCode.R)

								local hasFDown = (newValue=="Hold" and hasRDown)
								if newValue=="Toggle" and hasRDown and not wasLastFrameHolding then
									C.AvailableHacks.Basic[24].IsHoldingF = not C.AvailableHacks.Basic[24].IsHoldingF
								end
								hasFDown = hasFDown or C.AvailableHacks.Basic[24].IsHoldingF
								wasLastFrameHolding = hasRDown

								local canCollide = state == Enum.HumanoidStateType.Climbing or hasFDown
									or (C.AvailableHacks.Beast[2] and C.AvailableHacks.Beast[2].IsCrawling)
								for num, basepart in ipairs(C.char:GetDescendants()) do
									if basepart and basepart:IsA("BasePart") then
										C.SetCollide(basepart,"wallclip",canCollide,true)
									end
								end
							end
						end
					end)
				else
					for num, basepart in ipairs(C.char:GetDescendants()) do
						if basepart and basepart:IsA("BasePart") then
							C.SetCollide(basepart,"wallclip",true,true)
						end
					end
				end
			end,
		},
		[25]={
			["Type"]="ExTextButton",
			["Title"]="Disable Touch Transmitters",
			["Desc"]="Disable Touch Transmitters",
			["Shortcut"]="Basic_DisableTouchTransmitters",
			["Default"]=false,
			["DontActivate"]=true,
			["Options"]={
				[false]={
					["Title"]="DISABLED",
					["TextColor"]=newColor3(255, 0, 0),
				},
				["Parts"]={
					["Title"]="PARTS",
					["TextColor"]=newColor3(170,170,170),
				},
				["Humanoids"]={
					["Title"]="HUMANOIDS",
					["TextColor"]=newColor3(0,170,170),
				},
				[true]={
					["Title"]="ALL",
					["TextColor"]=newColor3(255, 255, 255),
				},
			},
			["Universes"]={"Global"},
			["TouchTransmitters"]={},
			["GlobalTouchTransmitters"]={},
			["MapAdded"]=function(newMap)
				local GameStatus = RS:WaitForChild("GameStatus")
				while GameStatus.Value:find("LOADING:") do
					GameStatus.Changed:Wait()
					task.wait(1/2)--wait a bit!
				end
				if not C.enHacks.Basic_DisableTouchTransmitters or not newMap.Parent then
					return
				end
				C.AvailableHacks.Basic[25].ApplyTransmitters(newMap)
			end,
			["GetType"]=function(instance)
				if instance.Parent.Parent.ClassName=="Model" and instance.Parent.Parent.Parent==workspace
					and instance.Parent.Parent:WaitForChild("Humanoid",.1) then
					return "Humanoid"
				else
					return "Part"
				end
			end,
			["CanBeEnabled"]=function(instance,Type)
				Type = Type or C.AvailableHacks.Basic[25].GetType(instance)
				if C.isCleared or not instance or not instance.Parent then
					return false, Type
				end
				if C.enHacks.Basic_DisableTouchTransmitters=="Humanoids" and Type=="Humanoid" then
					return true, Type
				elseif C.enHacks.Basic_DisableTouchTransmitters=="Parts" and Type=="Part" then
					return true, Type
				elseif C.enHacks.Basic_DisableTouchTransmitters==true then
					return true, Type
				elseif not C.enHacks.Basic_DisableTouchTransmitters then
					return false, Type
				end
			end,
			["UndoTransmitter"]=function(index)
				local data = C.AvailableHacks.Basic[25].TouchTransmitters[index]
				local object, parent, Type, TouchToggle = table.unpack(data or {})
				if parent and parent.Parent and not C.AvailableHacks.Basic[25].CanBeEnabled(object,Type) then
						--[[if typeof(parent)=="table" then
							for num, connection in ipairs(parent) do
								if connection.Function then
									connection:Enable()
								else
									warn("Function Not Found! May not work!")
								end
							end
						else--]]
					parent.CanTouch = true--object.Parent = parent
					if TouchToggle then
						TouchToggle:Destroy()
					end
					parent:RemoveTag("TouchDisabled")
					C.AvailableHacks.Basic[25].TouchTransmitters[index]=nil
					C.AvailableHacks.Basic[25].GlobalTouchTransmitters[parent] = nil
					--table.remove(C.AvailableHacks.Basic[25].TouchTransmitters,index)
					--end
				end
			end,
			["UndoTransmitters"]=function(saveEn)
				for index = #C.AvailableHacks.Basic[25].TouchTransmitters,1,-1 do --for parent, object in pairs(C.AvailableHacks.Basic[25].TouchTransmitters) do
					if saveEn ~= C.enHacks.Basic_DisableTouchTransmitters and not C.isCleared then
						return
					end
					C.AvailableHacks.Basic[25].UndoTransmitter(index)
					if index%15==0 then
						RunS.RenderStepped:Wait()
					end
				end
			end,
			["ApplyTransmitters"]=function(instance)
				if instance:IsA("TouchTransmitter") and instance.Parent and instance.Parent.Parent then
					local parent = instance.Parent
					local canBeEn, Type = C.AvailableHacks.Basic[25].CanBeEnabled(instance)
					if canBeEn and not parent:HasTag("TouchDisabled") then
							--[[local touchList = C.GetHardValue(instance.Parent,"Touched",{yield=true})
							local didDisable = false
							if #touchList>0 then
								for num, connection in ipairs(touchList) do
									if connection.Function then
										connection:Disable()
										if not didDisable then
											table.insert(C.AvailableHacks.Basic[25].TouchTransmitters,{instance,touchList,Type})
											didDisable = true
										end
									else
										warn("Function Not Found! May not work!")
									end
								end
							end
							if #touchList==0 or not didDisable then--]]
						local TouchToggle=C.ToggleTag:Clone()
						local insertTbl = {instance,parent,Type,TouchToggle,{}}
						table.insert(C.AvailableHacks.Basic[25].TouchTransmitters,insertTbl)

						TouchToggle.Name = "TouchToggle"
						TouchToggle.Parent=GuiElements.HackGUI
						TouchToggle.Adornee=parent
						TouchToggle.ExtentsOffsetWorldSpace = Vector3.new(0, 0, 0)
						TouchToggle.Enabled = true
						CS:AddTag(TouchToggle,"RemoveOnDestroy")
						CS:AddTag(parent,"TouchDisabled")

						if Type=="Part" then
							if parent.CanCollide then
								TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 238)
							else
								TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 255)
							end
							TouchToggle.Toggle.Text = "Activate"
						else
							TouchToggle.Toggle.Text = "Enable"
							TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(0,170)
						end
						local saveCollide = parent.CanCollide or parent.Parent.Name=="FadingTiles"
						local function clickfunction()
							if Type=="Part" then
								local HRP = C.char and C.char:FindFirstChild("HumanoidRootPart")
								if not HRP then
									return
								end

								local toTouch

								if TouchToggle.Toggle.Text == "Activate" then
									TouchToggle.Toggle.Text = "DeActivate"
									TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(255,0,80)
									toTouch = 0
								else
									TouchToggle.Toggle.Text = "Activate"
									if saveCollide then
										TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 238)
									else
										TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 255)
									end
									toTouch = 1
								end


								parent.CanTouch = true
								RunS.RenderStepped:Wait()
								--warn("RUNNING",parent,toTouch)
								firetouchinterest(parent,HRP, toTouch)
								RunS.RenderStepped:Wait()
								task.wait(.5)

								if TouchToggle.Parent then
									parent.CanTouch = false
								end

								--[[firetouchinterest(parent,HRP, 1)
								task.wait(1)
								if TouchToggle.Parent then
									parent.CanTouch = false
								end--]]
							else
								if parent.CanTouch then
									TouchToggle.Toggle.Text = "Enable"
									TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(0,170)
								else
									TouchToggle.Toggle.Text = "Disable"
									TouchToggle.Toggle.BackgroundColor3 = Color3.fromRGB(170)
								end
								parent.CanTouch = not parent.CanTouch
							end
						end
						table.insert(insertTbl[5],TouchToggle.Toggle.MouseButton1Up:Connect(clickfunction))
						C.AvailableHacks.Basic[25].GlobalTouchTransmitters[parent] = clickfunction
						if Type=="Part" then
							--task.delay(Random.new():NextNumber(3,20),clickfunction)
						end
						--firetouchinterest(parent,HRP, toTouch)
						table.insert(insertTbl[5],parent.AncestryChanged:Connect(function(child,newParent)
							if not newParent then
								task.wait(1)
								local Key = table.find(C.AvailableHacks.Basic[25].TouchTransmitters,insertTbl)
								if Key then
									C.AvailableHacks.Basic[25].UndoTransmitter(Key)
								end
							else
								TouchToggle.Adornee=workspace:IsAncestorOf(child) and parent or nil
							end
						end))
						C.objectFuncts[parent]={Destroying = {parent.Destroying:Connect(function()
							DS:AddItem(TouchToggle,1)--Delay it so that 1) no crashes and 2) no lag!
						end)}}
						parent.CanTouch = false
						--instance:Destroy()
						--end
					end
				end

				local saveEn = C.enHacks.Basic_DisableTouchTransmitters
				for num, location in ipairs(instance:GetChildren()) do
					if saveEn ~= C.enHacks.Basic_DisableTouchTransmitters then
						return
					end
					C.AvailableHacks.Basic[25].ApplyTransmitters(location)
					if num%150==0 then
						RunS.RenderStepped:Wait()
					end
				end
			end,
			["Funct"]=nil,
			["ActivateFunction"]=function(newValue)
				if C.AvailableHacks.Basic[25].Funct then
					C.AvailableHacks.Basic[25].Funct:Disconnect()
					C.AvailableHacks.Basic[25].Funct = nil
				end
				C.AvailableHacks.Basic[25].UndoTransmitters(newValue)
				if newValue then
					C.AvailableHacks.Basic[25].Funct = workspace.DescendantAdded:Connect(C.AvailableHacks.Basic[25].ApplyTransmitters)
					C.AvailableHacks.Basic[25].ApplyTransmitters(workspace)
				end
			end,
			["MyStartUp"]=function(theirPlr,theirChar,firstRun)
				local theirHRP = theirChar:WaitForChild("HumanoidRootPart",30)-- wait for it to be loaded!
				if not theirHRP then
					return
				end
				task.wait(.5)
				if firstRun then
					task.wait(5)
					C.AvailableHacks.Basic[25].ActivateFunction(C.enHacks.Basic_DisableTouchTransmitters)
				else
					--C.AvailableHacks.Basic[25].ApplyTransmitters(theirChar)
				end
			end,
		},
		[27]=(C.gameUniverse ~= "Flee" and ({
			["Type"] = "ExTextButton",
			["Title"] = ("Anti Kick"),
			["Desc"] = ("Works in most cases"),
			["Shortcut"] = "Basic_AntiKick",
			["Universes"]={"Global"},
			["Default"]=true,
			["ActivateFunction"]=(function(newValue)
				local taskwait = task.wait
				local waitForChild = workspace.WaitForChild
				local destroy = workspace.Destroy
				local debrisAdditem = DS.AddItem
				local traceback = debug.traceback
				local info = debug.info
				local getfen = getfenv
				C.Hook(game,"__namecall","kick",newValue and (function()
					if C.gameUniverse == "Tower" then
						error("Purposeful Error!")
					end
					local RunScript = getcallingscript()

					print(traceback((`22The script has successfully intercepted an attempted kick from: {RunScript:GetFullName()} {RunScript.Parent or "nilpar"} and Disabled={RunScript.Disabled}`)))
					print(getfen())
					if C.gameUniverse == "FlagWars" then
						if RunScript.Name=="BAC_" then
							C.BAC = RunScript
							if C.BAC ~= RunScript then
								print("new BAC!!",RunScript.ClassName)
								print("BAC INFO",info())
							end
							--RunScript.Enabled = false
							--RunScript.Parent = workspace
							--debrisAdditem(DS,RunScript,0)
							--destroy(RunScript)
							--print("Parented!")
						end
						--error(`22The script has successfully intercepted an attempted kick from: {RunScript:GetFullName()} {RunScript.Parent or "nilpar"}`)
						--taskwait(69)
						--else

					end
					return true, nil
				end))
			end),
		}) or nil),

		[30]={
			["Type"]="ExTextButton",
			["Title"]="Invisible Character",
			["Desc"]="Warning: Not Everything Replicates. Do Not Leave This On For Too Long!",
			["Shortcut"]="Basic_InvisibleChar",
			["Default"]=false,
			["DontActivate"]=true,
			["Active"] = false,
			["Universes"]={"Global"},
			["Options"]={
				[false]={
					["Title"]="DISABLED",
					["TextColor"]=newColor3(255, 0, 0),
				},
				["Partial"]={
					["Title"]="PARTIAL",
					["TextColor"]=newColor3(170,170,170),
				},
				[true]={
					["Title"]="ALL",
					["TextColor"]=newColor3(255, 255, 255),
				},
			},
			["Functs"]={},
			["Deb"]=0.5,
			["HiddenLocation"] = Vector3.new(0,-20,0),
			["LastTeleportLocation"] = CFrame.new(),
			["ApplyChange"] = function(newHuman,oldHuman)
				local clonedChar, currentChar = newHuman.Parent, oldHuman.Parent
				--newHuman:ChangeState(oldHuman:GetState())
				oldHuman:ChangeState(Enum.HumanoidStateType.Physics)
				newHuman:ChangeState(Enum.HumanoidStateType.Running)
				local clonedHRP, currentHRP = clonedChar:FindFirstChild("HumanoidRootPart"), currentChar:FindFirstChild("HumanoidRootPart")
				if clonedHRP and currentHRP then
					clonedHRP.AssemblyLinearVelocity = currentHRP.AssemblyLinearVelocity
					clonedHRP.AssemblyAngularVelocity = currentHRP.AssemblyAngularVelocity
				end
				if clonedHRP then
					clonedHRP.AssemblyLinearVelocity = Vector3.new()
					clonedHRP.AssemblyAngularVelocity = Vector3.new()
				end
				if currentHRP then
					currentHRP.AssemblyLinearVelocity = Vector3.new()
					currentHRP.AssemblyAngularVelocity = Vector3.new()
				end

				local saveMovement = C.enHacks.Movement
				C.refreshEnHack["Movement"](false)
				--C.refreshEnHack["Movement"](saveMovement)
			end,
			["ReplicateProperties"]={
				{"Humanoid","HipHeight"},
				{"Humanoid","WalkSpeed"},
				{"Humanoid","JumpPower"}
			},
			["RunFunction"]=function(connections)
				local doAnimate = {
					[Enum.HumanoidRigType.R6] = function(Figure,connections2Add)
						-- humanoidAnimatePlayEmote.lua

						local Torso = Figure:WaitForChild("Torso")
						local RightShoulder = Torso:WaitForChild("Right Shoulder")
						local LeftShoulder = Torso:WaitForChild("Left Shoulder")
						local RightHip = Torso:WaitForChild("Right Hip")
						local LeftHip = Torso:WaitForChild("Left Hip")
						local Neck = Torso:WaitForChild("Neck")
						local Humanoid = Figure:WaitForChild("Humanoid")
						local pose = "Standing"

						local EMOTE_TRANSITION_TIME = 0.1

						local userAnimateScaleRunSuccess, userAnimateScaleRunValue = pcall(function() return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun") end)
						local userAnimateScaleRun = userAnimateScaleRunSuccess and userAnimateScaleRunValue

						local function getRigScale()
							if userAnimateScaleRun then
								return Figure:GetScale()
							else
								return 1
							end
						end

						local currentAnim = ""
						local currentAnimInstance = nil
						local currentAnimTrack = nil
						local currentAnimKeyframeHandler = nil
						local currentAnimSpeed = 1.0
						local animTable = {}
						local animNames = { 
							idle = 	{	
								{ id = "http://www.roblox.com/asset/?id=180435571", weight = 9 },
								{ id = "http://www.roblox.com/asset/?id=180435792", weight = 1 }
							},
							walk = 	{ 	
								{ id = "http://www.roblox.com/asset/?id=180426354", weight = 10 } 
							}, 
							run = 	{
								{ id = "run.xml", weight = 10 } 
							}, 
							jump = 	{
								{ id = "http://www.roblox.com/asset/?id=125750702", weight = 10 } 
							}, 
							fall = 	{
								{ id = "http://www.roblox.com/asset/?id=180436148", weight = 10 } 
							}, 
							climb = {
								{ id = "http://www.roblox.com/asset/?id=180436334", weight = 10 } 
							}, 
							sit = 	{
								{ id = "http://www.roblox.com/asset/?id=178130996", weight = 10 } 
							},	
							toolnone = {
								{ id = "http://www.roblox.com/asset/?id=182393478", weight = 10 } 
							},
							toolslash = {
								{ id = "http://www.roblox.com/asset/?id=129967390", weight = 10 } 
								--				{ id = "slash.xml", weight = 10 } 
							},
							toollunge = {
								{ id = "http://www.roblox.com/asset/?id=129967478", weight = 10 } 
							},
							wave = {
								{ id = "http://www.roblox.com/asset/?id=128777973", weight = 10 } 
							},
							point = {
								{ id = "http://www.roblox.com/asset/?id=128853357", weight = 10 } 
							},
							dance1 = {
								{ id = "http://www.roblox.com/asset/?id=182435998", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=182491037", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=182491065", weight = 10 } 
							},
							dance2 = {
								{ id = "http://www.roblox.com/asset/?id=182436842", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=182491248", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=182491277", weight = 10 } 
							},
							dance3 = {
								{ id = "http://www.roblox.com/asset/?id=182436935", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=182491368", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=182491423", weight = 10 } 
							},
							laugh = {
								{ id = "http://www.roblox.com/asset/?id=129423131", weight = 10 } 
							},
							cheer = {
								{ id = "http://www.roblox.com/asset/?id=129423030", weight = 10 } 
							},
						}
						local dances = {"dance1", "dance2", "dance3"}

						-- Existance in this list signifies that it is an emote, the value indicates if it is a looping emote
						local emoteNames = { wave = false, point = false, dance1 = true, dance2 = true, dance3 = true, laugh = false, cheer = false}

						local function configureAnimationSet(name, fileList)
							if (animTable[name] ~= nil) then
								for _, connection in pairs(animTable[name].connections) do
									connection:disconnect()
								end
							end
							animTable[name] = {}
							animTable[name].count = 0
							animTable[name].totalWeight = 0	
							animTable[name].connections = {}

							-- check for config values
							local config = script:FindFirstChild(name)
							if (config ~= nil) then
								--		print("Loading anims " .. name)
								table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
								table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))
								local idx = 1
								for _, childPart in pairs(config:GetChildren()) do
									if (childPart:IsA("Animation")) then
										table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
										animTable[name][idx] = {}
										animTable[name][idx].anim = childPart
										local weightObject = childPart:FindFirstChild("Weight")
										if (weightObject == nil) then
											animTable[name][idx].weight = 1
										else
											animTable[name][idx].weight = weightObject.Value
										end
										animTable[name].count = animTable[name].count + 1
										animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
										--			print(name .. " [" .. idx .. "] " .. animTable[name][idx].anim.AnimationId .. " (" .. animTable[name][idx].weight .. ")")
										idx = idx + 1
									end
								end
							end

							-- fallback to defaults
							if (animTable[name].count <= 0) then
								for idx, anim in pairs(fileList) do
									animTable[name][idx] = {}
									animTable[name][idx].anim = Instance.new("Animation")
									animTable[name][idx].anim.Name = name
									animTable[name][idx].anim.AnimationId = anim.id
									animTable[name][idx].weight = anim.weight
									animTable[name].count = animTable[name].count + 1
									animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
									--			print(name .. " [" .. idx .. "] " .. anim.id .. " (" .. anim.weight .. ")")
								end
							end
						end

						-- Setup animation objects
						local function scriptChildModified(child)
							local fileList = animNames[child.Name]
							if (fileList ~= nil) then
								configureAnimationSet(child.Name, fileList)
							end	
						end

						script.ChildAdded:connect(scriptChildModified)
						script.ChildRemoved:connect(scriptChildModified)

						-- Clear any existing animation tracks
						-- Fixes issue with characters that are moved in and out of the Workspace accumulating tracks
						local animator = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil
						if animator then
							local animTracks = animator:GetPlayingAnimationTracks()
							for i,track in ipairs(animTracks) do
								track:Stop(0)
								track:Destroy()
							end
						end


						for name, fileList in pairs(animNames) do 
							configureAnimationSet(name, fileList)
						end	

						-- ANIMATION

						-- declarations
						local toolAnim = "None"
						local toolAnimTime = 0

						local jumpAnimTime = 0
						local jumpAnimDuration = 0.3

						local toolTransitionTime = 0.1
						local fallTransitionTime = 0.3
						local jumpMaxLimbVelocity = 0.75

						-- functions

						local function stopAllAnimations()
							local oldAnim = currentAnim

							-- return to idle if finishing an emote
							if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
								oldAnim = "idle"
							end

							currentAnim = ""
							currentAnimInstance = nil
							if (currentAnimKeyframeHandler ~= nil) then
								currentAnimKeyframeHandler:disconnect()
							end

							if (currentAnimTrack ~= nil) then
								currentAnimTrack:Stop()
								currentAnimTrack:Destroy()
								currentAnimTrack = nil
							end
							return oldAnim
						end

						local function setAnimationSpeed(speed)
							if speed ~= currentAnimSpeed then
								currentAnimSpeed = speed
								currentAnimTrack:AdjustSpeed(currentAnimSpeed)
							end
						end

						local playAnimation

						local function keyFrameReachedFunc(frameName)
							if (frameName == "End") then

								local repeatAnim = currentAnim
								-- return to idle if finishing an emote
								if (emoteNames[repeatAnim] ~= nil and emoteNames[repeatAnim] == false) then
									repeatAnim = "idle"
								end

								local animSpeed = currentAnimSpeed
								playAnimation(repeatAnim, 0.0, Humanoid)
								setAnimationSpeed(animSpeed)
							end
						end

						-- Preload animations
						function playAnimation(animName, transitionTime, humanoid) 

							local roll = math.random(1, animTable[animName].totalWeight) 
							local origRoll = roll
							local idx = 1
							while (roll > animTable[animName][idx].weight) do
								roll = roll - animTable[animName][idx].weight
								idx = idx + 1
							end
							--		print(animName .. " " .. idx .. " [" .. origRoll .. "]")
							local anim = animTable[animName][idx].anim

							-- switch animation		
							if (anim ~= currentAnimInstance) and humanoid.Parent then

								if (currentAnimTrack ~= nil) then
									currentAnimTrack:Stop(transitionTime)
									currentAnimTrack:Destroy()
								end

								currentAnimSpeed = 1.0

								-- load it to the humanoid; get AnimationTrack
								currentAnimTrack = humanoid:LoadAnimation(anim)
								currentAnimTrack.Priority = Enum.AnimationPriority.Core

								-- play the animation
								currentAnimTrack:Play(transitionTime)
								currentAnim = animName
								currentAnimInstance = anim

								-- set up keyframe name triggers
								if (currentAnimKeyframeHandler ~= nil) then
									currentAnimKeyframeHandler:disconnect()
								end
								currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)

							end

						end

						-------------------------------------------------------------------------------------------
						-------------------------------------------------------------------------------------------

						local toolAnimName = ""
						local toolAnimTrack = nil
						local toolAnimInstance = nil
						local currentToolAnimKeyframeHandler = nil
						local playToolAnimation = nil

						local function toolKeyFrameReachedFunc(frameName)
							if (frameName == "End") then
								--		print("Keyframe : ".. frameName)	
								playToolAnimation(toolAnimName, 0.0, Humanoid)
							end
						end


						function playToolAnimation(animName, transitionTime, humanoid, priority)	 

							local roll = math.random(1, animTable[animName].totalWeight) 
							local origRoll = roll
							local idx = 1
							while (roll > animTable[animName][idx].weight) do
								roll = roll - animTable[animName][idx].weight
								idx = idx + 1
							end
							--		print(animName .. " * " .. idx .. " [" .. origRoll .. "]")
							local anim = animTable[animName][idx].anim

							if (toolAnimInstance ~= anim) then

								if (toolAnimTrack ~= nil) then
									toolAnimTrack:Stop()
									toolAnimTrack:Destroy()
									transitionTime = 0
								end

								-- load it to the humanoid; get AnimationTrack
								toolAnimTrack = humanoid:LoadAnimation(anim)
								if priority then
									toolAnimTrack.Priority = priority
								end

								-- play the animation
								toolAnimTrack:Play(transitionTime)
								toolAnimName = animName
								toolAnimInstance = anim

								currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
							end
						end

						local function stopToolAnimations()
							local oldAnim = toolAnimName

							if (currentToolAnimKeyframeHandler ~= nil) then
								currentToolAnimKeyframeHandler:disconnect()
							end

							toolAnimName = ""
							toolAnimInstance = nil
							if (toolAnimTrack ~= nil) then
								toolAnimTrack:Stop()
								toolAnimTrack:Destroy()
								toolAnimTrack = nil
							end


							return oldAnim
						end

						-------------------------------------------------------------------------------------------
						-------------------------------------------------------------------------------------------


						local function onRunning(speed)
							speed /= getRigScale()

							if speed > 0.01 then
								playAnimation("walk", 0.1, Humanoid)
								if currentAnimInstance and currentAnimInstance.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
									setAnimationSpeed(speed / 14.5)
								end
								pose = "Running"
							else
								if emoteNames[currentAnim] == nil then
									playAnimation("idle", 0.1, Humanoid)
									pose = "Standing"
								end
							end
						end

						local function onDied()
							pose = "Dead"
						end

						local function onJumping()
							playAnimation("jump", 0.1, Humanoid)
							jumpAnimTime = jumpAnimDuration
							pose = "Jumping"
						end

						local function onClimbing(speed)
							speed /= getRigScale()

							playAnimation("climb", 0.1, Humanoid)
							setAnimationSpeed(speed / 12.0)
							pose = "Climbing"
						end

						local function onGettingUp()
							pose = "GettingUp"
						end

						local function onFreeFall()
							if (jumpAnimTime <= 0) then
								playAnimation("fall", fallTransitionTime, Humanoid)
							end
							pose = "FreeFall"
						end

						local function onFallingDown()
							pose = "FallingDown"
						end

						local function onSeated()
							pose = "Seated"
						end

						local function onPlatformStanding()
							pose = "PlatformStanding"
						end

						local function onSwimming(speed)
							if speed > 0 then
								pose = "Running"
							else
								pose = "Standing"
							end
						end

						local function getTool()	
							for _, kid in ipairs(Figure:GetChildren()) do
								if kid.className == "Tool" then return kid end
							end
							return nil
						end

						local function getToolAnim(tool)
							for _, c in ipairs(tool:GetChildren()) do
								if c.Name == "toolanim" and c.className == "StringValue" then
									return c
								end
							end
							return nil
						end

						local function animateTool()

							if (toolAnim == "None") then
								playToolAnimation("toolnone", toolTransitionTime, Humanoid, Enum.AnimationPriority.Idle)
								return
							end

							if (toolAnim == "Slash") then
								playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
								return
							end

							if (toolAnim == "Lunge") then
								playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
								return
							end
						end

						local function moveSit()
							RightShoulder.MaxVelocity = 0.15
							LeftShoulder.MaxVelocity = 0.15
							RightShoulder:SetDesiredAngle(3.14 /2)
							LeftShoulder:SetDesiredAngle(-3.14 /2)
							RightHip:SetDesiredAngle(3.14 /2)
							LeftHip:SetDesiredAngle(-3.14 /2)
						end

						local lastTick = 0

						local function move(time)
							local amplitude = 1
							local frequency = 1
							local deltaTime = time - lastTick
							lastTick = time

							local climbFudge = 0
							local setAngles = false

							if (jumpAnimTime > 0) then
								jumpAnimTime = jumpAnimTime - deltaTime
							end

							if (pose == "FreeFall" and jumpAnimTime <= 0) then
								playAnimation("fall", fallTransitionTime, Humanoid)
							elseif (pose == "Seated") then
								playAnimation("sit", 0.5, Humanoid)
								return
							elseif (pose == "Running") then
								playAnimation("walk", 0.1, Humanoid)
							elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
								--		print("Wha " .. pose)
								stopAllAnimations()
								amplitude = 0.1
								frequency = 1
								setAngles = true
							end

							if (setAngles) then
								local desiredAngle = amplitude * math.sin(time * frequency)

								RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
								LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
								RightHip:SetDesiredAngle(-desiredAngle)
								LeftHip:SetDesiredAngle(-desiredAngle)
							end

							-- Tool Animation handling
							local tool = getTool()
							if tool and tool:FindFirstChild("Handle") then

								local animStringValueObject = getToolAnim(tool)

								if animStringValueObject then
									toolAnim = animStringValueObject.Value
									-- message recieved, delete StringValue
									animStringValueObject.Parent = nil
									toolAnimTime = time + .3
								end

								if time > toolAnimTime then
									toolAnimTime = 0
									toolAnim = "None"
								end

								animateTool()		
							else
								stopToolAnimations()
								toolAnim = "None"
								toolAnimInstance = nil
								toolAnimTime = 0
							end
						end

						-- connect events
						Humanoid.Died:connect(onDied)
						Humanoid.Running:connect(onRunning)
						Humanoid.Jumping:connect(onJumping)
						Humanoid.Climbing:connect(onClimbing)
						Humanoid.GettingUp:connect(onGettingUp)
						Humanoid.FreeFalling:connect(onFreeFall)
						Humanoid.FallingDown:connect(onFallingDown)
						Humanoid.Seated:connect(onSeated)
						Humanoid.PlatformStanding:connect(onPlatformStanding)
						Humanoid.Swimming:connect(onSwimming)

						---- setup emote chat hooktable.insert(connections,
						table.insert(connections,game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
							local emote = ""
							if msg == "/e dance" then
								emote = dances[math.random(1, #dances)]
							elseif (string.sub(msg, 1, 3) == "/e ") then
								emote = string.sub(msg, 4)
							elseif (string.sub(msg, 1, 7) == "/emote ") then
								emote = string.sub(msg, 8)
							end

							if (pose == "Standing" and emoteNames[emote] ~= nil) then
								playAnimation(emote, 0.1, Humanoid)
							end

						end))

						-- main program

						-- initialize to idle
						playAnimation("idle", 0.1, Humanoid)
						pose = "Standing"

						while Figure.Parent ~= nil do
							local _, time = wait(0.1)
							move(time)
						end
					end,
					[Enum.HumanoidRigType.R15]=function(Character, connections2Add)
						-- humanoidAnimateR15Moods.lua

						local Humanoid = Character:WaitForChild("Humanoid")
						local pose = "Standing"

						local userNoUpdateOnLoopSuccess, userNoUpdateOnLoopValue = pcall(function() return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop") end)
						local userNoUpdateOnLoop = userNoUpdateOnLoopSuccess and userNoUpdateOnLoopValue

						local userAnimateScaleRunSuccess, userAnimateScaleRunValue = pcall(function() return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun") end)
						local userAnimateScaleRun = userAnimateScaleRunSuccess and userAnimateScaleRunValue

						local function getRigScale()
							if userAnimateScaleRun then
								return Character:GetScale()
							else
								return 1
							end
						end

						local AnimationSpeedDampeningObject = script:FindFirstChild("ScaleDampeningPercent")
						local HumanoidHipHeight = 2

						local EMOTE_TRANSITION_TIME = 0.1

						local currentAnim = ""
						local currentAnimInstance = nil
						local currentAnimTrack = nil
						local currentAnimKeyframeHandler = nil
						local currentAnimSpeed = 1.0

						local runAnimTrack = nil
						local runAnimKeyframeHandler = nil

						local PreloadedAnims = {}

						local animTable = {}
						local animNames = { 
							idle = 	{	
								{ id = "http://www.roblox.com/asset/?id=507766666", weight = 1 },
								{ id = "http://www.roblox.com/asset/?id=507766951", weight = 1 },
								{ id = "http://www.roblox.com/asset/?id=507766388", weight = 9 }
							},
							walk = 	{ 	
								{ id = "http://www.roblox.com/asset/?id=507777826", weight = 10 } 
							}, 
							run = 	{
								{ id = "http://www.roblox.com/asset/?id=507767714", weight = 10 } 
							}, 
							swim = 	{
								{ id = "http://www.roblox.com/asset/?id=507784897", weight = 10 } 
							}, 
							swimidle = 	{
								{ id = "http://www.roblox.com/asset/?id=507785072", weight = 10 } 
							}, 
							jump = 	{
								{ id = "http://www.roblox.com/asset/?id=507765000", weight = 10 } 
							}, 
							fall = 	{
								{ id = "http://www.roblox.com/asset/?id=507767968", weight = 10 } 
							}, 
							climb = {
								{ id = "http://www.roblox.com/asset/?id=507765644", weight = 10 } 
							}, 
							sit = 	{
								{ id = "http://www.roblox.com/asset/?id=2506281703", weight = 10 } 
							},	
							toolnone = {
								{ id = "http://www.roblox.com/asset/?id=507768375", weight = 10 } 
							},
							toolslash = {
								{ id = "http://www.roblox.com/asset/?id=522635514", weight = 10 } 
							},
							toollunge = {
								{ id = "http://www.roblox.com/asset/?id=522638767", weight = 10 } 
							},
							wave = {
								{ id = "http://www.roblox.com/asset/?id=507770239", weight = 10 } 
							},
							point = {
								{ id = "http://www.roblox.com/asset/?id=507770453", weight = 10 } 
							},
							dance = {
								{ id = "http://www.roblox.com/asset/?id=507771019", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=507771955", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=507772104", weight = 10 } 
							},
							dance2 = {
								{ id = "http://www.roblox.com/asset/?id=507776043", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=507776720", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=507776879", weight = 10 } 
							},
							dance3 = {
								{ id = "http://www.roblox.com/asset/?id=507777268", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=507777451", weight = 10 }, 
								{ id = "http://www.roblox.com/asset/?id=507777623", weight = 10 } 
							},
							laugh = {
								{ id = "http://www.roblox.com/asset/?id=507770818", weight = 10 } 
							},
							cheer = {
								{ id = "http://www.roblox.com/asset/?id=507770677", weight = 10 } 
							},
						}

						-- Existance in this list signifies that it is an emote, the value indicates if it is a looping emote
						local emoteNames = { wave = false, point = false, dance = true, dance2 = true, dance3 = true, laugh = false, cheer = false}

						math.randomseed(tick())

						local function findExistingAnimationInSet(set, anim)
							if set == nil or anim == nil then
								return 0
							end

							for idx = 1, set.count, 1 do 
								if set[idx].anim.AnimationId == anim.AnimationId then
									return idx
								end
							end

							return 0
						end

						local function configureAnimationSet(name, fileList)
							if (animTable[name] ~= nil) then
								for _, connection in pairs(animTable[name].connections) do
									connection:disconnect()
								end
							end
							animTable[name] = {}
							animTable[name].count = 0
							animTable[name].totalWeight = 0	
							animTable[name].connections = {}

							local allowCustomAnimations = true

							local success, msg = pcall(function() allowCustomAnimations = game:GetService("StarterPlayer").AllowCustomAnimations end)
							if not success then
								allowCustomAnimations = true
							end

							-- check for config values
							local config = script:FindFirstChild(name)
							if (allowCustomAnimations and config ~= nil) then
								table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
								table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))

								local idx = 0
								for _, childPart in pairs(config:GetChildren()) do
									if (childPart:IsA("Animation")) then
										local newWeight = 1
										local weightObject = childPart:FindFirstChild("Weight")
										if (weightObject ~= nil) then
											newWeight = weightObject.Value
										end
										animTable[name].count = animTable[name].count + 1
										idx = animTable[name].count
										animTable[name][idx] = {}
										animTable[name][idx].anim = childPart
										animTable[name][idx].weight = newWeight
										animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
										table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
										table.insert(animTable[name].connections, childPart.ChildAdded:connect(function(property) configureAnimationSet(name, fileList) end))
										table.insert(animTable[name].connections, childPart.ChildRemoved:connect(function(property) configureAnimationSet(name, fileList) end))
									end
								end
							end

							-- fallback to defaults
							if (animTable[name].count <= 0) then
								for idx, anim in pairs(fileList) do
									animTable[name][idx] = {}
									animTable[name][idx].anim = Instance.new("Animation")
									animTable[name][idx].anim.Name = name
									animTable[name][idx].anim.AnimationId = anim.id
									animTable[name][idx].weight = anim.weight
									animTable[name].count = animTable[name].count + 1
									animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
								end
							end

							-- preload anims
							for i, animType in pairs(animTable) do
								for idx = 1, animType.count, 1 do
									if PreloadedAnims[animType[idx].anim.AnimationId] == nil then
										Humanoid:LoadAnimation(animType[idx].anim)
										PreloadedAnims[animType[idx].anim.AnimationId] = true
									end				
								end
							end
						end

						------------------------------------------------------------------------------------------------------------

						local function configureAnimationSetOld(name, fileList)
							if (animTable[name] ~= nil) then
								for _, connection in pairs(animTable[name].connections) do
									connection:disconnect()
								end
							end
							animTable[name] = {}
							animTable[name].count = 0
							animTable[name].totalWeight = 0	
							animTable[name].connections = {}

							local allowCustomAnimations = true

							local success, msg = pcall(function() allowCustomAnimations = game:GetService("StarterPlayer").AllowCustomAnimations end)
							if not success then
								allowCustomAnimations = true
							end

							-- check for config values
							local config = script:FindFirstChild(name)
							if (allowCustomAnimations and config ~= nil) then
								table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
								table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))
								local idx = 1
								for _, childPart in pairs(config:GetChildren()) do
									if (childPart:IsA("Animation")) then
										table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
										animTable[name][idx] = {}
										animTable[name][idx].anim = childPart
										local weightObject = childPart:FindFirstChild("Weight")
										if (weightObject == nil) then
											animTable[name][idx].weight = 1
										else
											animTable[name][idx].weight = weightObject.Value
										end
										animTable[name].count = animTable[name].count + 1
										animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
										idx = idx + 1
									end
								end
							end

							-- fallback to defaults
							if (animTable[name].count <= 0) then
								for idx, anim in pairs(fileList) do
									animTable[name][idx] = {}
									animTable[name][idx].anim = Instance.new("Animation")
									animTable[name][idx].anim.Name = name
									animTable[name][idx].anim.AnimationId = anim.id
									animTable[name][idx].weight = anim.weight
									animTable[name].count = animTable[name].count + 1
									animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
									-- print(name .. " [" .. idx .. "] " .. anim.id .. " (" .. anim.weight .. ")")
								end
							end

							-- preload anims
							for i, animType in pairs(animTable) do
								for idx = 1, animType.count, 1 do 
									Humanoid:LoadAnimation(animType[idx].anim)
								end
							end
						end

						-- Setup animation objects
						local function scriptChildModified(child)
							local fileList = animNames[child.Name]
							if (fileList ~= nil) then
								configureAnimationSet(child.Name, fileList)
							end	
						end

						script.ChildAdded:connect(scriptChildModified)
						script.ChildRemoved:connect(scriptChildModified)

						-- Clear any existing animation tracks
						-- Fixes issue with characters that are moved in and out of the Workspace accumulating tracks
						local animator = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil
						if animator then
							local animTracks = animator:GetPlayingAnimationTracks()
							for i,track in ipairs(animTracks) do
								track:Stop(0)
								track:Destroy()
							end
						end

						for name, fileList in pairs(animNames) do 
							configureAnimationSet(name, fileList)
						end	

						-- ANIMATION

						-- declarations
						local toolAnim = "None"
						local toolAnimTime = 0

						local jumpAnimTime = 0
						local jumpAnimDuration = 0.31

						local toolTransitionTime = 0.1
						local fallTransitionTime = 0.2

						local currentlyPlayingEmote = false

						-- functions

						local function stopAllAnimations()
							local oldAnim = currentAnim

							-- return to idle if finishing an emote
							if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
								oldAnim = "idle"
							end

							if currentlyPlayingEmote then
								oldAnim = "idle"
								currentlyPlayingEmote = false
							end

							currentAnim = ""
							currentAnimInstance = nil
							if (currentAnimKeyframeHandler ~= nil) then
								currentAnimKeyframeHandler:disconnect()
							end

							if (currentAnimTrack ~= nil) then
								currentAnimTrack:Stop()
								currentAnimTrack:Destroy()
								currentAnimTrack = nil
							end

							-- clean up walk if there is one
							if (runAnimKeyframeHandler ~= nil) then
								runAnimKeyframeHandler:disconnect()
							end

							if (runAnimTrack ~= nil) then
								runAnimTrack:Stop()
								runAnimTrack:Destroy()
								runAnimTrack = nil
							end

							return oldAnim
						end

						local function getHeightScale()
							if Humanoid then
								if not Humanoid.AutomaticScalingEnabled then
									-- When auto scaling is not enabled, the rig scale stands in for
									-- a computed scale.
									return getRigScale()
								end

								local scale = Humanoid.HipHeight / HumanoidHipHeight
								if AnimationSpeedDampeningObject == nil then
									AnimationSpeedDampeningObject = script:FindFirstChild("ScaleDampeningPercent")
								end
								if AnimationSpeedDampeningObject ~= nil then
									scale = 1 + (Humanoid.HipHeight - HumanoidHipHeight) * AnimationSpeedDampeningObject.Value / HumanoidHipHeight
								end
								return scale
							end	
							return getRigScale()
						end

						local function rootMotionCompensation(speed)
							local speedScaled = speed * 1.25
							local heightScale = getHeightScale()
							local runSpeed = speedScaled / heightScale
							return runSpeed
						end

						local smallButNotZero = 0.0001
						local function setRunSpeed(speed)
							local normalizedWalkSpeed = 0.5 -- established empirically using current `913402848` walk animation
							local normalizedRunSpeed  = 1
							local runSpeed = rootMotionCompensation(speed)

							local walkAnimationWeight = smallButNotZero
							local runAnimationWeight = smallButNotZero
							local walkAnimationTimewarp = runSpeed/normalizedWalkSpeed
							local runAnimationTimerwarp = runSpeed/normalizedRunSpeed

							if runSpeed <= normalizedWalkSpeed then
								walkAnimationWeight = 1
							elseif runSpeed < normalizedRunSpeed then
								local fadeInRun = (runSpeed - normalizedWalkSpeed)/(normalizedRunSpeed - normalizedWalkSpeed)
								walkAnimationWeight = 1 - fadeInRun
								runAnimationWeight  = fadeInRun
								walkAnimationTimewarp = 1
								runAnimationTimerwarp = 1
							else
								runAnimationWeight = 1
							end
							currentAnimTrack:AdjustWeight(walkAnimationWeight)
							runAnimTrack:AdjustWeight(runAnimationWeight)
							currentAnimTrack:AdjustSpeed(walkAnimationTimewarp)
							runAnimTrack:AdjustSpeed(runAnimationTimerwarp)
						end

						local function setAnimationSpeed(speed)
							if currentAnim == "walk" then
								setRunSpeed(speed)
							else
								if speed ~= currentAnimSpeed then
									currentAnimSpeed = speed
									currentAnimTrack:AdjustSpeed(currentAnimSpeed)
								end
							end
						end

						local playAnimation

						local function keyFrameReachedFunc(frameName)
							if (frameName == "End") then
								if currentAnim == "walk" then
									if userNoUpdateOnLoop == true then
										if runAnimTrack.Looped ~= true then
											runAnimTrack.TimePosition = 0.0
										end
										if currentAnimTrack.Looped ~= true then
											currentAnimTrack.TimePosition = 0.0
										end
									else
										runAnimTrack.TimePosition = 0.0
										currentAnimTrack.TimePosition = 0.0
									end
								else
									local repeatAnim = currentAnim
									-- return to idle if finishing an emote
									if (emoteNames[repeatAnim] ~= nil and emoteNames[repeatAnim] == false) then
										repeatAnim = "idle"
									end

									if currentlyPlayingEmote then
										if currentAnimTrack.Looped then
											-- Allow the emote to loop
											return
										end

										repeatAnim = "idle"
										currentlyPlayingEmote = false
									end

									local animSpeed = currentAnimSpeed
									playAnimation(repeatAnim, 0.15, Humanoid)
									setAnimationSpeed(animSpeed)
								end
							end
						end

						local function rollAnimation(animName)
							local roll = math.random(1, animTable[animName].totalWeight) 
							local origRoll = roll
							local idx = 1
							while (roll > animTable[animName][idx].weight) do
								roll = roll - animTable[animName][idx].weight
								idx = idx + 1
							end
							return idx
						end

						local function switchToAnim(anim, animName, transitionTime, humanoid)
							-- switch animation		
							if (anim ~= currentAnimInstance) then

								if (currentAnimTrack ~= nil) then
									currentAnimTrack:Stop(transitionTime)
									currentAnimTrack:Destroy()
								end

								if (runAnimTrack ~= nil) then
									runAnimTrack:Stop(transitionTime)
									runAnimTrack:Destroy()
									if userNoUpdateOnLoop == true then
										runAnimTrack = nil
									end
								end

								currentAnimSpeed = 1.0

								-- load it to the humanoid; get AnimationTrack
								currentAnimTrack = humanoid:LoadAnimation(anim)
								currentAnimTrack.Priority = Enum.AnimationPriority.Core

								-- play the animation
								currentAnimTrack:Play(transitionTime)
								currentAnim = animName
								currentAnimInstance = anim

								-- set up keyframe name triggers
								if (currentAnimKeyframeHandler ~= nil) then
									currentAnimKeyframeHandler:disconnect()
								end
								currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)

								-- check to see if we need to blend a walk/run animation
								if animName == "walk" then
									local runAnimName = "run"
									local runIdx = rollAnimation(runAnimName)

									runAnimTrack = humanoid:LoadAnimation(animTable[runAnimName][runIdx].anim)
									runAnimTrack.Priority = Enum.AnimationPriority.Core
									runAnimTrack:Play(transitionTime)		

									if (runAnimKeyframeHandler ~= nil) then
										runAnimKeyframeHandler:disconnect()
									end
									runAnimKeyframeHandler = runAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)	
								end
							end
						end

						function playAnimation(animName, transitionTime, humanoid) 	
							local idx = rollAnimation(animName)
							local anim = animTable[animName][idx].anim

							switchToAnim(anim, animName, transitionTime, humanoid)
							currentlyPlayingEmote = false
						end

						local function playEmote(emoteAnim, transitionTime, humanoid)
							switchToAnim(emoteAnim, emoteAnim.Name, transitionTime, humanoid)
							currentlyPlayingEmote = true
						end

						-------------------------------------------------------------------------------------------
						-------------------------------------------------------------------------------------------

						local toolAnimName = ""
						local toolAnimTrack = nil
						local toolAnimInstance = nil
						local currentToolAnimKeyframeHandler = nil
						local playToolAnimation

						local function toolKeyFrameReachedFunc(frameName)
							if (frameName == "End") then
								playToolAnimation(toolAnimName, 0.0, Humanoid)
							end
						end


						function playToolAnimation(animName, transitionTime, humanoid, priority)	 		
							local idx = rollAnimation(animName)
							local anim = animTable[animName][idx].anim

							if (toolAnimInstance ~= anim) then

								if (toolAnimTrack ~= nil) then
									toolAnimTrack:Stop()
									toolAnimTrack:Destroy()
									transitionTime = 0
								end

								-- load it to the humanoid; get AnimationTrack
								toolAnimTrack = humanoid:LoadAnimation(anim)
								if priority then
									toolAnimTrack.Priority = priority
								end

								-- play the animation
								toolAnimTrack:Play(transitionTime)
								toolAnimName = animName
								toolAnimInstance = anim

								currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
							end
						end

						local function stopToolAnimations()
							local oldAnim = toolAnimName

							if (currentToolAnimKeyframeHandler ~= nil) then
								currentToolAnimKeyframeHandler:disconnect()
							end

							toolAnimName = ""
							toolAnimInstance = nil
							if (toolAnimTrack ~= nil) then
								toolAnimTrack:Stop()
								toolAnimTrack:Destroy()
								toolAnimTrack = nil
							end

							return oldAnim
						end

						-------------------------------------------------------------------------------------------
						-------------------------------------------------------------------------------------------
						-- STATE CHANGE HANDLERS

						local function onRunning(speed)
							local heightScale = if userAnimateScaleRun then getHeightScale() else 1

							local movedDuringEmote = currentlyPlayingEmote and Humanoid.MoveDirection == Vector3.new(0, 0, 0)
							local speedThreshold = movedDuringEmote and (Humanoid.WalkSpeed / heightScale) or 0.75
							if speed > speedThreshold * heightScale then
								local scale = 16.0
								playAnimation("walk", 0.2, Humanoid)
								setAnimationSpeed(speed / scale)
								pose = "Running"
							else
								if emoteNames[currentAnim] == nil and not currentlyPlayingEmote then
									playAnimation("idle", 0.2, Humanoid)
									pose = "Standing"
								end
							end
						end

						local function onDied()
							pose = "Dead"
						end

						local function onJumping()
							playAnimation("jump", 0.1, Humanoid)
							jumpAnimTime = jumpAnimDuration
							pose = "Jumping"
						end

						local function onClimbing(speed)
							if userAnimateScaleRun then
								speed /= getHeightScale()
							end
							local scale = 5.0
							playAnimation("climb", 0.1, Humanoid)
							setAnimationSpeed(speed / scale)
							pose = "Climbing"
						end

						local function onGettingUp()
							pose = "GettingUp"
						end

						local function onFreeFall()
							if (jumpAnimTime <= 0) then
								playAnimation("fall", fallTransitionTime, Humanoid)
							end
							pose = "FreeFall"
						end

						local function onFallingDown()
							pose = "FallingDown"
						end

						local function onSeated()
							pose = "Seated"
						end

						local function onPlatformStanding()
							pose = "PlatformStanding"
						end

						-------------------------------------------------------------------------------------------
						-------------------------------------------------------------------------------------------

						local function onSwimming(speed)
							if userAnimateScaleRun then
								speed /= getHeightScale()
							end
							if speed > 1.00 then
								local scale = 10.0
								playAnimation("swim", 0.4, Humanoid)
								setAnimationSpeed(speed / scale)
								pose = "Swimming"
							else
								playAnimation("swimidle", 0.4, Humanoid)
								pose = "Standing"
							end
						end

						local function animateTool()
							if (toolAnim == "None") then
								playToolAnimation("toolnone", toolTransitionTime, Humanoid, Enum.AnimationPriority.Idle)
								return
							end

							if (toolAnim == "Slash") then
								playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
								return
							end

							if (toolAnim == "Lunge") then
								playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
								return
							end
						end

						local function getToolAnim(tool)
							for _, c in ipairs(tool:GetChildren()) do
								if c.Name == "toolanim" and c.className == "StringValue" then
									return c
								end
							end
							return nil
						end

						local lastTick = 0

						local function stepAnimate(currentTime)
							local amplitude = 1
							local frequency = 1
							local deltaTime = currentTime - lastTick
							lastTick = currentTime

							local climbFudge = 0
							local setAngles = false

							if (jumpAnimTime > 0) then
								jumpAnimTime = jumpAnimTime - deltaTime
							end

							if (pose == "FreeFall" and jumpAnimTime <= 0) then
								playAnimation("fall", fallTransitionTime, Humanoid)
							elseif (pose == "Seated") then
								playAnimation("sit", 0.5, Humanoid)
								return
							elseif (pose == "Running") then
								playAnimation("walk", 0.2, Humanoid)
							elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
								stopAllAnimations()
								amplitude = 0.1
								frequency = 1
								setAngles = true
							end

							-- Tool Animation handling
							local tool = Character:FindFirstChildOfClass("Tool")
							if tool and tool:FindFirstChild("Handle") then
								local animStringValueObject = getToolAnim(tool)

								if animStringValueObject then
									toolAnim = animStringValueObject.Value
									-- message recieved, delete StringValue
									animStringValueObject.Parent = nil
									toolAnimTime = currentTime + .3
								end

								if currentTime > toolAnimTime then
									toolAnimTime = 0
									toolAnim = "None"
								end

								animateTool()		
							else
								stopToolAnimations()
								toolAnim = "None"
								toolAnimInstance = nil
								toolAnimTime = 0
							end
						end

						-- connect events
						Humanoid.Died:connect(onDied)
						Humanoid.Running:connect(onRunning)
						Humanoid.Jumping:connect(onJumping)
						Humanoid.Climbing:connect(onClimbing)
						Humanoid.GettingUp:connect(onGettingUp)
						Humanoid.FreeFalling:connect(onFreeFall)
						Humanoid.FallingDown:connect(onFallingDown)
						Humanoid.Seated:connect(onSeated)
						Humanoid.PlatformStanding:connect(onPlatformStanding)
						Humanoid.Swimming:connect(onSwimming)

						-- setup emote chat hook
						table.insert(connections,game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
							local emote = ""
							if (string.sub(msg, 1, 3) == "/e ") then
								emote = string.sub(msg, 4)
							elseif (string.sub(msg, 1, 7) == "/emote ") then
								emote = string.sub(msg, 8)
							end

							if (pose == "Standing" and emoteNames[emote] ~= nil) then
								playAnimation(emote, EMOTE_TRANSITION_TIME, Humanoid)
							end
						end))

						if Character.Parent ~= nil then
							-- initialize to idle
							playAnimation("idle", 0.1, Humanoid)
							pose = "Standing"
						end

						-- loop to handle timed state transitions and tool animations
						while Character.Parent ~= nil do
							local _, currentGameTime = wait(0.1)
							stepAnimate(currentGameTime)
						end
					end,
				}
				local function removeAllClasses(instance,class)
					local foundClass
					while true do
						local foundClass = instance:FindFirstChildOfClass(class,true)
						if foundClass then
							foundClass:Destroy()
						else
							break
						end
					end
				end

				local orgChar = C.char
				local saveLoc = orgChar:GetPivot()

				orgChar.Archivable = true
				local clonedChar = C.char:Clone()
				orgChar.Archivable = false
				C.ClonedChar = clonedChar
				clonedChar.Name = "InviClone"
				clonedChar:AddTag("RemoveOnDestroy")

				for num, child in ipairs(clonedChar:GetDescendants()) do
					if child:GetAttribute("RemoveOnDestroy") then
						child:Destroy()
					end
				end


				local orgHuman = C.human
				local clonedHuman = clonedChar:WaitForChild("Humanoid")
				clonedHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				clonedChar:SetPrimaryPartCFrame(saveLoc)
				removeAllClasses(clonedChar,"Sound")
				local CLONEDHammer = clonedChar:FindFirstChild("Hammer")
				if CLONEDHammer then
					CLONEDHammer:Destroy()
				end
				local function teleportMyCharacterAway()
					if orgChar and orgChar:FindFirstChild("HumanoidRootPart") then
						--local bodyForce = Instance.new("BodyForce")
						local mass = 0
						for num, part in ipairs(orgChar:GetDescendants()) do
							if part:IsA("BasePart") then
								mass += part:GetMass()
							end
						end
						local vectorForce = Instance.new("VectorForce")
						local attachment = Instance.new("Attachment")
						vectorForce.RelativeTo = "World"
						vectorForce.ApplyAtCenterOfMass = true;
						vectorForce.Parent = orgChar.HumanoidRootPart
						vectorForce.Attachment0 = attachment
						vectorForce.Force = Vector3.new(0, mass * workspace.Gravity, 0)
						attachment:AddTag("RemoveOnDestroy")
						attachment.Name = "FloatAttachment"
						attachment.Parent = orgChar.HumanoidRootPart

						orgHuman.PlatformStand = true

						--orgChar.PrimaryPart.Anchored = true
						--orgHuman:ChangeState(Enum.HumanoidStateType.Landed)
					end
				end
				C.AvailableHacks.Basic[30].LastTeleportLocation = saveLoc + C.AvailableHacks.Basic[30].HiddenLocation
				teleportMyself(C.AvailableHacks.Basic[30].LastTeleportLocation)
				C.rchar = orgChar
				C.char = clonedChar
				C.rhuman = orgHuman
				C.human = clonedHuman

				C.AvailableHacks.Basic[30].ApplyChange(clonedHuman,orgHuman)

				task.spawn(teleportMyCharacterAway,saveLoc)


				clonedChar.Parent = workspace

				local TPDelay = os.clock()

				local function doCFrameChanged()
					if not orgChar.Parent then
						return
					end
					local newLoc = orgChar:GetPrimaryPartCFrame()
					if (newLoc.Position - C.AvailableHacks.Basic[30].LastTeleportLocation.Position).Magnitude < 1e-2 then
						for s = 25, 1, -1 do
							RunS.RenderStepped:Wait()
						end
					end
					print(("Teleport: %.2f"):format((newLoc.Position - C.AvailableHacks.Basic[30].LastTeleportLocation.Position).Magnitude))
					if (newLoc.Position - C.AvailableHacks.Basic[30].LastTeleportLocation.Position).Magnitude < 15
						or os.clock() - TPDelay < .2 then
						return
					end
					TPDelay = os.clock()
					C.AvailableHacks.Basic[30].LastTeleportLocation = newLoc + C.AvailableHacks.Basic[30].HiddenLocation
					orgChar:SetPrimaryPartCFrame(C.AvailableHacks.Basic[30].LastTeleportLocation) --teleportMyself(C.AvailableHacks.Basic[30].HiddenLocation)
					clonedChar:SetPrimaryPartCFrame(newLoc)
					return true
				end

				local Head = orgChar:FindFirstChild("Head")
				local CenterPart = orgChar:FindFirstChild(clonedHuman.RigType == Enum.HumanoidRigType.R6 and "Torso" or "UpperTorso")
				local HRP = orgChar:FindFirstChild("HumanoidRootPart")
				if not Head or not CenterPart or not HRP then
					return
				end

				table.insert(connections,Head:GetPropertyChangedSignal("CFrame"):Connect(doCFrameChanged))
				table.insert(connections,(CenterPart)
					:GetPropertyChangedSignal("CFrame"):Connect(doCFrameChanged))
				table.insert(connections,HRP:GetPropertyChangedSignal("CFrame"):Connect(doCFrameChanged))
				local function updateCamera()
					if camera.CameraSubject == orgHuman then
						camera.CameraSubject = clonedHuman
					end
				end
				table.insert(connections,camera:GetPropertyChangedSignal("CameraSubject"):Connect(updateCamera))
				updateCamera()
				--if C.gameName == "FleeMain" then
				--local charEnv = C.GetHardValue(orgChar.LocalPlayerScript, "env", {yield=true})
				for num, part in ipairs(clonedChar:GetChildren()) do
					local RelativePart = orgChar:FindFirstChild(part.Name)
					if part:IsA("BasePart") and RelativePart then
						table.insert(connections,part.Touched:Connect(function(instance)
							--charEnv.TriggerTouch(instance,true)
							if instance.CanTouch and (part.Name==CenterPart.Name or C.enHacks.Basic_InvisibleChar==true) then
								firetouchinterest(RelativePart,instance,0)
							end
						end))
						table.insert(connections,part.TouchEnded:Connect(function(instance)
							--charEnv.TriggerTouch(instance,false)
							firetouchinterest(RelativePart,instance,1)
						end))
					end
				end
				--end
				--[[table.insert(connections,C.RemoteEvent.OnClientEvent:Connect(function(thing)
					if thing=="FadeBlackTransition" then
						local lastPosition = clonedChar:GetPrimaryPartCFrame().Position
						for s = 300, 1, -1 do
							print('l00p')
							local dist = (orgch:GetPrimaryPartCFrame().Position - lastPosition).Magnitude
							if dist > 30 then
								print('SERVER TELEPORT!',dist)
								orgChar.PrimaryPart.Anchored = false
								for s = 3, 1, -1 do
									RunS.RenderStepped:Wait()
								end
								doCFrameChanged()
								teleportMyCharacterAway()
								return
							end
							lastPosition = clonedChar:GetPrimaryPartCFrame().Position
							RunS.RenderStepped:Wait()
						end
						print("I didn't teleporT?")
					end
				end))--]]
				task.spawn(function()
					while clonedChar and clonedHuman and clonedChar.Parent do
						local MoveDirection = C.PlayerControlModule and C.PlayerControlModule:GetMoveVector() or C.human.MoveDirection
						clonedHuman:Move(MoveDirection,true)
						orgHuman:GetPropertyChangedSignal("MoveDirection"):Wait()
					end
				end)
				task.spawn(function()
					local lastJumpTime = -50
					while clonedChar and clonedHuman and clonedChar.Parent do
						if (os.clock() - lastJumpTime > .3 and clonedHuman.FloorMaterial ~= Enum.Material.Air)
							or (os.clock() - lastJumpTime > .1 and clonedHuman:GetState() == Enum.HumanoidStateType.Climbing) then
							if isJumpBeingHeld then
								lastJumpTime = os.clock()
								clonedHuman:ChangeState(Enum.HumanoidStateType.Jumping)
								RunS.RenderStepped:Wait()
							else
								jumpChangedEvent.Event:Wait()
							end
						else
							RunS.RenderStepped:Wait()--clonedHuman:GetPropertyChangedSignal("FloorMaterial"):Wait()
						end
					end
				end)
				for _, propTable in ipairs(C.AvailableHacks.Basic[30].ReplicateProperties) do
					local propertyToReplicate = propTable[2]
					local oldObject = StringWaitForChild(orgChar,propTable[1])
					local newObject = StringWaitForChild(clonedChar,propTable[1])
					local function updFunction()
						if C.isCleared then
							--warn("[AHH]: Property Running After Shutdown: "..table.concat(propTable,"."))
							return
						end
						newObject[propertyToReplicate] = oldObject[propertyToReplicate]
					end
					table.insert(connections, oldObject:GetPropertyChangedSignal(propertyToReplicate):Connect(updFunction))
					updFunction()
				end

				for _, basePart in ipairs(clonedChar:GetDescendants()) do
					if basePart.Name=="Weight" or basePart.Name=="Gemstone" then
						basePart:Destroy()
					elseif (basePart.Name=="Handle" and basePart.Parent and basePart.Parent.Name=="PackedHammer") then
						basePart.Transparency = 1
					elseif basePart:IsA("BasePart") and basePart.Name ~= "HumanoidRootPart" then
						--and basePart.Parent == clonedChar then
						--local local function updLocalTrans()
						basePart.Transparency = .7
						--end
						--updLocalTrans()
					elseif basePart:IsA("Decal") then
						basePart.Transparency = .7
					end
				end
				local SavedAnimsTracks = {}
				local runningSpeed = orgHuman.MoveDirection.Magnitude > 1e-3 and 3 or 0
				local canRun = false
				local function animTrackAdded(animTrack,instant)
					local animation = animTrack.Animation
					if animation.AnimationId ~= "rbxassetid://961932719" then
						return
					end
					local myTrack = SavedAnimsTracks[animation.AnimationId]
					if not myTrack then
						myTrack = clonedHuman.Animator:LoadAnimation(animation)
						while myTrack.Length == 0 do
							RunS.RenderStepped:Wait()
						end RunS.RenderStepped:Wait() RunS.RenderStepped:Wait()
						myTrack.Looped = animTrack.Looped
						myTrack.TimePosition = animTrack.TimePosition
						myTrack.Priority = animTrack.Priority
						SavedAnimsTracks[animation.AnimationId] = myTrack

						local function update()
							if animTrack.IsPlaying and not myTrack.IsPlaying then
								myTrack:Play(instant and 0 or 0.1, 1, runningSpeed>.5 and 2 or 0)
							elseif not animTrack.IsPlaying and myTrack.IsPlaying then
								myTrack:Stop()
							end
						end
						table.insert(connections,animTrack:GetPropertyChangedSignal("Speed"):Connect(update))
						table.insert(connections,animTrack:GetPropertyChangedSignal("IsPlaying"):Connect(update))
						table.insert(connections,animTrack.Stopped:Connect(update))
						update()
					else
						myTrack:Play()
					end
				end
				table.insert(connections, orgHuman.Animator.AnimationPlayed:Connect(animTrackAdded))
				task.spawn(doAnimate[orgHuman.RigType],clonedChar,connections)
				table.insert(connections, clonedHuman.Running:Connect(function(speed)
					local myTrack = SavedAnimsTracks["rbxassetid://961932719"]
					if not myTrack then
						runningSpeed = speed
						return
					end
					if speed > .5 then
						myTrack:AdjustSpeed(2)
					else
						myTrack:AdjustSpeed(0)
					end
				end))
				for _, animTrack in ipairs(orgHuman.Animator:GetPlayingAnimationTracks()) do
					animTrackAdded(animTrack,true)--the "true" is for it to be instant!
				end
			end,
			["ActivateFunction"] = function(enabled, characterSpawn)
				if enabled == C.AvailableHacks.Basic[30].Active and not characterSpawn then
					return
				end
				C.AvailableHacks.Basic[30].Active = enabled
				if enabled then
					if C.rchar then
						return
					end
					C.AvailableHacks.Basic[30].RunFunction(C.AvailableHacks.Basic[30].Functs)
				else
					for index = #C.AvailableHacks.Basic[30].Functs, 1, -1 do
						local connection = C.AvailableHacks.Basic[30].Functs[index]
						connection:Disconnect()
						table.remove(C.AvailableHacks.Basic[30].Functs,index)
					end
					if not characterSpawn and C.ClonedChar and C.ClonedChar.Parent and C.rchar and C.rchar.Parent then
						local orgHuman = C.rhuman
						local clonedHuman = C.ClonedChar:FindFirstChild("Humanoid")
						orgHuman:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
						task.delay(1,function()
							orgHuman:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
						end)
						if orgHuman then
							orgHuman.PlatformStand = false
						end
						if C.rchar:FindFirstChild("HumanoidRootPart") then
							C.rchar:SetPrimaryPartCFrame(C.ClonedChar:GetPrimaryPartCFrame())
							--teleportMyself(C.ClonedChar:GetPivot())--C.rchar:PivotTo(C.ClonedChar:GetPivot())
							if C.rchar.HumanoidRootPart:FindFirstChild("FloatAttachment") then
								C.rchar.HumanoidRootPart.FloatAttachment:Destroy()
							end	
						end

						if C.ClonedChar.Humanoid.FloorMaterial ~= Enum.Material.Air then
							for num, animTrack in ipairs(C.rchar.Humanoid.Animator:GetPlayingAnimationTracks()) do
								if animTrack.Animation.AnimationId~="rbxassetid://961932719"
									and animTrack.Animation.AnimationId~="rbxassetid://1416947241" then
									animTrack:Stop(0)
								end
							end
						end--]]
						camera.CameraSubject = orgHuman
						C.char = C.rchar
						C.human = C.rhuman
						C.rchar = nil
						C.rhuman = nil
						--for s = 2, 1, -1 do
						--RunS.RenderStepped:Wait()
						--end
						C.AvailableHacks.Basic[30].ApplyChange(orgHuman,clonedHuman)
					end
					if C.ClonedChar then
						C.ClonedChar:Destroy()
						C.ClonedChar = nil
					end
				end
			end,
			["MyStartUp"] = function(_,_,firstRun)
				if not firstRun then
					C.AvailableHacks.Basic[30].ActivateFunction(false,true)
				end
				local Start = os.clock()
				game:GetService("ContentProvider"):PreloadAsync({C.rchar})
				--print(("Character Appearence Loaded In %.2f!"):format(os.clock()-Start))
				--task.wait(.5)
				if C.enHacks["Basic_InvisibleChar"] then
					C.AvailableHacks.Basic[30].ActivateFunction(C.enHacks["Basic_InvisibleChar"])
				end
			end,
			--[[["MyPlayerAdded"] = function()
				task.wait(1.5)
				C.AvailableHacks.Basic[30].ActivateFunction(C.enHacks["Basic_InvisibleChar"])
				C.AvailableHacks.Basic[30].Funct = plr.CharacterAppearanceLoaded:Connect(function()
					print("Character Appearence Loaded!")
					if C.enHacks["Basic_InvisibleChar"] then
						C.AvailableHacks.Basic[30].ActivateFunction(C.enHacks["Basic_InvisibleChar"])
					end
				end)
				
			end,--]]
		},
		[40]={
			["Type"] = "ExTextButton",
			["Title"] = ("Force Allow Reset"),
			["Desc"] = ("Allows to reset from the roblox menu gui"),
			["Shortcut"] = "Basic_ResetButton",
			["DontActivate"] = true,
			["Options"] = {
				[false] = {
					["Title"]="OFF",
					["TextColor"]=newColor3(255),
				},
				["DEFAULT"] = {
					["Title"]="DEFAULT",
					["TextColor"]=newColor3(255,255,0)
				},
				[true]={
					["Title"]="CUSTOM",
					["TextColor"]=newColor3(0,255,255)
				}
			},
			["Universes"]={"Global"},
			["Default"]=true,
			["ActivateFunction"]=(function(newValue)
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", (newValue==true and ResetEvent) or (newValue=="DEFAULT"))
			end),
			["MyStartUp"]=function()
				task.wait(1/2)
				if (not C.enHacks.Basic_ResetButton) then
					return
				end--it resets itself anyways!
				C.AvailableHacks.Basic[40].ActivateFunction(C.enHacks.Basic_ResetButton)
			end
		},
		[60]={
			["Type"]="ExTextButton",
			["Title"]="Anti AFK",
			["Desc"]="Avoid AFK Kick",
			["Shortcut"]="AntiAFK1",
			["Default"]=true,
			["Funct"]=nil,
			["ActivateFunction"]=function(newValue)
				if newValue and not C.AvailableHacks.Basic[60].Funct then
					local function IdleOccuredFunction(timeInSec)--runs every sec after 2m, and pulses every second after that
						if C.enHacks.AntiAFK1 and not isStudio then
							VU:CaptureController()
							VU:ClickButton2(Vector2.new())
						end
					end
					C.AvailableHacks.Basic[60].Funct=plr.Idled:connect(IdleOccuredFunction)
				elseif not newValue and C.AvailableHacks.Basic[60].Funct then
					C.AvailableHacks.Basic[60].Funct:Disconnect()
				end
			end,
		},
		[99]={
			["Type"]="ExTextButton",
			["Title"]="Refresh & Update",
			["Desc"]=(reloadFunction and "Gets latest update straight from GitHub!" or "Unavailable: Reload Function Not Found!"),
			["Shortcut"]="UpdateFunction",
			["DontActivate"]=true,
			["Default"]=false,
			["Options"]={
				[false]={
					["Title"]=(reloadFunction and "UPDATE" or "Unavailable"),
					["TextColor"]=newColor3(0,170,170),
				},
			},
			["ActivateFunction"]=function(newValue,dontKeep)
				if reloadFunction then
					if lastRunningEnv.GlobalSettings and not dontKeep then

					elseif dontKeep then
						C.enHacks = {}--reset hacks!
						saveSaveData()--deletes the save file!
					end
					lastRunningEnv.GlobalSettings.enHacks = {}
					for hackID, value in pairs(C.enHacks) do
						lastRunningEnv.GlobalSettings.enHacks[hackID] = value
					end
					task.wait(1)
					task.spawn(reloadFunction)
				else
					print("Update/Reload Function Not Found!")
				end
			end,
		},
		[100]={
			["Type"]="ExTextButton",
			["Title"]="Self Destruct 'Button'",
			["Desc"]="Reinject to re-enable",
			["Shortcut"]="SelfDestruct",
			["DontActivate"]=true,
			["Default"]=false,
			["Options"]={
				[false]={
					["Title"]="DELETE",
					["TextColor"]=newColor3(255, 180, 0),
				},
			},
			["ActivateFunction"]=function(newValue)
				if C.isCleared then
					return warn("Instance "..(C.saveIndex or "Unknown").." is trying to delete itself but has already been cleared!")
				end
				C.clear(true)
			end,
		},
	},
	["Beast"]={
		[2]={
			["Type"]="ExTextButton",
			["Title"]="Always Allow Crawl",
			["Desc"]="Very obvious",
			["Shortcut"]="OverrideCrawl",
			["LoadedAnim"]=nil,
			["Default"]=false,
			["DontActivate"]=true,
			--[[["Options"]={
				[false]={
					["Title"]="OFF",
					["TextColor"]=newColor3(255, 0, 0),
				},
				["CrawlOnly"]={
					["Title"]="CRAWL ONLY",
					["TextColor"]=newColor3(255, 255, 0),
				},
				[true]={
					["Title"]="ON",
					["TextColor"]=newColor3(0, 255, 0),
				},
			},--]]
			["ActivateFunction"]=function(newValue)
				--C.AvailableHacks.Beast[2].SetScriptActive()
				if not newValue then
					C.AvailableHacks.Beast[2].Crawl(false)
				end
				--C.AvailableHacks.Beast[2].UpdateVentsVisibility()
			end,
			["MyStartUp"]=function()
				if C.AvailableHacks.Beast[2].LoadedAnim~=nil then
					C.AvailableHacks.Beast[2].LoadedAnim:Destroy()
				end
				C.AvailableHacks.Beast[2].IsCrawling=false
				local CrawlScript=C.char:WaitForChild("CrawlScript") 
				if CrawlScript==nil then
					return
				end
				for num,animTrack in pairs(C.char.Humanoid.Animator:GetPlayingAnimationTracks()) do
					if animTrack.Animation.AnimationId=="rbxassetid://961932719" then
						animTrack:Stop(0)
						animTrack:Destroy()
						C.human.HipHeight=0
					end
				end
				CrawlScript.Disabled=true
				local animTrack=C.human:WaitForChild("Animator"):LoadAnimation(CrawlScript:WaitForChild("AnimCrawl"))
				C.AvailableHacks.Beast[2].LoadedAnim=animTrack
				local function keyAction(actionName, inputState, inputObject)
					local shouldHold = C.enHacks.Util_CrawlType=="Default" and Enum.UserInputType.Keyboard == inputObject.UserInputType or C.enHacks.Util_CrawlType=="Hold"
					if shouldHold then
						if inputState==Enum.UserInputState.Begin then
							C.AvailableHacks.Beast[2].Crawl(true)
						elseif inputState==Enum.UserInputState.End then
							C.AvailableHacks.Beast[2].Crawl(false)
						end
					elseif inputState == Enum.UserInputState.Begin then
						local inverse = not C.AvailableHacks.Beast[2].IsCrawling;
						C.AvailableHacks.Beast[2].Crawl(inverse);
					end
				end
				local button = C.getDictLength(CAS:GetBoundActionInfo("Crawl"))>0 and CAS:GetButton("Crawl")
				local setPosition = plr:GetAttribute("CrawlPosition") or UDim2.new(1, -220, 1, -90)
				if button then
					setPosition = button.Position
					plr:SetAttribute("CrawlPosition",setPosition)
				end
				CAS:UnbindAction("Crawl")
				CAS:BindActionAtPriority("Crawl"..C.saveIndex, keyAction, true, 100, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL2)
				RunS.RenderStepped:Wait()
				CAS:SetTitle("Crawl"..C.saveIndex, "C")
				CAS:SetPosition("Crawl"..C.saveIndex,setPosition);

				local function HumanRunningFunction(speed)
					if speed > 0.5 then
						animTrack:AdjustSpeed(2)
					else
						animTrack:AdjustSpeed(0)
					end
				end
				table.insert(C.functs,(C.human.Running:Connect(HumanRunningFunction)))
				local inputToCrawlFunction_INPUT = UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.ButtonL2)
				C.AvailableHacks.Beast[2].Crawl(inputToCrawlFunction_INPUT,true)
			end,
			["MyPlayerAdded"]=function()
				local function crawlFunction()
					C.AvailableHacks.Blatant[(2)].Crawl()
				end

				table.insert(C.functs, C.myTSM:WaitForChild("DisableCrawl").Changed:Connect(function()
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					CAS:UnbindAction("Crawl")
				end))
			end,
			["IsCrawling"]=false,
			["MapAdded"]=function(newMap,firstRun)
				if not firstRun then
					task.wait(5) -- Delay this so it doesn't cause lag!
				else
					task.wait(1)
				end
				local loopInstance = C.Map.Name == "The Library by Drainhp" and StringWaitForChild(C.Map,"Misc.Vents") or C.Map
				for num, instance in ipairs(loopInstance:GetChildren()) do
					if instance.Name == "Vent" or instance.Name=="AirVent" then
						local VentBlock = instance:FindFirstChild("VentBlock")
						if VentBlock then
							VentBlock:Destroy()
						end
					elseif instance.Name == "VentBlock" or instance.Name == "VentBlocks" then
						instance:Destroy()
					end
					if num%100==0 then
						RunS.RenderStepped:Wait()
					end
				end
			end,
			["Crawl"]=function(set,instant)
				local TSM = plr:WaitForChild("TempPlayerStatsModule");
				local animTrack = C.AvailableHacks.Beast[2].LoadedAnim;
				local shouldReturn = not animTrack or not C.human or C.human.Health <= 0;
				if shouldReturn then
					return;
				end
				local argument = set and (C.enHacks.OverrideCrawl or not TSM.DisableCrawl.Value);
				if argument then
					local hipHeight = -2;
					C.human.HipHeight = hipHeight;
					local arg1 = instant and 0 or 0.1;
					local arg2 = 1.0;
					local arg3 = 0.0;
					animTrack:Play(arg1, arg2, arg3);
					C.human.WalkSpeed = 8;
					C.AvailableHacks.Beast[2].IsCrawling = true;
				else
					C.human.HipHeight = 0;
					animTrack:Stop();
					C.human.WalkSpeed = (((C.human.WalkSpeed==8) and 16) or C.human.WalkSpeed);
					C.AvailableHacks.Beast[2].IsCrawling=false;
				end
				C.RemoteEvent:FireServer("Input", "Crawl", C.AvailableHacks.Beast[2].IsCrawling)
				--TSM.IsCrawling.Value = C.AvailableHacks.Beast[2].IsCrawling;
			end,
		},
		[55]={
			["Type"]="ExTextButton",
			["Title"]="Auto Add Rope",
			["Desc"]="Automatically adds rope when player is hit",
			["Shortcut"]="AutoAddRope",
			["Options"]={
				[false]={
					["Title"]="NOBODY",
					["TextColor"]=newColor3(255),
				},
				["Me"]={
					["Title"]="ME",
					["TextColor"]=newColor3(0,0,255),
				},
				["Everyone"]={
					["Title"]="EVERYONE",
					["TextColor"]=newColor3(255, 255, 0),
				},
			},
			["Default"]=false,
			["RopeSurvivor"]=function(TSM,theirPlr,override)
				if (C.enHacks.AutoAddRope~="Everyone" and (C.enHacks.AutoAddRope~="Me" or C.Beast~=C.char)) and not override then
					return
				end
				if (not C.Beast or not TSM.Ragdoll.Value) then
					return
				end
				local CarriedTorso=C.Beast:FindFirstChild("CarriedTorso")
				if CarriedTorso==nil or CarriedTorso.Value then
					return
				end
				C.Beast.Hammer.HammerEvent:FireServer("HammerTieUp",theirPlr.Character.Torso,theirPlr.Character.Torso.NeckAttachment.WorldPosition)
			end,
			["ChangedFunction"]=function(TSM,theirPlr,loop)
				if (not TSM.Ragdoll.Value or not C.Beast) then
					return
				end
				local CarriedTorso=C.Beast:FindFirstChild("CarriedTorso")
				while (C.Beast and CarriedTorso.Value and TSM.Ragdoll.Value and loop and not C.isCleared) do
					CarriedTorso.Changed:Wait()
				end
				C.AvailableHacks.Beast[55].RopeSurvivor(TSM,theirPlr)
				--deletes the last function!
			end,
			["ActivateFunction"]=function(newVal)
				if newVal then
					--for num, theirPlr in ipairs(PS:GetPlayers()) do
					--	C.AvailableHacks.Beast[55].ChangedFunction(theirPlr:WaitForChild("TempPlayerStatsModule"),theirPlr)
					--end
					for num,theirPlr in ipairs(PS:GetPlayers()) do
						C.AvailableHacks.Beast[55].PlayerAdded(theirPlr)
					end
				end
			end,
			["PlayerAdded"]=function(theirPlr)
				local TSM = theirPlr:WaitForChild("TempPlayerStatsModule")
				local funct = function()
					C.AvailableHacks.Beast[55].ChangedFunction(TSM,theirPlr,true)
				end
				local myInput = (C.enHacks.AutoAddRope and funct)
				setChangedProperty(TSM:WaitForChild("Ragdoll",30),"Value", myInput)
				C.AvailableHacks.Beast[55].ChangedFunction(TSM,theirPlr,false)
			end,
			["MyPlayerAdded"]=function(myPlr)
				C.AvailableHacks.Beast[55].PlayerAdded(myPlr)
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				C.AvailableHacks.Beast[55].PlayerAdded(theirPlr)
			end,
		},
		[60] = {
			["Type"] = "ExTextButton",
			["Title"] = "Auto Capture",
			["Desc"] = "Instantly capture other survivors",
			["Shortcut"] = "AutoCapture",
			["Default"] = _SETTINGS.botModeEnabled,
			["ActivateFunction"] = (function(newValue)

				local TSM = plr:WaitForChild("TempPlayerStatsModule");
				local TSM_IsBeast = TSM:WaitForChild("IsBeast");

				local function BlatantChangedFunction()
					C.AvailableHacks.Beast[60].ChangedFunction();
				end
				local inputChangedAttribute_INPUT = (newValue and BlatantChangedFunction);
				setChangedProperty(TSM_IsBeast, "Value", inputChangedAttribute_INPUT);
				C.AvailableHacks.Beast[60].ChangedFunction();
			end),
			["CaptureSurvivor"] = function(theirPlr,theirChar,chosenCapsule,override)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				if not TSM:WaitForChild("IsBeast") or not C.Beast then
					return
				end
				if C.Beast.CarriedTorso.Value==nil then
					return
				end
				if not C.enHacks.AutoCapture and not override then
					return
				end
				--if C.enHacks.AutoCapture=="Me" and theirPlr~=plr then return end
				local function doCapsulePreCheck(cap)
					if cap.PrimaryPart then
						if (cap:FindFirstChild("PodTrigger") 
							and cap.PodTrigger:FindFirstChild("CapturedTorso") and not cap.PodTrigger.CapturedTorso.Value) then
							return true
						end
					end
				end
				local capsule,closestDist=nil,math.huge
				if chosenCapsule then
					if not doCapsulePreCheck(chosenCapsule) then
						warn("Invalid Input Capsule",chosenCapsule)
						return
					else
						capsule,closestDist = chosenCapsule, 0
					end
				end
				for num,cap in ipairs(CS:GetTagged("Capsule")) do
					if doCapsulePreCheck(cap) then
						local dist=(cap.PrimaryPart.Position-theirChar.PrimaryPart.Position).magnitude
						--print(dist,cap:FindFirstChild("PodTrigger"))
						if (dist<closestDist) then
							capsule,closestDist=cap,dist
						end
					end
					--print("PP",cap.PrimaryPart)
				end
				--print("Capturing survivor!")
				if not capsule then
					warn("Capsule Not Found For",theirPlr,theirChar)
					return false, "Capsule Not Found"
				end
				local Trigger = capsule:WaitForChild("PodTrigger",5)
				local ActionSign = Trigger and Trigger:FindFirstChild("ActionSign")
				for s=1,3,1 do
					local isOpened = ActionSign and (ActionSign.Value==11)
					if not Trigger or not ActionSign or not Trigger:FindFirstChild("CapturedTorso") then
						return
					elseif (Trigger and Trigger.CapturedTorso.Value~=nil) then 
						break --we got ourselves a trapped survivor!
					elseif not C.enHacks.AutoCapture and not override then
						break
					elseif s~=1 then
						wait(.15)
					end
					if Trigger:FindFirstChild("Event") then
						C.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
						C.RemoteEvent:FireServer("Input", "Action", true)
						if isOpened then
							C.RemoteEvent:FireServer("Input", "Trigger", false)
						end
					end
				end
				return true
			end,
			["ChangedFunction"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				if not TSM:WaitForChild("IsBeast").Value then
					return
				end
				local CarriedTorso=C.char:WaitForChild("CarriedTorso",20)
				if CarriedTorso~=nil then
					local function canRun(saveTorso)
						return C.char == C.Beast and CarriedTorso.Parent and not C.isCleared and saveTorso==CarriedTorso.Value
					end
					local function captureSurvivorFunction()
						local saveTorso = CarriedTorso.Value
						while canRun(saveTorso) do
							local capsuleList = CS:GetTagged("Capsule")
							local hasValid = false
							for _, cap in ipairs(capsuleList) do
								if cap and cap:IsDescendantOf(C.Map) 
									and cap.PrimaryPart 
									and cap:FindFirstChild("PodTrigger")
									and cap.PodTrigger:FindFirstChild("CapturedTorso") and not cap.PodTrigger.CapturedTorso.Value then
									hasValid = true
									--print("Valid Cap Found!",cap.Name)
									break
								else
									--CAPSULE IS STILL LOADING, SO WAIT!
									--warn("Invalid Capsule At",cap)
								end
							end
							if hasValid then
								break
							elseif #capsuleList==0 then
								--print("Waiting For More Cap")
								CS:GetInstanceAddedSignal("Capsule"):Wait()
							end
							task.wait(.25)
							--print("LOOPINg")
						end
						if not canRun(saveTorso) then
							--print("Exited for sm reason")
							return
						end
						C.AvailableHacks.Beast[60].CaptureSurvivor(plr,C.char,nil)
					end
					local input = C.enHacks.AutoCapture and captureSurvivorFunction
					setChangedProperty(CarriedTorso,"Value",input)
					captureSurvivorFunction()--C.AvailableHacks.Beast[60].CaptureSurvivor(plr,C.char)
				elseif C.char == C.Beast and C.char.Parent then -- make sure a new beast didn't spawn or it doesn't exist
					warn("rope not found!!!! hackssss bro!", C.char:GetFullName())
				end
			end,


			--["MyStartUp"]=function()
	--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
	setChangedProperty(
		TSM:WaitForChild("IsBeast"),
		"Value",C.enHacks.AutoCapture and function()
			C.AvailableHacks.Beast[60].ChangedFunction()
		end or false)--]]
			--C.AvailableHacks.Beast[60].ChangedFunction()
			--end,


			["MyBeastAdded"]=function(theirPlr,theirChar)
				C.AvailableHacks.Beast[60].ChangedFunction(theirPlr,theirChar)
			end,
			--["OthersBeastAdded"]=function(theirPlr,theirChar)
			--	C.AvailableHacks.Beast[60].ChangedFunction(theirPlr,theirChar)
			--end,
		},
		[66]={
			["Type"]="ExTextButton",
			["Title"]="Auto Beast Hit",
			["Desc"]="Beast AUTO hits when near",
			["Shortcut"]="AutoBeastHit",
			["DontActivate"]=false,
			["Default"]="None",
			["Options"]={
				["None"]={
					["Title"]="NONE",
					["TextColor"]=newColor3(255)
				},
				["Me"]={
					["Title"]="ME ONLY",
					["TextColor"]=newColor3(255,255)
				},
				["All"]={
					["Title"]="ALL",
					["TextColor"]=newColor3(0,255)
				}
			},
			["HitFunction"]=function(Hammer,Handle,theirChar)
				if not theirChar.PrimaryPart then
					return
				end
				local Dist=(Handle.Position-theirChar.PrimaryPart.Position).magnitude
				if Dist<15 then
					local closestPart, closestDist = nil, 10 -- Test Success: Hit Part Must Be < 8 Studs of Hammer
					for num, part in ipairs(theirChar:GetChildren()) do
						if part:IsA("BasePart") then
							local testDist = (part.Position-Handle.Position).Magnitude
							if testDist < closestDist then
								closestPart, closestDist = part, testDist
							end
						end
					end
					if closestPart then
						Hammer.HammerEvent:FireServer("HammerHit", closestPart)
						return true
					end
				end
			end,
			["BeastStartUp"]=function()
				local saveState=C.enHacks.AutoBeastHit
				local beast=C.Beast--the current C.Beast
				local Hammer=beast:WaitForChild("Hammer",2)
				local Handle=Hammer and Hammer:WaitForChild("Handle",2)
				while beast~=nil and beast.Parent~=nil and Hammer and Hammer.Parent and C.enHacks.AutoBeastHit==saveState and Handle
					and (C.enHacks.AutoBeastHit=="All" 
						or (C.enHacks.AutoBeastHit=="Me" and beast==C.char)) do
					for num,theirPlr in pairs(PS:GetPlayers()) do
						if theirPlr~=nil and theirPlr.Character~=nil then
							local theirChar=theirPlr.Character
							local theirTSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
							if theirTSM and not theirTSM.Captured.Value and not theirTSM.Ragdoll.Value and theirChar ~= C.Beast then
								C.AvailableHacks.Beast[66].HitFunction(Hammer,Handle,theirChar)
							end
						end
					end
					RunS.RenderStepped:Wait()
				end
			end,
			["ActivateFunction"]=function(newValue)
				if newValue~="None" and C.Beast then
					C.AvailableHacks.Beast[66].BeastStartUp()
				end
			end,
			["MyPlayerAdded"]=function(plr)
				C.AvailableHacks.Beast[66].OthersBeastAdded=C.AvailableHacks.Beast[66].BeastStartUp
				C.AvailableHacks.Beast[66].MyBeastAdded=C.AvailableHacks.Beast[66].BeastStartUp
			end,
		},
		--[[[70]={
			["Type"]="ExTextButton",
			["Title"]="Insta Rope",
			["Desc"]="Beast INSTA ropes downed users when near",
			["Shortcut"]="AutoBeastRope",
			["DontActivate"]=false,
			["Default"]="None",
			["Options"]=({
				["None"]={
					["Title"]="NONE",
					["TextColor"]=(newColor3(255)),
				},
				["Me"]={
					["Title"]="ME ONLY",
					["TextColor"]=(newColor3(255,255)),
				},
				["All"]={
					["Title"]="ALL",
					["TextColor"]=(newColor3(0,255)),
				}
			}),
			["BeastStartUp"]=function()
				local saveState=C.enHacks.AutoBeastRope
				local beast=C.Beast--the current C.Beast
				local Hammer=beast:WaitForChild("Hammer",2)
				local Handle=Hammer:WaitForChild("Handle",5)
				local CarriedTorso = beast:WaitForChild("CarriedTorso",2)
				while (beast~=nil and beast.Parent~=nil and Hammer~=nil and C.enHacks.AutoBeastRope==saveState and CarriedTorso and (C.enHacks.AutoBeastRope=="All" or (C.enHacks.AutoBeastRope=="Me" and beast==C.char))) do
					for num,theirPlr in ipairs(PS:GetChildren()) do
						if theirPlr~=nil and theirPlr.Character~=nil then
							local theirChar=theirPlr.Character
							local TSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
							if TSM~=nil and not TSM.Captured.Value and TSM.Ragdoll.Value then
								local Dist=(Handle.Position-theirChar.PrimaryPart.Position).magnitude
								if Dist<14 then
									Hammer.HammerEvent:FireServer("HammerTieUp",theirChar.Torso,theirChar.Torso.Position)
								end
							end
						end
					end
					RunS.PreAnimation:Wait()
					while CarriedTorso and CarriedTorso.Value and CarriedTorso.Value.Parent do
						CarriedTorso.Changed:Wait()
					end
				end
			end,
			["ActivateFunction"]=function(newValue)
				if newValue~="None" and C.Beast then
					C.AvailableHacks.Beast[70].BeastStartUp()
				end
			end,
			["MyPlayerAdded"]=function(plr)
				C.AvailableHacks.Beast[70].OthersBeastAdded=C.AvailableHacks.Beast[70].BeastStartUp
				C.AvailableHacks.Beast[70].MyBeastAdded=C.AvailableHacks.Beast[70].BeastStartUp
			end,
		},--]]
		[77]={
			["Type"]="ExTextButton",
			["Title"]="Insta Capture All",
			["Desc"]="Activate To CAPTURE ALL SURVIVORS!",
			["Shortcut"]="Beast_CaptureAllSurvivors",
			["Default"]=false,
			["Options"]={
				[false]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(255,255,255),
				},
				["In Progress"]={
					["Title"]="IN PROGRESS",["Locked"]=true,
					["TextColor"]=newColor3(255,0,255),
				},
				[true]={
					["Title"]="ENABLED",
					["TextColor"]=newColor3(0,255,0),
				},
			},
			["SaveDeb"] = 0,
			["ActivateFunction"]=function(newValue,isFirstRun)
				if newValue=="In Progress" then 
					if isFirstRun then
						trigger_setTriggers("Beast_CaptureAllSurvivors",true)
					end
					return
				end

				C.AvailableHacks.Beast[77].SaveDeb+=1
				local savedDeb = C.AvailableHacks.Beast[77].SaveDeb

				if newValue==false or C.char ~= C.Beast then
					trigger_setTriggers("Beast_CaptureAllSurvivors",true)
					return
				end

				local Hammer = C.char:WaitForChild("Hammer",30)
				local CarriedTorso = Hammer and C.char:WaitForChild("CarriedTorso",30)
				if not Hammer or not CarriedTorso then return end
				local Handle = Hammer:WaitForChild("Handle")

				local function canRun(noReset)
					local retValue = savedDeb == C.AvailableHacks.Beast[77].SaveDeb and not C.isCleared and C.char == C.Beast

					local isFinished = true
					for num, theirPlr in ipairs(PS:GetPlayers()) do
						local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule",1)
						if theirTSM and theirTSM.Health.Value > 0 and not theirTSM.Captured.Value then
							isFinished = false
							break--performance reasons!
						end
					end
					if isFinished then
						retValue = false
						if C.enHacks.Beast_CaptureAllSurvivors=="In Progress" then
							warn("<font color='rgb(255,255,0)'>Finished Capturing!</font>")
							C.refreshEnHack["Beast_CaptureAllSurvivors"](true)
						end
					end

					if not retValue and not noReset then--CLEANUP CHECK!
						trigger_setTriggers("Beast_CaptureAllSurvivors",true)
					end


					return retValue
				end
				local function canRunPlr(theirPlr)
					return theirPlr and theirPlr.Parent and theirPlr.Character and theirPlr.Character.PrimaryPart
						and theirPlr.Character:FindFirstChild("Humanoid") and theirPlr.Character.Humanoid.Health>0
				end
				if not canRun() then return end
				C.refreshEnHack["Beast_CaptureAllSurvivors"]("In Progress")
				trigger_setTriggers("Beast_CaptureAllSurvivors",false)
				local function teleportFunct(theirChar,theirHuman)
					local offset = (theirHuman.MoveDirection.Magnitude>0 and theirChar:GetPivot() * Vector3.new(0,0,-1) or theirChar:GetPivot().Position+theirHuman.MoveDirection*5)
					teleportMyself(C.char:GetPivot() - C.char:GetPivot().Position + offset)
					--+ Vector3.new(0,C.getHumanoidHeight(C.char)))
				end
				while true do
					if not canRun() then return end
					for num, theirPlr in ipairs(PS:GetPlayers()) do
						local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule",1)
						local theirChar = theirPlr.Character
						if theirChar and theirChar.PrimaryPart and theirTSM and (not CarriedTorso.Value or CarriedTorso.Value.Parent == theirChar) then
							local theirHuman = theirChar:FindFirstChild("Humanoid")
							if theirHuman and theirHuman.Health > 0 and select(2,C.isInGame(theirChar,true))=="Runner" then
								--PROCESS SEQUENCE
								local loopInstance = 1
								while not theirTSM.Captured.Value and canRunPlr(theirPlr) do
									if not canRun() then
										return
									elseif not canRunPlr(theirPlr) then
										break
									end
									teleportFunct(theirChar,theirHuman)
									while canRun(true) and canRunPlr(theirPlr) 
										and not theirTSM.Ragdoll.Value do

										if not C.AvailableHacks.Beast[66].HitFunction(Hammer,Handle,theirChar) then
											teleportFunct(theirChar,theirHuman)
											--TELEPORT IF IT RETURNS FALSE (WE'RE OUT OF RANGE!)
										else
											Hammer.HammerEvent:FireServer("HammerClick", true)
										end
										print("Out of range")
										RunS.RenderStepped:Wait()
									end
									if not canRun() then return elseif not canRunPlr(theirPlr) then break end
									while canRun(true) and canRunPlr(theirPlr)
										and theirTSM.Ragdoll.Value and CarriedTorso.Value == nil do

										print("Tie")
										Hammer.HammerEvent:FireServer("HammerTieUp",theirChar.Torso,theirChar.Torso.Position)
										RunS.RenderStepped:Wait()
									end
									if not canRun() then return elseif not canRunPlr(theirPlr) then break end
									while canRun(true) and canRunPlr(theirPlr) and theirTSM.Ragdoll.Value and CarriedTorso.Value and CarriedTorso.Value.Parent == theirChar and not theirTSM.Captured.Value do
										C.AvailableHacks.Beast[60].CaptureSurvivor(theirPlr,theirChar,nil,true)
										print("Capturing")
										RunS.RenderStepped:Wait()
									end
									if loopInstance > 1 then
										warn("<font color='rgb(255,255,0)'>[INSTA CAPTURE]: LOOP INSTANCE = "..loopInstance.."!</font>")
										task.wait()
									end
									RunS.RenderStepped:Wait()
									loopInstance+=1
								end
							end
						end
					end
					if not canRun() then return end
					RunS.RenderStepped:Wait()
					print("OUTside loop1!")
				end
			end,
			["MyBeastAdded"]=function()
				C.AvailableHacks.Beast[77].ActivateFunction(C.enHacks.Beast_CaptureAllSurvivors)
			end,
		},
	},
	["Runner"]={
		[3]={
			["Type"]="ExTextButton",
			["Title"]="Auto Remove Rope",
			["Desc"]="Automatically Beast's Removes Rope When Runner",
			["Shortcut"]="AutoRemoveRope",
			["Options"]={
				[false]={
					["Title"]="NOBODY",
					["TextColor"]=newColor3(255),
				},
				["Me"]={
					["Title"]="ME",
					["TextColor"]=newColor3(0,0,255),
				},
				["Everyone"]={
					["Title"]="EVERYONE",
					["TextColor"]=newColor3(255, 255, 0),
				},
			},
			["Default"]=false,
			["ChangedFunction"]=function(newSet,override)
				--print("begun")
				if C.Beast==nil then
					return
				end
				local CarriedTorso=C.Beast:FindFirstChild("CarriedTorso")
				if CarriedTorso==nil then
					return
				end
				local Hammer=C.Beast:WaitForChild("Hammer")
				if Hammer==nil or (not override and not C.enHacks.AutoRemoveRope) then
					return
				end
				if not C.char:IsAncestorOf(CarriedTorso.Value) and C.enHacks.AutoRemoveRope=="Me" then
					--print("cancelled ", C.char:GetFullName())
					return
				end
				for s=2,1,-1 do
					if CarriedTorso.Value==nil then
						break
					end
					--print("activated")
					Hammer.HammerEvent:FireServer("HammerClick", true)
					wait(.05)
				end
				--print("finished")
			end,
			["ActivateFunction"]=function()
				if workspace:IsAncestorOf(C.Beast) and C.Beast~=C.char then
					setChangedProperty(C.Beast:WaitForChild("CarriedTorso",30),"Value",false)--deletes the last function!
					C.AvailableHacks.Runner[3].OthersBeastAdded(PS:GetPlayerFromCharacter(C.Beast),C.Beast)
				end
				--C.AvailableHacks.Runner[3].ChangedFunction()
			end,
			["OthersBeastAdded"]=function(theirPlr,theirChar)
				local CarriedTorso=theirChar:WaitForChild("CarriedTorso",30)
				if CarriedTorso==nil then
					return
				end
				setChangedProperty(CarriedTorso,"Value",C.enHacks.AutoRemoveRope and (function(newRopee)
					C.AvailableHacks.Runner[3].ChangedFunction(newRopee)
				end) or false)
				C.AvailableHacks.Runner[3].ChangedFunction()
			end,
			["MyPlayerAdded"]=function()
				local function ToRunFunct(actionName,actionState)
					if actionState == Enum.UserInputState.Begin then
						if C.enHacks.AutoRemoveRope == false then
							C.refreshEnHack["AutoRemoveRope"]("Everyone")
						else
							C.refreshEnHack["AutoRemoveRope"](false)
						end
					end
				end
				CAS:BindAction("AutoRemoveRope"..C.saveIndex,ToRunFunct, false, Enum.KeyCode.U)
			end,
			--["MyBeastAdded"]=function(...)
			--	C.AvailableHacks.Runner[3].OthersBeastAdded(...)
			--end
		},
		[4]={
			["Type"]="ExTextButton",
			["Title"]="Remote Hack PCs",
			["Desc"]='Remotely Hack PCs',
			["Shortcut"]="Blatant_RemoteHackPCs",
			["Default"]=false,
			["Funct"]=nil,
			["Functs"] = {},
			["Changed"]=nil,
			["ActivateFunction"]=function(newValue)
				local actionEvent = C.myTSM:WaitForChild("ActionEvent")
				local function currentAnimationUpdate(actionValue)
					if actionValue and actionValue.Parent and actionValue.Parent.Parent and trigger_gettype(actionValue.Parent.Parent)=="Computer" then
						if C.enHacks.Blatant_RemoteHackPCs then
							C.char.Torso.CanTouch = false
							trigger_setTriggers("Typing",{AllowExceptions={actionValue.Parent.Parent}})
							local actionSign = actionValue.Parent.ActionSign
							C.AvailableHacks.Runner[4].Changed = C.myTSM.CurrentAnimation.Changed:Connect(function()
								task.wait(1/3)--RunS.RenderStepped:Wait()
								actionValue.Parent.Parent.Screen.SoundTyping:Stop()
								C.myTSM.CurrentAnimation.Value = ""
								if C.AvailableHacks.Runner[4].Changed then
									table.remove(C.functs,table.find(C.functs,C.AvailableHacks.Runner[4].Changed))
									C.AvailableHacks.Runner[4].Changed:Disconnect()
								end
								local function CanRun()
									return actionSign.Value == 0 and not C.isCleared
								end
								while CanRun() do
									while CanRun() and actionValue.Parent.Parent.Screen.SoundWindowsPopUp.Playing do
										actionSign.Parent.Parent.Screen.SoundWindowsPopUp:Stop()
										RunS.RenderStepped:Wait()
									end
									--warn("Waiting")
									if CanRun() then
										actionSign.Parent.Parent.Screen.SoundWindowsPopUp:GetPropertyChangedSignal("Playing"):Wait()
									end
									--warn("Play Event")
								end
								--warn("ActionSign Changed",actionSign.Value)
							end)
							table.insert(C.functs,C.AvailableHacks.Runner[4].Changed)
							return
						else
							if actionValue.Parent and not table.find(C.char.Torso:GetTouchingParts(),actionValue.Parent) then
								task.spawn(stopCurrentAction,true)
								C.PurgeActionsWithTag("ComputerHack")
							end
						end
					end
					trigger_setTriggers("Typing",true)
					if C.char:FindFirstChild("Torso") then
						C.char.Torso.CanTouch = true
					end
					if C.AvailableHacks.Runner[4].Changed then
						C.AvailableHacks.Runner[4].Changed:Disconnect()
						C.AvailableHacks.Runner[4].Changed=nil
					end
				end

				if not C.AvailableHacks.Runner[4].Funct and newValue then
					C.AvailableHacks.Runner[4].Funct = actionEvent.Changed:Connect(currentAnimationUpdate)
				elseif C.AvailableHacks.Runner[4].Funct and not newValue then
					C.AvailableHacks.Runner[4].Funct:Disconnect()
					C.AvailableHacks.Runner[4].Funct=nil
				end
				if C.AvailableHacks.Runner[4].Changed then
					C.AvailableHacks.Runner[4].Changed:Disconnect()
					C.AvailableHacks.Runner[4].Changed=nil
				end
				--setChangedProperty(currentAnimation,"Value",newValue and currentAnimationUpdate)
				currentAnimationUpdate(actionEvent.Value)
			end,
		},


		[71]={
			["Type"]="ExTextButton",
			["Title"]="Panic When Hit",
			["Desc"]="Instantly fly around while hit",
			["Shortcut"]="Panic",
			["Default"]=false,
			["Triggered"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				--print("Triggersed",C.enHacks.Panic,C.char:FindFirstChild("HumanoidRootPart"),TSM.Ragdoll.Value)
				if not C.enHacks.Panic or C.char:FindFirstChild("HumanoidRootPart")==nil or not TSM.Ragdoll.Value then
					return
				end
				local newVel=Instance.new("BodyVelocity",C.char.HumanoidRootPart)
				newVel.MaxForce = (newVector3(3000,3000,3000)*2.25)
				newVel.P = 3e3
				CS:AddTag(newVel,"RemoveOnDestroy")
				local function RagdollPanicThreadFunction()
					while (C.enHacks.Panic and TSM.Ragdoll.Value and not TSM.Captured.Value and not C.isCleared) do
						newVel.Velocity = (Random.new():NextUnitVector()*5e2)
						task.wait(.065)
					end
					newVel.Velocity=newVector3(0,0,0)
					DS:AddItem(newVel,.1)
				end
				task.spawn(RagdollPanicThreadFunction)

			end,
			["SetChanged"]=function(shouldntTrigger)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local function theFunction()
					C.AvailableHacks.Runner[71].Triggered()
				end
				--local theArg = ((C.enHacks.Panic and (theFunction)) or false)
				--setChangedProperty(TSM:WaitForChild("Ragdoll"),"Value",theArg)
				if shouldntTrigger~=true then
					C.AvailableHacks.Runner[71].Triggered()
				end
			end,
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Runner[71].SetChanged()
			end,
			["MyPlayerAdded"]=function()
				C.AvailableHacks.Runner[71].SetChanged(true)
				table.insert(C.functs,C.myTSM:WaitForChild("Ragdoll").Changed:Connect(C.AvailableHacks.Runner[71].Triggered))
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Runner[71].Triggered()
			end,
		},
		[76] = {
			["Type"]="ExTextButton",
			["Title"]="Respawn Before Hit",
			["Desc"]="Despawns and respawns character before hit",
			["Shortcut"]="RespawnBeforeHit",
			["Default"]=false,
			["OthersBeastAdded"] = function(myBeastPlr,myBeast)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				while (myBeast~=nil and workspace:IsAncestorOf(myBeast) and myBeast:FindFirstChild("HumanoidRootPart") 
					and not C.isCleared and myBeast==C.Beast and C.char~=myBeast) do
					if (not TSM.Ragdoll.Value and C.enHacks.RespawnBeforeHit and not TSM.Captured.Value) then
						local whieList = {"Whitelist",C.Map,myBeast}
						local didHit,instance=C.raycast(C.char.PrimaryPart.Position,myBeast:GetPivot().Position,whieList,18,nil,true)
						if (didHit and myBeast:IsAncestorOf(instance) and not TSM.Ragdoll.Value and not TSM.Captured.Value) then
							C.AvailableHacks.Commands[24].ActivateFunction(true)




							local newChar = plr.CharacterAdded:Wait()
							repeat
								RunS.RenderStepped:Wait()
							until newChar.PrimaryPart
						end
					elseif not C.enHacks.RespawnBeforeHit then
						hackChanged.Event:Wait()
					end
					RunS.RenderStepped:Wait()
				end
			end,
		},
		[80]={
			["Type"]="ExTextButton",
			["Title"]="Auto Rescue",
			["Desc"]="Instantly rescues survivors. Requires To Be Alive and Interactable",
			["Shortcut"]="AutoRescue",
			["Default"]=false,
			["Options"]={
				[false]={
					["Title"]="OFF",
					["TextColor"]=newColor3(255),
				},
				["Close"]={
					["Title"]="CLOSE",
					["TextColor"]=newColor3(0,0,255),
				},
				["Far"]={
					["Title"]="FAR",
					["TextColor"]=newColor3(255, 255, 0),
				},
			},
			["ActivateFunction"]=function(newValue)
				for num, capsule in pairs(CS:GetTagged("Capsule")) do
					local PodTrigger = capsule:FindFirstChild("PodTrigger")
					if PodTrigger then
						local CapturedTorso = PodTrigger:FindFirstChild("CapturedTorso")
						if CapturedTorso and PodTrigger.Parent then
							setChangedProperty(
								CapturedTorso,
								"Value",newValue and function()
									C.AvailableHacks.Runner[80].RescueSurvivor(capsule)
								end or false)
							C.AvailableHacks.Runner[80].RescueSurvivor(capsule)
						end
					end
				end
			end,
			["CanActive"]=function(capsule)
				--print("CanActive Began")
				local MinTime = Random.new():NextNumber(1,3)
				local StartCountdown
				local Trigger=capsule:FindFirstChild("PodTrigger")
				while C.enHacks.AutoRescue and workspace:IsAncestorOf(Trigger) and Trigger.CapturedTorso.Value 
					and C.Beast and C.Beast.PrimaryPart do
					local Dist = (Trigger.Position - C.Beast:GetPivot().Position).Magnitude
					--print("Beast Dist",Dist)
					if (C.enHacks.AutoRescue=="Close" and Dist >= 14) or Dist >= 24 then
						if StartCountdown then
							if os.clock()-StartCountdown>=MinTime then
								return true
							end
						else
							StartCountdown = os.clock()
							--print("Started Timer!")
						end
					else
						StartCountdown = nil
						--print("Reset Timer!")
					end
					RunS.RenderStepped:Wait()
				end
			end,
			["RescueSurvivor"]=function(capsule,override)
				if not capsule or not capsule:FindFirstChild("PodTrigger")
					or not capsule.PodTrigger.CapturedTorso.Value then return end
				if not override and not C.AvailableHacks.Runner[80].CanActive(capsule) then return end
				if C.char:FindFirstChild("Hammer")~=nil or C.myTSM.Health.Value <= 0 then return end
				local Trigger=capsule:FindFirstChild("PodTrigger")
				if not Trigger then return end
				for s=5,1,-1 do
					if not workspace:IsAncestorOf(Trigger) then 
						break
					elseif Trigger.CapturedTorso.Value==nil then
						return true
					end
					local isOpened=Trigger.ActionSign.Value==11
					C.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
					C.RemoteEvent:FireServer("Input", "Action", true)
					if isOpened then
						C.RemoteEvent:FireServer("Input", "Trigger", false)
					end
					wait(.075)
					C.RemoteEvent:FireServer("Input", "Action", false)
					wait(.075)
				end
			end,
			["CapsuleAdded"]=function(capsule)
				task.wait(.5)
				local PodTrigger = capsule:WaitForChild("PodTrigger",10)
				if PodTrigger and PodTrigger:FindFirstChild("CapturedTorso") then
					setChangedProperty(
						PodTrigger.CapturedTorso,
						"Value",C.enHacks.AutoRescue and (function()
							C.AvailableHacks.Runner[80].RescueSurvivor(capsule)
						end) or false)
				end
			end,
		},
		[82]={
			["Type"] = "ExTextButton",
			["Title"] = "[BROKEN] Super Flop",
			["Desc"] = "Allows you to flop far and without limitations",
			["Shortcut"] = "Runner_SuperFlop",
			["Default"]=false,
			["DontActivate"]=true,
			["ActivateFunction"]=(function(newValue,passed)
				local RagdollValue = C.myTSM:WaitForChild("Ragdoll")
				local CharacterScriptInstance = C.char:WaitForChild("LocalPlayerScript")
				local CharacterScriptEnv = C.GetHardValue(CharacterScriptInstance,"env",{yield=true,noCache=true})
				if not CharacterScriptEnv then
					task.delay(1,C.AvailableHacks.Runner[82].ActivateFunction,C.enHacks.Runner_SuperFlop,true)
				end
				local tblUnpack = table.unpack
				C.Hook(CharacterScriptInstance,CharacterScriptEnv.FlopAction,"Runner_SuperFlop",newValue and RagdollValue.Value and (function(caller,args)
					local _,inputState = tblUnpack(args)
					if inputState == Enum.UserInputState.Begin then
						print("Flop:",inputState.Name)
						if not C.enHacks.Runner_SuperFlop then
							return
						end
						local Torso = C.char:FindFirstChild("Torso")
						if Torso then
							local bodyForce = Instance.new("BodyForce")
							local Direction = Torso.CFrame.p - workspace.Camera.CFrame.p
							local Force = Vector3.new(Direction.X, 0, Direction.Z)
							local Magnitude = Force.Magnitude
							if Magnitude~=0 then
								Force /= Magnitude
							end
							bodyForce.Force = (Force * 1e4) + 4e3 * Vector3.new(0,1,0)
							bodyForce.Parent = Torso
							DS:AddItem(bodyForce,.1)
						end

						return true--]]
					end
				end))--]]
			end),
			["MyStartUp"]=function()
				C.AvailableHacks.Runner[82].ActivateFunction(C.enHacks.Runner_SuperFlop)
			end,
			["MyPlayerAdded"]=function()
				task.wait(3)
				--local C.myTSM_Module = getscriptfunction(C.myTSM)
				local RagdollValue = C.myTSM:WaitForChild("Ragdoll")
				table.insert(C.functs,RagdollValue.Changed:Connect(function(new)
					--if C.myTSM_Module.Get("Ragdoll") then
					C.AvailableHacks.Runner[82].ActivateFunction(C.enHacks.Runner_SuperFlop)
					--end
				end))
			end,
		},
		[83]={
			["Type"]="ExTextButton",
			["Title"]="Anti Ragdoll",
			["Desc"]="Undoes your Ragdoll",
			["Shortcut"]="Runner_AntiRagdoll",
			["Default"]=false,
			["DontActivate"]=true,
			["ChangedFunction"]=function()
				--local RagdollConnections = C.GetHardValue(C.myTSM.Ragdoll,"Changed",{yield=true})

				if not C.myTSM.Ragdoll.Value or not C.enHacks.Runner_AntiRagdoll then
					CAS:UnbindAction("hack_jumpANTI_RAGDOLL"..C.saveIndex)
					if C.AvailableHacks.Runner[83].Funct then
						C.AvailableHacks.Runner[83].Funct:Disconnect()
						C.AvailableHacks.Runner[83].Funct=nil
					end
				elseif C.myTSM.Ragdoll.Value and C.enHacks.Runner_AntiRagdoll and not C.AvailableHacks.Runner[83].Funct then
					local lastGround
					local mySignal
					CAS:BindActionAtPriority("hack_jumpANTI_RAGDOLL"..C.saveIndex,jumpAction,false,9999999,Enum.KeyCode.Space)
					C.AvailableHacks.Runner[83].Funct = mySignal
					mySignal = jumpChangedEvent.Event:Connect(function(new)
						if not new then
							return
						end
						while isJumpBeingHeld and C.enHacks.Runner_AntiRagdoll and C.myTSM.Ragdoll.Value and not C.isCleared do
							if C.human.FloorMaterial ~= Enum.Material.Air and (not lastGround or os.clock()-lastGround>.25) then
								C.human:ChangeState(Enum.HumanoidStateType.Jumping)
								lastGround = os.clock()
							end
							RunS.RenderStepped:Wait()
						end
					end)
				end
				local human_state = C.human:GetState()
				if C.enHacks.Runner_AntiRagdoll and human_state == Enum.HumanoidStateType.Physics and C.myTSM.Ragdoll.Value then
					local orgCF,height = C.char:GetPivot()+Vector3.new(0,2),C.getHumanoidHeight(C.char)
					local result, hitPart = C.raycast(orgCF.Position,orgCF.Position-Vector3.new(0,1),{C.char},height+4,false,true)
					if result then
						teleportMyself((orgCF-orgCF.Position)+ result.Position+Vector3.new(0,height))
					end
					C.human.JumpPower = _SETTINGS.defaultCharacterJumpPower
					--C.human.WalkSpeed = 16
					while C.enHacks.Runner_AntiRagdoll and C.myTSM.Ragdoll.Value and C.human:GetState()~=Enum.HumanoidStateType.Running do
						C.human:ChangeState(Enum.HumanoidStateType.GettingUp)
						task.wait(.2)
					end

					--[[for num, connection in ipairs(RagdollConnections) do
						connection:Disable()
					end
					C.SetTempValue("Runner_AntiRagdoll",function(theirPlr,caller,instance_name,instance_value)
						print("FOund",caller)
						if theirPlr == plr and instance_name == "Ragdoll" and C.enHacks.Runner_AntiRagdoll then
							warn("Sp00f",instance_name)
							return false
						end
					end)
					for num, connection in ipairs(RagdollConnections) do
						if not C.enHacks.Runner_AntiRagdoll then break end
						connection:Fire(false)
					end
					C.SetTempValue("Runner_AntiRagdoll",nil)
					for num, connection in ipairs(RagdollConnections) do
						connection:Enable()
					end--]]
				elseif not C.enHacks.Runner_AntiRagdoll and C.myTSM.Ragdoll.Value then-- and human_state ~= Enum.HumanoidStateType.Physics then
					--[[for num, connection in ipairs(RagdollConnections) do
						print("Fired",num)
						connection:Fire(true)
					end--]]
					C.human:ChangeState(Enum.HumanoidStateType.Physics)
					C.human.JumpPower = 0
				end
			end,
			["ActivateFunction"]=function(newValue)
				--if newValue then
				C.AvailableHacks.Runner[83].ChangedFunction()
				--end
				setChangedProperty(C.human,"StateChanged",newValue and C.human.StateChanged:Connect(function()
					task.wait(1)
					C.AvailableHacks.Runner[83].ChangedFunction()
				end),"Runner_AntiRagdoll")
				--setChangedProperty(C.myTSM.Ragdoll,"Changed",newValue and C.myTSM.Ragdoll.Changed:Connect(C.AvailableHacks.Runner[83].ChangedFunction),"Runner_AntiRagdoll")
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Runner[83].ActivateFunction(C.enHacks.Runner_AntiRagdoll)
			end,
			["CleanUp"]=function()
				C.AvailableHacks.Runner[83].ChangedFunction()
			end,
		},
		[86]={
			["Type"]="ExTextButton",
			["Title"]="Auto Beast Troll",
			["Desc"]="Trolls beast automatically",
			["Shortcut"]="AutoTroll",
			["IsRunning"]=false,
			["Default"]=false,
			["CleanUp"]=(function()
				C.AvailableHacks.Runner[86].IsRunning=false
			end),
			["ActivateFunction"]=(function(enabled)
				if enabled then
					C.AvailableHacks.Runner[86].OthersBeastAdded()
				end
			end),
			["OthersBeastAdded"]=(function()
				if C.AvailableHacks.Runner[86].IsRunning then
					return
				end
				if C.Beast==C.char then
					return
				end
				C.AvailableHacks.Runner[86].IsRunning=true
				while C.AvailableHacks.Runner[86].IsRunning and C.Beast~=nil and workspace:IsAncestorOf(C.Beast) and C.enHacks.AutoTroll do
					local Trigger,dist=C.findClosestObj(CS:GetTagged("DoorTrigger"),C.Beast.HumanoidRootPart.Position,20,1.5)
					if Trigger~=nil and Trigger.Parent~=nil and Trigger:FindFirstChild("ActionSign")~=nil
						and Trigger.ActionSign.Value~=0 then--Trigger.ActionSign.Value==11 then
						--print("closed door")
						--C.RemoteEvent:FireServer("Input", "Action", false)
						--C.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
						--task.wait()
						--C.RemoteEvent:FireServer("Input", "Action", true)
						--C.RemoteEvent:FireServer("Input", "Trigger", false, Trigger.Event)
						--task.wait()
						--C.AvailableHacks.Blatant[10].CloseDoor(Trigger)
						local wasClosed = Trigger.ActionSign.Value ~= 11 
						C.AvailableHacks.Blatant[15].DoorFuncts[Trigger.Parent]()
						if wasClosed then
							task.wait(2/3)
							C.RemoteEvent:FireServer("Input", "Trigger", false)
						else
							RunS.RenderStepped:Wait()
						end
					else
						RunS.RenderStepped:Wait()
					end
				end
				C.AvailableHacks.Runner[86].IsRunning=false
			--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
			local myChar=C.char
			while myChar~=nil and workspace:IsAncestorOf(myChar) 
				and myChar.PrimaryPart~=nil and plr.Character==myChar and not C.isCleared do
				if C.Beast~=nil and C.Beast~=C.char  
					and C.enHacks.AutoCamp and TSM.Captured.Value then
					teleportMyself(CFrame.new(C.Beast.PrimaryPart.CFrame*newVector3(0,0,-3)))
					--C.AvailableHacks.Basic[12].TeleportFunction(C.Beast.PrimaryPart.CFrame*newVector3(0,0,-3))
				elseif not C.enHacks.AutoCamp then
					hackChanged.Event:Wait()
				else
					workspace.DescendantAdded:Wait() wait(1/3)
				end
				wait()
			end--]]
			end),
		},
		[90]={
			["Type"]="ExTextButton",
			["Title"]="Perma Slow Beast",
			["Desc"]="Perm Slows Beast when its not u",
			["Shortcut"]="PermSlowBeast",
			["Default"]=false,
			["ActivateFunction"]=function()
				if C.Beast~=nil and C.Beast~=C.char then
					C.AvailableHacks.Runner[90].OthersBeastAdded(nil,C.Beast);
				end;
			end,
			["OthersBeastAdded"] = function(nun,beastChar)
				local Humanoid=beastChar:WaitForChild("Humanoid",(_SETTINGS.waitForChildTimout))
				if ((not Humanoid) or ((Humanoid.Health) <=0)) then
					return
				end

				local function changeSpeed()
					local BeastPowers = beastChar:WaitForChild("BeastPowers", (_SETTINGS.waitForChildTimout));
					if (not BeastPowers) then
						return false;
					end
					local BeastEvent = BeastPowers:WaitForChild("PowersEvent", (_SETTINGS.waitForChildTimout)) ;
					if not BeastEvent then
						return false;
					end;
					if ((not C.enHacks.PermSlowBeast) or (not (workspace:IsAncestorOf(BeastEvent)))) then
						return false;
					end
					--if Humanoid.WalkSpeed ~= SlowWalkSpeed then
					BeastEvent:FireServer("Jumped");
					--end
					return true;
				end
				local setChangedPropertyUpdate_INPUT = (C.enHacks.PermSlowBeast and changeSpeed) ;
				--setChangedProperty(Humanoid,"WalkSpeed", setChangedPropertyUpdate_INPUT);
				while (C.enHacks.PermSlowBeast and (changeSpeed())) do
					RunS.RenderStepped:Wait()
				end;
			end,
			["OthersBeastRemoved"] = function(nun,beastChar)
				if beastChar==nil then
					return
				end
				local Humanoid = beastChar:WaitForChild("Humanoid", 20)
				if Humanoid==nil or Humanoid.Health<=0 then
					return
				end
				setChangedProperty(Humanoid,"WalkSpeed",nil)
			end,
		},

	},
	["Bot"] = {
		[15] = {
			["Type"] = "ExTextButton",
			["Title"] = "Bot Farm",
			["Desc"] = "Automatically Bot Farms as Runner",
			["Shortcut"]="BotRunner",
			["Default"]=_SETTINGS.MyDefaults.BotFarmRunner, -- _SETTINGS.MyDefaults.BotFarmRunner
			["DontActivate"]=true,
			["CurrentPath"]=nil,
			["CurrentTarget"]=nil,
			["Options"] = {
				[false] = {
					["Title"]="OFF",
					["TextColor"]=(newColor3(255, 0, 0))
				},
				["Hack"] = {
					["Title"]="HACK",
					["TextColor"]=(newColor3(255, 180, 0)),
				},
				["Freeze"] = {
					["Title"]="FREEZE",
					["TextColor"]=(newColor3(0, 170, 255)),
				},
			},
			["MapData"] = ({


			}),
			["AvoidParts"]={},
			["CurrentNum"]=0,
			["DidAction"]=false,
			--["CanRun"]=nil,
			["ChangedEvent"]=(Instance.new("BindableEvent",script)),
			["WalkPath"]=(function(path,target,checkFunct)
				path:Stop()
				local updatedTarget = (typeof(target)=="Instance" and (target:GetAttribute("WalkToPoso") or target.Position) or target)
				local event = C.AvailableHacks.Bot[15].ChangedEvent
				C.AvailableHacks.Bot[15].DidAction = false
				C.AvailableHacks.Bot[15].CurrentTarget = target

				if isTeleportingAllowed then
					local setVector3 = updatedTarget+newVector3(0,C.getHumanoidHeight(C.char))
					local setCFrame = CFrame.new(setVector3)
					if (typeof(target)=="Instance") then
						setCFrame = target.CFrame--CFrame.new(C.char.Position,Vector3.new(setVector3.X,setVector3.Y,setVector3.Z))
					end
					teleportMyself(setCFrame)
					return true
				end

				local startLoc=C.char.Torso.Position

				local isWaiting,start,lastTrigger = true, os.clock(), 0
				local Torso = C.char:FindFirstChild("Torso")
				local function taskSpawnFunction()
					while true do
						if not isWaiting or not Torso or not Torso.Parent then
							break
						end
						local currentPoso=Torso.Position
						if os.clock()-start>3 
							or (checkFunct and not checkFunct())then
							if os.clock()-start>3 and (startLoc-C.char.Torso.Position).Magnitude<4 then
								for s=1,2 do
									C.declareError(path, path.ErrorType.AgentStuck)
								end
							end
							event:Fire(false,false) break 
						end
						if os.clock()-lastTrigger>=1.5 then
							task.spawn(path.Run,path,updatedTarget)
							lastTrigger=os.clock()
							startLoc=C.char.Torso.Position
						end
						task.wait(.15)
					end
				end
				task.spawn(taskSpawnFunction)
				local result,canRun=event.Event:Wait()
				--local results=event.Event:Wait() 
				--if results then
				--	
				--end
				--isWaiting=false
				--return results
				isWaiting=false

				if not canRun and C.char.Parent then
					if C.char.HumanoidRootPart then
						C.human:MoveTo(C.char.HumanoidRootPart.Position)
					end
					return false
				elseif result then
					path:Stop() task.wait()
					--C.human:MoveTo(updatedTarget)
					C.AvailableHacks.Bot[20].Funct(path,updatedTarget)
				end
				return result or ((updatedTarget-C.char.HumanoidRootPart.Position)/newVector3(1,4,1)).magnitude<2
			end),
			["UnlockDoor"]=function(shouldWait)
				if C.isActionProgress then
					return false
				end
				local TSM = plr:WaitForChild("TempPlayerStatsModule")
				local ActionSign 
				--if not skipWait and ActionSign==nil then --print("searching") 
				for s=60,1,-1 do

					--for num,part in pairs(C.char.Torso:GetTouchingParts()) do
					local firstHalf = TSM.ActionEvent.Value~=nil and TSM.ActionEvent.Value.Parent and TSM.ActionEvent.Value.Parent.Parent
					ActionSign=firstHalf and string.find(TSM.ActionEvent.Value.Parent.Parent.Name,"Door")~=nil and TSM.ActionEvent.Value.Parent:FindFirstChild("ActionSign")--part:FindFirstChild("ActionSign")
					--if ActionSign~=nil then break end
					--end
					--local hit=C.char.Torso.Touched:Wait() task.wait()
					--ActionSign=hit:FindFirstChild("ActionSign")
					--print("touch set!")
					if ActionSign or not shouldWait then
						break
					end
					task.wait() --print("reset")
				end
				--end
				if ActionSign then
					local Trigger=ActionSign.Parent
					if true then
						C.isActionProgress=true C.AvailableHacks.Bot[15].DidAction=true
						if TSM.ActionEvent.Value~=nil and (ActionSign.Value==10 or ActionSign.Value==12) then
							VU:SetKeyDown("e") 
							wait()  
							VU:SetKeyUp("e") 
							TSM.ActionProgress.Changed:Wait()
						end --print("opening!",shouldWait)
						while TSM.ActionProgress.Value%1~=0 and TSM.ActionProgress.Value~=1 do
							TSM.ActionProgress.Changed:Wait()
						end
						local function inputDetectionFunction()
							if ActionSign.Value%1==0 then
								ActionSign.Changed:Wait()
							end
							local Event=Trigger:FindFirstChild("Event")
							for s=3,1,-1 do--tries a few times, otherwise exits
								if Event~=nil and Event==TSM.ActionEvent.Value then
									VU:SetKeyDown("e")
									wait()  
									VU:SetKeyUp("e")
								end
								task.wait()
							end
						end
						task.spawn(inputDetectionFunction)
						C.isActionProgress=false
						return true
					end
				end 
				return false
			end,
			["CrawlVent"]=(function(shouldWait)
				local Torso = C.char:WaitForChild("Torso")
				for TimesLeft = 30, 1, -1 do
					local getTouchingPartsList = Torso:GetTouchingParts()
					for num,part in ipairs(getTouchingPartsList) do
						if part.Name=="VentPartWalkThru" then
							C.AvailableHacks.Beast[2].Crawl(true)
							task.wait(.4)
							local startCrawlTime=os.clock()
							while ((table.find(Torso:GetTouchingParts(),part)~=nil) and (os.clock()-startCrawlTime < 2)) do --((part.Position-Torso.Position)/newVector3(0,math.huge,0)).magnitude<.5
								task.wait()
							end
							C.AvailableHacks.Blatant[(2)].Crawl(false)
							return true
						end
					end
					if not shouldWait then
						return false
					end
					task.wait()
				end
				return false
			end),
			["noComputeStuck"]=function()
				C.human:MoveTo(C.char.Torso.CFrame*(5*Random.new():NextUnitVector()))
				wait(1/3)
			end,
			["getGoodTriggers"]=function(pc,onlyHacks95)
				local screen = pc:FindFirstChild("Screen")
				if ((screen.Color.G*255)<128) and ((screen.Color.G*255)>126) 
					or (not onlyHacks95 and (pc:GetAttribute("Progress") or 0) > .95 ) then--check if its green, meaning no hack hecked pcs!
					return {}
				end
				local list={}
				for num,triggerName in pairs(({"ComputerTrigger1","ComputerTrigger2","ComputerTrigger3"})) do
					local trigger=pc:FindFirstChild(triggerName)
					local canContinue1 = (trigger~=nil and trigger.Parent~=nil and C.Map~=nil and workspace:IsAncestorOf(trigger))
					if canContinue1 then
						if (screen~=nil and trigger:FindFirstChild("ActionSign")~=nil and trigger.ActionSign.Value==20 and not trigger:GetAttribute("Unreachable"..C.saveIndex)) then
							table.insert(list,trigger)
						end
					end
				end
				return list
			end,
			["RUNNERHack"]=function(TSM,currentPath,savedDeb)
				local canRun;
				function canRun(fullLoop)
					local Check1 = C.enHacks.BotRunner=="Hack" and C.char~=nil and C.human~=nil and C.human.Health>0 and camera.CameraSubject==C.human;
					local Check2 = savedDeb==C.AvailableHacks.Bot[15].CurrentNum and C.char:FindFirstChild("HumanoidRootPart");
					local Check3 = select(2,C.isInGame(C.char,true))=="Runner" and not C.isCleared;--(not fullLoop or select(2,C.isInGame(C.char,true))=="Runner") and not C.isCleared;
					return Check1 and Check2 and Check3;
				end
				C.AvailableHacks.Bot[15].CanRun=canRun;

				local InGameOwnershipPlrs = {}
				for num, theirPlr in ipairs(PS:GetPlayers()) do
					if _SETTINGS.owernshipUsers[theirPlr.Name:lower() or ""] then
						print("[Bot Runner]:",theirPlr,"is an OWNERSHIP plr!")
						table.insert(InGameOwnershipPlrs,theirPlr)
					end
				end

				local function getComputerTriggers()
					local triggers = {}
					for num,pc in ipairs(CS:GetTagged("Computer")) do
						for num,goodTrigger in pairs(C.AvailableHacks.Bot[15].getGoodTriggers(pc,#InGameOwnershipPlrs>0)) do
							table.insert(triggers,goodTrigger)
						end
					end 
					if #triggers==0 and RS.IsGameActive.Value then 
						C.AvailableHacks.Bot[15].noComputeStuck() 
					end
					return triggers
				end
				local function getExitDoors()
					local exitAreas = {}
					for num,exit in ipairs(CS:GetTagged("Exit")) do
						local exitArea = exit:FindFirstChild("ExitArea")
						if exitArea~=nil and not exitArea:GetAttribute("Unreachable"..C.saveIndex) then
							table.insert(exitAreas,exitArea)
						end
					end 
					if #exitAreas == 0 and RS.IsGameActive.Value then 
						C.AvailableHacks.Bot[15].noComputeStuck() 
					end
					return exitAreas
				end
				C.AvailableHacks.Beast[2].Crawl(UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.ButtonL2))
				while canRun(true) do
					C.human:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
					while #CS:GetTagged("Computer")==0 do
						--print("[Bot Runner]: Waiting For Computers!")
						C.human:Move(newVector3())
						CS:GetInstanceAddedSignal("Computer"):Wait()
						task.wait()
						task.spawn(function()
							C.AvailableHacks.Beast[2].Crawl(C.AvailableHacks.Beast[2].IsCrawling) --RS.IsGameActive.Changed:Wait() --wait(1)
						end)
					end
					while canRun(true) and (RS.CurrentMap.Value==nil or RS.CurrentMap.Value==TS) do
						print("[Bot Runner]: Waiting For Map!")
						RS.CurrentMap.Changed:Wait()
					end
					--print(#CS:GetTagged("Computer"),string.sub(RS.GameStatus.Value,1,2),string.sub(RS.GameStatus.Value,1,2)=="15")
					if C.Beast and _SETTINGS.owernshipUsers[C.Beast.Name:lower() or ""] then
						print("Owner Player Detected")
						C.AvailableHacks.Bot[15].GetFreeze(canRun,false)
					elseif RS.ComputersLeft.Value>0 or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15") then--hack time :D
						local closestTrigger,dist=C.findClosestObj(getComputerTriggers(),C.char:FindFirstChild("HumanoidRootPart").Position,3000,6)
						while canRun() and closestTrigger~=nil and (RS.ComputersLeft.Value>0 or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15")) do --print("found trigger")
							local ActionSign=closestTrigger:FindFirstChild("ActionSign")
							local function walkPathFunct()
								return ActionSign~=nil and ActionSign.Value==20 and canRun()
							end
							local didReach=TSM.CurrentAnimation.Value=="Typing" or C.AvailableHacks.Bot[15].WalkPath(currentPath, closestTrigger, walkPathFunct)
							local distance=(closestTrigger.Position-C.char.Torso.Position).magnitude
							C.human:SetAttribute("OverrideSpeed",distance<13 and 35 or nil)
							if didReach or (closestTrigger.Position-C.char.Torso.Position).magnitude<2 or (TSM.ActionEvent.Value~=nil and closestTrigger:IsAncestorOf(TSM.ActionEvent.Value)) and ActionSign~=nil and ActionSign.Value==20 then--and table.find(closestTrigger:GetTouchingParts(),C.char:FindFirstChild("HumanoidRootPart")) ~=nil then
								--print(TSM.ActionEvent.Value,TSM.CurrentAnimation.Value)
								--effective way of making the server wait!
								task.wait(.45)
								if TSM.CurrentAnimation.Value~="Typing" and (TSM.ActionEvent.Value==nil or plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("ActionBox").Text~="Hack")and closestTrigger.ActionSign.Value==20 then
									--C.AvailableHacks.Basic[12].TeleportFunction(CFrame.new(closestTrigger.Position-newVector3(0,C.human.HipHeight+C.char.Torso.Size.Y/2,0),closestTrigger.Parent:FindFirstChild("HumanoidRootPart").Position))
									C.human:MoveTo(closestTrigger.Position)
									C.human:ChangeState(Enum.HumanoidStateType.Jumping)
									task.wait(.6)
								end
								local screen=closestTrigger.Parent:FindFirstChild("Screen")
								while canRun() and closestTrigger and closestTrigger.Parent and TSM.ActionEvent.Value~=nil and closestTrigger.ActionSign.Value==20 and TSM.CurrentAnimation.Value~="Typing" and not (screen.Color.G*255<128 and screen.Color.G*255>126) do
									local distTraveled=(lastHackedPosition-closestTrigger.Position).Magnitude
									local timeElapsed=os.clock()-computerHackStartTime
									local minHackTimeBetweenPCs = (0.15+math.max(distTraveled/_SETTINGS.minSpeedBetweenPCs,lastHackedPC==closestTrigger.Parent and 0 or _SETTINGS.absMinTimeBetweenPCs))
									if lastHackedPC~=closestTrigger.Parent and timeElapsed<minHackTimeBetweenPCs then
										timeElapsed = timeElapsed + (task.wait(minHackTimeBetweenPCs-timeElapsed))
									else
										print("Attempting to hack",closestTrigger.Parent.Name .."/"..closestTrigger.Parent.Parent.Name, "\nTime Elapsed:", math.round(timeElapsed*100)/100,"s".."\nDistance Traveled:",math.round(distTraveled*100)/100 .. "\nAvg Velocity:",math.round((distTraveled/timeElapsed)*100)/100)
										VU:SetKeyDown("e") --print("force 'e'")
										task.wait(.1)
										VU:SetKeyUp("e")
										task.wait(1/3)
									end
								end --print("hacking ", closestTrigger.Parent:GetFullName())
								--if TSM.CurrentAnimation.Value=="Typing" then
								task.wait(1)
								if canRun() and TSM.CurrentAnimation.Value=="Typing" then
									while canRun() and TSM.CurrentAnimation.Value=="Typing" do
										task.wait(1/3)
										if (#InGameOwnershipPlrs>0 and TSM.ActionProgress.Value > .95) then
											stopCurrentAction()
										end
										computerHackStartTime=os.clock() 
										lastHackedPosition=closestTrigger.Position
									end
								end

							end
							if C.char:FindFirstChild("HumanoidRootPart")~=nil then
								closestTrigger,dist=C.findClosestObj(C.AvailableHacks.Bot[15].getGoodTriggers(closestTrigger.Parent,#InGameOwnershipPlrs>0),C.char:FindFirstChild("HumanoidRootPart").Position,3000,1)
							end
							task.wait(0)
						end
						--print(C.AvailableHacks.Bot[15].WalkPath(currentPath,
						--	C.char:FindFirstChild("HumanoidRootPart").CFrame*newVector3(0,0,-15)))
					else--escape time :D
						local closestExitArea,dist=C.findClosestObj(getExitDoors(),(C.char:FindFirstChild("HumanoidRootPart") and C.char:FindFirstChild("HumanoidRootPart").Position or newVector3()),3000,1)
						while canRun() and closestExitArea~=nil and not closestExitArea:GetAttribute("Unreachable"..C.saveIndex) do
							local exitDoor = closestExitArea.Parent
							if exitDoor:FindFirstChild("ExitDoorTrigger") and (exitDoor.ExitDoorTrigger.ActionSign.Value == 12 or exitDoor.ExitDoorTrigger.ActionSign.Value == 10)
								and C.AvailableHacks.Blatant[15].DoorFuncts[exitDoor] and C.isInGame(C.char,true) and C.isInGame(C.char) then
								trigger_setTriggers("BotRunner",{Exit=false})
								C.AvailableHacks.Blatant[15].DoorFuncts[exitDoor](true,true)
							end
							local didReach=C.AvailableHacks.Bot[15].WalkPath(currentPath,closestExitArea,canRun)
							RunS.RenderStepped:Wait()
							while ((table.find(workspace:GetPartsInPart(C.char.HumanoidRootPart),closestExitArea)) and C.isInGame(C.char,true) and C.isInGame(C.char)
								and (not exitDoor:FindFirstChild("ExitDoorTrigger") 
									or (exitDoor.ExitDoorTrigger.ActionSign.Value ~= 12 and exitDoor.ExitDoorTrigger.ActionSign.Value ~= 10))) do
								trigger_setTriggers("BotRunner",true)
								if C.human.FloorMaterial~=Enum.Material.Air then
									C.human:ChangeState(Enum.HumanoidStateType.Jumping)
									teleportMyself(C.char:GetPivot() * CFrame.new(0,0,-2))
								end
								task.wait(1/6)
							end
							wait(0)
						end
					end
					RunS.RenderStepped:Wait()
				end
				C.human:SetAttribute("OverrideSpeed",nil)
				C.human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
			end,
			["RUNNERFreeze"]=function(TSM,currentPath,savedDeb)
				local runnerPlrs={}
				local warningPrint = true
				local myRunerPlrKey
				local function canRun(fullLoop)
					local plrs = {}
					for num, theirPlr in ipairs(PS:GetPlayers()) do
						if theirPlr and theirPlr.Character and select(2,C.isInGame(theirPlr.Character,true))=="Runner" then
							table.insert(plrs,theirPlr)
						end
					end
					runnerPlrs = C.sortPlayersByXPThenCredits(plrs)
					myRunerPlrKey = table.find(runnerPlrs,plr)
					--if Random.new():NextInteger(1,18)==1 then
					--	print(C.enHacks.BotRunner,savedDeb==C.AvailableHacks.Bot[15].CurrentNum,camera.CameraSubject==C.human,TSM.Escaped.Value,C.char:FindFirstChild("HumanoidRootPart"))
					--end
					--if true then
					--error("CanRunBro")
					--end

					local Ret1 = (C.enHacks.BotRunner=="Freeze" and C.char and C.human and C.human.Health>0 and camera.CameraSubject==C.human and savedDeb==C.AvailableHacks.Bot[15].CurrentNum and C.char:FindFirstChild("HumanoidRootPart") and C.Beast and C.Beast:FindFirstChild("HumanoidRootPart"))
					local Ret2 = ((select(2,C.isInGame(C.char,true))=="Runner") and not C.isCleared)
					local Ret3 = C.Beast and _SETTINGS.myBots[C.Beast.Name:lower()]
					if not Ret3 and C.Beast and warningPrint then
						C.createCommandLine("Freeze Disabled: Unrecognized Player",print)
						warningPrint = false
					end
					return (Ret1 and Ret2 and Ret3)
					--and not TSM.DisableInteraction.Value
				end
				task.spawn(function()
					while canRun(true) and not plr:GetAttribute("HasRescued") do
						local GuyToRescueIndex = (myRunerPlrKey%#runnerPlrs)+1--gets next index and loops over array
						local myGuyToRescuePlr = runnerPlrs[GuyToRescueIndex]
						if myGuyToRescuePlr and myGuyToRescuePlr.TempPlayerStatsModule.Captured.Value then
							local targetCapsule
							for num, capsule in pairs(CS:GetTagged("Capsule")) do
								if capsule:FindFirstChild("PodTrigger")~=nil and capsule.Parent then
									local capturedTorso = capsule.PodTrigger.CapturedTorso.Value
									if capturedTorso and capturedTorso.Parent and capturedTorso:IsDescendantOf(myGuyToRescuePlr.Character) then
										targetCapsule=capsule
										break
									end
								end
							end
							if targetCapsule and C.AvailableHacks.Runner[80].RescueSurvivor(targetCapsule,true) then
								return plr:SetAttribute("HasRescued",true)
							end
						end
						RunS.RenderStepped:Wait()
					end
				end)
				local function canCapture()
					local keyNeeded = 0
					for key, theirPlr in ipairs(runnerPlrs) do
						if not theirPlr:GetAttribute("HasCaptured") then
							keyNeeded = key
						end
					end
					return (myRunerPlrKey==keyNeeded and not plr:GetAttribute("HasCaptured")) or plr:GetAttribute("HasRescued") or #runnerPlrs==1
				end
				C.AvailableHacks.Bot[15].GetFreeze(canRun,canCapture)
			end,
			["GetFreeze"]=function(canRun,canCapture)
				local CarriedTorso = StringWaitForChild(C.Beast,"CarriedTorso",10)
				local currentPath = C.AvailableHacks.Bot[15].CurrentPath
				while canRun(true) and CarriedTorso do
					C.human:SetAttribute("OverrideSpeed",((C.Beast:GetPivot().Position-C.char:GetPivot().Position).Magnitude<16 and 25 or 42))
					local inRange = (C.Beast:GetPivot().Position-C.char:GetPivot().Position).Magnitude<6
					if not inRange and not C.myTSM.Captured.Value and (not C.myTSM.Ragdoll.Value or (CarriedTorso and CarriedTorso.Value~=(C.char and C.char.Parent))) then
						local didReach=C.AvailableHacks.Bot[15].WalkPath(currentPath,C.Beast:GetPivot()*newVector3(0,0,-4),canRun)
					end
					local i = 0
					while (canRun(true) and (C.Beast and C.Beast:FindFirstChild("HumanoidRootPart")) and ((C.Beast:GetPivot().Position-C.char:GetPivot().Position).Magnitude<7)) do
						-- or TSM.Ragdoll.Value))  do
						i+=1
						if i==10 then
							i = 0
						elseif i>1 then
							RunS.RenderStepped:Wait()
						end
						if not canCapture or canCapture() then
							--task.wait(1/2)
							if not canRun(true) then
								return
							end
							local HammerEvent = StringWaitForChild(C.Beast,"Hammer.HammerEvent",25)
							if not C.myTSM.Ragdoll.Value and C.Beast and C.Beast.Parent and C.char:FindFirstChild("Head") then
								HammerEvent:FireServer("HammerHit", C.char.Head)
								--task.wait(1/4)
							end
							if not canRun(true) then
								return
							end
							if C.myTSM.Ragdoll.Value and C.Beast and C.Beast.Parent and (CarriedTorso and CarriedTorso.Value~=(C.char and C.char.Parent)) then
								--teleportMyself(C.Beast:GetPivot()*CFrame.new(0,0,2))
								--RunS.RenderStepped:Wait()
								C.AvailableHacks.Beast[55].RopeSurvivor(C.myTSM,plr,true)
								--task.wait(1/2)
								--if C.Beast.CarriedTorso.Value and C.Beast.CarriedTorso.Value.Parent==C.char then
								--	C.AvailableHacks.Beast[60].CaptureSurvivor(plr,C.char,true)
								--end
							end
						end
						--if C.human.FloorMaterial~=Enum.Material.Air then
						--	C.human:ChangeState(Enum.HumanoidStateType.Jumping)
						--end
						--task.wait(1/6)
					end
					RunS.RenderStepped:Wait()
					--while C.myTSM.DisableCrawl.Value do
					--C.myTSM.DisableCrawl.Changed:Wait()
					--end
				end
			end,
			["ActivateFunction"]=function()
				--print("Bot Function Activated")
				trigger_setTriggers("BotRunner",true)
				local saveValue = C.enHacks.BotRunner
				C.human:SetAttribute("OverrideSpeed",nil)
				local currentPath=C.AvailableHacks.Bot[15].CurrentPath
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				if currentPath==nil then 
					error("no path found!") 
					return 
				end
				currentPath:Stop()
				C.AvailableHacks.Bot[15].ChangedEvent:Fire(false,false) 
				if not C.enHacks.BotRunner then
					--print("b1")
					C.human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
					return 
				end
				local maxDurationLeft = 45
				local start = os.clock()
				while true do--for s=180,1,-1 do
					if C.isCleared or C.enHacks.BotRunner ~= saveValue then 
						return false 
					end
					local inGame,role = C.isInGame(C.char)
					--print(role,C.enHacks.BotRunner,C.Beast,C.myTSM.Health.Value)
					if role=="Runner" and (saveValue~="Freeze" or (C.Beast and C.Beast:FindFirstChild("HumanoidRootPart"))) then
						--print("Bot "..saveValue.." Runner Activated After "..math.round(os.clock()-start).."/s=")
						break
					elseif maxDurationLeft <= 0 then 
						return false
					end
					maxDurationLeft-=RunS.RenderStepped:Wait() --task.wait(.25)
				end
				if C.enHacks.BotRunner ~= saveValue then
					--print("no save")
					return false
				end
				local savedValue=C.AvailableHacks.Bot[15].CurrentNum + 1
				C.AvailableHacks.Bot[15].CurrentNum = savedValue
				RunS.RenderStepped:Wait()--maybe wait a frame just in case, yk?
				if C.enHacks.BotRunner ~= saveValue then
					--print("no save2")
					return false
				end
				C.AvailableHacks.Bot[15]["RUNNER"..saveValue](TSM,currentPath,savedValue)
			end,
			["MyStartUp"]=function(myPlr,myChar)

				C.isActionProgress=false;
				local Torso=C.char:WaitForChild("Torso",30) ;
				if not Torso then 
					return;
				end
				local TSM = plr:WaitForChild("TempPlayerStatsModule");
				local Errors=0;
				local pathTable = {
					AgentCanJump=true,
					WaypointSpacing=7,
					AgentHeight=6.5,
					Costs = {
						DoorPath = 3,
						DoorOpened=1,
						Vent=1,
						Window=1,
						Beast = math.huge,
						NoWalkThru = math.huge
					};
				};
				local newPath = Path.new(myChar, pathTable);
				newPath.Visualize = true;
				table.insert(C.functs,newPath.Reached:Connect(function(agent,lastWayPoint)
					--print("reached!")
					if lastWayPoint and lastWayPoint.Position~=nil then
						C.human:MoveTo(lastWayPoint.Position)
					end
					Errors=0--math.max(0,Errors-.2)
					C.AvailableHacks.Bot[15].ChangedEvent:Fire(true,true)
				end));
				table.insert(C.functs,newPath.Blocked:Connect(function(myChar,wayPoint)
					if RS.IsGameActive.Value then
						C.AvailableHacks.Bot[15].noComputeStuck()
					end
				end))
				local function waypointReached(agent,lastWayPoint,nextWayPoint)
					Errors=math.max(0,Errors-.2);
					if C.isActionProgress or not C.char:FindFirstChild("HumanoidRootPart") then
						return false;
					end;
					local from=Torso.Position;
					local to = nextWayPoint.Position+newVector3(0,C.getHumanoidHeight(C.char),0);

					local didHit,instance=C.raycast(from,to,{"Whitelist",table.unpack(CS:GetTagged("DoorAndExit"))},5,0.001,true);
					local didHit2,instance2=C.raycast(from,to,{"Whitelist",C.Map},5,0.001,true);
					if nextWayPoint.Label=="DoorPath" or (didHit and (CS:HasTag(instance.Parent,"DoorAndExit") or CS:HasTag(instance.Parent.Parent,"DoorAndExit") or CS:HasTag(instance.Parent.Parent.Parent,"DoorAndExit"))) then
						return C.AvailableHacks.Bot[15].UnlockDoor(true);
					elseif (nextWayPoint.Label=="Vent" or (didHit2 and instance2.Name~="VentPartWalkThru") ) then
						return C.AvailableHacks.Bot[(15)].CrawlVent(true);
					elseif (to.Y>C.char:FindFirstChild("HumanoidRootPart").Position.Y and C.human.FloorMaterial~=Enum.Material.Air and not C.AvailableHacks.Blatant[(2)].IsCrawling and not C.isActionProgress) or nextWayPoint.Label=="Window" or (instance2~=nil and instance2.Name=="WindowWalkThru") then
						C.human:ChangeState(Enum.HumanoidStateType.Jumping);
						return true;
					end;
					return false;
				end;
				newPath.WaypointReached:Connect(waypointReached);
				table.insert(C.functs,TSM.ActionEvent.Changed:Connect(function(event)
					local path = C.AvailableHacks.Bot[(15)].CurrentPath
					if not C.isActionProgress and path~=nil and path._status==Path.StatusType.Active and event~=nil and string.find(event.Parent.Name,"DoorTrigger")~=nil and C.AvailableHacks.Bot[15].CurrentTarget~=nil then
						task.wait(3/5) --3/5s compromise APUSH letsgo
						local lastPath = path._currentWaypoint-1
						waypointReached(C.char,(path._waypoints[(1<lastPath) and (lastPath) or 1]),(path._waypoints[((#path._waypoints>=path._currentWaypoint) and path._currentWaypoint) or 1]))
					end
				end))
				local compCount = 0
				newPath.Error:Connect(function(errorType)
					if errorType == Path.ErrorType.ComputationError then
						--newPath:Run(C.AvailableHacks.Bot[15].CurrentTarget
						C.AvailableHacks.Bot[15].ChangedEvent:Fire(false,true)
						local failedTarget = C.AvailableHacks.Bot[15].CurrentTarget
						if (typeof(failedTarget)=="Instance") then
							local current=failedTarget:GetAttribute(("Unreachable"..C.saveIndex))
							failedTarget:SetAttribute(("Unreachable"..C.saveIndex),(current~=nil and (current+1) or 1))
							--print("set ",failedTarget:GetFullName(), "unreachable!")
							local function delayedFunction()
								if not workspace:IsAncestorOf(failedTarget) then 
									return
								end
								current=failedTarget:GetAttribute("Unreachable"..C.saveIndex)
								if current~=nil then
									failedTarget:SetAttribute("Unreachable"..C.saveIndex,current>1 and current-1 or nil)
								end
								--print("down ",failedTarget:GetFullName(), "to",tostring(current>1 and current-1 or nil))
							end
							delay(4,delayedFunction)
						elseif (compCount>=5) then
							errorType = Path.ErrorType.AgentStuck
							compCount = 0
						else
							compCount = compCount + 1
						end
					end
					if errorType == Path.ErrorType.AgentStuck then
						--and #newPath._waypoints>=newPath._currentWaypoint+1 then
						--local wayPoint=newPath._waypoints[newPath._currentWaypoint+1]
						--local newPart=Instance.new("Part")
						--newPart.Size=newVector3(2,2,2)
						--newPart.Transparency=.6
						--newPart.Anchored=true
						--newPart.CanCollide=false
						--newPart.Position=wayPoint.Position
						--newPart.Parent=workspace
						--C.createModifer(newPart,"NoWalkThru",false)
						Errors = Errors + 1;
						if Errors==3 then
							print("LEFT / err bruh",Errors);
							C.human:MoveTo(C.char:FindFirstChild("HumanoidRootPart").CFrame*newVector3(-4,0,0));
						elseif Errors>=10 then
							print("RESET / err bruh",Errors);
							C.AvailableHacks.Commands[24].ActivateFunction();
						else
							print("err bruh",Errors);
						end;
					end;
				end)
				local function TorsoTouched(hit)
					if hit.Name=="WindowWalkThru" and Path~=nil and C.AvailableHacks.Bot[15].CurrentTarget~=nil and C.human~=nil and C.human.Health>0 and C.human.FloorMaterial~=Enum.Material.Air then
						C.human:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end
				table.insert(C.functs,Torso.Touched:Connect(TorsoTouched))
				C.AvailableHacks.Bot[15].CurrentPath=newPath
				C.AvailableHacks.Bot[15].ActivateFunction(C.enHacks.BotRunner)
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				local capturedValue = TSM:WaitForChild("Captured",30)
				if not capturedValue then
					return
				end
				local function CaptureChanged()
					if not capturedValue.Value and C.human and theirPlr==plr then
						C.human:ChangeState(Enum.HumanoidStateType.Landed)
					end
					theirPlr:SetAttribute("HasCaptured",true)
				end
				table.insert(C.functs,capturedValue.Changed:Connect(CaptureChanged))
			end,
			["MyPlayerAdded"]=function()
				local function EscapeChanged()
					if not C.myTSM.Escaped.Value and C.enHacks.BotRunner then
						C.AvailableHacks.Bot[15].ActivateFunction(true)
					end
				end
				local function HealthChanged()
					--print("Health Changed",TSM.Health.Value,TSM.Escaped.Value,C.AvailableHacks.Bot[15].IsRunning)
					if C.myTSM.Health.Value>0 and not C.myTSM.Escaped.Value and C.enHacks.BotRunner and not C.AvailableHacks.Bot[15].IsRunning then
						--print("Activation Started")

						C.AvailableHacks.Bot[15].ActivateFunction(true)
						--warn("Activation Failed")
					end
				end
				table.insert(C.functs,C.myTSM.Escaped.Changed:Connect(EscapeChanged))
				table.insert(C.functs,C.myTSM.Health.Changed:Connect(HealthChanged))
				C.AvailableHacks.Bot[15].OthersPlayerAdded(plr)
			end,
			["DoorAdded"]=function(door)
				local doorTrigger=door.Name~="ExitDoor" and door:WaitForChild("DoorTrigger") or door:WaitForChild("ExitDoorTrigger",1e5)
				if not doorTrigger then 
					return 
				end
				local ActionSign=door.Name=="ExitDoor" and doorTrigger:FindFirstChild("ActionSign") or doorTrigger:WaitForChild("ActionSign",1e5)
				if not ActionSign then 
					return 
				end
				local exitArea=door.Name=="ExitDoor" and door:WaitForChild("ExitArea")
				local walkThruPart=doorTrigger:Clone() 
				walkThruPart:ClearAllChildren()
				C.RemoveAllTags(walkThruPart)
				walkThruPart.Name="WalkThru"
				walkThruPart.Parent=door
				walkThruPart.Transparency=_SETTINGS.hitBoxesEnabled and .6 or 1
				walkThruPart.Size=door.Name=="ExitDoor" and newVector3(6,7,8.6) or newVector3(3,7,2.25)--walkThruPart.Size+=newVector3(-.5,4,0)
				CS:AddTag(walkThruPart,"WalkThruDoor")
				local currentPoso=walkThruPart.Position
				if door.Name=="ExitDoor" then
					local setPoso=doorTrigger.Position:lerp(exitArea.Position,.4)
					walkThruPart.Position=newVector3(setPoso.X,doorTrigger.Position.Y,setPoso.Z)
					walkThruPart.Size=newVector3(6,7,(doorTrigger.Position-exitArea.Position).magnitude/2+5.5)
					exitArea:SetAttribute("Unreachable"..C.saveIndex,nil)
				end

				--if C.Map.Name=="Homestead by MrWindy" and door.Name=="ExitDoor" then
				--print("set homestead exit!")
				--walkThruPart.Position=walkThruPart.Position:lerp(newVector3(door.ExitArea.Position.X,currentPoso.Y,currentPoso.Z),1/5)
				--end

				--print(doorTrigger.Orientation.Y,math.fmod(math.abs(doorTrigger.Orientation.Y),180))
				if  math.fmod(math.abs(doorTrigger.Orientation.Y),180)==0 then
					walkThruPart.CFrame=CFrame.new(walkThruPart.Position+newVector3(0,2,0))*CFrame.Angles(0,math.rad(90),0)
				else
					walkThruPart.CFrame=CFrame.new(walkThruPart.Position+newVector3(0,2,0))
				end
				if door.Name=="ExitDoor" then
					if C.Map.Name=="Abandoned Prison by AtomixKing and Duck_Ify" then
						walkThruPart.CFrame = walkThruPart.CFrame * CFrame.Angles(0,math.rad(90),0)
					elseif C.Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda" then
						walkThruPart.Size=newVector3(3,5,walkThruPart.Size.Z)
					elseif C.Map.Name=="Airport by deadlybones28" then
						walkThruPart.Size=newVector3(3,7,walkThruPart.Size.Z)
					end
				else
					if C.Map.Name=="Abandoned Prison by AtomixKing and Duck_Ify" then
						walkThruPart.CFrame = walkThruPart.CFrame * CFrame.Angles(0,math.rad(90),0)
					elseif C.Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda" then
						walkThruPart.Size=newVector3(3,5,1.5)
					end
				end
				--walkThruPart.Size=newVector3(4,7,6)


				CS:AddTag(walkThruPart,"RemoveOnDestroy")
				C.createModifer(walkThruPart,(ActionSign~=nil and (ActionSign.Value==10 or ActionSign.Value==12)) and "DoorPath" or "DoorOpened",true)
			end,
			["OthersBeastAdded"]=function(theirPlr,theirChar)
				local theirTorso=theirChar:WaitForChild("Torso",3)
				if theirTorso==nil or not workspace:IsAncestorOf(theirTorso) then 
					return 
				end
				for num,part in pairs(C.AvailableHacks.Bot[15].AvoidParts) do
					part:Destroy()
				end
				C.AvailableHacks.Bot[15].AvoidParts={}
				local avoidPart=Instance.new("Part",theirChar)
				avoidPart.Shape=Enum.PartType.Ball
				avoidPart.Anchored=true
				avoidPart.Size=newVector3(20,20,20)
				avoidPart.Position=theirTorso.Position
				avoidPart.Transparency=(_SETTINGS.hitBoxesEnabled and .7 or 1)
				avoidPart.CanCollide=false
				avoidPart.Name="AvoidPart"
				table.insert(C.AvailableHacks.Bot[15].AvoidParts,avoidPart)
				--local newWeld=Instance.new("Weld",avoidPart)
				--newWeld.Part0=theirTorso
				--newWeld.Part1=avoidPart
				C.createModifer(avoidPart,"Beast",false)
				CS:AddTag(avoidPart,"RemoveOnDestroy")
				avoidPart.Parent=camera
			end,
			["CleanUp"]=function()
				local parts2Avoid = C.AvailableHacks.Bot[15].AvoidParts
				for num,part in ipairs(parts2Avoid) do
					part:Destroy()
				end
				C.AvailableHacks.Bot[15].AvoidParts={}
				local CurrentPath = C.AvailableHacks.Bot[15].CurrentPath
				if CurrentPath then
					CurrentPath:Stop()
				end
				local eachPlayer = PS:GetPlayers()
				for num, theirPlr in ipairs(eachPlayer) do
					theirPlr:SetAttribute("HasRescued",nil)
					theirPlr:SetAttribute("HasCaptured",nil)
				end
			end,
			["MapAdded"]=function()
				task.wait(1.3333)
				local function createBoxPart(DataTbl,DefaultSize,PartName,LabelName,PartColor,Collide)
					DataTbl = (DataTbl or ({}))

					for num,ventData in ipairs(DataTbl) do

						local newPart = Instance.new("Part")
						newPart.Transparency = (_SETTINGS.hitBoxesEnabled and (0.6) or (1))
						newPart.Color = (PartColor or newPart.Color)
						newPart.CanCollide = (false)
						newPart.Anchored = true
						newPart.Size = (DefaultSize or newPart.Size)
						newPart.Parent = C.Map
						newPart.Name = PartName
						CS:AddTag(newPart, "RemoveOnDestroy")
						CS:AddTag(newPart, PartName)
						for property,setTo in pairs(ventData) do
							--print(property,setTo)
							newPart[property]=setTo
						end

						C.createModifer(newPart,LabelName,Collide)
					end
				end
				local function createSolidPart(cframe,size,shape,partName,place)
					local newPart=Instance.new((shape=="WedgePart" and shape or "Part"))
					newPart.Transparency=_SETTINGS.hitBoxesEnabled and .6 or 1
					newPart.Anchored=true
					newPart.Color=newColor3(255,255)
					newPart.Size=size
					if shape~="WedgePart" then
						newPart.Shape=shape or Enum.PartType.Block
					end
					newPart.CFrame=cframe
					newPart.Parent=place
					newPart.Name=partName
					CS:AddTag(newPart,"RemoveOnDestroy")
					CS:AddTag(newPart,partName)
				end
				local Data=C.AvailableHacks.Bot[15].MapData[C.Map and C.Map.Name or ""]
				if Data~=nil then
					--print("Found C.Map Data For "..C.Map.Name)
					createBoxPart(Data.Vents,Data.DefaultVentSize,"VentPartWalkThru","Vent",newColor3(165, 0, 2),true)
					createBoxPart(Data.Windows,Data.DefaultWindowSize,"WindowWalkThru","Window",newColor3(0,255,255),true)
					createBoxPart(Data.NoWalkThru,nil,"NoWalkThruPart","NoWalkThru",newColor3(255, 0, 191),true)
					for num,data in pairs((Data.CollideSpots or {})) do
						local orientation=(data.Orientation or newVector3())
						createSolidPart(CFrame.new(data.Position)*CFrame.Angles(math.rad(orientation.X),math.rad(orientation.Y),math.rad(orientation.Z)),data.Size,data.Shape,"SolidCollidable",C.Map)
					end
				else
					--TODO: actually make a system for pathfinding
					--warn(C.Map.Name,"not found!")
				end
				if C.Map.Name=="Airport by deadlybones28" and false then
					for num,box in pairs(C.Map:WaitForChild("Boxes"):GetChildren()) do
						local cframe,size=box:GetBoundingBox()
						createSolidPart(cframe,size,nil,"SolidCollidable",box)
					end
				elseif C.Map.Name=="Forgotten Facility by Kmart_Corp" or C.Map.Name=="Abandoned Facility Remake by Daniel_H407" or C.Map.Name=="Facility_0 by MrWindy" then
					for num,windowModel in pairs(C.Map:GetChildren()) do
						if windowModel.Name=="Window" then
							local Barrier=windowModel:FindFirstChild("Barrier")
							if Barrier~=nil then 
								Barrier.Parent=C.Map
							end
							local cframe,size=windowModel:GetBoundingBox()
							local sendTable = {
								{["CFrame"]=(cframe-newVector3(0,1.75,0))}
							}
							createBoxPart(sendTable,newVector3(3, 9.5, 2.5),"WindowWalkThru","Window",newColor3(0,255,255),true)
						end

					end
					for num,box in pairs(C.Map:GetChildren()) do
						if box:IsA("Model") and string.find(box.Name,"Crate")~=nil then
							local cframe,size=box:GetBoundingBox()
							createSolidPart(cframe,size,nil,"SolidCollidable",box)
						end
					end
				elseif C.Map.Name=="The Library by Drainhp" and false then -- THIS IS DEFECTIVE AT FINDING WINDOWS!
					for num,windowModel in ipairs((C.Map:WaitForChild("Misc"):WaitForChild("Windows"):GetChildren())) do
						local cframe,size=windowModel:GetBoundingBox()
						local sendTable = {
							{["CFrame"]=(cframe-newVector3(0,0,0))}
						}
						createBoxPart(sendTable,newVector3(1.9, 18, 2.5),"WindowWalkThru","Window",newColor3(0,255,255),true)
					end
				end
			end,--]]
		},
		[20] = {
			["Type"]="ExTextButton",
			["Title"]="Bot Transportation",
			["Desc"]="Means of transportation",
			["Shortcut"]="BotTransport",
			["Options"]=({
				["Walk"]=({
					["Title"]="WALK",
					["TextColor"]=(newColor3(0,255)),
				}),
				["Teleport"]=({
					["Title"]="TELEPORT",
					["TextColor"]=(newColor3(255,255)),
				}),
			}),
			["Default"]="Walk",
			["TeleportDelay"]=(0),
			["LastTeleport"]=(0),
			["Funct"]=nil,
			["WalkFunct"]=(function(currentPath,nextPoso,expireTime)
				C.human:MoveTo(nextPoso)
			end),
			["ActivateFunction"]=(function(newValue)
				local teleportOffset=newVector3(0,2,0)
				if newValue=="Walk" then
					C.AvailableHacks.Bot[20].Funct=C.AvailableHacks.Bot[20].WalkFunct
				elseif newValue=="Teleport" then
					C.AvailableHacks.Bot[20].Funct=function(currentPath,nextPoso)
						local function teleportSpawnFunct()
							if os.clock()<C.AvailableHacks.Bot[20].TeleportDelay then
								return C.AvailableHacks.Bot[20].WalkFunct(nextPoso)
							end
							local hrp=C.char:WaitForChild("HumanoidRootPart")
							local startPoso=(C.char:GetPivot().Position+teleportOffset)
							local result,hitPart=C.raycast(startPoso,nextPoso,{C.Map},nil,nil,true)
							local dist=(result and result.Distance or ((nextPoso-startPoso)/newVector3(1,5,1)).Magnitude)
							if dist>.3 then
								local endPoint=(result and CFrame.new(startPoso,result.Position)*newVector3(0,0,-(dist-1.5)) or nextPoso)
								local x,y,z=C.char:GetPivot():ToOrientation()
								teleportMyself(CFrame.new(endPoint+teleportOffset)*CFrame.Angles(x,y,z))
								--C.char.Torso.Anchored=true
								--wait()--print("Response",RS.DefaultChatSystemChatEvents.MutePlayerRequest:InvokeServer())--we wait for a response--task.wait(1/4)
								--C.char.Torso.Anchored=false
								if (startPoso-hrp:GetPivot().Position).Magnitude+2<(endPoint-hrp:GetPivot().Position).Magnitude then
									C.AvailableHacks.Bot[20].TeleportDelay=os.clock()+3
									print("Detected Cheating!")
									return
								end
								C.AvailableHacks.Bot[20].TeleportDelay=0
								if not C.AvailableHacks.Bot[15].IsRunning or not currentPath then 
									return 
								end
								dist=((C.char:GetPivot().Position-nextPoso)/newVector3(1,5,1)).Magnitude

								if dist<4 and C.AvailableHacks.Bot[15].IsRunning then
									return currentPath:moveToFinished(true)
								else
									return --C.AvailableHacks.Bot[20].WalkFunct(nextPoso)
								end
							else
								return C.AvailableHacks.Bot[20].WalkFunct(nextPoso)
							end
						end
						task.spawn(teleportSpawnFunct) -- runs the above function!
					end
				end
			end),--]]
		},
		--[[[23]={
			["Type"]="ExTextButton",
			["Title"]="Auto Vote For Known Maps",
			["Desc"]="",
			["Shortcut"]="AutoVote/Known",
			["Default"]=_SETTINGS.botModeEnabled,
			["CurrentNum"]=0,
			["DontActivate"]=true,
			["CurrentPath"]=nil,
			["IsRunning"]=false,
			["CleanUp"]=function()
				C.AvailableHacks.Bot[23].CurrentNum = C.AvailableHacks.Bot[23].CurrentNum + 1
				C.AvailableHacks.Bot[23].IsRunning = false
			end,
			["ActivateFunction"]=function()
				C.AvailableHacks.Bot[23].CurrentNum = C.AvailableHacks.Bot[23].CurrentNum + 1
				local SaveNum=C.AvailableHacks.Bot[23].CurrentNum
				local newPath=C.AvailableHacks.Bot[23].CurrentPath
				if newPath==nil or SaveNum~=C.AvailableHacks.Bot[23].CurrentNum then 
					return 
				end
				if not C.enHacks["AutoVote/Known"] then
					newPath:Stop() 
					C.AvailableHacks.Bot[23].IsRunning=false
					C.human:MoveTo(C.char:GetPivot().Position)
					return
				end
				C.AvailableHacks.Bot[23].IsRunning=true
				local votableMaps={}
				for num,board in pairs(workspace.MapVotingBoard:GetChildren()) do
					if string.sub(board.Name,1,8)=="MapBoard" then
						local SurfaceGui=board.SurfaceGui
						if SurfaceGui.Enabled then
							local pad=board.Parent["VoteBox"..string.sub(board.Name,9)]
							local votableMapsData = {["Name"]=SurfaceGui.TitleLabel.Text,
								["Board"]=board,["Pad"]=pad} 
							table.insert(votableMaps,votableMapsData)
						end
					end
				end
				local mapsToVoteFor={}
				for num,map in pairs(votableMaps) do
					if C.AvailableHacks.Bot[15].MapData[map.Name] then --map.Name=="Forgotten Facility by Kmart_Corp"
						--or map.Name=="Abandoned Facility Remake by Daniel_H407" then--C.enHacks["AutoVote/"..map.Name] or map.Name=="Homestead by MrWindy"
						--or map.Name=="Airport by deadlybones28" then
						table.insert(mapsToVoteFor,map)
					end
				end
				local function sortByNameFunction(a,b)
					return a.Name:lower()>b.Name:lower()
				end
				table.sort(mapsToVoteFor,sortByNameFunction)

				local mapTarget

				local function canRun()
					local C.isInGame = C.isInGame(C.char)
					local Check1 = C.char~=nil and workspace:IsAncestorOf(C.char) and C.human~=nil and C.human.Health>0
					local Check2 = C.enHacks["AutoVote/Known"] and mapTarget and mapTarget.Board.SurfaceGui.Enabled
					local Check3 = not C.isInGame and ((SaveNum)==(C.AvailableHacks.Bot[23].CurrentNum)) and not C.isCleared
					return Check1 and Check2 and Check3
				end
				local function calculteMapTarget()
					local sortedPlayers = C.sortPlayersByXPThenCredits()
					local topPlr = sortedPlayers[1]
					local topPlrStatsMod = topPlr:FindFirstChild("SavedPlayerStatsModule")

					if topPlrStatsMod then
						local newRandom = Random.new(C.getTotalXP(topPlrStatsMod.Level.Value,topPlrStatsMod.Xp.Value)*topPlrStatsMod.Credits.Value)
						local tbl = {}
						for num, instance in ipairs(mapsToVoteFor) do
							table.insert(tbl,instance.Name)
						end
						--print("Random Creation: ",(C.getTotalXP(topPlrStatsMod.Level.Value,topPlrStatsMod.Xp.Value)
						--	*topPlrStatsMod.Credits.Value).." Maps: ",table.concat(tbl,", "))
						mapTarget=#mapsToVoteFor>=1 and mapsToVoteFor[newRandom:NextInteger(1,#mapsToVoteFor)] or nil
						if mapTarget and not mapTarget.Pad:GetAttribute("WalkToPoso") then
							mapTarget.Pad:SetAttribute("WalkToPoso", C.findRandomPositionOnBox(mapTarget.Pad.CFrame,mapTarget.Pad.Size/2))
						end
					end
					return true
				end

				local walkPath = C.AvailableHacks.Bot[15].WalkPath
				while calculteMapTarget() and canRun() do
					local didReach = walkPath(newPath, mapTarget.Pad, canRun)
					task.wait()
				end
				if SaveNum==C.AvailableHacks.Bot[23].CurrentNum then
					C.AvailableHacks.Bot[23].IsRunning=false
				end
			end,
			["MyStartUp"]=function()
				task.wait();
				local Torso=C.char:WaitForChild("Torso",30); 
				if not Torso then 
					return;
				end;
				local PathConfigurationTable = {
					AgentCanJump=true,
					Costs = {
						NoWalkThru = math.huge
					}
				};

				--DEAD ZONE:

				local TSM=plr:WaitForChild("TempPlayerStatsModule");
				local newPath = Path.new(C.char, PathConfigurationTable);
				newPath.Visualize = true;
				C.AvailableHacks.Bot[23].CurrentPath=newPath;
				C.AvailableHacks.Bot[23].ActivateFunction(C.enHacks["AutoVote/Known"]);
			end,
			["MyPlayerAdded"]=function()
				local MapVotingBoard=workspace:WaitForChild("MapVotingBoard")
				local function RSUpdateGameStatusFunction()
					if (not C.AvailableHacks.Bot[23].IsRunning and not ({C.isInGame(C.char)})[1]) then
						C.AvailableHacks.Bot[23].ActivateFunction() 
					else
						--print(C.AvailableHacks.Bot[23].IsRunning)
					end
				end
				setChangedProperty(RS.GameStatus, "Value", (RSUpdateGameStatusFunction))
			end,
		},--]]
		[28]=(false and {
			["Type"]="ExTextButton",
			["Title"]="Auto Vote For Random Map",
			["Desc"]="Votes for maps synchronously",
			["Shortcut"]="AutoVote/Random",
			["Default"]=_SETTINGS.botModeEnabled,
			["DontActivate"]=true,
			["ActivateFunction"]=function()
				if not C.enHacks["AutoVote/Random"] then
					return
				end
				local mapsToVoteFor={}
				for num,board in pairs(workspace.MapVotingBoard:GetChildren()) do
					if string.sub(board.Name,1,8)=="MapBoard" then
						local SurfaceGui=board.SurfaceGui
						if SurfaceGui.Enabled then
							local pad=board.Parent["VoteBox"..string.sub(board.Name,9)]
							local votableMapsData = {["Name"]=SurfaceGui.TitleLabel.Text,
								["Board"]=board,["Pad"]=pad} 
							table.insert(mapsToVoteFor,votableMapsData)
						end
					end
				end
				--[[local mapsToVoteFor={}
				for num,map in pairs(votableMaps) do
					table.insert(mapsToVoteFor,map)
				end--]]
				--[[local function sortByNameFunction(a,b)
					return a.Name:lower()>b.Name:lower()
				end--]]
				table.sort(mapsToVoteFor,function(a,b)
					return a.Name:lower()>b.Name:lower()
				end)

				local seed = StringWaitForChild(C.sortPlayersByXPThenCredits()[1],"SavedPlayerStatsModule.Credits",.2)--tonumber(RS.GameStatus.Value:match("%d+")) or 100--os.time()
				if not seed then
					print("seed not found!")
					return
				elseif #mapsToVoteFor == 0 then
					return
				end
				--math.randomseed(math.floor(seed.Value))
				--print("RandomSeed:",math.floor(seed.Value),"Maps#",#mapsToVoteFor)
				local selectedVote = mapsToVoteFor[seed.Value%#mapsToVoteFor+1]--math.random(1,#mapsToVoteFor)]

				local Torso = C.char and C.char:FindFirstChild("Torso")
				if selectedVote and selectedVote.Pad and Torso then
					--teleportMyself(CFrame.new(selectedVote.Pad:GetPivot().Position+Vector3.new(0,C.getHumanoidHeight(C.char)+selectedVote.Pad.Size.Y/2),
					--	Vector3.new(selectedVote.Board:GetPivot().X,C.char:GetPivot().Y,selectedVote.Board:GetPivot().Z)))
					firetouchinterest(selectedVote.Pad,Torso, 0)
					RunS.RenderStepped:Wait()
					firetouchinterest(selectedVote.Pad,Torso, 1)
					--C.FireSignal(selectedVote.Pad,selectedVote.Pad.TouchInterest,nil,C.char:FindFirstChildWhichIsA("BasePart"))
				end
			end,
			["MyStartUp"]=function()
				task.wait();
				local Torso=C.char:WaitForChild("Torso",30); 
				if not Torso then 
					return;
				end;

				C.AvailableHacks.Bot[28].ActivateFunction(C.enHacks["AutoVote/Random"]);
			end,
			["MyPlayerAdded"]=function()
				local MapVotingBoard=workspace:WaitForChild("MapVotingBoard")
				local function RSUpdateGameStatusFunction()
					if not C.isInGame(C.char) then
						C.AvailableHacks.Bot[28].ActivateFunction() 
					end
				end
				setChangedProperty(RS.GameStatus, "Value", (RSUpdateGameStatusFunction))
			end,
		}),
		[30]={
			["Type"]="ExTextButton",
			["Title"]="Reset After "..tostring(_SETTINGS.botBeastBreakMin).."m or exit open",
			["Desc"]="Waits for runners to finish hacking (BEAST BOT ONLY)",
			["Shortcut"]="Bot/AutoReset",
			["Default"]=(_SETTINGS.botModeEnabled and false),
			["CurrentNum"]=0,
			["ShouldBreak"]=function()
				if (RS.GameTimer.Value<=(60 * (tonumber(_SETTINGS.botBeastBreakMin) or 0))) then 
					return true 
				end
				if (RS:WaitForChild("GameStatus").Value==("FIND AN EXIT")) then
					local canBreak = true
					for num,theirPlr in pairs(PS:GetPlayers()) do
						local theirTSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
						if theirTSM then
							if theirTSM.CurrentAnimation.Value=="Typing" and theirTSM.ActionProgress.Value>0.5 then
								canBreak=false
								break
							end
						end
					end
					if canBreak then
						return true
					end
				end
				return false
			end,
			["ActivateFunction"]=function(en)
				C.AvailableHacks.Bot[30].CurrentNum = C.AvailableHacks.Bot[30].CurrentNum + 1
				local saveNum=C.AvailableHacks.Bot[30].CurrentNum
				task.delay(3/2,function()
					while C.enHacks["Bot/AutoReset"] and C.Map and C.Beast==C.char and C.human and C.human.Health>0
						and saveNum==C.AvailableHacks.Bot[30].CurrentNum and not C.isCleared do
						if C.AvailableHacks.Bot[30].ShouldBreak() then
							C.AvailableHacks.Commands[24].ActivateFunction(true)
							break
						end
						RS:WaitForChild("GameTimer").Changed:Wait()
					end
				end)
			end,
			["MyBeastAdded"]=function()
				C.AvailableHacks.Bot[30].ActivateFunction(C.enHacks["Bot/AutoReset"])
			end,
		},
		[150]={
			["Type"]="ExTextButton",
			["Title"]="Buy Shop Item",
			["Desc"]="Automatically buys quantity and id of the crates and bundles selected!",
			["Shortcut"]="Bot/BuyItems",
			["Places"]={"FleeTrade"},--only works in 1 place, no universes
			["DontActivate"]=true,
			["Options"]={
				[true]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(255, 0, 4),
				},
			},
			["Default"]=_SETTINGS.botModeEnabled,["IsRunning"]=false,
			["ActivateFunction"]=function(en)
				if C.AvailableHacks.Bot[150].IsRunning then
					C.createCommandLine("<font color='rgb(255,0,0)'>Stuff is being purchased!!</font>")
					return
				end
				C.AvailableHacks.Bot[150].IsRunning=true
				local thingsToGet={
					["BuyShopBundle"]={
						(C.enHacks["Bot/Bundle"] 
							and C.enHacks["Bot/BundleQty"]>0 and ({C.enHacks["Bot/Bundle"],C.enHacks["Bot/BundleQty"]}) or nil)
					},
					["BuyCrate"]={
						(C.enHacks["Bot/Crate"] 
							and C.enHacks["Bot/CrateQty"]>0 and ({C.enHacks["Bot/Crate"],C.enHacks["Bot/CrateQty"]}) or nil)
					}
				}

				local totalLoopMult=1
				local totalCountToBuy,alreadyPurchasedCount=0,0

				local function purchaseCrateFunction(main,crateType,id)
					if main=="BoughtCrate" then
						C.createCommandLine("🎁Purchase Success:"..crateType.." "..
							RS.ItemDatabase[id]:GetAttribute("ItemName"))
						alreadyPurchasedCount = alreadyPurchasedCount + 1
					end
				end

				C.AvailableHacks.Bot[150].Funct=C.RemoteEvent.OnClientEvent:Connect(purchaseCrateFunction)

				local function makeOrders(orderName)
					for num,desc in pairs(thingsToGet[orderName]) do
						for s=1,desc[2] or 1 do
							C.RemoteEvent:FireServer(orderName,desc[1])
							if orderName=="BuyShopBundle" then
								C.createCommandLine("📦Purchase Success: "..desc[1])
							else
								totalCountToBuy = totalCountToBuy + 1
							end
						end
					end
				end

				for s=1,totalLoopMult do
					C.ShuffleArray(thingsToGet,"BuyShopBundle")
					C.ShuffleArray(thingsToGet,"BuyCrate")
					if Random.new():NextInteger(1,2)==1 then
						makeOrders("BuyShopBundle")
						makeOrders("BuyCrate")
					else
						makeOrders("BuyCrate")
						makeOrders("BuyShopBundle")
					end
				end

				local startPurchase=os.clock()
				while totalCountToBuy>alreadyPurchasedCount do
					if os.clock()-startPurchase>12 then
						local ErrorMessage = "Purchase Timeout!! "
							..alreadyPurchasedCount.."/"..totalCountToBuy..
							"\n(This usually occurs when you're out of Credits)"
						C.createCommandLine("<font color='rgb(255,0,0)'>"..ErrorMessage.."</font>",warn)
						C.AvailableHacks.Bot[150].Funct:Disconnect()
						C.AvailableHacks.Bot[150].IsRunning=false
						return
					end
					task.wait()
				end
				local combinedStringForCommandLine = "All "..C.comma_value(totalCountToBuy).." Purchase"..(totalCountToBuy~=1 and "s" or "").." Succeeded in "..(math.round((os.clock()-startPurchase)*100)/100).."s"
				C.createCommandLine(combinedStringForCommandLine)
				C.AvailableHacks.Bot[150].Funct:Disconnect()
				C.AvailableHacks.Bot[150].IsRunning=false
			end,
		},
		[147]={
			["Type"]="ExTextBox",
			["Title"]="Bundle Quantity",
			["Desc"]="",
			["Places"]={
				"FleeTrade"
			},
			["Shortcut"]="Bot/BundleQty",
			["Default"]=0,
			["MinBound"]=0,
			["MaxBound"]=30,
		},
		[144]={
			["Type"]="ExTextBox",
			["Title"]="Crate Quantity",
			["Desc"]="",
			["Places"]={"FleeTrade"},
			["Shortcut"]="Bot/CrateQty",
			["Default"]=0,
			["MinBound"]=0,
			["MaxBound"]=30,
		},
		[143]={
			["Type"]="ExTextButton",


			["Title"]="Crate To Purchase",


			["Desc"]="",

			["Places"]={
				("FleeTrade")
			},

			["Shortcut"] = ("Bot/Crate"),
			["Options"]={}
		},
		[146]={


			["Title"] = "Bundle To Purchase",


			["Desc"]="",
			["Type"] = "ExTextButton" , 


			["Places"]={
				("FleeTrade")
			},


			["Shortcut"]="Bot/Bundle",

			["Options"] = {

			}
		},

		[200] = {
			["Type"]="ExTextButton",
			["Title"]="Auto Claim Rewards",
			["Desc"]="Means of transportation",
			["Default"]=true,
			["Shortcut"]="Bot_AutoClaimRewards",
			["Universes"]={"UGCSpin"},
			["Functs"]={},
			["ActivateFunction"]=(function(newValue)
				for num, funct in ipairs(C.AvailableHacks.Bot[200].Functs) do
					funct:Disconnect()
				end C.AvailableHacks.Bot[200].Functs = {}
				if not newValue then return end
				local FreeRewardContainer = StringWaitForChild(PlayerGui,"PlaytimeRewards.Main.Container")
				for num, imageLabel in ipairs(FreeRewardContainer:GetChildren()) do
					if imageLabel:IsA("ImageButton") then
						local ClaimReward = RS:WaitForChild("Packages"):FindFirstChild("ClaimReward",true)
						local function Upd()
							if imageLabel.Status.Label.Text=="CLAIM!" and not C.isCleared then
								local result, message = ClaimReward:InvokeServer(tonumber(imageLabel.Name))
								if result == true then
									print("Sent Reward #"..imageLabel.Name..": "..tostring(message).."!")
								else
									print("Sent Reward Error: "..tostring(message).."; Trying again in 5s.")
									task.wait(5)
									Upd()
								end
							end
						end
						table.insert(C.AvailableHacks.Bot[200].Functs,imageLabel.Status.Label:GetPropertyChangedSignal("Text"):Connect(Upd))
						task.spawn(Upd)
					end
				end
			end)
		},
		[201] = {
			["Type"]="ExTextButton",
			["Title"]="Auto Spin Rewards",
			["Desc"]="Automatically Spins and Prints Good Rewards In Output",
			["Default"]=true,
			["Shortcut"]="Bot_AutoSpin",
			["Universes"]={"UGCSpin"},
			["Functs"]={},
			["ActivateFunction"]=(function(newValue)
				for num, funct in ipairs(C.AvailableHacks.Bot[201].Functs) do
					funct:Disconnect()
				end C.AvailableHacks.Bot[201].Functs = {}
				local SpinsLeft = StringWaitForChild(plr,"leaderstats.Spins")
				local function SpinsLeftChanged()
					while SpinsLeft.Value>0 and not C.isCleared do
						local Result = StringWaitForChild(RS:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.6.0"),
							"knit.Services.SpinService.RF.Spin"):InvokeServer()
						if not Result then
							task.wait(1)
						else
							if Result.Reward ~= "Nothing" then
								if Result.Reward:gmatch("Spins_%d+")() then
									local SpinsNum = tostring(Result.Reward:gmatch("%d+")())
									print("Reward: "..SpinsNum.." Spin"..(SpinsNum==1 and "" or "s").."!")
								else
									warn("GOOD REWARD: "..tostring(Result.Reward))
								end
							end
							if Result.SpinTime then
								task.wait(Result.SpinTime)
							end
						end
					end
				end
				SpinsLeft.Changed:Connect(SpinsLeftChanged)
				task.spawn(SpinsLeftChanged)
			end)
		},
		[215] = {
			["Type"]="ExTextButton",
			["Title"]="Auto Get Top",
			["Desc"]="Automatically Gets To The Top",
			["Default"]=true,
			["Shortcut"]="Bot_AutoTowerTop",
			["Universes"]={"Tower"},
			["Funct"]=nil,
			["LastPosition"]=nil,
			["ActivateFunction"]=(function(newValue)
				if C.AvailableHacks.Bot[215].Funct then
					C.AvailableHacks.Bot[215].Funct:Disconnect()
					C.AvailableHacks.Bot[215].Funct=nil
				end
				if not newValue then
					return
				end
				local timerLeftButton = StringWaitForChild(PlayerGui,"timer.timeLeft")
				local function disable()
					if C.AvailableHacks.Bot[215].LastPosition then
						C.human:MoveTo(C.AvailableHacks.Bot[215].LastPosition.Position)
						teleportMyself(C.AvailableHacks.Bot[215].LastPosition)
						C.AvailableHacks.Bot[215].LastPosition = nil
					end
				end
				local function doUpdate()
					if C.isCleared then
						return
					end
					if (timerLeftButton.TextColor3.G > .8 and timerLeftButton.TextColor3.B < .8) then
						disable()
						return
					end
					if not C.char or not C.char.PrimaryPart or not C.human or C.human.Health <= 0 then
						task.delay(1,doUpdate)
					end
					C.AvailableHacks.Bot[215].LastPosition = C.char:GetPivot()
					for num, stage in ipairs(workspace:WaitForChild("tower"):WaitForChild("sections"):GetChildren()) do
						if stage.Name ~= "lobby" and stage.Name ~= "finish" then
							teleportMyself(CFrame.new(stage:WaitForChild("start").Position+Vector3.new(0,3,0)))
							task.wait(1)
							if not C.human or C.human.Health <= 0 then
								return
							end
							if stage:WaitForChild("start").Position.Y > C.char:GetPivot().Position.Y then
								print("We fell offf! :(")
								return
							end
						end
					end
					local finishes = workspace:WaitForChild("tower"):WaitForChild("finishes")
					for num, instance in ipairs(finishes:GetChildren()) do
						if instance.Name == "Finish" then
						--[[for num, myPart in ipairs(C.char:GetChildren()) do
							if myPart:IsA("BasePart") then
								firetouchinterest(C.char.hitbox,instance,1)
								task.delay(1,function()
									firetouchinterest(C.char.hitbox,instance,0)
								end)
								task.wait()
							end
						end--]]
							teleportMyself(instance.CFrame * CFrame.new(-2.8,0,0))
							C.human:MoveTo(instance.CFrame * Vector3.new(5,0,0))
							task.wait(1)
							break
						end
					end
					disable()
					task.delay(1,doUpdate)
				end
				C.AvailableHacks.Bot[215].Funct = timerLeftButton:GetPropertyChangedSignal("TextColor3"):Connect(doUpdate)
				task.spawn(doUpdate)
				--local C = {char = game.Players.LocalPlayer.Character}
			end)
		},
		[250] = {
			["Type"]="ExTextButton",
			["Title"]="Autoclicker",
			["Desc"]="Auto Fakes Clicks",
			["Default"]=true,
			["Shortcut"]="Bot_AutoClick",
			["Universes"]={"UGCClick"},
			["ActivateFunction"]=(function(newValue)
				local ClickEvent = RS:WaitForChild("Events"):WaitForChild("Click")
				local Debounce = plr:WaitForChild("ClickDebounce")

				local ClicksVal = StringWaitForChild(plr,"leaderstats.Clicks")
				local StartVal, StartTime = ClicksVal.Value, os.clock()
				task.delay(60,function()
					print(("Time per minute was measured to be %.3f/m!"):format((60*(ClicksVal.Value-StartVal))/(os.clock()-StartTime)))
				end)

				while newValue and not C.isCleared and C.enHacks.Bot_AutoClick do
					for s = 1, 1, -1 do
						task.spawn(ClickEvent.FireServer,ClickEvent)
					end
					RunS.RenderStepped:Wait()
					--[[while Debounce.Value do
						Debounce.Changed:Wait()
					end--]]
				end
			end)
		},
		[300] = {
			["Type"]="ExTextButton",
			["Title"]="Auto Grind Money",
			["Desc"]="Gets Money",
			["Default"]=true,
			["Shortcut"]="Bot_AutoGrindBAB",
			["Universes"]={"BuildABoat"},
			["Functs"]={},
			["Deb"] = 0,
			["DontActivate"]=true,
			["ActivateFunction"]=(function(newValue)
				C.AvailableHacks.Bot[300].Deb+=1 local SaveDeb = C.AvailableHacks.Bot[300].Deb
				if not newValue then
					--C.char.PrimaryPart.Anchored = false
					return
				end
				local SaveChar = C.char
				local function RunFunct()
					return C.AvailableHacks.Bot[300].Deb==SaveDeb and C.enHacks.Bot_AutoGrindBAB and C.char == SaveChar and C.char.PrimaryPart
				end
				for num, funct in ipairs(C.AvailableHacks.Bot[300].Functs) do
					funct:Disconnect()
				end C.AvailableHacks.Bot[300].Functs = {}

				task.wait(3 - (os.clock() - C.AvailableHacks.Bot[300].Spawned))


				--while RunFunct() do
				local TPPosition=Vector3.new(-55.17,-356.49,9491.75)
				for num,stage in pairs(workspace.BoatStages.NormalStages:GetChildren()) do
					if not RunFunct() then return end
					if stage:FindFirstChild("DarknessPart")~=nil then
						--firetouchinterest(C.char.PrimaryPart,stage.DarknessPart,1)
						teleportMyself(CFrame.new(stage.DarknessPart.Position)+Vector3.new(0,15,0))
						C.char.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
						task.wait(1/4)
						if not RunFunct() then return end
						teleportMyself(CFrame.new(stage.DarknessPart.Position)+Vector3.new(0,15,0))
						C.char.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
						task.wait(1/4)
						--C.char:SetPrimaryPartCFrame(CFrame.new(stage.DarknessPart.Position)+Vector3.new(0,15,0))
						--task.wait(1/2)
						--firetouchinterest(C.char.PrimaryPart,stage.DarknessPart,0)
						--task.wait(1/4)
					end
				end
				if not RunFunct() then return end
				while RunFunct() do
					teleportMyself(CFrame.new(TPPosition))
					if C.human then
						C.human:ChangeState(Enum.HumanoidStateType.Jumping)
					end
					task.wait(1)
				end
				--end
			end),
			["MyStartUp"]=function()
				task.wait(2)
				workspace.ClaimRiverResultsGold:FireServer()
				C.AvailableHacks.Bot[300].Spawned = os.clock()
				C.AvailableHacks.Bot[300].ActivateFunction(C.enHacks.Bot_AutoGrindBAB)
			end,
		},

	},
	["Commands"]={
		[1]={
			["Type"]="ExTextButton",
			["Title"]="Spawn Location",
			["Desc"]="Sets your spawnpoint",
			["Shortcut"]="TeleportWithSpawn",
			["Default"]=0,
			["DontActivate"]=true,
			["Options"]={
				[0]={
					["Title"]="Lobby",
					["TextColor"]=newColor3(255, 255, 255),
				},
				[1]={
					["Title"]="Ally Harbor",
					["TextColor"]=newColor3(255, 255, 255),
				},
				[2]={
					["Title"]="Island 1",
					["TextColor"]=newColor3(255, 255, 255),
				},
				[3]={
					["Title"]="Island 2",
					["TextColor"]=newColor3(255, 255, 255),
				},
				[4]={
					["Title"]="Island 3",
					["TextColor"]=newColor3(255, 255, 255),
				},
				[5]={
					["Title"]="Enemy Harbor",
					["TextColor"]=newColor3(255, 255, 255),
				},
			},
			["Universes"]={"NavalWarefare"},
			["UpdInGame"]=function()
				local RemoveUniform = StringWaitForChild(PlayerGui,"ScreenGui.RemoveUniform")
				local ShouldBeDead = C.isInGame(C.char)
				--RemoveUniform.Visible = not C.isInGame(C.char)
				RemoveUniform.Position = ShouldBeDead and UDim2.fromScale(-1,.5) or UDim2.fromScale(0,.5)
				RemoveUniform.AnchorPoint = ShouldBeDead and Vector2.new(1, 0.5) or Vector2.new(0,.5)
				--setChangedProperty(RemoveUniform,"Visible",C.AvailableHacks.Commands[1].UpdInGame)
			end,
			["SpawnFunction"]=function(newValue)
				local Teleports={{"USDock"},{"Island","A"},{"Island","B"},{"Island","C"},{"JapanDock"}}
				if newValue ~= 0 then
					local Data = Teleports[plr.Team.Name=="USA" and newValue or (#Teleports-newValue+1)]
					local Target
					if Data[1] == "Island" then
						for num, base in ipairs(C.Bases.Island) do
							local IslandCode = base:WaitForChild("IslandCode",1e-3)
							if IslandCode and IslandCode.Value == Data[2] then
								Target = base
								break
							end
						end
					else
						Target = workspace:WaitForChild(Data[1])
					end
					if not Target then
						return
					end
					local MainBody = Target:WaitForChild("MainBody")
					if MainBody and C.human and C.human.Health>0 then
						teleportMyself(
							CFrame.new(MainBody:GetPivot().Position) * CFrame.new(0,C.getHumanoidHeight(C.char)
								+ (Data[1]=="Island" and MainBody.Size.X or MainBody.Size.Y)/2,0))
					end
				end
				C.AvailableHacks.Blatant[5].BlockTeleports = newValue ~= 0
				if C.gameUniverse == "NavalWarefare" then
					C.AvailableHacks.Commands[1].UpdInGame()
				end
			end,
			["MyStartUp"]=function(myPlr,myChar,firstRun)
				while #C.Bases.Island < 3 or StringWaitForChild(workspace,"VariableFolder.TimerVal").Value < 0 do
					task.wait(1)
				end
				task.wait(.5)

				if not firstRun then
					C.AvailableHacks.Commands[1].SpawnFunction(C.enHacks.TeleportWithSpawn)
				elseif C.gameUniverse == "NavalWarefare" then
					C.AvailableHacks.Commands[1].UpdInGame()
				end
			end,
		},
		[2]={
			["Type"]="ExTextButton",["CategoryAlias"]="Developer",
			["Title"]="Clear Consoles",
			["Desc"]="Activate To Clear Consoles",
			["Shortcut"]="ClearConsole",
			["Default"]=true,
			["DontActivate"]=true,
			["Options"]={
				[(true)]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(255, 255, 255),
				},
			},
			["Universes"]={"Global"},
			["ActivateFunction"]=function(newValue)
				LogS:ClearOutput() --rconsoleclear()
				if C.BetterConsole_ClearConsoleFunction then
					C.BetterConsole_ClearConsoleFunction()
				end
				C.clearCommandLines()
			end,
		},
		[3]={
			["Type"]="ExTextButton",
			["Title"]="Get Console Logs", ["CategoryAlias"]="Developer",
			["Desc"]="Activate To See Console Logs",
			["Shortcut"]="GetConsoleLogs",
			["Default"]=true,
			["DontActivate"]=true,
			["Options"]={
				[(true)]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(0, 170, 170),
				},
			},
			["Universes"]={"Global"},
			["MessageTypeColors"]={
				[Enum.MessageType.MessageOutput] = '<font color="rgb(255,255,255)">',
				[Enum.MessageType.MessageInfo] = '<font color="rgb(255,255,255)">',
				[Enum.MessageType.MessageWarning] = '<font color="rgb(255,0,255)">',
				[Enum.MessageType.MessageError] = '<font color="rgb(255,0,0)">'
			},
			["ActivateFunction"]=function(newValue)
				local fullHistory = game:GetService("LogService"):GetLogHistory()
				local totalLogs = #fullHistory
				local maximum = 5 * (C.Console.AbsoluteWindowSize.Y / C.CommandBarLine.AbsoluteSize.Y)
				for num = totalLogs, math.max(1,totalLogs-maximum), -1 do--only loop through the last ones!
					local logItem = fullHistory[num]
					C.createCommandLine(C.AvailableHacks.Commands[3].MessageTypeColors[logItem.messageType]..logItem.message.."</font>")
				end
				--for num, logItem in ipairs() do
				--if  - (100 - (#fullHistory - num) > 0 then
				--end
				--end
			end,
		},
		[24]={
			["Type"]="ExTextButton",
			["Title"]="Reset", ["CategoryAlias"]="Developer",
			["Desc"]="Activate To Reset Character",
			["Shortcut"]="Reset",
			["Default"]=true,
			["DontActivate"]=true,
			["Options"]={
				[(true)]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(255, 0, 4),
				},
			},
			["Universes"]={"Global"},
			["BeforeReset"]=function()
				local function Remove(findName,recurseLoop)
					local obj=C.char:FindFirstChild(findName,recurseLoop)
					if obj~=nil then
						obj:Destroy()
					end
				end
				Remove("LocalClubScript",true)
				Remove("BackgroundMusicLocalScript")
				C.createCommandLine("Reset Sequence Activated")
			end,
			["ActivateFunction"]=function(newValue)
				if C.char~=nil and C.human~=nil and C.char.Parent~=nil and C.human.Health > 0 then 
					--(not C.char:FindFirstChild("HumanoidRootPart") or not C.char:FindFirstChild("HumanoidRootPart").Anchored) then
					local saveChar = C.char
					C.AvailableHacks.Commands[24].BeforeReset()
					if C.char.PrimaryPart then
						C.char.PrimaryPart.Anchored=true
					end
					if C.char:FindFirstChild("Head") then
						C.char.Head:Destroy()
					elseif C.human.Health>0 then
						C.human.Health = 0
					end
					task.wait(1);
					teleportMyself(CFrame.new(1e3,1e-3,1e3))
					task.wait(.25);
					if not C.char.Humanoid:FindFirstChild("Humanoid") then
						if C.char.Humanoid.Health<=0 then
							local chardescendants = C.char:GetDescendants();
							for num,part in ipairs(chardescendants) do
								if part:IsA("BasePart") then
									part:Destroy();
								end;
							end;
						else
							C.char.Humanoid.Health = 0;
						end;
						task.delay(30,function()
							if C.char==saveChar and _SETTINGS.botModeEnabled and C.enHacks.BotRunner and not C.isCleared then
								C.createCommandLine("<font color='rgb(255,0,0)'>Reset Activation Sequence Failed.".."Auto Kicking Sequence Begun</font>",error)
								plr:Kick("Reset Activation Failed")
							end
						end)
					else
						warn("Humanoid Not Found!")
					end
				end
			end,
			--[[["MyStartUp"]=function()
				local isChecking=plr:WaitForChild("IsCheckingLoadData")
				if not isChecking.Value then
					plr:WaitForChild("PlayerGui")
					:WaitForChild("ScreenGui"):WaitForChild("MenusTabFrame").Visible=true
				end
			end,--]]
		},
		[30]={
			["Type"]="ExTextButton",
			["Title"]="Hack ALL PCs",
			["Desc"]="Activate To Hack All Available PCs in the map.\nWhile doing this, you can move around and open/close doors",
			["Shortcut"]="Cmds_HackAllPCs",
			["Default"]=false,
			["DontActivate"]=false,
			["Options"]={
				[false]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(0,0,0),
				},
				["Enabling"]={
					["Title"]="ENABLING...",
					["TextColor"]=newColor3(255,255,255),
				},
				[true]={
					["Title"]="IN PROGRESS",
					["Locked"]=true,
					["TextColor"]=newColor3(0, 255, 0),
				},
			},
			["SaveDeb"] = 0;
			["Funct"]=nil,
			["ActivateFunction"]=function(newValue)
				if newValue == true then
					return
				elseif newValue == false then
					if C.AvailableHacks.Commands[30].Funct then
						C.AvailableHacks.Commands[30].Funct:Disconnect()
						C.AvailableHacks.Commands[30].Funct = nil
					end
					trigger_setTriggers("Cmds_HackAllPCs",true)
				end

				local savedDeb = C.AvailableHacks.Commands[30].SaveDeb + 1
				C.AvailableHacks.Commands[30].SaveDeb = savedDeb

				local function canRun()
					return not C.isCleared and savedDeb == C.AvailableHacks.Commands[30].SaveDeb and C.refreshEnHack["Cmds_HackAllPCs"]
				end

				if not newValue then return end
				local ActionProgress = C.myTSM:WaitForChild("ActionProgress")
				local actionTable = {}
				C.AvailableHacks.Commands[30].Funct = ActionProgress.Changed:Connect(function(newValue)
					if newValue > .97 then
						print("Stopped Hacking On Purpose!")
						local event = actionTable[1]
						table.remove(actionTable,1)
						C.RemoteEvent:FireServer("Input","Trigger",false,event)
					end
				end)
				trigger_setTriggers("Cmds_HackAllPCs",{["Computer"]=false})
				local hackedPCS = 0
				for num, pc in ipairs(CS:GetTagged("Computer")) do
					if not canRun() then return end
					local goodTriggers = C.AvailableHacks.Bot[15].getGoodTriggers(pc)
					if #goodTriggers>0 then
						local selectedTriggerKey = 1
						local trigger = goodTriggers[selectedTriggerKey]
						teleportMyself(trigger:GetPivot()*CFrame.new(0,0,.1)+Vector3.new(0,-trigger.Size.Y/2+C.getHumanoidHeight(C.char)))
						task.wait(.5)
						if not canRun() then return end
						table.insert(actionTable,trigger.Event)
						print("LastPC2",trigger_enabledNames["LastPC"])
						while trigger_enabledNames["LastPC"] and not trigger_enabledNames["LastPC"].Computer do

							RunS.RenderStepped:Wait()
						end
						C.myTSM:WaitForChild("ActionEvent").Value = trigger.Event
						task.wait(.5)
						local lastPCSave = lastHackedPC
						for s = 15, 1, -1 do
							if not canRun() then return end--or hackedPCS>=1 then return end
							C.myTSM:WaitForChild("ActionEvent").Value = trigger.Event
							task.wait()
							C.RemoteEvent:FireServer("Input","Trigger",true,trigger.Event)
							task.wait(.3)
							if not canRun() then return end
							C.RemoteEvent:FireServer("Input","Action",true)
							task.wait(.3)
							if not canRun() then return end
							if lastHackedPC ~= lastPCSave then
								print("PC Hack Change Detected")
							end
							if lastHackedPC == pc or s == 5 then
								print("PC Hack Successful!")
								C.myTSM.CurrentAnimation.Value = ""
								hackedPCS+=1
								break
							elseif s == 1 then
								C.createCommandLine("[Hack All PCs]: PC HACK FAIL TIMEOUT!",warn)
								hackedPCS+=1
								return C.refreshEnHack["Cmds_HackAllPCs"](false)
							end
						end
						task.wait(.1)
						if not canRun() then return end
						C.RemoteEvent:FireServer("Input","Action",false)

					end

				end
				if not canRun() then return end
				C.refreshEnHack["Cmds_HackAllPCs"](true)
				task.wait(3)
				if not canRun() then return end
				C.refreshEnHack["Cmds_HackAllPCs"](false)
			end,
			["CleanUp"]=function()
				if C.isCleared or C.refreshEnHack["Cmds_HackAllPCs"] then
					return
				end
				C.refreshEnHack["Cmds_HackAllPCs"](false)
			end,
			["MyStartUp"]=function()
				C.refreshEnHack["Cmds_HackAllPCs"](false)
			end,
		},
		[12]={
			["Type"]="ExTextButton",
			["Title"]="Count Stats",
			["Desc"]="Adds player stats and XP for bots and other users",
			["Shortcut"]="Reset",
			["Default"]=true,
			["DontActivate"]=true,
			["Options"]={
				[true]={
					["Title"]="EXECUTE",
					["TextColor"]=newColor3(255,255,255),
				},
			},
			["Universes"]={"Flee"},
			["ActivateFunction"]=function(newValue)
				local allStats={
					["XP"]={
						Bot=0,
						Other=0,
					},
					["Credits"]={
						Bot=0,
						Other=0,
					}
				}

				local plrList = C.sortPlayersByXPThenCredits()

				local totString = "Players Found ("..C.comma_value(#plrList)..")"

				for num, theirPlr in ipairs(plrList) do
					local plrString = ""
					local searchKey = "Other"
					local SavedPlayerStatsModule=theirPlr:WaitForChild("SavedPlayerStatsModule")
					if _SETTINGS.myBots[theirPlr.Name:lower()] then
						searchKey="Bot"
						plrString = plrString .. emojiDesc.Level --"⭐"
					else
						plrString = plrString .. emojiDesc.Heart --"💟"
					end
					local theirCredits,theirXP=SavedPlayerStatsModule:WaitForChild("Credits"),SavedPlayerStatsModule:WaitForChild("Xp")
					local theirLevel = SavedPlayerStatsModule:WaitForChild("Level")
					local totXP = C.getTotalXP(theirLevel.Value,theirXP.Value)
					plrString = plrString .. C.comma_value(theirLevel.Value) .." "..theirPlr.Name.." | ".. emojiDesc.Money .. " "..C.comma_value(theirCredits.Value).." ".. emojiDesc.NumberOne .. " "..C.comma_value(totXP) -- 💰 🥇

					allStats.XP[searchKey] = allStats.XP[searchKey] + totXP
					allStats.Credits[searchKey] = allStats.Credits[searchKey] + theirCredits.Value
					totString = totString .. "\n"..plrString
				end

				for Type,Vals in pairs(allStats) do
					for UserType,NumValue in pairs(Vals) do
						if NumValue>0 then
							totString = totString .. "\n	>"..UserType.." "..Type..": "..C.comma_value(NumValue)
						end
					end
				end

				C.createCommandLine(totString)

			end,
			--[[["MyStartUp"]=function()
				local isChecking=plr:WaitForChild("IsCheckingLoadData")
				if not isChecking.Value then
					plr:WaitForChild("PlayerGui")
					:WaitForChild("ScreenGui"):WaitForChild("MenusTabFrame").Visible=true
				end
			end,--]]
		},
		[22]={
			["Type"]="ExTextButton",
			["Title"]="Get Frozen",
			["Desc"]="Forces yourself to get frozen. Includes Chat Message",
			["Shortcut"]="Commands_GetFrozen",
			["Default"]=false,
			["DontActivate"]=true,
			["ForceDefault"]=true,
			["Options"]={
				[false]={
					["Title"]="FREEZE",
					["TextColor"]=newColor3(0,170),
				},
				[true]={
					["Title"]="Running",
					["TextColor"]=newColor3(0,170),
				},
			},
			["SaveDeb"] = 0,
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Commands[22].SaveDeb += 1
				trigger_setTriggers("Commands_GetFrozen",{Exit = not newValue})
				if newValue == false then
					return
				end
				local saveDeb = C.AvailableHacks.Commands[22].SaveDeb
				local function canRun()
					return saveDeb ==  C.AvailableHacks.Commands[22].SaveDeb and newValue and select(2,C.isInGame(C.char,true))=="Runner"
						and not C.isCleared and C.Map and C.Beast
				end
				C.AvailableHacks.Bot[15].GetFreeze(canRun,false)
				if saveDeb ==  C.AvailableHacks.Commands[22].SaveDeb and not C.isCleared then
					C.refreshEnHack["Commands_GetFrozen"](false)
				end
			end,
			["CleanUp"] = function()
				C.refreshEnHack["Commands_GetFrozen"](false)
			end,
		},
		[35]={
			["Type"]="ExTextButton",
			["Title"]="ClickDetectors",
			["Desc"]="Activates All Possible ClickDetectors",
			["Shortcut"]="Commands_ClickDetectors",
			["Default"]=true,
			["DontActivate"]=true,
			["Universes"] = {"Global"},
			["Options"]={
				[true]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(0,0,170),
				},
			},
			["CoreFunction"]=function(loopInstance)
				local fireclickdetector = fireclickdetector
				for num, obj in ipairs(loopInstance:GetDescendants()) do
					if obj:IsA("ClickDetector") then
						if obj.MaxActivationDistance > 0 then
							fireclickdetector(obj,1)
							task.spawn(fireclickdetector,obj,0)
						end 
						print("Activated",obj.Parent:GetFullName(),obj.Name)
					end
					if num%1000==0 then
						task.wait(.1)
					end
				end
			end,
			["ActivateFunction"]=function(newValue)
				local LoopValue
				if C.gameUniverse == "Flee" then
					LoopValue = RS:WaitForChild("CurrentMap").Value
				else
					LoopValue = workspace
				end
				C.AvailableHacks.Commands[35].CoreFunction(LoopValue)
				if C.gameUniverse == "Flee" then
					task.wait(.5)
					C.AvailableHacks.Commands[35].CoreFunction(LoopValue)
				end
			end,
		},
		[36]={
			["Type"]="ExTextButton",
			["Title"]="TouchTransmitters",
			["Desc"]="Activates All Possible TouchTransmitters",
			["Shortcut"]="Commands_TouchTransmitters",
			["Default"]=true,
			["DontActivate"]=true,
			["Options"]={
				[true]={
					["Title"]="ACTIVATE",
					["TextColor"]=newColor3(0,50,170),
				},
			},
			["Universes"] = {"Global"},
			["CoreFunction"]=function(loopInstance)
				local fireclickdetector = fireclickdetector
				for num, obj in ipairs(loopInstance:GetDescendants()) do
					if obj:IsA("TouchTransmitter")
						and (C.gameName ~= "GlassBridge" or (obj.Parent and obj.Parent.Parent and obj.Parent.Parent.Parent and 
							obj.Parent.Parent.Parent.Name=="Bridge")) then --and (not obj.Parent.CanCollide or (obj:GetAttribute(C.OriginalCollideName)) <= 0))) then
						local parent = obj.Parent
						local clickfunction = C.AvailableHacks.Basic[25].GlobalTouchTransmitters[parent]
						if clickfunction then
							task.spawn(clickfunction)
							task.delay(5,clickfunction)
						else
							firetouchinterest(C.char.PrimaryPart,parent,0)
							task.spawn(firetouchinterest,C.char.PrimaryPart,parent,1)
						end
						print("TouchActivated",obj.Parent:GetFullName(),obj.Name)
					end
					if num%300==0 then
						task.wait(.1)
					end
				end
			end,
			["ActivateFunction"]=function(newValue)
				local LoopValue
				--if C.gameUniverse == "Flee" then
				--	LoopValue = RS:WaitForChild("CurrentMap").Value
				--else
				LoopValue = workspace
				--end
				C.AvailableHacks.Commands[36].CoreFunction(LoopValue)
			end,
		},
	},
	["Debug"]={
		[36]={
			["Type"]="ExTextButton",
			["Title"]="Print Remote Requests",
			["Desc"]="Prints all Remote Requests To Output",
			["Shortcut"]="Debug_PrintRemoteRequests",
			["Default"]=true,
			["Universes"] = C.PlaceIdsForDebug,
			["ActivateFunction"]=function(newValue)
				if C.gameName == "Bloxburg" then
					local DataService = StringWaitForChild(RS,"Modules.DataService")
					local DataModule = C.requireModule(DataService)
					--DataModule.HookFunction = nil
					local IgnoreTypesList = {"LookDir","FloorPos","CheckOwnsAsset","GetServerTime"}

					for name, funct in pairs(DataModule) do
						if typeof(funct) == "function" and (name=="FireServer") then-- or name=="InvokeServer") then
							warn("Hooked",name)
							local Old = funct
							--[[DataModule[name] = (function(self,...)
								local args = {...}
								local Data = args[1]
								local shouldIgnore = typeof(Data) == "table" and table.find(IgnoreTypesList,Data.Type)
								if not shouldIgnore then
									if name == "FireServer" then
										local returns = {Old(self,table.unpack(args))}
										print("RemoteEvent",args,returns)
										return table.unpack(returns)
									elseif name == "InvokeServer" then
										local returns = {Old(self,table.unpack(args))}
										print("RemoteFunction",args,returns)
										return table.unpack(returns)
									end
								elseif name == "InvokeServer" then
									return Old(self,table.unpack(args))
								end
								return Old(self,table.unpack(args))
							end)--]]
							--[[Old = hookfunction(funct,function(self,...)
								local args = {...}
								local Data = args[1]
								if typeof(Data) ~= "table" or (Data.Type ~="LookDir" and Data.Type~="FloorPos") then
									print("Remote Spy",getcallingscript(),args)
								end
								return Old(self,table.unpack(args))
							end)--]]
							--[[C.Hook(DataService,funct,name,newValue and (function(caller,args)
								local self = args[1]
								local Data = args[2]
								local shouldIgnore = typeof(Data) == "table" and table.find(IgnoreTypesList,Data.Type)
								if not shouldIgnore then
									print(name,caller,select(2,table.unpack(args)))
								end 
								return false--do not change
							end))--]]
						end
					end
				else
					C.Hook(game,"__namecall","fireserver",newValue and (function(method,args)
						local event = args[1]
						if tostring(event.Parent) ~= "DataService" and tostring(event.Parent.Parent) ~= "DataService" then
							print("Remote Spy",getcallingscript(),args)
						end

						return false -- do not change!
					end))
				end
			end,
		},

	}
}
function C.defaultFunction(functName,args)
	if not C.AvailableHacks then
		return;
	end
	for hackType,hackList in pairs(C.AvailableHacks) do
		for num,hackInfo in pairs(hackList) do
			if not hackInfo then continue end
			local funct2Run = hackInfo[functName];
			if funct2Run then
				task.spawn(funct2Run, table.unpack(args));
			end;
		end;
	end;
	for commandIndex, data in pairs(C.CommandFunctions) do
		if not data then continue end
		local funct2Run = data[functName];
		if funct2Run then
			task.spawn(funct2Run, table.unpack(args));
		end;
	end
end;
--BOT TRADE SYS--
if C.gameName=="FleeTrade" then
	for crateName, crateData in pairs(C.requireModule(RS:WaitForChild("ShopCrates"))) do
		if not crateData.CostRobux then
			C.AvailableHacks.Bot[143].Options[crateName]={
				["Title"]=crateData.Name.. " ("..C.comma_value(crateData.Price)..")",
				["TextColor"]=ComputeNameColor(crateData.Name),
			}
			if not C.AvailableHacks.Bot[143].Default then
				C.AvailableHacks.Bot[143].Default = crateName
			end
		end
	end
	local HasBundles = false
	for bundleName, bundleData in pairs(C.requireModule(RS:WaitForChild("ShopBundles"))) do
		if not bundleData.CostRobux then
			C.AvailableHacks.Bot[146].Options[bundleName]={
				["Title"]=bundleData.Name.. " ("..C.comma_value(bundleData.Price)..")",
				["TextColor"]=ComputeNameColor(bundleData.Name),
			}
			C.AvailableHacks.Bot[146].Default = bundleName
			if not C.AvailableHacks.Bot[146].Default then
				C.AvailableHacks.Bot[146].Default = bundleName
			end
			HasBundles = true
		end
	end
	if not HasBundles then
		C.AvailableHacks.Bot[146]=nil
		C.AvailableHacks.Bot[147]=nil
	end
end


--Multi Script Check:
C.saveIndex = ((plr:GetAttribute(getID) or 0)+1)
--print("My SaveIndex:",C.saveIndex)
script.Name = "FleeHacks/"..C.saveIndex
--if plr:GetAttribute("Cleared"..getID) then plr:SetAttribute("Cleared"..getID,false) end
local previousCopy = (plr:GetAttribute(getID)~=nil)
plr:SetAttribute(getID,C.saveIndex)
local attributeChangedSignal
local function attributeAddedFunction()
	local newIndex = plr:GetAttribute(getID)
	if newIndex>C.saveIndex then
		if attributeChangedSignal then
			attributeChangedSignal:Disconnect()
			attributeChangedSignal=nil
		end
		if C.clear==nil then
			C.isCleared=true
			print("Clear Not Found!",C.saveIndex)
			DS:AddItem(script,15)
			return
		end
		--print("Different:",newIndex,C.saveIndex)
		C.clear()
	end
end

--DELETION--
C.clear = function(isManualClear)
	C.isCleared=true
	if GuiElements.HackGUI then
		GuiElements.HackGUI.Enabled=false
	end
	if DraggableMain then DraggableMain:Disable() end
	--plr:SetAttribute(getID,nil)
	if (C.AvailableHacks.Bot[15] and C.AvailableHacks.Bot[15].CurrentPath~=nil) then
		C.AvailableHacks.Bot[15].CurrentPath:Stop()
	end
	if C.gameName == "FleeMain" then
		C.AvailableHacks.Utility[8].CleanUp()--beast hammer
	end
	if C.AvailableHacks.Basic and C.AvailableHacks.Basic[30]  then
		C.AvailableHacks.Basic[30].ActivateFunction(false);--disable char invisibility
	end
	if C.AvailableHacks.Basic and C.AvailableHacks.Basic[25] then
		C.AvailableHacks.Basic[25].ActivateFunction(false);--re-enable transmitter
	end
	--[[for num,obj in ipairs(CS:GetTagged("RemoveOnDestroy")) do
		if obj~=nil then
			for _, tag in ipairs(obj:GetTags()) do
				obj:RemoveTag(tag)
			end
			obj:Destroy();
		end;
	end;--]]
	C.DestroyAllTaggedObjects("RemoveOnDestroy")
	C.PurgeActionsWithTag("RemoveOnDestroy")
	for userID,functList in pairs(C.playerEvents) do
		for num,funct in pairs(functList or {}) do
			funct:Disconnect();
			funct=nil;
		end;
	end;
	if isManualClear then
		getrenv().warn = getgenv().oldWarn
		getrenv().print = getgenv().oldPrint
		--getgenv().currentDesc = nil -- clear the cashe
		--getgenv().JoinPlayerMorphId = nil -- clear the join player id

		if C.gameUniverse == "Flee" then
			if C.gameUniverse=="FleeMain" then
				local spectatorName = StringWaitForChild(PlayerGui,"ScreenGui.SpectatorFrame.SpectatorName",.5)
				if spectatorName then
					spectatorName.TextColor3 = Color3.fromRGB(255,255,255)
				end
			end
			local LocalPlayerScript = C.char:WaitForChild("LocalPlayerScript")
			if LocalPlayerScript then
				LocalPlayerScript.Disabled = true
				LocalPlayerScript.Disabled = false
			end
			if C.Beast == C.char then
				task.delay(0,CAS.UnbindAction,CAS,"Crawl")

				task.spawn(function()
					local LocalClubScript = C.char:FindFirstChild("LocalClubScript",true)
					if LocalClubScript then
						LocalClubScript.Disabled = false
					end
				end)
			end
			local chatBar = StringWaitForChild(PlayerGui,"Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar")
			for num, chatConnection in ipairs(C.GetHardValue(chatBar,"FocusLost",{yield=true})) do
				chatConnection:Enable()
			end
		end
		--local CrawlScript=C.char:WaitForChild("CrawlScript") 
		--if CrawlScript then
		--	CrawlScript.Disabled=false
		--end
		C.AvailableHacks.Utility[2].ActivateFunction(false)--disable override zooming
		if C.AvailableHacks.Utility[7] then
			C.AvailableHacks.Utility[7].ActivateFunction(false,true)--enable touchscreen, if needed!
		end
		if C.AvailableHacks.Utility[5] then
			C.AvailableHacks.Utility[5].ActivateFunction(false)--disable spectate hacks
			local DefaultLightning = game.ReplicatedStorage:FindFirstChild("DefaultLightingSettings") or game.ReplicatedStorage:FindFirstChild("NotDefaultLightingSettings")
			if DefaultLightning then
				DefaultLightning.Name = "DefaultLightingSettings"
			end
			local MapLighting = C.Map and (C.Map:FindFirstChild("_LightingSettings") or C.Map:FindFirstChild("NotLightingSettings"))
			if MapLighting then
				MapLighting.Name = "_LightingSettings"
			end
		end
		C.AvailableHacks.Basic[40].ActivateFunction(false)--disable reset button again!
		C.AvailableHacks.Basic[20].ActivateFunction(false)--make invisible walls unable to walk through again!
	else
		getgenv().enHacks = table.clone(C.enHacks)
	end
	getgenv().TSMGetHooks = {}
	saveSaveData()--save before we delete stuff!
	for hackName,enabled in pairs(C.enHacks) do
		C.enHacks[hackName]=nil;  --disables all running hacks to stop them!
	end;--effectively disables all hacks!
	C.AvailableHacks.Basic[4].ActivateFunction(false);--disble hacks
	C.AvailableHacks.Basic[4].ActivateFunction(false);--disable hacks
	C.AvailableHacks.Basic[1].UpdateSpeed();--disable walkspeed
	if C.human then
		C.human:SetAttribute("OverrideSpeed",nil)
	end

	if C.gameUniverse=="Flee" then
		if C.AvailableHacks.Beast and C.AvailableHacks.Beast[2]  then
			C.AvailableHacks.Beast[2].IsCrawling=false;--disable crawl
			C.AvailableHacks.Beast[2].Crawl(false);--disable crawl
		end
		if C.gameName=="FleeMain" then
			trigger_setTriggers("Override",{})--Before it removes tags, undo setting triggers!
		end
	end
	for num,tagPart in ipairs(CS:GetTagged("Trigger_AllowException")) do
		tagPart:SetAttribute("Trigger_AllowException",nil)
	end
	local allTheTages = {"WalkThruDoor","Computer","Trigger","Capsule","DoorAndExit","Door","DoorTrigger","Exit","Trigger_AllowException"}
	for num,tagName in ipairs(allTheTages) do
		local loopList = CS:GetTagged(tagName)
		for num,tagPart in ipairs(loopList) do
			CS:RemoveTag(tagPart,tagName)
		end--]]
	end
	for category, categoryList in pairs(C.AvailableHacks or {}) do
		for index,tbl in pairs(categoryList) do
			local funcList = tbl and tbl.Functs or {}
			if tbl and tbl.Funct then
				table.insert(funcList,tbl.Funct)
			end
			for _, funct in ipairs(funcList) do
				local check = (funct and typeof(funct))
				if (check=="RBXScriptConnection") then
					funct:Disconnect()
				end
			end
		end
	end
	for num,funct in pairs(C.functs) do
		funct:Disconnect()
		funct=nil
	end
	for name,data in pairs(C.CommandFunctions or {}) do
		for num, funct in ipairs(data.Functs or {}) do
			funct:Disconnect()
		end
	end
	--HOOK UNBINDING
	--print(RBXHooks)
	for instance, hookData in pairs(RBXHooks or {}) do
		--print(instance)
		for root, methodData in pairs(hookData) do
			--print(root)
			for index, indexFunct in pairs(methodData) do
				--for index,funct in pairs(methodFuncts) do
				--print("Disabled",index,indexFunct)
				if index=="List" then
					for index2, funct in pairs(indexFunct) do
						indexFunct.List[index2] = nil
					end
				elseif index=="Event" then
					indexFunct:Fire(nil)
				else
					methodData[index] = nil -- Remove the instances, we don't need to clear anything else!
				end
				--end
			end
		end
	end
	hackChanged:Fire()
	hackChanged:Destroy()
	CAS:UnbindAction("hack_jump"..C.saveIndex)
	CAS:UnbindAction("Crawl"..C.saveIndex)
	CAS:UnbindAction("CloseMenu"..C.saveIndex)
	CAS:UnbindAction("PushSlash"..C.saveIndex)
	CAS:UnbindAction("OpenBetterConsole"..C.saveIndex)
	CAS:UnbindAction("hack_jump2"..C.saveIndex)
	CAS:UnbindAction("AutoRemoveRope"..C.saveIndex)
	RunS:UnbindFromRenderStep("Follow"..C.saveIndex)


	for num, thing2Clear in pairs({"objectFuncts"}) do
		local searchList = C[thing2Clear] or {}
		for obj,objectEventsList in pairs(searchList) do
			local insideSearchList = objectEventsList or {}
			for value,functList in pairs(insideSearchList) do
				for index, funct in pairs(functList) do
					if funct~=nil then
						funct:Disconnect()
						funct=nil
					end
				end--]]
				--[[if functList then
					functList:Disonncet()
				end--]]
			end
		end
	end
	--[[for obj, objEventsList in pairs(C.attributeFuncts) do
		for property, functList in pairs(objEventsList) do
			for index, funct in pairs(functList) do
				funct:Disconnect()
				funct=nil
			end
		end
	end--]]


	getgenv()["ActiveScript"..getID][C.saveIndex] = nil


	plr:SetAttribute("Cleared"..getID,(plr:GetAttribute("Cleared") or 0)+1)
	DS:AddItem(GuiElements.HackGUI,1)
	if isStudio then DS:AddItem(script,1) end
	--print("I started clearing",C.saveIndex)
	C.clear=nil
end

if script==nil or plr:GetAttribute(getID)~=C.saveIndex then
	attributeAddedFunction()
	return "Saved Index Changed (Code 101)"
end
attributeChangedSignal = plr:GetAttributeChangedSignal(getID):Connect(attributeAddedFunction)
table.insert(C.functs,attributeChangedSignal)

--C.PlayerControlModule = StringWaitForChild(plr,"PlayerScripts.PlayerModule.ControlModule",1) or StringWaitForChild(plr,"PlayerScripts.ControlScript.MasterControl",1)

for num, module in ipairs(getloadedmodules(true)) do
	if module and (module.Name == "MasterControl" or module.Name == "ControlModule") then
		C.PlayerControlModule = C.requireModule(module)
		break
	end
end




--Anti Main Check:
local function iterPageItems(page)
	local PlayersFriends = {}
	while true do
		local info = (page and page:GetCurrentPage()) or ({})
		for i, friendInfo in pairs(info) do
			table.insert(PlayersFriends, {SortName = friendInfo.Username, UserId = friendInfo.Id})
		end
		if not page.IsFinished then 
			page:AdvanceToNextPageAsync()
		else
			break
		end
	end
	return PlayersFriends
end
getgenv()["ActiveScript"..getID] = getgenv()["ActiveScript"..getID] or {} 
if previousCopy then
	local changedEvent=Instance.new("BindableEvent",script)
	local startTime=os.clock()
	local maxWaitTime=5
	local function maxWaitTimeReturnFunction()
		if not changedEvent or not changedEvent.Parent then
			return
		end
		changedEvent:Fire(true)
	end
	task.delay(maxWaitTime,maxWaitTimeReturnFunction)
	changedEvent:AddTag("RemoveOnDestroy")
	local function clearFunct()
		changedEvent:Fire()
	end
	local clearedConnection=(plr:GetAttributeChangedSignal("Cleared"..getID):Connect(clearFunct))
	local currentSize = C.getDictLength(getgenv()["ActiveScript"..getID])
	task.delay(1,changedEvent.Fire,changedEvent)
	while currentSize>0 do
		local timeOut = changedEvent.Event:Wait()
		--[[while currentSize == C.getDictLength(getgenv()["ActiveScript"..getID]) do
			warn("waiting",C.getDictLength(getgenv()["ActiveScript"..getID]),currentSize,getgenv()["ActiveScript"..getID])
			RunS.RenderStepped:Wait()
		end--]]
		RunS.RenderStepped:Wait()
		currentSize = C.getDictLength(getgenv()["ActiveScript"..getID])
		if C.isCleared then
			DS:AddItem(script,1)
			clearedConnection:Disconnect()
			return "Cleared While Waiting (Code 102)"
		end
		if timeOut then
			warn(( "Maximum Wait Time Reached ("..maxWaitTime.."s), Starting Script..." ))
			break
		elseif currentSize>0 then
			--C.createCommandLine("Dict Length Still Larger Than Zero After One Cycle!\nThis may have occured if one or more instances already exist!",print)
			print("Dict Length Still Larger Than Zero After One Cycle!\nThis may have occured if one or more instances already exist! Current Size: "..currentSize)
		end
	end
	changedEvent:Destroy()
	clearedConnection:Disconnect()
	clearedConnection=nil
end
if C.isCleared then
	DS:AddItem(script,1)
	return "After Waiting Cleared (Code 103)"
end
getgenv()["ActiveScript"..getID][C.saveIndex] = true
--local startTime = os.clock()--DEL
--print(("Starting Instance %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

local numOfFriends = (0) 
local savedFriendsCashe = {}

function C.GetFriendsFunct(userID)
	local friendsTable = savedFriendsCashe[userID]
	if not friendsTable then
		local canExit,friendsPages
		while true do
			canExit,friendsPages = pcall(PS.GetFriendsAsync,PS,userID) -- it complains if we get it too much!
			if canExit then
				break
			end
			task.wait(3)
		end
		friendsTable = iterPageItems(friendsPages)
		savedFriendsCashe[userID] = table.clone(friendsTable)
	end
	return friendsTable
end

local success, err = pcall(checkFriendsPCALLFunction);

if (not success) then
	warn(("Error getting friends!"), (err));
end;
local mainAccountDetected = (success and ((#err)>=(15)) and not isStudio);
if mainAccountDetected then
	plr:Kick("Anti Main Hack: Main Account Detected!");
	C.clear(true)
	return
end;
--print(("Friend Check Finished %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

local function resetEventFunction()
	if C.AvailableHacks.Commands[24] then
		C.AvailableHacks.Commands[24].ActivateFunction();
	end;
end;
ResetEvent = Instance.new("BindableEvent");
ResetEvent.Event:Connect(resetEventFunction);
CS:AddTag(ResetEvent, "RemoveOnDestroy");
ResetEvent.Parent = RS;

-- GUI CREATION / Instances:

GuiCreationFunction();
GuiCreationFunction = nil;

--print(("Gui Creation Finished %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

--JUMP CONTROL
jumpChangedEvent = Instance.new("BindableEvent")
function jumpAction(actionName, inputState, inputObject)
	if inputState == Enum.UserInputState.Begin and not isJumpBeingHeld then
		isJumpBeingHeld = true
	elseif (inputState == Enum.UserInputState.End or inputState==Enum.UserInputState.Cancel) and isJumpBeingHeld then
		isJumpBeingHeld = false
	else
		return
	end
	jumpChangedEvent:Fire(isJumpBeingHeld)
end
task.spawn(function()
	local JumpButton = plr.PlayerGui:WaitForChild("TouchGui",math.huge):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton",math.huge);
	table.insert(C.functs, JumpButton:GetPropertyChangedSignal("ImageRectOffset"):Connect(function()
		local org = isJumpBeingHeld
		if JumpButton.ImageRectOffset.X > 3 then
			isJumpBeingHeld = true;
		else
			isJumpBeingHeld = false;
		end
		if not org then
			jumpChangedEvent:Fire(isJumpBeingHeld)
		end
	end))
end)
CS:AddTag(jumpChangedEvent,"RemoveOnDestroy")

CAS:BindAction("hack_jump"..C.saveIndex,jumpAction,false, Enum.PlayerActions.CharacterJump)

--GUI CODING
local refreshTypes = ({
	ExTextButton = function(hackFrame,hackInfo,isFirstRun)
		local selectedKey = (C.enHacks[hackInfo.Shortcut]);
		local selectedOption = hackInfo.Options[selectedKey];
		local ToggleButton = hackFrame:WaitForChild("Toggle",60)
		if C.isCleared then
			if not ToggleButton then
				return --error("SEEMS GOOD: TOGGLE DOESN'T EXIST FOR "..hackInfo.Title)
			end
			return
		elseif not ToggleButton then
			return error("WHERE DID TOGGLE GO FOR "..hackInfo.Title)
		end
		--print(hackInfo.Shortcut, selectedKey, selectedOption);
		assert(selectedOption, hackInfo.Title.." doesn't have options with default value!")

		ToggleButton.Text = selectedOption.Title;
		ToggleButton.TextColor3 = selectedOption.TextColor;
		if hackInfo.ActivateFunction then
			if not hackInfo.DontActivate then
				task.spawn(hackInfo.ActivateFunction, C.enHacks[hackInfo.Shortcut], isFirstRun);
			else
				hackInfo.DontActivate=false;
			end;
		end;
		hackChanged:Fire();
	end,
	ExTextBox = function(hackFrame,hackInfo,isFirstRun)
		hackFrame.TextBox.Text = C.enHacks[hackInfo.Shortcut]
		if hackInfo.ActivateFunction then
			if not hackInfo.DontActivate then
				task.spawn(hackInfo.ActivateFunction, C.enHacks[hackInfo.Shortcut], isFirstRun)
			else 
				hackInfo.DontActivate=false
			end
		end	
		hackChanged:Fire()
	end,
})
local initilizationTypes = ({
	ExTextButton = (function(hackInfo)
		local hackFrame = hackInfo.MiniHackFrame;
		
		local putIntoArray ={}
		for Type,Vals in pairs(hackInfo.Options) do
			table.insert(putIntoArray,{Type=Type,Vals=Vals})
		end
		table.sort(putIntoArray,function(a,b)
			return tostring(a.Type):lower() < tostring(b.Type):lower()
		end)
		--local lastClick = os.clock()-10
		local function cycle(delta)
			--[[if hackInfo.Deb then
				local currentTime = os.clock()
				if currentTime - lastClick < hackInfo.Deb then
					return
				end
				lastClick = currentTime
			end--]]
			local totalNum, shortCutNum = 0, 0;
			for index,ValsAndType in ipairs(putIntoArray) do
				local Type,Vals = ValsAndType.Type, ValsAndType.Vals
				if not Vals.Locked then
					totalNum = totalNum + 1;
					local condition = Type==C.enHacks[hackInfo.Shortcut]; 
					if (condition) then
						shortCutNum = totalNum;
					end;
				end
			end
			if delta>0 then
				if (shortCutNum+delta<=totalNum) then
					shortCutNum+=delta
				else
					shortCutNum = 1
				end
			elseif delta<0 then
				if (shortCutNum+delta>0) then
					shortCutNum+=delta
				else
					shortCutNum = totalNum
				end
			end
			totalNum=0
			for index,ValsAndType in ipairs(putIntoArray) do
				local Type,Vals = ValsAndType.Type, ValsAndType.Vals
				if not Vals.Locked then
					totalNum = totalNum + 1
					if (totalNum==shortCutNum) then
						C.enHacks[hackInfo.Shortcut] = Type
						break
					end
				end
			end
			refreshTypes.ExTextButton(hackFrame,hackInfo)
		end
		--[[local isDown
		local function hackFrameToggleButtonFunction()
			if (not isDown or os.clock() - isDown > .5) then
				return
			end
			isDown = nil
			cycle(1)
		end
		local HackFrameMSBUp2 = hackFrame.Toggle.MouseButton1Down:Connect(function()
			isDown = os.clock()
		end)
		table.insert(C.functs,HackFrameMSBUp2)
		local HackFrameMSBUp = hackFrame.Toggle.MouseButton1Up:Connect(hackFrameToggleButtonFunction)
		table.insert(C.functs,HackFrameMSBUp)
		if ((C.getDictLength(hackInfo.Options))>=(2)) then
			local function hackFrameReverseToggleButtonFunction()
				
				cycle(-1)
			end
			local MSBUp = hackFrame.Toggle.MouseButton2Up:Connect(hackFrameReverseToggleButtonFunction)
			table.insert(C.functs,MSBUp)
		end--]]
		local function Button1Clicked(button,builtInDebounce)
			assert(button,"invalid args!")
			assert(button:IsA("TextButton") or button:IsA("ImageButton"),button:GetFullName().."must be a TextButton or ImageButton!")
			local debounceLastPress = 0
			local lastClickTime,lastClickPoso=0,Vector2.new()
			local bindableEvent = Instance.new("BindableEvent")
			bindableEvent.Name = "Button1Clicked"
			table.insert(C.functs, button.MouseButton1Down:Connect(function(x,y)
				lastClickTime,lastClickPoso=os.clock(),Vector2.new(x,y-36)
			end))
			table.insert(C.functs, button.MouseButton1Up:Connect(function(x,y)
				if builtInDebounce and os.clock()-debounceLastPress<builtInDebounce then return end
				local clickPosition = Vector2.new(x,y-36)
				if (lastClickPoso-clickPosition).Magnitude>10 then return end
				if os.clock()-lastClickTime>0.25 then return end
				lastClickTime,lastClickPoso=0,Vector2.new()
				bindableEvent:Fire(Enum.UserInputType.MouseButton1, clickPosition.X,clickPosition.Y)
				debounceLastPress = os.clock()
			end))
			table.insert(C.functs, button.MouseButton2Down:Connect(function(x,y)
				lastClickTime,lastClickPoso=os.clock(),Vector2.new(x,y-36)
			end))
			table.insert(C.functs, button.MouseButton2Up:Connect(function(x,y)
				if builtInDebounce and os.clock()-debounceLastPress<builtInDebounce then return end
				local clickPosition = Vector2.new(x,y-36)
				if (lastClickPoso-clickPosition).Magnitude>10 then return end
				if os.clock()-lastClickTime>0.25 then return end
				lastClickTime,lastClickPoso=0,Vector2.new()
				bindableEvent:Fire(Enum.UserInputType.MouseButton2, clickPosition.X,clickPosition.Y)
				debounceLastPress = os.clock()
			end))
			table.insert(C.functs, button.Destroying:Connect(function()
				bindableEvent:Destroy()
			end))

			bindableEvent.Parent=button
			return bindableEvent.Event
		end
		Button1Clicked(hackFrame.Toggle,hackInfo.Deb):Connect(function(userinputtype)
			cycle(userinputtype == Enum.UserInputType.MouseButton1 and 1 or -1)
		end)
	end),
	ExTextBox = function(hackInfo)
		local hackFrame

		local hackInfoShortcut = hackInfo.Shortcut;

		hackFrame = hackInfo.MiniHackFrame;


		local theTextBox = hackFrame:WaitForChild("TextBox");
		local theTextBoxFocusLost_FUNCTION = theTextBox["FocusLost"];
		local myFocusLost_CONNECTION = theTextBoxFocusLost_FUNCTION:Connect(function()
			local toNumber = tonumber(hackFrame.TextBox.Text);
			if toNumber then
				local setNumber = math.clamp(toNumber, hackInfo.MinBound, hackInfo.MaxBound);
				C.enHacks[hackInfoShortcut] = setNumber;
			else
				local defaultBracket = hackInfo.Default;
				C.enHacks[hackInfoShortcut] = defaultBracket;
			end;
			refreshTypes.ExTextBox(hackFrame, hackInfo);
		end);
		table.insert(C.functs, myFocusLost_CONNECTION);

	end,
})
loadSaveData()

--print(("Hacks Starting %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

if C.Modules.Developer then
	C.Modules.Developer(C,_SETTINGS)
end
--Load game specific module!
if C.Modules[C.gameName] then
	C.Modules[C.gameName](C,_SETTINGS)
end

GuiElements.TempStoreCache = {}

for categoryName, differentHacks in pairs(C.AvailableHacks) do
	local newButton, newProperty
	for num,hack in pairs(differentHacks) do
		if C.isCleared then
			return "Load Hacks Cleared (Code 104)"
		elseif not hack then
			differentHacks[num] = nil -- clear this so that it isn't referenced again-
			continue -- skip this lolo!
		end
		local overrideCategoryName = hack.CategoryAlias or categoryName
		local canPass = overrideCategoryName=="Basic" or (((hack.Universes and (table.find(hack.Universes,"Global") or table.find(hack.Universes,C.gameUniverse))) or (not hack.Universes and not hack.Places and C.gameName=="FleeMain")) or (hack.Places and table.find(hack.Places,C.gameName)))
			and (overrideCategoryName~="Developer" or _SETTINGS.developer);
		if canPass then
			if not newButton or not newProperty or overrideCategoryName ~= categoryName then
				local Data = GuiElements.TempStoreCache[overrideCategoryName]
				if Data then
					newButton, newProperty = table.unpack(Data)
				else
					newButton = GuiElements.MainListEx:Clone()
					newButton.Text = overrideCategoryName
					newButton.TextColor3 = ComputeNameColor(overrideCategoryName)
					newButton.Name = overrideCategoryName
					newButton.LayoutOrder = (overrideCategoryName=="Commands" and 1 or 0)
					newButton.Parent=GuiElements.myList

					newProperty = GuiElements.PropertiesEx:Clone()
					newProperty.Parent = GuiElements.Properties
					newProperty.Name = overrideCategoryName
					newProperty.Visible=false
					local saveNewProperty, saveNewButton = newProperty, newButton
					local function newButtonMB1Up()
						C.Console.Visible = false
						GuiElements.Properties.Visible = true
						for num,prop in pairs(GuiElements.Properties:GetChildren()) do
							if prop.ClassName=="ScrollingFrame" then
								prop.Visible = (prop==saveNewProperty)
							end
						end
						for num,button in pairs(GuiElements.myList:GetChildren()) do
							if button.ClassName=="TextButton" then
								button.Font = (button==saveNewButton and textFontBold or textFont)
							end
						end
					end
					newButton.MouseButton1Up:Connect(newButtonMB1Up)--This should be cleaned up automatically!
					GuiElements.TempStoreCache[overrideCategoryName] = {newButton,newProperty}
				end
			end

			if C.enHacks[hack.Shortcut] ~= nil then
				warn(`⚠️⚠️HACK TYPE DUPLICATE FOUND: {hack.Shortcut} in {overrideCategoryName}, ONE IS {differentHacks.Title}⚠️⚠️`)	
			end

			hack.Options = (hack.Options or (defaultOptionsTable))
			assert(C.getDictLength(hack.Options)>0,("Options Table Empty for "..overrideCategoryName.." "..hack.Title))
			local overrideDefault
			if not hack.ForceDefault then
				if GlobalSettings.enHacks and GlobalSettings.enHacks[hack.Shortcut]~=nil then
					overrideDefault = GlobalSettings.enHacks[hack.Shortcut]

				end
				if overrideDefault==nil and getgenv().enHacks then
					overrideDefault = getgenv().enHacks[hack.Shortcut]
				end
				if overrideDefault==nil then
					overrideDefault = loadedEnData[hack.Shortcut]
				end
				if overrideDefault~=nil and ((hack.Type=="ExTextButton" and hack.Options[overrideDefault] == nil) or 
					(hack.Type=="ExTextBox" and (typeof(overrideDefault) ~= "number" or overrideDefault < hack.MinBound or overrideDefault > hack.MaxBound))) then
					warn("Invalid Option For "..tostring(hack.Title)..": "..tostring(overrideDefault)..". Reverting To Original...")
					overrideDefault = nil
				end
			end
			if overrideDefault~=nil then
				C.enHacks[hack.Shortcut]=overrideDefault;
			else
				C.enHacks[hack.Shortcut]=hack.Default;
			end
			--print(hack.Shortcut,hack.Type);
			local miniHackFrame = GuiElements.TextBoxExamples[hack.Type]:Clone();
			miniHackFrame.Parent = newProperty;
			miniHackFrame.Name = hack.Title;
			miniHackFrame.Title.Text = hack.Title;
			miniHackFrame.Desc.Text = hack.Desc;
			miniHackFrame.LayoutOrder = num;
			hack.MiniHackFrame = miniHackFrame
			task.spawn(refreshTypes[hack.Type], miniHackFrame, hack, true);

			local initilizationType_FUNCTION = initilizationTypes[hack.Type];
			task.spawn(initilizationType_FUNCTION,hack);
			local update_Function = refreshTypes[hack.Type]
			C.refreshEnHack[hack.Shortcut] = function(new)
				if C.enHacks[hack.Shortcut] == new then
					return
				end
				C.enHacks[hack.Shortcut] = new
				update_Function(miniHackFrame,hack)
			end
		else
			differentHacks[num]=nil
		end
		if overrideCategoryName ~= categoryName then
			newButton, newProperty = nil, nil
		end
	end
end

--print(("Hacks Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

--COMMAND BAR CONTROL

local function consoleButtonControlFunction()
	C.Console.Visible = not C.Console.Visible
	GuiElements.Properties.Visible = not GuiElements.Properties.Visible
end

C.ConsoleButton.MouseButton1Up:Connect(consoleButtonControlFunction)

getrenv().Outfits = getrenv().Outfits or {}
getgenv().currentDesc = getgenv().currentDesc or {}


--HACK CONTROL
local function BeastAdded(theirPlr,theirChar)
	local Hammer = C.GetBeastHammerFunct(theirPlr)
	if not Hammer or not theirChar.Parent or not Hammer.Parent then
		return
	end
	C.Beast=theirChar;
	local inputArray = {
		theirPlr, 
		theirChar
	};
	local function2Input = theirPlr==plr and "MyBeastAdded" or "OthersBeastAdded";
	C.defaultFunction(function2Input,inputArray);
	C.defaultFunction("BeastAdded",inputArray);
	table.insert(C.functs,Hammer.Destroying:Connect(function(newParent)
		--if newParent then
		--return
		--end
		--warn("Hammer Destroying!")
		C.Beast=nil
		local inputArray = {theirPlr,theirChar}
		C.defaultFunction((theirPlr==plr and "MyBeastRemoved" or "OthersBeastRemoved"),(inputArray))
	end))
end
local function CharacterAdded(theirChar,firstRun)
	if C.isCleared then
		return
	end
	TPStack = {}--clears TPStack!
	isTeleporting = false--if its still teleporting then stap it!
	local HRP=theirChar:WaitForChild("HumanoidRootPart",1) or theirChar.PrimaryPart
	task.wait()
	local theirPlr=PS:GetPlayerFromCharacter(theirChar)
	if not theirPlr then
		return
	end
	local theirHumanoid=theirChar:WaitForChild("Humanoid")

	if not firstRun and theirPlr:GetAttribute("CharacterNotInit") then
		firstRun = true
		theirPlr:SetAttribute("CharacterNotInit",nil)
	end

	local isMyChar=theirPlr==plr
	if isMyChar then
		C.char=theirChar
		C.human=theirHumanoid
	end
	local inputFunctions = {theirPlr,theirChar,firstRun}
	C.defaultFunction(isMyChar and "MyStartUp" or "OthersStartUp",inputFunctions)
	C.defaultFunction("StartUp",inputFunctions)
	C.objectFuncts[theirHumanoid] = C.objectFuncts[theirHumanoid] or {}
	C.objectFuncts[theirHumanoid]["Died"] = {theirHumanoid.Died:Connect(function()
		C.defaultFunction(isMyChar and "MyDeath" or "OthersDeath",inputFunctions)
	end)}
	if isMyChar then
		local lastSeat
		C.objectFuncts[theirHumanoid]["Seated"] = {theirHumanoid.Seated:Connect(function(active,seatPart)
			C.defaultFunction(active and "MySeatAdded" or "MySeatRemoved",{seatPart or lastSeat})
			lastSeat = seatPart
		end)}
		if theirHumanoid.SeatPart then
			lastSeat = theirHumanoid.SeatPart
			C.defaultFunction("MySeatAdded",{theirHumanoid.SeatPart})
		end
	end
	if C.gameUniverse=="Flee" then
		local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule");
		local theirTSM_module = require(theirTSM);
		if theirTSM then
			local isBeastValue = theirTSM:WaitForChild("IsBeast");
			if isBeastValue and isBeastValue.Value then
				BeastAdded(theirPlr,theirPlr.Character);
			end
		end
		if C.gameName=="FleeMain" and C.Map and C.Map.Parent and isMyChar and not firstRun
			and select(2,C.isInGame(theirChar)) == "Runner" then
			local SpawnPad = C.Map:WaitForChild("OBSpawnPad")
			if SpawnPad then
				teleportMyself(SpawnPad:GetPivot() + Vector3.new(0,C.getHumanoidHeight(theirChar),0))
				print("My Teleport Function :P")
			end
		end
	end
end
local function CharacterRemoving(theirPlr,theirChar)
	if C.isCleared then 
		return 
	end
	local isMyChar=theirPlr==plr
	local inputFunctions = ({theirPlr,theirChar})
	C.defaultFunction((isMyChar and "MyShutDown" or "OthersShutDown"),inputFunctions)
end
C.savedCommands = getgenv().lastCommands
if not C.savedCommands then
	C.savedCommands = {}
	getgenv().lastCommands = C.savedCommands
end
function C.RunCommand(inputMsg,shouldSave,noRefresh,canYield)
	if shouldSave then
		table.insert(C.savedCommands,1,inputMsg)
		if #C.savedCommands > 10 then
			table.remove(C.savedCommands,#C.savedCommands)
		end
	end

	local args = inputMsg:sub(2):split(" ")
	local inputCommand = args[1]
	table.remove(args,1)
	for index = 1, 3, 1 do
		args[index] = args[index] or "" -- leave them be empty so it doesn't confuse the game!
	end
	local command, CommandData = C.StringStartsWith(C.CommandFunctions,inputCommand)
	if CommandData then
		if CommandData.RequiresRefresh and noRefresh then
			return
		end
		local canRunFunction = true
		local ChosenPlr = args[1]
		if CommandData.Type=="Players" or CommandData.Type=="Player" then
			if ChosenPlr=="all" then
				args[1] = PS:GetPlayers()
			elseif ChosenPlr == "others" then
				args[1] = PS:GetPlayers()
				table.remove(args[1],table.find(args[1],plr))
				if #args[1]==0 then
					canRunFunction = false
					C.CreateSysMessage(`No other players found`)
				end
			elseif ChosenPlr == "me" or ChosenPlr == "" then
				args[1] = {plr}
			elseif ChosenPlr == "random" then
				args[1] = {PS:GetPlayers()[Random.new():NextInteger(1,#PS:GetPlayers())]}
			elseif ChosenPlr == "new" then
				if not CommandData.SupportsNew then
					canRunFunction = false
					C.CreateSysMessage(`{command} doesn't support "new" players`)
				end
				args[1] = "new"
			else
				_, ChosenPlr = C.StringStartsWith(PS:GetPlayers(),args[1])
				if ChosenPlr then
					args[1] = {ChosenPlr}
				else
					canRunFunction = false
					C.CreateSysMessage(`Player(s) Not Found: {command}; allowed: all, others, me, <plrName>`)
				end
			end
			if canRunFunction and CommandData.Type=="Player" and #args[1]>1 then
				canRunFunction = false
				C.CreateSysMessage(`{command} only supports a single player`)
			end
		elseif CommandData.Type=="" then
			--do nothing
		elseif CommandData.Type~=false then
			canRunFunction = false
			C.CreateSysMessage(`Internal Error: Command Implemented But Not Supported: {command}, {tostring(CommandData.Type)}`)
		end
		if canRunFunction then
			local function yieldFunction()
				local returns = table.pack(C.CommandFunctions[command].Run(args))
				local wasSuccess = returns[1]
				table.remove(returns,1)
				local displayNameCommand = command:sub(1,1):upper() .. command:sub(2)
				if wasSuccess then
					local length = #args[1]
					local playersAffected = 
						(typeof(ChosenPlr)=="Instance" and (ChosenPlr==plr and ChosenPlr.Name) or ChosenPlr.Name) 
						or (ChosenPlr:sub(1,1):upper() .. 
							ChosenPlr:sub(2,ChosenPlr:sub(ChosenPlr:len())=="s" and ChosenPlr:len()-1 or ChosenPlr:len()))
					if playersAffected == plr.Name then
						playersAffected = "you"
					end
					returns[1] = returns[1] or ""
					C.CreateSysMessage(`{displayNameCommand}ed {(playersAffected)}{(CommandData.AfterTxt or ""):format(table.unpack(returns)):gsub("  "," ")}`,
						Color3.fromRGB(255,255,255))
				else
					C.CreateSysMessage(
						`{displayNameCommand} Error: {returns[1] or `unknown RET for {displayNameCommand}`}`,
						Color3.fromRGB(255))
				end
			end
			if canYield then
				yieldFunction()
			else
				task.spawn(yieldFunction)
			end
		end
	elseif inputCommand~="c" and inputCommand~="whisper" and inputCommand~="mute" and inputCommand~="block" and inputCommand~="unblock"
		and inputCommand~="unmute" and inputCommand~="e" then
		C.CreateSysMessage(`Command Not Found: {inputCommand}`)
	end
end
local function processPlayerMessage(data,noRefresh,shouldYield)
	if data.MessageType == "Message" then
		local message = data.Message
		local theirPlr = PS:GetPlayerByUserId(data.SpeakerUserId)
		if theirPlr then
			if theirPlr ~= plr and _SETTINGS.myBots[theirPlr.Name:lower()] and _SETTINGS.botModeEnabled then
				if message:sub(1,1) == "/" then
					C.RunCommand(message,false,noRefresh==true,shouldYield)--message:sub(2),theirPlr == plr)
				end
			end
		else
			warn("(ChatMessage) Player Not Found!")
		end
	end
end
if C.saveIndex == 1 and C.gameUniverse=="Flee" and _SETTINGS.botModeEnabled then--C.saveIndex == 1 and C.gameUniverse == "Flee" then
	task.delay(1,function()
		for num, value in ipairs(game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents").GetInitDataRequest:InvokeServer().Channels[2][3]) do
			processPlayerMessage(value,true,true)
		end
	end)
end
if C.gameUniverse == "Flee" and _SETTINGS.botModeEnabled then
	table.insert(C.functs, StringWaitForChild(RS,"DefaultChatSystemChatEvents.OnMessageDoneFiltering").OnClientEvent:Connect(processPlayerMessage))
end
local function PlayerAdded(theirPlr)
	local isMe = (plr==theirPlr)
	C.playerEvents[theirPlr.UserId] = {}
	if theirPlr.Character~=nil then
		task.spawn(CharacterAdded,theirPlr.Character,true)
	else
		theirPlr:SetAttribute("CharacterNotInit",true)
	end
	local myPlayerAddedInputArray = {theirPlr}
	local characterFunctionName = "OthersPlayerAdded";
	if isMe then
		characterFunctionName = "MyPlayerAdded";
	end
	C.defaultFunction(characterFunctionName, myPlayerAddedInputArray);
	local CharacterAddedConnection = theirPlr.CharacterAdded:Connect(CharacterAdded);
	table.insert(C.playerEvents[theirPlr.UserId], CharacterAddedConnection);
	local function characterRemovingFunction(removingChar)
		CharacterRemoving(theirPlr,removingChar);
	end
	--bro please work!

	local PlayerAddedConnection = theirPlr.CharacterRemoving:Connect(characterRemovingFunction);
	table.insert(C.playerEvents[theirPlr.UserId], PlayerAddedConnection);
	if _SETTINGS.myBots[theirPlr.Name:lower()] and _SETTINGS.botModeEnabled then
		if C.gameUniverse~="Flee" then
			--print("Listening Chat Messages",theirPlr.Name)
			table.insert(C.playerEvents[theirPlr.UserId], theirPlr.Chatted:Connect(function(message)
				--[[if message:sub(1,1) == "/" then
					C.RunCommand(message,false)--";"..message:sub(2),false)
				end--]]
				processPlayerMessage({
					MessageType = "Message", 
					SpeakerUserId = theirPlr.UserId, 
					Message = message})
			end))
		end
	end

	--if C.gameUniverse=="Flee" then
	if isMe then
		--MY PLAYER CHAT
		local chatBar
		local index = 0
		local hasNewChat = TCS.ChatVersion == Enum.ChatVersion.TextChatService
		local function registerNewChatBar(_,firstRun)
			local sendButton = hasNewChat and StringWaitForChild(game.CoreGui,"ExperienceChat.appLayout.chatInputBar.Background.Container.SendButton")
			chatBar = StringWaitForChild(not hasNewChat and PlayerGui or game.CoreGui,not hasNewChat and 
				"Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar" or "ExperienceChat.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox")

			local sendTheMessage
			if hasNewChat then
				sendButton.Visible = false
				local mySendButton = sendButton:Clone()
				mySendButton.Parent = sendButton.Parent
				mySendButton.Visible = true
				mySendButton.Name = "MySendButton"
				mySendButton:AddTag("RemoveOnDestroy")
				sendTheMessage = function(message,dontSetTB)
					message = typeof(message)=="string" and message or chatBar.Text
					if message == "" then
						return
					end
					local channels = TCS:WaitForChild("TextChannels")
					local myChannel = channels.RBXGeneral
					local targetChannelTB = chatBar.Parent.Parent.TargetChannelChip
					if targetChannelTB.Visible then
						local theirUser = targetChannelTB.Text:sub(5,targetChannelTB.Text:len()-1)
						local theirPlr
						for num, thisPlr in ipairs(PS:GetPlayers()) do
							if thisPlr.Name == theirUser or thisPlr.DisplayName == theirUser then
								if theirPlr then
									warn(`(SendMessage) DUPLICATE Players Found For Display Name "{theirUser}"`)
								end
								theirPlr = thisPlr
							end
						end
						if theirPlr then
							myChannel = channels:FindFirstChild("RBXWhisper:"..plr.UserId.."_"..theirPlr.UserId) or channels:FindFirstChild("RBXWhisper:"..theirPlr.UserId.."_"..plr.UserId)
							if not myChannel then
								return warn(`(SendMessage) Could Not Find MyChannel {"RBXWhisper:"..plr.UserId.."_"..theirPlr.UserId} or {"RBXWhisper:"..theirPlr.UserId.."_"..plr.UserId}`)
							end
						else
							return warn(`(SendMessage) Could Not Find Private Message User {theirUser} from "{targetChannelTB.Text}"`)
						end
					end
					myChannel:SendAsync(message)
					if dontSetTB~=false then
						chatBar.Text = ""
					end
				end
				table.insert(C.functs,mySendButton.MouseButton1Up:Connect(sendTheMessage))
				mySendButton.Destroying:Connect(function()
					if sendButton then
						sendButton.Visible = true
					end
				end)
			end
			local connectionsFuncts = {}
			for num, connection in ipairs(C.GetHardValue(chatBar,"FocusLost",{yield=true})) do
				connection:Disable()
				table.insert(connectionsFuncts,connection)
			end
			--[[table.insert(C.functs,chatBar.InputChanged:Connect(function(Key,GameProcessed)
				print(Key.KeyCode.Name)
				--if not chatBar or not chatBar:IsFocused() then
				--	return
				--end
				if true then return end
				print("KeyCode",Key.KeyCode.Name)
				if Key.KeyCode == Enum.KeyCode.Up then
					index+=1
				elseif Key.KeyCode == Enum.KeyCode.Down then
					index-=1
				else
					return
				end
				index = math.clamp(1,#savedCommands)

				chatBar.Text = savedCommands[index]
				print("Set To",savedCommands[index])
			end))--]]
			local lastText
			local lastUpd = -5
			local function textUpd()
				if not chatBar or not chatBar:IsFocused() then--or os.clock() - lastUpd < .1 then
					return
				end
				--local WhatsNew = chatBar.Text:sub(lastText:len())
				--if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
				local newInput = chatBar.Text
				local newLength = newInput:len()
				if #C.savedCommands==0 or lastText == newInput then
					return
				end
				if newInput:match("/up") then --newInput:sub(chatBar.CursorPosition-2,chatBar.CursorPosition) =="/up" then
					index += 1
				elseif newInput:match("/down") then--newInput:sub(chatBar.CursorPosition-4,chatBar.CursorPosition) == "/down" then
					index -= 1
				else
					return
				end
				lastUpd = os.clock()
				index = math.clamp(index,0,#C.savedCommands+1)

				local setTo = C.savedCommands[index] or ""
				lastText = setTo
				RunS.RenderStepped:wait()
				chatBar.Text = setTo
				--end
				--lastText = chatBar.Text
			end
			table.insert(C.functs,chatBar:GetPropertyChangedSignal("Text"):Connect(textUpd))
			textUpd()
			table.insert(C.functs,chatBar.FocusLost:Connect(function(enterPressed)
				index = 0
				local inputMsg = chatBar.Text
				if enterPressed then
					if inputMsg:sub(1,1)==";" or inputMsg:sub(1,1)=="/" then
						enterPressed = inputMsg:sub(1,1)=="/" -- only send the message if it's a /
						if not enterPressed then
							chatBar.Text = ""
						end
						task.spawn(C.RunCommand,inputMsg,true)
					end
				end
				if not hasNewChat then
					for num, connectionFunct in ipairs(connectionsFuncts) do
						if connectionFunct.Function then
							connectionFunct.Function(enterPressed)
						else
							warn("NO Function Found For "..num)
						end
					end--]]
				elseif enterPressed then
					sendTheMessage(inputMsg)
				end
				--[[local yield = C.GetHardValue(sendButton,"Activated",{yield=true})
				print("Yield",yield)
				for num, connectionFunct in ipairs(yield) do
					connectionFunct:Fire()
				end--]]




			end))
			C.defaultFunction("ChatBarAdded",{chatBar,firstRun})
		end
		if not hasNewChat then
			table.insert(C.functs,StringWaitForChild(PlayerGui,"Chat.Frame.ChatBarParentFrame").ChildAdded:Connect(function(child)
				registerNewChatBar()
			end))
		end
		registerNewChatBar(nil,true)
	end
	if C.gameName == "FleeMain" then
		local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule");
		if theirTSM then
			local isBeastValue = theirTSM:WaitForChild("IsBeast");
			if isBeastValue then
				--if isBeastValue.Value then
				--BeastAdded(theirPlr,theirPlr.Character);
				--end--ONLY DO BEAST ADD IN CHARACER ADDED FUNCT
				table.insert(C.playerEvents[theirPlr.UserId], isBeastValue.Changed:Connect(function(new)
					if new then
						BeastAdded(theirPlr,theirPlr.Character);
					end
				end))
			end;
		end;
		C.ConnectPlrTSM(theirPlr,getscriptfunction(theirTSM))
	elseif C.gameUniverse == "NavalWarefare" and isMe then
		table.insert(C.playerEvents[theirPlr.UserId], plr:GetPropertyChangedSignal("Team"):Connect(function(new)
			C.defaultFunction("MyTeamAdded", {plr.Team});
		end))
	end
	--end
end;
local function DescendantRemoving(child)
	if string.sub(child.Name,1,13)=="ComputerTable" then
		C.defaultFunction("ComputerRemoved",{child})
	elseif string.sub(child.Name,1,9)=="FreezePod" then
		CS:RemoveTag(child,"Capsule")
		C.defaultFunction("CapsuleRemoved",{child})
	elseif child.Name=="SingleDoor" or child.Name=="DoubleDoor" or child.Name=="ExitDoor" then
		CS:RemoveTag(child,"DoorAndExit")
		CS:RemoveTag(child,"Door")
		CS:RemoveTag(child,"Exit")
		local inputArray = {child,child.Name}
		C.defaultFunction("DoorRemoved",inputArray)
	end
end
local function MapChildAdded(child,shouldntWait)
	if string.sub(child.Name,1,13)=="ComputerTable" then
		while child.PrimaryPart==nil do
			child:GetPropertyChangedSignal("PrimaryPart"):Wait();
			wait(.25);
		end;
		local Screen=child:WaitForChild("Screen");

		CS:AddTag(child,"Computer");
		local loopTriggers = {"ComputerTrigger1","ComputerTrigger2","ComputerTrigger3"};
		for num, triggerName in ipairs(loopTriggers) do
			local trigger=child:WaitForChild(triggerName);
			CS:AddTag(trigger,"Trigger");
			trigger.Transparency=(_SETTINGS.hitBoxesEnabled and .6 or 1);
			if (C.Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda") then
				trigger:SetAttribute("WalkToPoso",Vector3.new(Screen.Position.X,trigger.Position.Y,Screen.Position.Z):lerp(trigger.Position,1.17));
			end;
		end;
		child.Name = "ComputerTable/"..(#CS:GetTagged("Computer"));
		C.defaultFunction("ComputerAdded",{child});
	elseif string.sub(child.Name,1,9)=="FreezePod" then
		local PodTrigger=child:WaitForChild("PodTrigger",3);
		if PodTrigger~=nil then
			CS:AddTag(PodTrigger,"Trigger");
		end;
		CS:AddTag(child,"Capsule");
		C.defaultFunction("CapsuleAdded",({child}));
		table.insert(C.functs,child.Destroying:Connect(function()
			DescendantRemoving(child)
		end));
	elseif child.Parent~=workspace and (child.Name=="SingleDoor" or child.Name=="DoubleDoor" or child.Name=="ExitDoor") then
		local inputArray = {child, child.Name};
		local maximum_wait_time = (18 * 60);
		local doorTrigger=child.Name~="ExitDoor" and child:WaitForChild("DoorTrigger",maximum_wait_time) or child:WaitForChild("ExitDoorTrigger",maximum_wait_time);

		if not doorTrigger then
			return;
		end;
		local doorTrigger_NAME = "DoorTrigger";
		CS:AddTag(doorTrigger,"Trigger");
		CS:AddTag(doorTrigger,"DoorAndExit");
		if child.Name=="ExitDoor" then
			CS:AddTag(child,"Exit");
			CS:AddTag(child:WaitForChild("ExitArea"),"Trigger")
		else
			CS:AddTag(child,"Door");
			CS:AddTag(doorTrigger,doorTrigger_NAME);
		end;
		local doorAdded_NAME = "DoorAdded";
		C.defaultFunction(doorAdded_NAME, inputArray);
	end
end
local function registerObject(object,registerfunct,shouldntWait)
	if C.isCleared then return end
	table.insert(C.functs,object.ChildAdded:Connect(function(child)
		if C.isCleared then return end
		local function IntermediateDescendantRemovingFunction(newParent)
			DescendantRemoving(child);
		end;
		table.insert(C.functs,child.Destroying:Connect(IntermediateDescendantRemovingFunction));
		registerfunct(child,false)
	end))
	for num, lowerobject in ipairs(object:GetChildren()) do
		if C.isCleared then
			return--get out of here!
		end
		local function IntermediateDescendantRemovingFunction(newParent)
			DescendantRemoving(lowerobject);
		end;
		task.spawn(registerfunct,lowerobject,shouldntWait)
		table.insert(C.functs,lowerobject.Destroying:Connect(IntermediateDescendantRemovingFunction));
		if num%100 == 0 then
			RunS.RenderStepped:Wait()
		end
	end
end
local function updateCurrentMap(newMap,firstRun)
	if C.isCleared then return end
	if newMap ~= C.Map and newMap and newMap ~= TS then
		C.Map = newMap;
		task.wait(1);
		if C.isCleared then return end
		local inputArray = {newMap};
		C.defaultFunction("MapAdded",{newMap,firstRun});
		task.spawn(registerObject,newMap,MapChildAdded);
		table.insert(C.functs,newMap.Destroying:Connect(function(newParent)
			task.wait(2);--give a hefty wait time before deleting components, so that individual children can be erased first!
			updateCurrentMap(nil);
		end))
	elseif C.Map and not newMap and newMap ~= TS then
		RS.CurrentMap.Value = TS;
		task.wait(2); -- Delay this to avoid lag spikes
		local clonedMap = C.Map;
		C.Map = nil; C.Beast = nil;
		C.defaultFunction("CleanUp",{clonedMap});

		C.PurgeActionsWithTag("Game")
		C.PurgeActionsWithTag("Computer")
		C.PurgeActionsWithTag("ComputerHack")
	end
end

--print(("Functions Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

if C.gameName == "FleeMain" then
	local MapChangedValue = RS:WaitForChild("CurrentMap")

	task.spawn(updateCurrentMap,MapChangedValue.Value,true)
	table.insert(C.functs,MapChangedValue.Changed:Connect(updateCurrentMap))
end

table.insert(C.functs,PS.PlayerAdded:Connect(PlayerAdded))

local function intermediatePlayerRemovingFunction(theirPlr)
	if plr==theirPlr then
		if not C.isCleared then
			saveSaveData()
		end
		return
	end
	for num,funct in pairs((C.playerEvents[theirPlr.UserId] or ({}))) do
		funct:Disconnect()
	end
	C.playerEvents[theirPlr.UserId]=nil
end
table.insert(C.functs,(PS.PlayerRemoving:Connect(intermediatePlayerRemovingFunction)))

--print(("C.Map Functs Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

for num,theirPlr in ipairs(PS:GetPlayers()) do
	if theirPlr==plr then
		task.spawn(PlayerAdded,theirPlr)
	else
		task.delay(.1 * num,PlayerAdded,theirPlr)
	end
	if num%10==0 then
		RunS.RenderStepped:Wait()
	end
end

--print(("Players Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

--MENU FUNCTS
if C.gameName=="FleeMain" then
	local lastPC_time
	local currentAnimation = C.myTSM:WaitForChild("CurrentAnimation")
	local lastAnimationName
	local PCFunctions = {}
	local function getPC(obj)
		if obj:HasTag("Computer") then
			return obj
		elseif obj == workspace or obj == C.Map then
			return
		end
		return getPC(obj.Parent)
	end
	local function ResetPCEvents()
		for num, conn in ipairs(PCFunctions) do
			conn:Disconnect()
		end PCFunctions = {}
	end
	local function updateAnimation(override)
		local newValue = currentAnimation.Value
		if newValue=="Typing" then
			print("New PC Found!")
			ResetPCEvents()
			local saveEvent = C.myTSM.ActionEvent.Value
			lastHackedPC = getPC(C.myTSM.ActionEvent.Value)
			if not lastHackedPC then
				if not C.myTSM.ActionEvent.Value then
					warn("PC Not Found: ActionEvent.Value nil")
				else
					warn("PC Not Found:",C.myTSM.ActionEvent.Value:GetFullName())
				end
			end
			C.RemoveAction("PC CoolDown")
			C.AddAction({Name=lastHackedPC.Name,Tags={"Game","ComputerHack","Computer"},Time=function(ActionClone,info)
				ActionClone.Time.Text = "Time: TBA"
			end,Stop=function(onRequest)
				if onRequest then
					local old = C.myTSM.ActionEvent.Value
					C.RemoteEvent:FireServer("Input", "Trigger", saveEvent)
					--RunS.RenderStepped:Wait()
					stopCurrentAction(true)
					updateAnimation(true)
					--C.RemoteEvent:FireServer("Input", "Trigger", old)
				end
			end,})

			local screen = lastHackedPC:WaitForChild("Screen")
			table.insert(PCFunctions,screen:GetPropertyChangedSignal("Color"):Connect(function()
				updateAnimation(true)
			end))
		elseif (C.enHacks.Blatant_RemoteHackPCs and override ~= true) then
			return
		elseif lastHackedPC and lastAnimationName=="Typing" then
			ResetPCEvents()
			lastPC_time = os.clock()
			C.RemoveAction(lastHackedPC.Name)

			trigger_setTriggers("LastPC",{Computer=false,AllowExceptions = {lastHackedPC}})
			local timeNeeded = 15--(math.max((70)/_SETTINGS.minSpeedBetweenPCs,_SETTINGS.absMinTimeBetweenPCs))
			C.AddAction({Name="PC CoolDown",Tags={"Game","Computer"},Stop=function(onRequest)

				--task.delay(timeNeeded,function()
				--if (os.clock() - lastPC_time) >= timeNeeded then
				trigger_setTriggers("LastPC",{Computer=true})
				print("Triggers Enabled After",timeNeeded)
				--end
				--end)
			end, Time=timeNeeded,})
			print("Triggers Disabled")	
		end
		lastAnimationName = newValue
		C.defaultFunction("AnimationChanged",newValue)
	end
	setChangedProperty(currentAnimation,"Value",updateAnimation)
	task.delay(2,updateAnimation)
	trigger_setTriggers("StartUp",{Computer=false})
	task.delay(5,trigger_setTriggers,"StartUp",{Computer=true})--careful with computers at the start!
	table.insert(C.functs,C.myTSM:WaitForChild("ActionProgress").Changed:Connect(function(newVal)
		if newVal > .95 and (C.char and not C.isInGame(C.char,true)) and C.myTSM.CurrentAnimation.Value == "Typing" then
			print("Stop Hacking PC")
			stopCurrentAction()
		end
	end))


	local totalXPEarned = 0;
	local totalCreditsEarned = 0;
	local totCreditsOffset = PS:GetAttribute("TotalServerCreditsOffset");
	if not totCreditsOffset then
		totCreditsOffset = 0;
	end
	local totXPOffset = (PS:GetAttribute("TotalServerXPOffset") or 0);
	local function calculateCreditsForPlayer(theirPlr)
		local currentXP;
		local currentCredits;
		local currentLvl;
		local creditsEarned = 0
		local xpEarned = 0;
		local startXP;
		local startCredits;

		local function updateXPStats()
			if theirPlr.Parent~=PS then
				return
			end
			local newXP = C.getTotalXP(currentLvl.Value, currentXP.Value)
			local deltaXP = (newXP - startXP)
			startXP = newXP
			xpEarned = xpEarned + deltaXP
			totalXPEarned = totalXPEarned + deltaXP

			local serverXPEarned = totalXPEarned + totXPOffset

			GuiElements.ServerXPGained.Text = ("Server XP: +"..C.comma_value(serverXPEarned).."/"..C.comma_value(math.round((serverXPEarned/time())*3600)))
			if theirPlr==plr then
				GuiElements.XPGained.Text = ("XP: +"..C.comma_value(xpEarned).."/"..C.comma_value(math.round((xpEarned/time())*3600)))
			end
		end
		local function updateCreditStats()
			if theirPlr.Parent~=PS then
				return
			end
			local deltaCredits = (currentCredits.Value-startCredits)
			startCredits = (currentCredits.Value)
			creditsEarned = creditsEarned + deltaCredits
			totalCreditsEarned = totalCreditsEarned + deltaCredits

			local serverCreditsEarned = totalCreditsEarned+totCreditsOffset

			GuiElements.ServerCreditsGained.Text="Server Credits: +"..C.comma_value(serverCreditsEarned).."/"..C.comma_value(math.round((serverCreditsEarned/time())*3600))
			if theirPlr==plr then
				GuiElements.CreditsGained.Text="Credits: +"..C.comma_value(creditsEarned).."/"..C.comma_value(math.round((creditsEarned/time())*3600))
			end
		end
		local function ancestryChangedFunction()
			PS:SetAttribute("TotalServerXPOffset",(currentXP and currentXP.Value or xpEarned)+(PS:SetAttribute("TotalServerXPOffset") or 0))
			PS:SetAttribute("TotalServerCreditsOffset",(currentCredits and currentCredits.Value or creditsEarned)+(PS:SetAttribute("TotalServerCreditsOffset") or 0))
		end
		local ancestryChangedInput_CONNECTION = theirPlr.AncestryChanged:Connect(ancestryChangedFunction);
		table.insert(C.functs,ancestryChangedInput_CONNECTION)
		local function instantFunction()
			local theirSSM=theirPlr:WaitForChild("SavedPlayerStatsModule")
			currentLvl=theirSSM:WaitForChild("Level",1e5)
			if not currentLvl then
				return
			end
			currentXP, currentCredits = theirSSM:WaitForChild("Xp"), theirSSM:WaitForChild("Credits");
			startXP = theirPlr:GetAttribute("StartXP") or C.getTotalXP(currentLvl.Value,currentXP.Value);
			startCredits = theirPlr:GetAttribute("StartCredits") or currentCredits.Value;
			theirPlr:SetAttribute("StartXP",startXP);
			theirPlr:SetAttribute("StartCredits",startCredits);
			setChangedProperty(currentXP,"Value",updateXPStats);
			setChangedProperty(currentCredits,"Value",updateCreditStats);
			updateXPStats();
			updateCreditStats();
		end
		task.spawn(instantFunction)
	end
	PS.PlayerAdded:Connect(calculateCreditsForPlayer);

	for _,theirPlr in pairs(PS:GetPlayers()) do
		calculateCreditsForPlayer(theirPlr);
	end;
end;

--print(("Game Specific Functs Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

DraggableMain=C.Modules.DraggableModule().new(GuiElements.Main)
DraggableMain:Enable()

local function CloseMenu(actionName, inputState, inputObject)
	if inputState==Enum.UserInputState.Begin and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or inputObject.UserInputType ~= Enum.UserInputType.Keyboard) then
		local newMain = not GuiElements.Main.Visible
		GuiElements.Main.Visible=newMain
		if newMain then
			DraggableMain:Enable()
			if C.BetterConsole then
				C.BetterConsole.Visible = false
			end
		else
			DraggableMain:Disable()
		end
	end
end
CAS:BindActionAtPriority("CloseMenu"..C.saveIndex,CloseMenu,true,1e5,Enum.KeyCode.V)

getgenv().C, getgenv()._SETTINGS = C, _SETTINGS

task.spawn(function()
	--[[for num, event in ipairs(RS:GetDescendants()) do
		if event:IsA("RemoteEvent") or event:IsA("RemoteFunction") then
			print("Event",event.Name,event:GetFullName())
		end
	end	--]]
	table.insert(C.functs,game:GetService("NetworkClient").ChildRemoved:Connect(function()
		SG:SetCore("DevConsoleVisible", true)
		GS:ClearError()
		print(("Client/Server Kick Has Occured (%.2f)"):format(time()))
		local ErrorMessage = StringWaitForChild(game:GetService("CoreGui"),"RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage",5)
		if ErrorMessage then
			warn(ErrorMessage.Text)
		else
			warn("Error Message Not Found, Yielding Failed")
		end
	end))
	local getcallingscript = getcallingscript
	local getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, stringlower = getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, string.lower
	if C.gameName ~= "FlagWars" then
		return
	else
		--[[if true then
			
			
			
			return
		end
		local old
		old = hookfunction(getrenv().pcall,newcclosure(function(funct2Run)
			if not checkcaller() then
				print("A script tried to run a function, cancelled!",getcallingscript())
				return true, nil
			end
			return old(funct2Run)
		end))--]]
	end
	local OldNamecall
	local debris = DS.AddItem
	local destroy = workspace.Destroy
	local tblPack = table.pack

	local connList = {}

	local function set(parent)
		parent.Parent = RunS
	end

	local function conn(int)
		if typeof(int) == "Instance" and int.ClassName == "RemoteEvent" then
			if not connList[int] then
				local signal = int.OnClientEvent:Connect(function(...)
					warn("recieve,",int,...)
				end)
				connList[int] = signal
				table.insert(C.functs,signal)
			end
		end
	end

	OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(int,...)
		if (not checkcaller()) and (stringlower(getnamecallmethod()) == "fireserver" or stringlower(getnamecallmethod()) == "invokeserver") then
			--getcallingscript().Name=="BAC_"
			local caller = getcallingscript() or "not found"
			if caller then
				--int.Parent = RunS
				--task.spawn(set,caller)
				--print("Deleted",getfenv())
				--caller:Destroy()
				--print("Blocked BAC_",getnamecallmethod(),int)
				--debris(DS,caller,0)
				if caller ~= "not found" then
					getgenv().BAC = caller
				end
				if caller ~= "not found" and tostring(caller) == "BAC_" then
					task.spawn(conn,int)
				end
				if #tblPack(...) > 200 then
					print(caller,int,'max args!')--,#tblPack(...),tblPack(...)[8000])
				elseif (...)[1] and typeof((...)[1])=='table' and (...)[1] == (...)[1][1] then
					print(caller,int,tostring(...))
				else
					print(caller,int,...)
				end
				--error("idk man")
			end
			--error("idk man")

			--return nil
		end

		return OldNamecall(int,...)
	end))--]]
	--[[if C.gameName == 'FlagWars' then
		while not C.BAC do
			RunS.RenderStepped:Wait()
		end--]]
	--print("Removing BAC...")
	--task.wait(5)
		--[[for num, connection in ipairs(C.GetHardValue(C.BAC,"Changed",{yield=true})) do
			connection:Disconnect()
			print("ConnectionChanged",num)
		end
		for num, connection in ipairs(C.GetHardValue(C.BAC,"Changed",{yield=true})) do
			connection:Disconnect()
			print("ConnectionDestroyed",num)
		end
		task.wait(2)--]]
	--C.BAC.Disabled = true
	--C.BAC:Destroy()
	--print("BAC Removed!")
	--C.BAC = nil
	--task.wait(2)--]]
	--task.wait(2)
	--C.BAC.Enabled = false

	--C.BAC.Enabled = true
	--C.BAC.Enabled = false
	--C.BAC.Enabled = true

	--print(("Haha is %s; before %s"):format(C.BAC:GetFullName(),tostring(sethiddenproperty(C.BAC,"Enabled",false))))

	--getgenv().BAC = C.BAC

	--end
end)

return "Hack Successfully Executed V1.02!"
