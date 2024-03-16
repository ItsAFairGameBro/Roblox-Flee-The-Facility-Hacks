local MyTextBox

local PS=game:GetService("Players")
local CS=game:GetService("CollectionService")
local RS=game:GetService("ReplicatedStorage")
local DS=game:GetService("Debris")
local CAS=game:GetService("ContextActionService")
local UIS=game:GetService("UserInputService")
local RunS=game:GetService("RunService")
local VU=game:GetService('VirtualUser')
local SP=game:GetService("StarterPlayer")
local PathfindingService = game:GetService("PathfindingService")



local gameName=((game.PlaceId==1738581510 and "FleeTrade") or (game.PlaceId==893973440 and "FleeMain") or "Unknown")
local gameUniverse=gameName:find("Flee") and "Flee" or "Unknown"
local newVector3, newColor3 = Vector3.new, Color3.fromRGB
local isStudio=RunS:IsStudio()
local enHacks,playerEvents,objectFuncts={},{},{}
local functs = {}

local Map,char,Beast,TestPart,ToggleTag,clear,saveIndex,AvailableHacks,ResetEvent,CommandBarLine,Console,ConsoleButton,PlayerControlModule
local myTSM,mySSM
local plr = PS.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui");
local isActionProgress=false
local isCleared=false
local isJumpBeingHeld = false

local lastRunningEnv = getfenv()
local reloadFunction = lastRunningEnv.ReloadFunction
local GlobalSettings = lastRunningEnv.GlobalSettings or {}
local isTeleportingAllowed = GlobalSettings.isTeleportingAllowed~=false

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

--DEBUG--
local botModeEnabled=GlobalSettings.botModeEnabled
local myBots={--has faster default walkspeed for all my bot's and their usernames
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
local whitelistedUsers={
	["facilitystorage"]=true,
	["4evernIove"]=true,
	["kitcat4681"]=true,
	["goldenbear25"]=true,
};
if not botModeEnabled or not myBots[plr.Name:lower()] or GlobalSettings.ForceBotMode then
	myBots={};
	botModeEnabled = false;
end
local MyDefaults = {BotFarmRunner = (botModeEnabled and "Freeze")}
local hitBoxesEnabled=((botModeEnabled and false) or GlobalSettings.hitBoxesEnabled)
local minSpeedBetweenPCs=18 --minimum time to hack between computers is 6 sec otherwise kick
local absMinTimeBetweenPCs=9.5 --abs min time to hack, overrides minspeed
local botBeastBreakMin=13.5 --in minutes
local waitForChildTimout = 20
local max_tpStackSize = 1
local minTimeBetweenTeleport = .5
local defaultCharacterWalkSpeed=SP.CharacterWalkSpeed
local defaultCharacterJumpPower=SP.CharacterJumpPower


local NameTagEx,HackGUI


--INTERFACE/GUI CREATION
local MainListEx,myList,PropertiesEx,Properties,ServerCreditsGained,Main;
local TextBoxExamples, CreditsGained,ServerXPGained,XPGained;
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
local function GuiCreationFunction()
	--local Instance.new = Instance["new"];
	local ExTextButton = Instance.new("Frame");

	local Toggle = Instance.new("TextButton");

	createToggleButton(Toggle, ExTextButton);


	local ExTextBox = Instance.new("Frame");


	local Desc = Instance.new("TextLabel");



	local Title_2 = Instance.new("TextLabel");
	--pls work
	local Desc_2 = Instance.new("TextLabel");
	MyTextBox = Instance.new("TextBox");

	MainListEx = Instance.new("TextButton");
	HackGUI = Instance["new"]("ScreenGui");

	Main = Instance.new("Frame")


	--pls work
	local UIListLayout = Instance.new("UIListLayout");
	Properties = Instance.new("Frame");
	PropertiesEx = Instance.new("ScrollingFrame");
	local UIListLayout_2 = Instance.new("UIListLayout");
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder;
	UIListLayout_2.Padding = UDim.new(0, 20);
	UIListLayout_2.Parent = PropertiesEx;

	NameTagEx = Instance.new("BillboardGui");
	local ExpandingBar = Instance.new("Frame");
	local AmtFinished = Instance.new("Frame");
	ToggleTag = Instance.new("BillboardGui");
	local ToggleButton = Instance.new("TextButton");
	TestPart = Instance.new("Part");
	TestPart.Parent = RS;
	XPGained = Instance.new("TextLabel");
	CreditsGained = Instance.new("TextLabel");
	ServerXPGained = Instance.new("TextLabel");
	ServerCreditsGained = Instance.new("TextLabel");
	Console = Instance.new("ScrollingFrame");
	local UIListLayout2 = Instance.new("UIListLayout");
	ConsoleButton = Instance.new("ImageButton");
	CommandBarLine = Instance.new("TextLabel");

	TextBoxExamples = {};

	HackGUI.DisplayOrder = (50);

	ExTextButton.Name = "ExTextButton";
	ExTextButton.Parent = RS;
	ExTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	ExTextButton.BackgroundTransparency = 1.000;
	ExTextButton.Size = UDim2.new(1, -6, 0, 40);
	TextBoxExamples["ExTextButton"] = ExTextButton;

	local Title = Instance.new("TextLabel");
	Title.Name = "Title";
	Title.Parent = ExTextButton;
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Title.BackgroundTransparency = 1;
	Title.Size = UDim2.new(0.556971073, 0, 0.68, 0);
	Title.Font = textFont;
	Title.ZIndex = (3);
	local TextXAlignmentEnum = Enum.TextXAlignment.Left;
	Title.TextColor3 = Color3.fromRGB(255, 255, 255);
	Title.TextSize = (14);
	Title.TextStrokeTransparency = (0);
	Title.TextXAlignment = TextXAlignmentEnum;
	Title.TextWrapped = true;
	Title.TextScaled = true;

	Desc["ZIndex"] = (3);
	Desc.BackgroundTransparency = (1);
	Desc.Position = UDim2.new(0, 0, 1, 0);
	Desc.Size = UDim2.new(0.557, 0, 0.47, 0);
	Desc["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	Desc.Name = "Desc";
	Desc.Parent = ExTextButton;
	Desc.Font = textFont
	Desc.AnchorPoint = Vector2.new(0, 1);

	--Desc.Text = " See players through walls"
	Desc.TextColor3 = Color3.fromRGB(255, 255, 255);
	Desc.TextXAlignment = TextXAlignmentEnum;
	Desc.TextScaled = true;
	Desc.TextSize = (14);
	Desc.TextStrokeTransparency = 0;
	Desc.TextWrapped = true;

	ExTextBox.Name = "ExTextBox";
	TextBoxExamples["ExTextBox"] = ExTextBox;
	ExTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	ExTextBox.BackgroundTransparency = 1;
	ExTextBox.Size = UDim2.new(1, -6, 0, 40);


	Title_2.Name = "Title";
	Title_2.Parent = ExTextBox;
	Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Title_2.BackgroundTransparency = 1;
	Title_2.Size = UDim2.new(0.556971073, 0, 0.680000007, 0);
	Title_2.ZIndex = 3;
	Title_2.Font = textFont;
	Title_2.TextColor3 = Color3.fromRGB(255, 255, 255);
	Title_2.TextScaled = true;
	Title_2.TextSize = 14.000;
	Title_2.TextStrokeTransparency = 0.000;
	Title_2.TextWrapped = true;
	Title_2.TextXAlignment = Enum.TextXAlignment.Left;

	Desc_2.Name = "Desc";
	Desc_2.Parent = ExTextBox;
	Desc_2.AnchorPoint = Vector2.new(0, 1);
	Desc_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Desc_2.BackgroundTransparency = 1.000;
	Desc_2.Position = UDim2.new(0, 0, 1, 0);
	Desc_2.Size = UDim2.new(0.556999981, 0, 0.47, 0);
	Desc_2.ZIndex = 3;
	Desc_2.Font = textFont;
	Desc_2.TextColor3 = Color3.fromRGB(255, 255, 255);
	Desc_2.TextScaled = true;
	Desc_2.TextSize = 14.000;
	Desc_2.TextStrokeTransparency = 0.000;
	Desc_2.TextWrapped = true;
	Desc_2.TextXAlignment = Enum.TextXAlignment.Left;

	--print(MyTextBox)
	MyTextBox.AnchorPoint = Vector2.new(1, 0);
	MyTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	MyTextBox.BackgroundTransparency = 1.000;
	MyTextBox.Position = UDim2.new(1, 0, 0, 0);
	MyTextBox.Size = UDim2.new(0.442999989, 0, 1, 0);
	MyTextBox.Font = textFont2;
	MyTextBox.Text = "0";
	MyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
	MyTextBox.TextScaled = true;
	MyTextBox.TextSize = 14.000;
	MyTextBox.TextStrokeTransparency = 0.000;
	MyTextBox.TextWrapped = true;
	MyTextBox.ClearTextOnFocus = false;
	--pls work;
	MyTextBox.Parent = ExTextBox;


	--pls work
	TextBoxExamples["MainListEx"] = MainListEx;
	MainListEx.Name = "MainListEx";
	MainListEx.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	MainListEx.BackgroundTransparency = (1);
	MainListEx.Size = UDim2.new(1, 0, 0, 25);
	MainListEx.Font = textFont2;
	--MainListEx.Text = "Render";
	MainListEx.TextColor3 = Color3.fromRGB(255, 255, 255);
	MainListEx.TextScaled = true;
	MainListEx.TextSize = (14);
	MainListEx.TextWrapped = true;

	HackGUI.Name = "HackGUI";
	HackGUI.ResetOnSpawn = false;

	local hackGUIParent = (isStudio and plr:WaitForChild("PlayerGui") or game:GetService("CoreGui"));
	HackGUI.Parent = hackGUIParent;
	HackGUI.DisplayOrder = (-100);

	Main.Name = "Main"
	Main.Parent = HackGUI
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
	Main.Position = UDim2.new(0.25, 0, 0.75, 0)

	Main["Size"] = (UDim2.new(0.39, 0, 0.3375, 0))

	myList = Instance.new("ScrollingFrame");
	myList.Parent = Main;
	myList.BackgroundColor3 = Color3.fromRGB(52, 52, 52);
	myList.BackgroundTransparency = (1);
	myList.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	myList.ScrollingDirection = Enum.ScrollingDirection.Y;
	myList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
	myList.ScrollBarThickness = 3;
	myList.Size = UDim2.new(0.245, 0, 1, 0)
	myList.CanvasSize = UDim2.new(0, 0, 0, 0)
	myList.Name = ("myList")
	UIListLayout.Parent = (myList)
	UIListLayout.Padding = UDim.new(0, 20)

	Properties.Name = "Properties"
	Properties.Parent = Main
	Properties.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Properties.BackgroundTransparency = (1)
	Properties.Size = UDim2.new(1, 0, 1, 0)

	PropertiesEx.Name = "PropertiesEx"
	TextBoxExamples.PropertiesEx = PropertiesEx
	PropertiesEx.Size = UDim2.new(0.71, 0, 1, 0);
	PropertiesEx.ScrollBarThickness = (6);
	PropertiesEx.BackgroundColor3 = Color3.fromRGB(52, 52, 52);
	PropertiesEx.Position = UDim2.new(0.291, 0, 0, 0);
	PropertiesEx.CanvasSize = UDim2.new(0, 0, 0, 0);
	PropertiesEx.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	PropertiesEx.ScrollingDirection = Enum.ScrollingDirection.Y;



	PropertiesEx.BackgroundTransparency = 1;

	NameTagEx.Size = UDim2.new(3, 40, 0.7, 10);
	NameTagEx.LightInfluence = (1);
	NameTagEx.Name = "NameTagEx";
	NameTagEx.ExtentsOffsetWorldSpace = Vector3.new(0, 3, 0);
	NameTagEx.AlwaysOnTop = (true);




	local Username = Instance.new("TextLabel");
	Username.BackgroundColor3 = Color3.new(1,1,1);

	Username.Name = "Username";
	Username.Parent = NameTagEx;



	Username.BackgroundTransparency = (1);
	Username.TextScaled = true;
	Username.Size = ( UDim2.new(1, 0, 1, 0) ) ;

	Username.TextStrokeTransparency = (0);
	Username.TextWrapped = true;

	Username["Font"] = (textFont3.Value);


	Username.ZIndex = (mainZIndex);

	local distanceTLPOSO = UDim2.new((0.3625), 0, (-0.9), 0);
	local distanceTLSize = UDim2.new(0.275, 0, 1, 0);
	local distanceTLColor3 = Color3.fromRGB(255, 255, 255);

	local DistanceTL = Instance.new("TextLabel");
	DistanceTL.Size = distanceTLSize;
	DistanceTL.ZIndex = mainZIndex;
	DistanceTL.Font = (textFont3.Value);
	DistanceTL.TextColor3 = distanceTLColor3;
	DistanceTL.TextScaled = true;
	DistanceTL.TextSize = 14;
	DistanceTL.BackgroundTransparency = 1;
	DistanceTL.TextStrokeTransparency = 0;
	DistanceTL.TextWrapped = true;
	DistanceTL.Name = "Distance";
	DistanceTL.Parent = NameTagEx;







	DistanceTL.Position = distanceTLPOSO;


	Username.TextColor3 = Color3.fromRGB(0, 0, 255)


	ExpandingBar.Name = ("ExpandingBar")
	ExpandingBar.Parent = (NameTagEx)
	ExpandingBar.AnchorPoint = (Vector2.new(0, 1))
	ExpandingBar.BackgroundColor3 = Color3.fromRGB(32,32,32)
	ExpandingBar.BackgroundTransparency = (0.5)
	ExpandingBar.Position = UDim2.new(0, 0, 1.49, 0)
	ExpandingBar.Size = UDim2.new(1, 0, 0.5, 0)
	ExpandingBar.Visible = false

	AmtFinished.Name = "AmtFinished"
	AmtFinished.Parent = ExpandingBar
	AmtFinished.BackgroundColor3 = Color3.fromRGB(255,255,255)
	AmtFinished.BackgroundTransparency = (0.1)
	AmtFinished.Size = UDim2.new(0, 0, 1, 0)

	ToggleTag.Name = "ToggleTag"
	TextBoxExamples["ToggleTag"] = ToggleTag
	ToggleTag["Active"] = true
	ToggleTag.AlwaysOnTop = true
	ToggleTag.Enabled = false	
	ToggleTag.LightInfluence = 1.000
	ToggleTag.Size = UDim2.new(1, 30, 0.75, 10)
	ToggleTag.ExtentsOffsetWorldSpace = Vector3.new(0, 4, 0)

	ToggleButton.Name = "Toggle"
	ToggleButton.Parent = ToggleTag
	ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	ToggleButton.Size = UDim2.new(1, 0, 1, 0)
	ToggleButton.Font = textFont
	ToggleButton.Text = "Close"
	ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	ToggleButton.TextScaled = true
	ToggleButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	ToggleButton.TextStrokeTransparency = 0
	ToggleButton.TextWrapped = true

	TestPart.Size=Vector3.new(1.15,1.15,1.15)
	TestPart.BrickColor=BrickColor.Red()
	TestPart.Anchored=true
	TestPart.CanCollide=false
	TestPart.Transparency=.35

	XPGained.Name = "XPGained"
	XPGained.Parent = Main
	XPGained.BackgroundColor3 = Color3.new(1, 1, 1)
	XPGained.BackgroundTransparency = 1
	XPGained.Position = UDim2.new(0.5, 0, 1, 0)
	XPGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	XPGained.ZIndex = (mainZIndex + 1)
	XPGained.Font = textFont
	XPGained.Text = " "
	XPGained.TextColor3 = Color3.new(0, 1, 0)
	XPGained.TextScaled = true
	XPGained.TextStrokeTransparency = 0
	XPGained.TextWrapped = true
	XPGained.TextXAlignment = Enum.TextXAlignment.Right

	CreditsGained.Name = "CreditsGained"
	CreditsGained.Parent = Main
	CreditsGained.BackgroundColor3 = Color3.new(1, 1, 1)
	CreditsGained.BackgroundTransparency = 1
	CreditsGained.Position = UDim2.new(-0, 0, 1, 0)
	CreditsGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	CreditsGained.ZIndex = (mainZIndex + 1)
	CreditsGained.Font = textFont
	CreditsGained.Text = " "
	CreditsGained.TextColor3 = Color3.new(1, 0.8, 0)
	CreditsGained.TextScaled = true
	CreditsGained.TextStrokeTransparency = 0
	CreditsGained.TextWrapped = true
	CreditsGained.TextXAlignment = Enum.TextXAlignment.Left

	ServerXPGained.Name = "ServerXPGained"
	ServerXPGained.Parent = Main
	ServerXPGained.BackgroundColor3 = Color3.new(1, 1, 1)
	ServerXPGained.BackgroundTransparency = 1
	ServerXPGained.Position = UDim2.new(0.5, 0, 1.12, 0)
	ServerXPGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	ServerXPGained.Font = textFont
	ServerXPGained.Text = " "
	ServerXPGained.TextColor3 = Color3.new(0, 1, 0)
	ServerXPGained.TextScaled = true
	ServerXPGained.TextStrokeTransparency = 0
	ServerXPGained.TextWrapped = true
	ServerXPGained.TextXAlignment = Enum.TextXAlignment.Right

	ServerCreditsGained.Name = "ServerCreditsGained"
	ServerCreditsGained.Parent = Main
	ServerCreditsGained.BackgroundColor3 = Color3.new(1, 1, 1)
	ServerCreditsGained.BackgroundTransparency = 1
	ServerCreditsGained.Position = UDim2.new(-0, 0, 1.12, 0)
	ServerCreditsGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	ServerCreditsGained.ZIndex = (mainZIndex + 1)
	ServerCreditsGained.Font = textFont
	ServerCreditsGained.Text = " "
	ServerCreditsGained.TextColor3 = Color3.new(1, 0.8, 0)
	ServerCreditsGained.TextScaled = true
	ServerCreditsGained.TextStrokeTransparency = 0
	ServerCreditsGained.TextWrapped = true
	ServerCreditsGained.TextXAlignment = Enum.TextXAlignment.Left

	Console.Name = "Console"
	Console.Parent = Main
	Console.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Console.ScrollingDirection = Enum.ScrollingDirection.Y
	Console.BackgroundColor3 = Color3.new(0.203922, 0.203922, 0.203922)
	Console.BackgroundTransparency = 1
	Console.ZIndex=(mainZIndex + 100)
	Console.Position = UDim2.new(0.290841579, 0, 0, 0)
	Console.Size = UDim2.new(0.709158421, 0, 1, 0)
	Console.CanvasSize = UDim2.new(0, 0, 0, 0)

	UIListLayout2.Parent = Console
	UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Top
	UIListLayout2.Padding = UDim.new(0, 3)

	ConsoleButton.Name = "ConsoleButton"
	ConsoleButton.Parent = Main
	ConsoleButton.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
	ConsoleButton.BackgroundTransparency = 1
	ConsoleButton.BorderColor3 = Color3.new(0, 0, 0)
	ConsoleButton.BorderSizePixel = 0
	ConsoleButton.Position = UDim2.new(0.916, 0, .9, 0)
	ConsoleButton.Size = UDim2.new(0.0818077475, 0, 0.10969051, 0)
	ConsoleButton.ZIndex = (mainZIndex + 9)
	ConsoleButton.Visible = false
	ConsoleButton.Image = "rbxassetid://12350781258"
	ConsoleButton.ScaleType = Enum.ScaleType.Fit

	CommandBarLine.Name = "CommandBarLine"
	TextBoxExamples["CommandBarLine"] = CommandBarLine
	CommandBarLine.BackgroundColor3 = Color3.new(1, 1, 1)
	CommandBarLine.BackgroundTransparency = 1
	CommandBarLine.LayoutOrder = 1
	CommandBarLine.Size = UDim2.new(1, 0, 0, 0)
	CommandBarLine.ZIndex = (mainZIndex + 1)
	CommandBarLine.Font = textFont
	CommandBarLine.AutomaticSize = Enum.AutomaticSize.Y
	CommandBarLine.TextColor3 = Color3.new(1, 1, 1)
	CommandBarLine.TextSize = 14
	CommandBarLine.TextStrokeTransparency = 0
	CommandBarLine.TextXAlignment = Enum.TextXAlignment.Left
	CommandBarLine.TextWrapped = true

end

--BIGGIE FUNCTIONS
local TPStack = {}
local isTeleporting = false

local function teleport_module_teleportQueue()
	if isTeleporting then return end isTeleporting = true
	while #TPStack>0 do
		local currentTP = TPStack[1]
		if os.clock()-(plr:GetAttribute("LastTP") or 0) >= minTimeBetweenTeleport then
			char:SetPrimaryPartCFrame(currentTP)
			plr:SetAttribute("LastTP",os.clock())
			table.remove(TPStack,1)
		end
		RunS.RenderStepped:Wait()
	end
	isTeleporting = false
end
local function teleportMyself(new)
	table.insert(TPStack,new)
	while max_tpStackSize < #TPStack do
		table.remove(TPStack,#TPStack)
	end
	if not isTeleporting then
		task.spawn(teleport_module_teleportQueue)
	end
end
local function StringWaitForChild(instance,str2Parse,duration)
	for num, stringLeft in ipairs(str2Parse:split(".")) do
		instance = instance:WaitForChild(stringLeft,duration)
	end
	return instance
end
local function getgenv()
	return _G
end
local function isInLobby(theirChar)
	--[[local a=Vector3.new(410.495, 59.4767, -197.00)
	local b=Vector3.new(-54.505, 59.4767, -547.007)
	return (point.X >= a.X and point.X <= b.X) and (point.Z >= a.Z and point.Z <= b.Z)--]]
	if theirChar~=nil and
		theirChar:FindFirstChild("Hammer")~=nil or (Map~=nil and Map:IsAncestorOf(theirChar)) then
		--print("beast ", theirChar.Name)
		return true,"Beast"
	end
	--for num,textLabel in pairs(PS.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
	--	:WaitForChild("StatusBars"):GetChildren()) do
	local player=PS:GetPlayerFromCharacter(theirChar)
	if player==nil then
		return false, "Unknown"
	end
	local TSM=player:WaitForChild("TempPlayerStatsModule",4)
	if TSM==nil then
		return false,"Unknown"
	end

	--if theirChar~=nil and textLabel.ClassName=="TextLabel"
	--	and textLabel.Text==theirChar.Name
	--	and textLabel.Bar.Size.X.Scale>=.001
	--	and textLabel.Bar.Visible then
	if TSM.Health.Value>0 then
		return true,"Runner"
	end
	--print("runner ", theirChar.Name, "true")

	--end
	--print(textLabel.Bar.Size.X.Scale)
	--end
	--print("runner ", theirChar.Name, "false")
	return false,"Lobby"--]]
end
local jumpChangedEvent

--CLOSEST POINT ON PART
local function ClosestPointOnPart(Part, Point)
	local Transform = Part.CFrame:pointToObjectSpace(Point) -- Transform into local space
	local HalfSize = Part.Size * 0.5
	return Part.CFrame * Vector3.new( -- Clamp & transform into world space
		math.clamp(Transform.x, -HalfSize.x, HalfSize.x),
		math.clamp(Transform.y, -HalfSize.y, HalfSize.y),
		math.clamp(Transform.z, -HalfSize.z, HalfSize.z)
	)
end
local function RemoveAllTags(obj)
	for _, tag in ipairs(obj:GetTags()) do
		obj:RemoveTag(tag)
	end
end
local function DestroyInstance(instance)
	RemoveAllTags(instance)
	instance:Destroy()
end
local function DestroyAllTaggedObjects(tag)
	for _, obj in ipairs(CS:GetTagged(tag)) do
		DestroyInstance(obj)
	end
end
--PRINT ENVIRONMENT START
local function printInstances(...)
	local printVal = ""
	for num, val in pairs({...}) do
		if num~=1 then
			printVal ..= " "
		end
		local print4Instance = val
		if typeof(print4Instance) == "Instance" then
			print4Instance = val:GetFullName()
		end
		printVal ..= tostring(print4Instance)
	end
	return (printVal)
end
local function recurseLoopPrint(leftTbl,str,depth)
	local totalValues = #leftTbl
	for num, val in pairs(leftTbl) do
		str..=string.rep("\t",depth)
		if typeof(val)=="table" then
			str..=("tbl "..num..":	{\n")
			str..=recurseLoopPrint(val,"",depth+1)
			str..=("\n	}")
		else
			if depth ~= 0 and (totalValues>=1 or num~=1) then
				str..=printInstances(num,val)
			else
				str..=printInstances(val)
			end
		end
		if totalValues ~= num then
			str..=" "
		end
	end
	return str
end
local function myPrint(...)
	print(recurseLoopPrint({...},"",0))
end
local print = myPrint;
--PRINT ENVIRONMENT END
local function findClosestObj(objs,poso,maxDist,yMult)
	local closest,closestDist=nil,maxDist or 2000
	for num,current in ipairs(objs) do
		local dist=((poso-current.Position)*Vector3.new(1,yMult or 1,1)).magnitude
		if dist<=closestDist then
			closest,closestDist=current,dist
		end
	end
	return closest,closestDist
end
local function createModifer(obj,label,passThru)
	local modifer=Instance.new("PathfindingModifier")
	modifer.Label=label
	modifer.PassThrough=passThru
	modifer.Parent=obj
	CS:AddTag(modifer,"RemoveOnDestroy")
end
local function createTestPart(position,timer)
	if not hitBoxesEnabled then
		return
	end
	local newPart=TestPart:Clone()
	newPart.Position=position
	newPart.Parent=workspace.Camera
	DS:AddItem(newPart,5)
end
local function getHumanoidHeight(model)
	local Humanoid=model:WaitForChild("Humanoid")
	local RootPart=model:WaitForChild("HumanoidRootPart")
	if Humanoid.RigType==Enum.HumanoidRigType.R15 then
		return (0.5 * RootPart.Size.Y) + Humanoid.HipHeight
	elseif Humanoid.RigType==Enum.HumanoidRigType.R6 then
		return model:WaitForChild("Left Leg").Size.Y + (0.5 * RootPart.Size.Y) + Humanoid.HipHeight
	end
end
local function getDictLength(dict)
	local num=0
	for key,val in pairs(dict) do
		num = num + 1
	end
	return num
end
local function ShuffleArray(tabl)
	for i=1,#tabl-1 do
		local ran = Random.new():NextInteger(i,#tabl)
		tabl[i],tabl[ran] = tabl[ran],tabl[i]
	end return tabl
end
local function comma_value(amount)
	local k
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end
--Commands Control

local CommandCountIndex = 0
local CommandInstances = {}

local function createCommandLine(message,printType)
	CommandCountIndex=(CommandCountIndex+1)%1000;
	local CommandClone = CommandBarLine:Clone();
	CommandClone.Text = message;
	CommandClone.Name = CommandCountIndex;
	CommandClone.LayoutOrder = -CommandCountIndex;
	CommandClone.Parent = Console;
	table.insert(CommandInstances,CommandClone);
	ConsoleButton.Visible=true;
	if printType then
		if printType == true then
			print(message)
		elseif printType=="warn" then
			warn(printType)
		elseif printType=="error" then

		end
	end
	while Console.AbsoluteCanvasSize.Y>Console.AbsoluteWindowSize.Y*5 do
		CommandInstances[1]:Destroy();
		table.remove(CommandInstances,1);
	end;
end;
--SET TRIGGERS uses the following format for setting active triggers that the user can interact with:
--triggerParams = true/false, toggle ALL triggers.
--name: identifier
--table: {FreezePod = true, Computer = true, Exit = false, Door = true, AllowExceptions = {Door, Computer, ExitModel, etc}}
local trigger_params = {FreezePod = 0, Computer = 0, Exit = 0, Door = 0}
local trigger_enabledNames = {}
local trigger_allowedExceptions
local trigger_allEnabled = {FreezePod = true, Computer = true, Exit = true, Door = true, AllowExceptions={}}
local trigger_allDisabled = {FreezePod = true, Computer = true, Exit = true, Door = true, AllowExceptions={}}
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
	if isCleared and name ~= "Override" then return end
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
	for num,trigger in ipairs(CS:GetTagged("Trigger")) do
		local triggerParent = trigger.Parent
		if triggerParent and trigger:IsA("BasePart") and workspace:IsAncestorOf(trigger) then
			local triggerType = trigger_gettype(triggerParent)
			assert(triggerType,"Unknown Trigger Type: "..trigger:GetFullName())
			local enabled = name=="Override" or trigger_params[triggerType]<=(triggerParent:GetAttribute("Trigger_AllowException") or 0)
			if enabled and trigger:GetAttribute("OrgSize")~=nil then
				trigger.Size=trigger:GetAttribute("OrgSize") trigger:SetAttribute("OrgSize",nil)
			elseif not enabled and trigger:GetAttribute("OrgSize")==nil then
				trigger:SetAttribute("OrgSize",trigger.Size)
				trigger.Size=newVector3(.0001,trigger.Size.Y,.0001)
			end
			trigger.CanTouch=enabled
		end
	end
end

local function requireModule(module: ModuleScript): Table
	return require(module)
end

--Module 0: XP + Stats
local LevelingXpCurve=gameUniverse=="Flee" and requireModule(RS:WaitForChild("LevelingXpCurve"))

local function getTotalXP(Level,CurrentXP)
	local totalXP=0
	for level=1,Level-1,1 do
		totalXP = totalXP + (LevelingXpCurve[level] or 4000)
	end
	totalXP = totalXP + CurrentXP
	return totalXP
end
local function sortPlayersByXPThenCredits(plrList)
	plrList = plrList or PS:GetPlayers()

	local function tableSortFunction(a,b)
		local aStats=a:FindFirstChild("SavedPlayerStatsModule")
		local bStats=b:FindFirstChild("SavedPlayerStatsModule")
		local doesExistA, doesExistB = aStats and aStats.Parent, bStats and bStats.Parent
		if not doesExistA or not doesExistB then
			return doesExistA and not doesExistB
		end
		local isABot=myBots[a.Name:lower()]
		local isBBot=myBots[b.Name:lower()]
		if isABot~=isBBot then
			return isABot
		end
		local aLevel = aStats:FindFirstChild("Level")
		local bLevel = bStats:FindFirstChild("Level")
		if not aLevel or not bLevel then
			return aLevel~=nil
		end
		if aLevel.Value~=bLevel.Value then
			return (aLevel.Value>bLevel.Value)
		end
		local aXP = aStats:FindFirstChild("Xp")
		local bXP = bStats:FindFirstChild("Xp")
		if not aXP or not bXP then
			return aXP~=nil
		end
		if aXP.Value~=bXP.Value then
			return (aXP.Value>bXP.Value)
		end
		return (aStats.Credits.Value>bStats.Credits.Value)
	end

	table.sort(plrList,tableSortFunction)

	return plrList
end
local function findRandomPositionOnBox(BoxCF,BoxSize,BasedOnOrigin)
	if BasedOnOrigin then
		BoxCF = BoxCF - BoxCF.Position;
	end;
	local HalfSize = BoxSize / 2;
	local Randomizer = Random.new();
	return BoxCF * Vector3.new(Randomizer:NextNumber(-HalfSize.X, HalfSize.X), Randomizer:NextNumber(-HalfSize.Y, HalfSize.Y), Randomizer:NextNumber(-HalfSize.Z, HalfSize.Z));
end;
--Module 1: Draggable


local UDim2_new = UDim2.new

local UserInputService = game:GetService("UserInputService")

local DraggableMain

local DraggableObject 		= {}
DraggableObject.__index 	= DraggableObject

-- Sets up a new draggable object
function DraggableObject.new(Object)
	local self 			= {}
	self.Object			= Object
	self.DragStarted	= nil
	self.DragEnded		= nil
	self.Dragged		= nil
	self.Dragging		= false

	setmetatable(self, DraggableObject)

	return self
end

-- Enables dragging
function DraggableObject:Enable()
	local object			= self.Object
	local dragInput			= nil
	local dragStart			= nil
	local startPos			= nil
	local preparingToDrag	= false

	-- Updates the element
	local function update(input)
		local delta 		= input.Position - dragStart
		local newPosition	= UDim2_new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		object.Position 	= newPosition

		return newPosition
	end

	self.InputBegan = object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			preparingToDrag = true
				--[[if self.DragStarted then
					self.DragStarted()
				end
				
				dragging	 	= true
				dragStart 		= input.Position
				startPos 		= Element.Position
				--]]

			local connection 
			connection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End and (self.Dragging or preparingToDrag) then
					self.Dragging = false
					connection:Disconnect()

					if self.DragEnded and not preparingToDrag then
						self.DragEnded()
					end

					preparingToDrag = false
				end
			end)
		end
	end)

	self.InputChanged = object.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	self.InputChanged2 = UserInputService.InputChanged:Connect(function(input)
		if object.Parent == nil then
			self:Disable()
			return
		end

		if preparingToDrag then
			preparingToDrag = false

			if self.DragStarted then
				self.DragStarted()
			end

			self.Dragging	= true
			dragStart 		= input.Position
			startPos 		= object.Position
		end

		if input == dragInput and self.Dragging then
			local newPosition = update(input)

			if self.Dragged then
				self.Dragged(newPosition)
			end
		end
	end)
end

function DraggableObject:Disable()
	self.InputBegan:Disconnect()
	self.InputChanged:Disconnect()
	self.InputChanged2:Disconnect()

	if self.Dragging then
		self.Dragging = false

		if self.DragEnded then
			self.DragEnded()
		end
	end
end

--Module 3: RAYCAST
local whitelistCashe = {};
local whitelistDataCashe = {};
local function compareArrays(arr1, arr2)
	for i, v in pairs(arr1) do
		if (typeof(v) == "table") then
			if (compareArrays(arr2[i], v) == false) then
				return false;
			end;
		else
			if (v ~= arr2[i]) then
				return false;
			end;
		end;
	end;

	--pls work
	return true;


end;










local raycast;

function raycast(from, target, filter, distance, passThroughTransparency,passThroughCanCollide)
	local raycastParams = RaycastParams.new();
	raycastParams.FilterType = Enum.RaycastFilterType.Include;
	if filter[1]~=nil and (filter[1]=="Whitelist" or filter[1]=="Blacklist" or filter[1]=="Include" or filter[1]=="Exclude") then
		raycastParams.FilterType = Enum.RaycastFilterType[(filter[1])];
		table.remove(filter,1)
	end
	if raycastParams.FilterType==Enum.RaycastFilterType.Include then
		local newFilter={};
		for num, cashedData in pairs(whitelistCashe) do
			if compareArrays(cashedData, filter) then
				newFilter=whitelistDataCashe[num];
			end;
		end;
		if #newFilter==0 then
			for num,model in pairs(filter) do
				for num,part in pairs(model:GetDescendants()) do
					if part:IsA("BasePart") and ((not passThroughTransparency or  part.Transparency<(passThroughTransparency or 1)) and (not passThroughCanCollide or part.CanCollide)) then
						table.insert(newFilter,part);
					end;
				end;
			end;
			local nextIndex = (#whitelistCashe+1);
			table.insert(whitelistCashe,nextIndex,filter);
			table.insert(whitelistDataCashe,nextIndex,newFilter);
		end;
		filter = newFilter;
	end;
	raycastParams.FilterDescendantsInstances = filter;
	raycastParams.IgnoreWater = true;
	local direction = (target - from);
	local result, lastInstance;
	while true do
		result = workspace:Raycast(from, direction.Unit*(distance or direction.magnitude+.5), raycastParams);
		--print(result~=nil and result.Instance or "no hit")
		--print(result,passThroughTransparency,passThroughTransparency,passThroughCanCollide)
		if raycastParams.FilterType==Enum.RaycastFilterType.Include or (result==nil or result.Instance==nil) or ((not passThroughTransparency or result.Instance.Transparency<(passThroughTransparency or 1)) and (not passThroughCanCollide or result.Instance.CanCollide)) then
			break;
		elseif result~=nil and lastInstance==result.Instance then
			break;
		else
			from = result.Position:lerp(target,.01);
			lastInstance = result.Instance;
			table.insert(filter, lastInstance);
			raycastParams.FilterDescendantsInstances = filter;
		end
	end
	if result~=nil and result.Instance~=nil and result.Instance.Parent~=nil then
		return result,result.Instance;
	else
		return false;
	end;
end;
--Module 4: SIMPLE PATH (PATHFINDING MODULE)
local DEFAULT_SETTINGS = {

	TIME_VARIANCE = 0.03,

	COMPARISON_CHECKS = 1,

	JUMP_WHEN_STUCK = true,
}
local function output(func, msg)
	func(((func == error and "SimplePath Error: ") or "SimplePath: ")..msg)
end
local Path = {
	StatusType = {
		Idle = "Idle",
		Active = "Active",
	},
	ErrorType = {
		LimitReached = "LimitReached",
		TargetUnreachable = "TargetUnreachable",
		ComputationError = "ComputationError",
		AgentStuck = "AgentStuck",
	},
}
Path.__index = function(table, index)
	if index == "Stopped" and not table._humanoid then
		output(error, "Attempt to use Path.Stopped on a non-humanoid.")
	end
	return (table._events[index] and table._events[index].Event) or (index == "LastError" and table._lastError) or (index == "Status" and table._status) or Path[index]
end

local visualWaypoint = Instance.new("Part",script)
visualWaypoint.Size = Vector3.new(0.3, 0.3, 0.3)
visualWaypoint.Anchored = true
visualWaypoint.CanCollide = false
visualWaypoint.Material = Enum.Material.Neon
visualWaypoint.Shape = Enum.PartType.Ball
visualWaypoint:AddTag("RemoveOnDestroy")

local function declareError(self, errorType)
	self._lastError = errorType
	self._events.Error:Fire(errorType)
end

local function createVisualWaypoints(waypoints)
	if isCleared then
		return
	end
	local visualWaypoints = {}
	for _, waypoint in ipairs(waypoints) do
		local visualWaypointClone = visualWaypoint:Clone()
		visualWaypoint:AddTag("Waypoints")
		visualWaypointClone.Position = waypoint.Position
		visualWaypointClone.Color = (waypoint == waypoints[#waypoints] and Color3.fromRGB(0, 255, 0)) or (waypoint.Action == Enum.PathWaypointAction.Jump and Color3.fromRGB(255, 0, 0)) or Color3.fromRGB(255, 139, 0)
		visualWaypointClone.Parent = char
		table.insert(visualWaypoints, visualWaypointClone)
	end
	return visualWaypoints
end

local function destroyVisualWaypoints(waypoints)
	for _, waypoint in ipairs(CS:GetTagged("Waypoints")) do
		DestroyInstance(waypoint)
	end
	return
end

local function getNonHumanoidWaypoint(self)
	for i = 2, #self._waypoints do
		if (self._waypoints[i].Position - self._waypoints[i - 1].Position).Magnitude > 0.1 then
			return i
		end
	end
	return 2
end

local function setJumpState(self)
	local function setJumpStateInternal()
		if ((self._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and self._humanoid.FloorMaterial~=Enum.Material.Air and not isActionProgress and not isCleared and game.Players.LocalPlayer.PlayerGui.ScreenGui.ActionBox.Text~="Open Door")) then
			self._humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
	pcall(setJumpStateInternal)
end

local function move(self)
	while isActionProgress do
		wait()
	end
	if not self._moveConnection then
		return
	end
	if self._status == Path.StatusType.Idle or self._waypoints==nil then
		return
	end
	if (self._waypoints[self._currentWaypoint].Action == Enum.PathWaypointAction.Jump) then
		setJumpState(self)
	elseif (self._currentWaypoint>1 and self._waypoints[self._currentWaypoint-1].Action == Enum.PathWaypointAction.Jump) then
		setJumpState(self)
	end
	local arg1 = (self._waypoints[self._currentWaypoint].Position)
	AvailableHacks.Bot[20].Funct(self, arg1)
end

local function disconnectMoveConnection(self)
	if (self~=nil and self._moveConnection~=nil) then
		self._moveConnection:Disconnect()
	end
	self._moveConnection = nil
end

local function invokeWaypointReached(self)
	local lastWaypoint = (self._currentWaypoint>=2 and self._waypoints[self._currentWaypoint - 1])
	local nextWaypoint = (self._waypoints[self._currentWaypoint])
	self._events.WaypointReached:Fire(self._agent, lastWaypoint, nextWaypoint)
end
local function waitForFall(self)
	if self._currentWaypoint==1 then
		return
	end
	local lastWaypoint = self._waypoints[self._currentWaypoint - 1]
	local currentWaypoint = self._waypoints[self._currentWaypoint]
	if lastWaypoint.Position.Y-currentWaypoint.Position.Y>6 then
		task.wait(1/3)
	end
end
local function moveToFinished(self, reached)

	if not getmetatable(self) then
		return
	end

	if not self._humanoid then
		if reached and self._currentWaypoint + 1 <= #self._waypoints then
			invokeWaypointReached(self)
			self._currentWaypoint = self._currentWaypoint + 1
		elseif reached then
			self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
			self._target = nil
			self._events.Reached:Fire(self._agent, self._waypoints[self._currentWaypoint])
		else
			self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
			self._target = nil
			declareError(self, self.ErrorType.TargetUnreachable)
		end
		return
	end

	if reached and ((self._currentWaypoint + 1) <= #self._waypoints)  then --Waypoint reached
		waitForFall(self)
		if ((self._currentWaypoint + 1) < #self._waypoints) then
			invokeWaypointReached(self)
		end
		self._currentWaypoint = self._currentWaypoint + 1
		move(self)
	elseif reached then --Target reached, pathfinding ends
		disconnectMoveConnection(self)
		self._status = Path.StatusType.Idle
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
		self._events.Reached:Fire(self._agent, (self._waypoints[self._currentWaypoint]))
	else --Target unreachable
		disconnectMoveConnection(self)
		self._status = Path.StatusType.Idle
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
		declareError(self, self.ErrorType.TargetUnreachable)
	end
end

local function comparePosition(self)
	if self._currentWaypoint == #self._waypoints or not self._agent.PrimaryPart then
		return
	end
	--print("compared")
	local dist = ((self._agent.PrimaryPart.Position - self._position._last)/(Vector3.new(1,math.huge,1))).Magnitude;
	self._position._count = (((dist <= 3.5) and (self._position._count + 1)) or 0);
	self._position._last = self._agent.PrimaryPart.Position;
	if not isActionProgress then
		if self._position._count >= self._settings.COMPARISON_CHECKS then
			--declareError(self, errorType)
			if self._settings.JUMP_WHEN_STUCK then
				if not AvailableHacks.Bot[15].UnlockDoor(false) and not AvailableHacks.Bot[15].CrawlVent(false) then
					self._agent.Humanoid:MoveTo(self._agent.PrimaryPart.CFrame*Vector3.new(0,0,1.35));
					task.wait((0.1));
					setJumpState(self);
					declareError(self, self.ErrorType.AgentStuck);
				end;
			end;
			return;
		end;
		local inputTbl = {Map};
		local result,hitPart = raycast(self._agent.PrimaryPart.Position,self._agent.Head.Position,inputTbl,4,nil,true);
		if hitPart then
			warn("He is stuck in wall!");
			declareError(self, self.ErrorType.AgentStuck);
		end;
	end;
end;


function Path.GetNearestCharacter(fromPosition)
	local character, dist = nil, math.huge
	for _, player in ipairs(PS:GetPlayers()) do
		if player.Character and (player.Character.PrimaryPart.Position - fromPosition).Magnitude < dist then
			character, dist = player.Character, (player.Character.PrimaryPart.Position - fromPosition).Magnitude
		end
	end
	return character
end

function Path.new(agent, agentParameters, override)
	if (not (agent and agent:IsA("Model") and agent.PrimaryPart)) then
		output(error, "Pathfinding agent must be a valid Model Instance with a set PrimaryPart.")
	end

	local self = setmetatable(({
		_settings = override or DEFAULT_SETTINGS,
		_events = {
			Reached = Instance.new("BindableEvent"),
			WaypointReached = Instance.new("BindableEvent"),
			Blocked = Instance.new("BindableEvent"),
			Error = Instance.new("BindableEvent"),
			Stopped = Instance.new("BindableEvent"),
		},
		_agent = agent,
		_humanoid = agent:FindFirstChildOfClass("Humanoid"),
		_path = PathfindingService:CreatePath(agentParameters),
		_status = "Idle",
		_t = 0,
		_position = {
			_last = Vector3.new(),
			_count = 0,
		},
	}), Path)

	--Configure settings
	for setting, value in pairs(DEFAULT_SETTINGS) do
		self._settings[setting] = self._settings[setting] == nil and value or self._settings[setting]
	end

	--Path blocked connection
	local function selfPathBlockedFunction(...)
		if (not ... or (self._currentWaypoint <= ... and self._currentWaypoint + 1 >= ...)) and self._humanoid and not isActionProgress then
			self._events.Blocked:Fire(self._agent, self._waypoints[...])
			setJumpState(self)
		end
	end
	self._path.Blocked:Connect(selfPathBlockedFunction)

	return self
end


function Path:Destroy()
	for _, event in ipairs(self._events) do
		event:Destroy()
	end
	self._events = nil
	if rawget(self, "_visualWaypoints") then
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
	end
	self._path:Destroy()
	setmetatable(self, nil)
	for k, _ in pairs(self) do
		self[k] = nil
	end
end

function Path:Stop()
	if not self._humanoid then
		output(error, "Attempt to call Path:Stop() on a non-humanoid.")
		return
	end
	if self._status == Path.StatusType.Idle then
		--output(function(m)
		--	warn(debug.traceback(m))
		--end, "Attempt to run Path:Stop() in idle state")
		return
	end
	disconnectMoveConnection(self)
	self._status = Path.StatusType.Idle
	self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
	self._events.Stopped:Fire(self._model)
end

function Path:Run(target)
	if isCleared then
		return false
	end
	--Non-humanoid handle case
	if (not target and not self._humanoid and self._target) then
		moveToFinished(self, true)
		return
	end

	--Parameter check
	if (not (target and (typeof(target) == "Vector3" or target:IsA("BasePart")))) then
		output(error, "Pathfinding target must be a valid Vector3 or BasePart.")
	end
	if not AvailableHacks.Blatant[2].IsCrawling then
		isActionProgress = ((plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("ActionProgress").Value%1)~=0)
	end

	while self._humanoid.Health>0 and self._humanoid.FloorMaterial==Enum.Material.Air do
		self._humanoid:GetPropertyChangedSignal("FloorMaterial"):Wait()
	end

	--Refer to Settings.TIME_VARIANCE
	if ((os.clock() - self._t) <= self._settings.TIME_VARIANCE) and self._humanoid then
		task.wait(os.clock() - self._t)
		declareError(self, self.ErrorType.LimitReached)
		return false
	elseif self._humanoid then
		self._t = os.clock()
	end

	if not self._agent.PrimaryPart then 
		return
	end

	local Destination = ((typeof(target) == "Vector3" and target) or target.Position)
	local From = self._agent.PrimaryPart.Position

	--Compute path
	local excludeRaycastTable = ({"Exclude",nil,nil,char,Beast})
	local directPath = false
	local function pcallFunction()
		local distToTarget = (Destination-From).Magnitude
		local result, hitPart = raycast(From,(Destination+Vector3.new(0,4,0)),(excludeRaycastTable),distToTarget,nil,true)
		if distToTarget<24 and not result then
			directPath=true
		else
			self._path:ComputeAsync(From, Destination)
		end
	end
	local pathComputed, _nothing = pcall(pcallFunction)
	--print(directPath,_)
	--Make sure path computation is successful
	if (not pathComputed or ((self._path.Status == Enum.PathStatus.NoPath or (#self._path:GetWaypoints() < 2)) and not directPath) or (self._humanoid and self._humanoid:GetState() == Enum.HumanoidStateType.Freefall)) then
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)

		local returnFalse = (self._target~=target or self._waypoints==nil or self._currentWaypoint==nil or self._waypoints[self._currentWaypoint]==nil or ((self._waypoints[self._currentWaypoint].Position-self._agent.PrimaryPart.Position)/Vector3.new(1,1,1)).magnitude>=6)

		if (returnFalse) then
			declareError(self, self.ErrorType.ComputationError)
			return false
			--else
			--self._currentWaypoint = self._currentWaypoint or 2
			--print("using old data!")
		end

	else
		local newWaypoints = {{Position=From, Action=Enum.PathWaypointAction.Walk},
		{Position=Destination, Action=Enum.PathWaypointAction.Walk}}
		self._target = target
		self._waypoints = (directPath and newWaypoints) or self._path:GetWaypoints()
		self._currentWaypoint = 2
	end

	--Set status to active pathfinding starts
	self._status = ((self._humanoid and Path.StatusType.Active) or Path.StatusType.Idle)


	--Set network owner to server to prevent "hops"
	--pcall(function()
	--	self._agent.PrimaryPart:SetNetworkOwner(nil)
	--end)

	--Initialize waypoints


	--Refer to Settings.COMPARISON_CHECKS
	if self._humanoid then
		comparePosition(self)
	end

	--Visualize waypoints
	destroyVisualWaypoints(self._visualWaypoints)
	if self._status == Path.StatusType.Idle then
		return
	end
	self._visualWaypoints = (self.Visualize and createVisualWaypoints(self._waypoints))

	--Create a new move connection if it doesn't exist already
	if AvailableHacks.Bot[15].AvoidParts[1]~=nil and Beast~=nil and Beast:FindFirstChild("Torso")~=nil then
		if not myBots[Beast.Name:lower()] then
			AvailableHacks.Bot[15].AvoidParts[1].Position=(Beast.Torso.Position)
		end
	end
	task.spawn(AvailableHacks.Bot[15].UnlockDoor)
	local function mtf(...)
		moveToFinished(self, ...)
	end
	self._moveConnection = self._humanoid and (self._moveConnection or self._humanoid.MoveToFinished:Connect(mtf))

	--Begin pathfinding
	if self._humanoid then
		--self._humanoid:MoveTo(self._waypoints[self._currentWaypoint].Position)
		if self._waypoints[self._currentWaypoint] then
			AvailableHacks.Bot[20].Funct(self,self._waypoints[self._currentWaypoint].Position)
			--self._currentWaypoint-=1--subtract the current waypoint to add it later!
			--moveToFinished(self,true)
			if self._waypoints[self._currentWaypoint].Position and self._agent.PrimaryPart then
				if self._waypoints[self._currentWaypoint].Action==Enum.PathWaypointAction.Jump or (self._currentWaypoint>1 and self._waypoints[self._currentWaypoint-1].Action==Enum.PathWaypointAction.Jump) or self._waypoints[self._currentWaypoint].Position.Y>self._agent.PrimaryPart.Position.Y-2 then
					setJumpState(self)
				end
			end
		end
	elseif #self._waypoints == 2 then
		self._target = nil
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
		self._events.Reached:Fire(self._agent, self._waypoints[2])
	else
		self._currentWaypoint = getNonHumanoidWaypoint(self)
		moveToFinished(self, true)
	end
	return true
end
--MODULE 3: LOCAL CLUB SCRIPT
local currentRaycastParams = RaycastParams.new()
local ClearFreezePodBillboardIcons
local function LocalClubScriptFunction(Original_LocalClubScript)
	local script = Original_LocalClubScript
	local Hammer = Original_LocalClubScript.Parent

	local ClubConnections = AvailableHacks.Utility[8].ClubFuncts
	local ShowFreezeConnections = AvailableHacks.Utility[8].ShowFreezeConnections

	local ShowRaycast, RagdollLimbRaycast, FindCharacterFromChild, SetLocalTransparencyInChildren
	local ShowEmptyFreezePodBillboardIcons, OnClick

	local v2 = script.Parent
	local v4 = v2:WaitForChild("HammerEvent")
	local v7 = game:GetService("UserInputService")
	local v10 = game:GetService("ReplicatedStorage")
	local v13 = game:GetService("ContextActionService")
	local v19 = v2:WaitForChild("Handle")
	local v20 = false
	local v21 = false
	local v23 = game.Players
	local v24 = v23.LocalPlayer
	v23 = v24.Character
	local v26 = v23:WaitForChild("Humanoid")
	local v28 = v24:GetMouse()
	local v30 = workspace.CurrentCamera
	local v32 = v23:WaitForChild("CarriedTorso")
	local v36 = require(v24:WaitForChild("TempPlayerStatsModule"))
	local v40 = v26:LoadAnimation(v2:WaitForChild("AnimSwing"))
	local v44 = v26:LoadAnimation(v2:WaitForChild("AnimWipe"))
	local v48 = v26:LoadAnimation(v2:WaitForChild("AnimArmIdle"))
	local v51 = v19:WaitForChild("SoundHitPlayer")
	local v54 = v19:WaitForChild("SoundHitWall")
	local function ClearFreezeConnection()
		for s = #AvailableHacks.Utility[8].ShowFreezeConnections, 1, -1 do
			local funct = AvailableHacks.Utility[8].ShowFreezeConnections[s]
			if funct then
				funct:Disconnect()
			end
			table.remove(AvailableHacks.Utility[8].ShowFreezeConnections,s)
		end
	end
	ShowEmptyFreezePodBillboardIcons = function()
		ClearFreezeConnection()
		local v70 = v10.CurrentMap
		for v69, v74 in ipairs(v70.Value:GetChildren()) do
			local v73 = v74.Name
			local podTrigger = v74:FindFirstChild("PodTrigger")
			if podTrigger and podTrigger:FindFirstChild("ActionSign") then
				local v77 = v10.BillboardGuiIcons.EmptyPodBillboardGui:Clone()
				v77.Parent = v23:FindFirstChild("IconBillboardGuis")
				v77.Adornee = v74:FindFirstChild("PodRoof")
				v77.Enabled = podTrigger.ActionSign.Value==30
				
				table.insert(ShowFreezeConnections, podTrigger.ActionSign.Changed:Connect(function()
					v77.Enabled = podTrigger.ActionSign.Value==30
				end))
			end
		end
	end
	ClearFreezePodBillboardIcons = function()
		ClearFreezeConnection()
		for v95, v94 in ipairs(v23:FindFirstChild("IconBillboardGuis"):GetChildren()) do
			if v94.Name == "EmptyPodBillboardGui" then
				v94:Destroy()
			end
		end
	end
	ShowRaycast = function(p1, p2)
		local v100 = Instance.new("Part", v2)
		v100.BrickColor = BrickColor.new("Bright red")
		v100.FormFactor = "Custom"
		v100.Material = "Neon"
		v100.Transparency = 0.25
		v100.Anchored = true
		v100.Locked = true
		v100.CanCollide = false
		local v128 = p1.Origin - p2.magnitude
		v100.Size = Vector3.new(0.01, 0.01, v128)
		v100.CFrame = CFrame.new(p1.Origin, p2) * CFrame.new(0, 0, -v128 / 2)
		DS:AddItem(v100, 1)
	end
	currentRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
	currentRaycastParams.IgnoreWater = true
	--currentRaycastParams.CollisionGroup = "PLAYERS_BODIES"
	RagdollLimbRaycast = function(p3)
		--print("weapon raycast")
		local v137 = false
		local v138 = {}
		v138[1] = v23
		local v144 = v23
		if not v23.Parent then return end
		local v145 = v144.Head
		local v146 = v145.CFrame
		local v147 = v146.p
		local v174 = p3 - v147
		local v175 = v174.unit
		local v149
		local v150
		local i = 0
		while i < 10 do
			i+=1
			v147 = Ray.new(v23.Head.CFrame.p, v175 * 6)
			v146 = v138
			v145 = false
			v144 = true
			--local v151, hitLoc = workspace:FindPartOnRayWithIgnoreList(v147, v146, v145, v144)
			currentRaycastParams.FilterDescendantsInstances = v146
			local result = workspace:Raycast(v23.Head.CFrame.p,v175 * 6,currentRaycastParams)
			v149 = result and result.Instance
			v150 = v174
			if result and v149 and v149:IsA("BasePart") then
				local v151 = v149.Transparency
				v174 = 0.95
				if not v149.CanCollide or (v149.Parent and (v149.Parent:FindFirstChild("Humanoid") or v149.Parent.Parent:FindFirstChild("Humanoid"))) then
					table.insert(v146, v149)
					v137 = true
					local v158 = PS:GetPlayerFromCharacter(v149.Parent)
					if v158 then
						local v161 = (v158:FindFirstChild("TempPlayerStatsModule"))
						local v164 = v149:isDescendantOf(v23)
						if not v164 then
							if v161.Ragdoll.Value and v161.Health.Value > 0 then
								v4:FireServer("HammerTieUp", v149, result.Position)
								v137 = false
								return v149
							else
								return
							end
						else
							return
						end
					end
				else
					return
				end
			else
				return
			end
		end
		--print("Weapons Raycast failed after i =",i)
		return
	end
	OnClick = function()
		--print("Mouse pressed!")
		local v180 = v20
		if not v180 then
			v180 = RagdollLimbRaycast
			local v181 = v28
			local v182 = v181.Hit
			local v184 = v180(v182.p)
			if v184 then
				v181 = "tie up player's: "
				v182 = v181 .. v184.Name
				print(v182)
				return 
			end
		end
		if v21 or v20 then
			return
		end
		v21 = true
		--print("HOI, swing!")
		v40:Play()
		local hammerHitConnection
		local swingStoppedConnection
		hammerHitConnection = v19.Touched:connect(function(p4)
			local v193 = "I hit: "
			local v194 = p4.Name
			--print(v193 .. v194)
			local v198 = FindCharacterFromChild(p4)
			if v198 then
				local v199 = v23
				--[[if v198 == v199 then
					v199 = p4.Transparency
					v193 = 0.95
					if v193 < v199 then
						v199 = p4.CanCollide
					end
				end--]]
				v199 = p4.Parent
				if v199 == v198 then
					--print( "I hit another player")
					v51:Play()
					v194 = "HammerHit"
					v4:FireServer(v194, p4)
					hammerHitConnection:Disconnect()
					swingStoppedConnection:Disconnect()
					v26.WalkSpeed = 0
					v21 = true
					while true do
						if v40.TimePosition ~= v40.Length then
							break
						end
						wait()
					end
					v44:Play(0.1, 1, 0.5)
					local v204
					local v211 = 0
					while true do
						if not v44.IsPlaying then
							break
						end
						wait()
					end
					--v211 = v26
					--local v214 = v211.WalkSpeed
					--v214 = v26
					--v214.WalkSpeed = v204.WalkSpeed
					v26.WalkSpeed = myTSM.NormalWalkSpeed.Value
					v21 = false
					return 
				end
				return 
			else
				v54:Play()
				v40:Stop()
			end
		end)
		swingStoppedConnection = v40.Stopped:connect(function()
			v21 = false
			hammerHitConnection:disconnect()
			swingStoppedConnection:disconnect()
		end)
	end
	FindCharacterFromChild = function(p5)
		if p5==workspace or p5==game then
			return
		elseif PS:GetPlayerFromCharacter(p5) then
			local v237 = p5:FindFirstChild("Humanoid")
			if v237 then
				return p5
			else
				return
			end
		end
		return FindCharacterFromChild(p5.Parent)
	end
	SetLocalTransparencyInChildren = function(p6)
		if p6 then
			local v246 = p6:IsA("BasePart")
			if v246 then
				v246 = p6.Transparency
				p6.LocalTransparencyModifier = v246
			end
			for _, obj in  ipairs(p6:GetChildren()) do
				SetLocalTransparencyInChildren(obj)
			end
		end
	end
	local function IsInsideGuiBox_1(p7, p8)
		local v257 = p7.X
		local v258 = p8.AbsolutePosition
		local v259 = v258.X
		if v257 > v259 then
			v257 = p7.X
			local v260 = p8.AbsolutePosition
			local v261 = p8.AbsoluteSize
			v258 = v260 + v261
			v259 = v258.X
			if v259 > v257 then
				v257 = p7.Y
				v258 = p8.AbsolutePosition
				v259 = v258.Y
				if v257 > v259 then
					v257 = p7.Y
					v260 = p8.AbsolutePosition
					v261 = p8.AbsoluteSize
					v258 = v260 + v261
					v259 = v258.Y
					if v259 > v257 then
						v257 = true
						return v257
					end
				end
			end
		end
		return false
	end
	local IsInsideGuiBox = IsInsideGuiBox_1
	IsInsideGuiBox_1 = UIS.TouchEnabled
	IsInsideGuiBox_1 = UIS.TouchTapInWorld
	table.insert(ClubConnections, IsInsideGuiBox_1:connect(function(p9, p10)
		if p10 then
			v4:FireServer("HammerClick", true)
			OnClick()
		end
	end))
	table.insert(ClubConnections, plr:GetMouse().Button1Down:connect(function()
		v4:FireServer("HammerClick", true)
		OnClick()
	end))
	local LArm = char:FindFirstChild("Left Arm")
	local RArm = char:FindFirstChild("Right Arm")
	table.insert(ClubConnections, game:GetService("RunService").RenderStepped:connect(function()
		LArm.LocalTransparencyModifier = LArm.Transparency
		RArm.LocalTransparencyModifier = RArm.Transparency
		SetLocalTransparencyInChildren(Hammer)
	end))
	local function carriedTorsoChangedFunction()
		local v295 = v32.Value
		if v295 then
			v295 = true
			v20 = v295
			v295 = ShowEmptyFreezePodBillboardIcons
			v295()
			return 
		end
		v20 = false
		ClearFreezePodBillboardIcons()

	end
	local carriedTorsoConnection = v32.Changed:connect(carriedTorsoChangedFunction)
	table.insert(ClubConnections,carriedTorsoConnection)
	table.insert(ClubConnections, Hammer.ChildRemoved:connect(function(p11)
		local v300 = p11.Name
		v300 = v48
		v300:Stop()
		ClearFreezePodBillboardIcons()
		--v24.CameraMode = Enum.CameraMode.Classic
	end))
	if (enHacks.Util_CanZoom==false) then
		print("Zooming Locked!")
		--v24.CameraMode = Enum.CameraMode.LockFirstPerson
	end
	v19:WaitForChild("SoundHeartBeat").Volume = 0
	v19:WaitForChild("SoundChaseMusic").Volume = 0
	v48:Play(0.100000001, 1, 0.5)
	carriedTorsoChangedFunction()
end

--USER COLOR COMPUTATION
--[[local ChatColors = {
	newColor3(0.768628, 0.156863, 0.109804),
	newColor3(0.0509804, 0.411765, 0.67451),
	newColor3(0.152941, 0.27451, 0.176471),
	newColor3(0.419608, 0.196078, 0.486275),
	newColor3(0.854902, 0.521569, 0.254902),
	newColor3(0.960784, 0.803922, 0.188235),
	newColor3(0.909804, 0.729412, 0.784314),
	newColor3(0.843137, 0.772549, 0.603922)
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
end--]]

--Important Variables:
plr=PS.LocalPlayer
char=plr.Character or plr.CharacterAdded:Wait()
local human=char:WaitForChild("Humanoid")
local camera=workspace:WaitForChild("Camera")
local hackChanged=Instance.new("BindableEvent")
local computerHackStartTime=os.clock()
local lastHackedPC,lastHackedPosition=nil,Vector3.new(100,100,100)


if gameUniverse=="Flee" then
	myTSM=plr:WaitForChild("TempPlayerStatsModule");
	mySSM=plr:WaitForChild("SavedPlayerStatsModule");
end;
if gameName=="FleeMain" then
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

local function setChangedAttribute(object,value,funct)
	if object==nil or object.Parent==nil then
		return
	end
	if not objectFuncts[object] then
		objectFuncts[object] = {};
	end
	if objectFuncts[object][value]~=nil then
		objectFuncts[object][value]:Disconnect();
		objectFuncts[object][value] = nil;
	end
	if funct~=nil and funct~=false then
		if value=="Value" and object:IsA("ValueBase") then
			objectFuncts[object][value] = object.Changed:Connect(funct);
		else

			objectFuncts[object][value] = object:GetPropertyChangedSignal(value):Connect(funct);
		end
	else
		objectFuncts[object][value]=nil;
	end
end
--Settings:


--BOT TRADE SYS--
if gameName=="FleeTrade" then
	for crateName, crateData in pairs(requireModule(RS:WaitForChild("ShopCrates"))) do
		if not crateData.CostRobux then
			AvailableHacks.Bot[143].Options[crateName]={
				["Title"]=crateData.Name.. " ("..comma_value(crateData.Price)..")",
				["TextColor"]=Color3.fromRGB(255),-- ComputeNameColor(crateData.Name),
			}
		end
	end
	local HasBundles = false
	for bundleName, bundleData in pairs(requireModule(RS:WaitForChild("ShopBundles"))) do
		if not bundleData.CostRobux then
			AvailableHacks.Bot[146].Options[bundleName]={
				["Title"]=bundleData.Name.. " ("..comma_value(bundleData.Price)..")",
				["TextColor"]=Color3.fromRGB(255),--ComputeNameColor(bundleData.Name),
			}
			HasBundles = true
		end
	end
	if not HasBundles then
		AvailableHacks.Bot[146]=nil
		AvailableHacks.Bot[147]=nil
	end
end




AvailableHacks ={
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
				local Head=theirChar:WaitForChild("Head",1e5) 
				if not Head then
					return
				end
				local newTag=NameTagEx:Clone()
				newTag.Username.Text=theirPlr.Name
				newTag.Distance.Visible=enHacks.ESP_Distance
				newTag.Parent=Head
				newTag.Enabled=enHacks.ESP_Players
				theirChar.Humanoid.DisplayDistanceType=(enHacks.ESP_Players and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer)
				CS:AddTag(newTag,"HackDisplays")
				CS:AddTag(newTag,"RemoveOnDestroy")
				local function childChanged(child)
					if not newTag:FindFirstChild("Username") then
						return
					end
					newTag.Username.TextColor3=(theirChar:FindFirstChild("Hammer")~=nil and newColor3(255) or newColor3(0,0,255))
				end
				table.insert(playerEvents[theirPlr.UserId],(theirChar.ChildAdded:Connect(childChanged)))
				table.insert(playerEvents[theirPlr.UserId],(theirChar.ChildRemoved:Connect(childChanged)))
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
					while (NameTag~=nil and NameTag.Parent~=nil and NameTag.Parent.Parent~=nil and DistanceTag~=nil and not isCleared) do
						local dist=math.round((camera.CFrame.p-(CenterObject.Position+NameTag.StudsOffset)).Magnitude)
						DistanceTag.Text=(dist.."m")
						if isInLobby(NameTag.Parent.Parent)==isInLobby(camera.CameraSubject.Parent) then
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
				local Head=theirChar:WaitForChild("Head",1e5) 
				if not Head then 
					return 
				end
				local NameTag=Head:WaitForChild("NameTagEx",1e5) 
				if not NameTag then 
					return 
				end
				NameTag.Distance.Visible=enHacks.ESP_Distance
				AvailableHacks.Render[2].UpdateDistFunct(NameTag,Head)
			end,
			["ComputerAdded"]=function(computer)
				local PrimPart=computer.PrimaryPart
				local NameTag=PrimPart:WaitForChild("NameTagEx")
				AvailableHacks.Render[2].UpdateDistFunct(NameTag,PrimPart)
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
				if not objectFuncts[computerTable] then
					objectFuncts[computerTable] = {};
				end
				local primPart,Screen=computerTable.PrimaryPart,computerTable:FindFirstChild("Screen",true);
				local newTag=NameTagEx:Clone();
				newTag.Username.TextColor3=newColor3(84, 84, 84);
				newTag.Distance.Visible=enHacks.ESP_Distance;
				newTag.ExtentsOffsetWorldSpace = newTag.ExtentsOffsetWorldSpace + newVector3(0,4,0);
				newTag.Parent=primPart;
				newTag.Enabled=enHacks.ESP_PC;

				CS:AddTag(newTag,"RemoveOnDestroy");
				CS:AddTag(newTag,"HackDisplays2");
				local function updateText()
					if not workspace:IsAncestorOf(newTag) then
						return
					end
					newTag.Username.Text="Computer"..string.sub(computerTable.Name,14);
					-- ..(
					--AvailableHacks.Render[3].ScreenColors[Screen.BrickColor.Name]
					--	or "[INTERNAL ERROR]")
					newTag.Username.TextColor3=Screen.BrickColor.Color
					newTag.ExpandingBar.Visible=Screen.BrickColor.Name~="Dark green" and (math.abs(newTag.ExpandingBar.AmtFinished.Size.X.Scale%1)<=.00001) and enHacks.ESP_PCProg
				end
				setChangedAttribute(Screen,"Color",updateText)
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
				local VPF=HackGUI:FindFirstChild("ViewportFrame")
				if VPF~=nil then
					VPF.Visible=newValue
				end
			end,
			["OthersStartUp"]=function(theirPlr,theirChar)
				local Head=theirChar:WaitForChild("Head",1e5)
				if not Head then
					return
				end
				local nameTag=Head:WaitForChild("NameTagEx",1e5) 
				if not Head then
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
				--if not enHacks.ESP_Highlight then
				changeVisibility(robloxHighlight,1)	--changeRenderVisibility(theirViewportChar,1)
				--end
				local key
				delay(.25,function()
					objectFuncts[theirChar]=objectFuncts[theirChar] or {}
					while not isCleared and theirChar~=nil and theirChar.Parent~=nil do
						--if enHacks.ESP_Highlight then
						--key=#objectFuncts[theirChar]+1
						while enHacks.ESP_Highlight and nameTag.Parent~=nil and nameTag.Parent.Parent~=nil and not isCleared do--table.insert(objectFuncts[theirChar],key,RunS.RenderStepped:Connect(function(dt)
							if (Head.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance and (({isInLobby(theirChar)})[1])==({isInLobby(camera.CameraSubject.Parent)})[1] then
								--local didHit,instance=true,theirChar.PrimaryPart
								local didHit,instance=raycast(camera.CFrame.p, Head.Position, {"Blacklist",camera.CameraSubject.Parent}, 100, 0.001)
								changeVisibility(robloxHighlight,(didHit and theirChar:IsAncestorOf(instance)) and 1 or 0,(Beast==theirChar and newColor3(255) or newColor3(0,0,255)))--changeRenderVisibility(theirViewportChar,(didHit and theirChar:IsAncestorOf(instance)) and 1 or 0, (theirChar:FindFirstChild("Hammer")==nil and newColor3(0,0,255) or newColor3(255)))
								--myRenderer:step(0)
							else
								changeVisibility(robloxHighlight,1)
								--changeRenderVisibility(theirViewportChar,1,(theirChar:FindFirstChild("Hammer")==nil and newColor3(0,0,255) or newColor3(255)))
							end
							task.wait()
							while theirChar.Humanoid==camera.CameraSubject do
								changeVisibility(robloxHighlight,1) --changeRenderVisibility(theirViewportChar,1)
								camera:GetPropertyChangedSignal("CameraSubject"):Wait()
							end
						end
						--end))
						--elseif objectFuncts[theirChar][key]~=nil then
						--objectFuncts[theirChar][key]:Disconnect()
						--table.remove(objectFuncts[theirChar],key) task.wait()
						changeVisibility(robloxHighlight,1)--changeRenderVisibility(theirViewportChar,1)
						--end
						hackChanged.Event:Wait()
					end
					--if objectFuncts[theirChar][key] ~=nil then
					--	objectFuncts[theirChar][key]:Disconnect()--do a favor
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
				local VPF=HackGUI:FindFirstChild("ViewportFrame")
				if VPF~=nil then
					VPF.Visible=newValue
				end
			end,
			["CleanUp"]=function()
				for num, computerElement in pairs(HackGUI:GetChildren()) do
					if string.sub(computerElement.Name,1,13)=="ComputerTable" then
						DestroyInstance(computerElement)
					end
				end
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
					while not isCleared and Computer~=nil and Computer.Parent~=nil do
						while enHacks.ESP_PCHighlight and not isCleared do
							if (((primPart.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance) and isInLobby(camera.CameraSubject.Parent)) then
								local didHit = false
								local instance = primPart
								if (Map~=nil and Screen~=nil) then    
									local castArgument = camera.CameraSubject~=nil and camera.CameraSubject.Parent
									local castArray = {"Blacklist", castArgument}
									didHit,instance=raycast(camera.CFrame.p, Screen.Position, castArray, 100, 0.001)
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
					local Head=theirChar:FindFirstChild("Head") 
					if not Head then 
						return
					end
					local nameTag=Head:WaitForChild("NameTagEx", waitForChildTimout)
					if not nameTag then
						return
					end
					nameTag.ExpandingBar.Visible=(enHacks.ESP_PlayerProg and ActionProgress.Value~=0 and TSM.CurrentAnimation.Value~="Typing")
					if TSM.CurrentAnimation.Value=="Typing" then
						AvailableHacks.Render[7].RefreshBar(theirPlr,Head,ActionProgress)
					else
						nameTag.ExpandingBar.AmtFinished.Size=UDim2.new(ActionProgress.Value, 0, 1, 0)
					end
				end
				setChangedAttribute(ActionProgress,"Value",ActionChanged)
				ActionChanged()
			end,
		},
		[7]={
			["Type"]="ExTextButton",
			["Title"]="ESP Computer Progress",
			["Desc"]="Works under most conditions",
			["Shortcut"]="ESP_PCProg",
			["Default"]=false,
			["RefreshBar"]=function(theirPlr,CenterPoso,ActionProgress)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				if (TSM.ActionEvent.Value==nil or (TSM.CurrentAnimation.Value~=("Typing")) or (string.sub(TSM.ActionEvent.Value.Parent.Name,1,15)~=("ComputerTrigger"))) then
					return
				end
				local closestPC,dist=nil,15
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					local Screen=tag.Parent
					local PC=Screen.Parent
					local newDist=(Screen.Position-CenterPoso.Position).magnitude
					if newDist<dist then
						closestPC,dist=PC,newDist
					end
				end
				if (closestPC~=nil) then
					AvailableHacks.Render[7].SetBar(closestPC,ActionProgress.Value)
				end
			end,
			["SetBar"]=function(PC,Progress)
				local ExpandingBar=PC.PrimaryPart:WaitForChild("NameTagEx"):WaitForChild("ExpandingBar")
				ExpandingBar.AmtFinished.Size=UDim2.new(Progress, 0, 1, 0)
				ExpandingBar.Visible=((PC.Screen.BrickColor.Name~=("Dark green")) and Progress>0.001 and enHacks.ESP_PCProg)
				PC:SetAttribute("Progress",Progress)
			end,
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					tag.ExpandingBar.Visible = (newValue and tag.ExpandingBar.AmtFinished.Size.X.Scale>0.0001)
				end
			end,
			["ComputerAdded"]=function(PC)
				local progress=PC:GetAttribute("Progress")
				if progress~=nil then
					AvailableHacks.Render[7].SetBar(PC,progress)
				end
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local ActionProgress=TSM:WaitForChild("ActionProgress")
				local function ActionChanged()
					local theirChar=plr.Character 
					if theirChar==nil then
						return
					end
					local Head=theirChar:FindFirstChild("Head")
					if Head==nil then
						return
					end
					if TSM.CurrentAnimation.Value=="Typing" then
						AvailableHacks.Render[7].RefreshBar(plr,Head,ActionProgress)
					end
					local function SetMiniGameResultFunction()
						for s=1,1,-1 do
							if not enHacks.Util_AutoHack then
								return
							end
							RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
							task.wait((0.05))
						end
					end
					task.spawn(SetMiniGameResultFunction)
				end
				setChangedAttribute(ActionProgress,"Value",ActionChanged)
				ActionChanged()
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
					human.WalkSpeed=newValue==16 and plr.TempPlayerStatsModule.NormalWalkSpeed.Value or newValue
				end

				if newValue==16 then
					setChangedAttribute(human,"WalkSpeed",false)
				else
					setChangedAttribute(human,"WalkSpeed",setSpeed)
				end
				setSpeed()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				AvailableHacks.Blatant[1].ActivateFunction(enHacks.WalkSpeed)
			end,
		},--]]
		[2]={
			["Type"]="ExTextButton",
			["Title"]="Crawl as Beast",
			["Desc"]="Very obvious",
			["Shortcut"]="OverrideCrawl",
			["LoadedAnim"]=nil,
			["Default"]=false,
			["DontActivate"]=true,
			["ActivateFunction"]=function(newValue)
				--AvailableHacks.Blatant[2].SetScriptActive()
				if not newValue then
					AvailableHacks.Blatant[2].Crawl(false)
				end
			end,
			["MyStartUp"]=function()
				if AvailableHacks.Blatant[2].LoadedAnim~=nil then
					AvailableHacks.Blatant[2].LoadedAnim:Destroy()
				end
				AvailableHacks.Blatant[2].IsCrawling=false
				local CrawlScript=char:WaitForChild("CrawlScript") 
				if CrawlScript==nil then
					return
				end
				for num,animTrack in pairs(char.Humanoid.Animator:GetPlayingAnimationTracks()) do
					if animTrack.Animation.AnimationId=="rbxassetid://961932719" then
						animTrack:Stop(0)
						animTrack:Destroy()
						human.HipHeight=0
					end
				end
				CrawlScript.Disabled=true
				local animTrack=human:WaitForChild("Animator"):LoadAnimation(CrawlScript:WaitForChild("AnimCrawl"))
				AvailableHacks.Blatant[2].LoadedAnim=animTrack
				local function keyAction(actionName, inputState, inputObject)
					local shouldHold = enHacks.Util_CrawlType=="Default" and Enum.UserInputType.Keyboard == inputObject.UserInputType or enHacks.Util_CrawlType=="Hold"
					if shouldHold then
						if inputState==Enum.UserInputState.Begin then
							AvailableHacks.Blatant[2].Crawl(true)
						elseif inputState==Enum.UserInputState.End then
							AvailableHacks.Blatant[2].Crawl(false)
						end
					elseif inputState == Enum.UserInputState.Begin then
						local inverse = not AvailableHacks.Blatant[2].IsCrawling;
						AvailableHacks.Blatant[2].Crawl(inverse);
					end
				end
				local button = getDictLength(CAS:GetBoundActionInfo("Crawl"))>0 and CAS:GetButton("Crawl")
				local setPosition = plr:GetAttribute("CrawlPosition") or UDim2_new(1, -220, 1, -90)
				if button then
					setPosition = button.Position
					plr:SetAttribute("CrawlPosition",setPosition)
				end
				CAS:UnbindAction("Crawl")
				CAS:BindActionAtPriority("Crawl"..saveIndex, keyAction, true, 100, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL2)
				RunS.RenderStepped:Wait()
				CAS:SetTitle("Crawl"..saveIndex, "C")
				CAS:SetPosition("Crawl"..saveIndex,setPosition);

				local function HumanRunningFunction(speed)
					if speed > 0.5 then
						animTrack:AdjustSpeed(2)
					else
						animTrack:AdjustSpeed(0)
					end
				end
				table.insert(functs,(human.Running:Connect(HumanRunningFunction)))
				local inputToCrawlFunction_INPUT = UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.ButtonL2)
				AvailableHacks.Blatant[2].Crawl(inputToCrawlFunction_INPUT)
			end,
			["MyPlayerAdded"]=function()
				local function crawlFunction()
					AvailableHacks.Blatant[(2)].Crawl()
				end
				
				table.insert(functs, myTSM:WaitForChild("DisableCrawl").Changed:Connect(function()
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					CAS:UnbindAction("Crawl")
				end))
			end,
			["IsCrawling"]=false,
			["Crawl"]=function(set)
				local TSM = plr:WaitForChild("TempPlayerStatsModule");
				local animTrack = AvailableHacks.Blatant[2].LoadedAnim;
				local shouldReturn = not animTrack or not human or human.Health <= 0;
				if shouldReturn then
					return;
				end
				local argument = set and (enHacks.OverrideCrawl or not TSM.DisableCrawl.Value);
				if argument then
					local hipHeight = -2;
					human.HipHeight = hipHeight;
					local arg1 = 0.1;
					local arg2 = 1.0;
					local arg3 = 0.0;
					animTrack:Play(arg1, arg2, arg3);
					human.WalkSpeed = 8;
					AvailableHacks.Blatant[2].IsCrawling = true;
				else
					human.HipHeight = 0;
					animTrack:Stop();
					human.WalkSpeed = (((human.WalkSpeed==8) and 16) or human.WalkSpeed);
					AvailableHacks.Blatant[2].IsCrawling=false;
				end
				TSM.IsCrawling.Value = AvailableHacks.Blatant[2].IsCrawling;
			end,
		},
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
			["ChangedFunction"]=function(newSet)
				--print("begun")
				if Beast==nil then
					return
				end
				local CarriedTorso=Beast:FindFirstChild("CarriedTorso")
				if CarriedTorso==nil then
					return
				end
				while newSet~=nil and CarriedTorso.Value~=newSet do
					--print("waiting")
					task.wait(1/3)
				end
				local Hammer=Beast:WaitForChild("Hammer")
				if Hammer==nil or not enHacks.AutoRemoveRope then
					return
				end
				if not char:IsAncestorOf(CarriedTorso.Value) and enHacks.AutoRemoveRope=="Me" then
					--print("cancelled ", char:GetFullName())
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
				if workspace:IsAncestorOf(Beast) and Beast~=char then
					setChangedAttribute(Beast:WaitForChild("CarriedTorso",30),"Value",false)--deletes the last function!
					AvailableHacks.Blatant[3].OthersBeastAdded(
						PS:GetPlayerFromCharacter(Beast),Beast)
				end
				--AvailableHacks.Blatant[3].ChangedFunction()
			end,
			["OthersBeastAdded"]=function(theirPlr,theirChar)
				local CarriedTorso=theirChar:WaitForChild("CarriedTorso",30)
				if CarriedTorso==nil then
					return
				end
				wait(.5)
				setChangedAttribute(CarriedTorso,"Value",enHacks.AutoRemoveRope and (function(newRopee)
					AvailableHacks.Blatant[3].ChangedFunction(newRopee)
				end) or false)
				AvailableHacks.Blatant[3].ChangedFunction()
			end,
			--["MyBeastAdded"]=function(...)
			--	AvailableHacks.Blatant[3].OthersBeastAdded(...)
			--end
		},
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
				setChangedAttribute(plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("Ragdoll"),"Value",newValue and 
					AvailableHacks.Blatant[4].EnableScript or false)
				if newValue then
					spawn(AvailableHacks.Blatant[4].EnableScript)
				end
			end,
		},--]]
		[7]={
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
				if (enHacks.AutoAddRope~="Everyone" and (enHacks.AutoAddRope~="Me" or Beast~=char)) and not override then
					return
				end
				if (not Beast or not TSM.Ragdoll.Value) then
					return
				end
				local CarriedTorso=Beast:FindFirstChild("CarriedTorso")
				if CarriedTorso==nil or CarriedTorso.Value then
					return
				end
				Beast.Hammer.HammerEvent:FireServer("HammerTieUp",theirPlr.Character.Torso,theirPlr.Character.Torso.NeckAttachment.WorldPosition)
			end,
			["ChangedFunction"]=function(TSM,theirPlr,loop)
				if (not TSM.Ragdoll.Value or not Beast) then
					return
				end
				local CarriedTorso=Beast:FindFirstChild("CarriedTorso")
				while (Beast and CarriedTorso.Value and TSM.Ragdoll.Value and loop and not isCleared) do
					CarriedTorso.Changed:Wait()
				end
				AvailableHacks.Blatant[7].RopeSurvivor(TSM,theirPlr)
				--deletes the last function!
			end,
			["ActivateFunction"]=function(newVal)
				if newVal then
					--for num, theirPlr in ipairs(PS:GetPlayers()) do
					--	AvailableHacks.Blatant[7].ChangedFunction(theirPlr:WaitForChild("TempPlayerStatsModule"),theirPlr)
					--end
					for num,theirPlr in ipairs(PS:GetPlayers()) do
						AvailableHacks.Blatant[7].PlayerAdded(theirPlr)
					end
				end
			end,
			["PlayerAdded"]=function(theirPlr)
				local TSM = theirPlr:WaitForChild("TempPlayerStatsModule")
				local funct = function()
					AvailableHacks.Blatant[7].ChangedFunction(TSM,theirPlr,true)
				end
				local myInput = (enHacks.AutoAddRope and funct)
				setChangedAttribute(TSM:WaitForChild("Ragdoll",30),"Value", myInput)
				AvailableHacks.Blatant[7].ChangedFunction(TSM,theirPlr,false)
			end,
			["MyPlayerAdded"]=function(myPlr)
				AvailableHacks.Blatant[7].PlayerAdded(myPlr)
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				AvailableHacks.Blatant[7].PlayerAdded(theirPlr)
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
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
				task.wait()
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false, Trigger.Event)
				ActionEventVal.Value=nil
				while Trigger.ActionSign.Value~=10 do--wait for it to be opened
					Trigger.ActionSign.Changed:Wait()
				end
				for s=5,1,-1 do
					if Trigger.ActionSign.Value==11 then
						break
					end
					game.ReplicatedStorage.RemoteEvent:FireServer("Trigger", "Input", true, Trigger.Event)
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
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
					AvailableHacks.Blatant[10].CloseDoor(Trigger)
				end
			end,
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				setChangedAttribute(plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("ActionInput"),"Value",(newValue and AvailableHacks.Blatant[10].EnableScript or false))
				if newValue then
					AvailableHacks.Blatant[10].EnableScript()
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
					newColor3(255,255)
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
				local Toggle = tag:WaitForChild("Toggle", waitForChildTimout);
				if Toggle==nil then
					return
				end
				--local tag=doorTrigger.ToggleTag
				local ActionSign = myDoorTrigger:WaitForChild("ActionSign",1e5)
				if not ActionSign then
					return
				end
				ActionSign = ActionSign.Value
				local currentSign = ((ActionSign==10 and door.Name=="ExitDoor") and 12 or ActionSign)
				Toggle.Text = AvailableHacks.Blatant[15].DifferentColors[currentSign][1]
				Toggle.BackgroundColor3 = AvailableHacks.Blatant[15].DifferentColors[currentSign][2]
				Toggle.Visible = (door.Name~="ExitDoor" or currentSign~=0)
				local modifier=door:WaitForChild("WalkThru",20)
				if modifier~=nil then
					modifier.PathfindingModifier.Label = ((currentSign==10 or currentSign==12) and "DoorPath" or "DoorOpened")
				end
			end,
			["ActivateFunction"]=function(newValue)
				local isInGame=isInLobby(camera.CameraSubject.Parent)
				local hackDisplayList = CS:GetTagged("HackDisplay2")
				for num,tag in ipairs(hackDisplayList) do
					tag.Enabled=newValue and camera.CameraType==Enum.CameraType.Custom and isInGame
				end
			end,
			["CleanUp"]=function()
				DestroyAllTaggedObjects("HackDisplay2")
				AvailableHacks.Blatant[15].DoorFuncts = {}
			end,
			["UpdateDisplays"]=function()
				AvailableHacks.Blatant[15].ActivateFunction(enHacks.RemotelyOpenDoors)
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				table.insert(functs,RS:WaitForChild("AnnouncementEvent").OnClientEvent:Connect(function(...)
					--print(...)
					if not ... then
						AvailableHacks.Blatant[15].UpdateDisplays()
					end
				end))--]]
				setChangedAttribute(RS.IsGameActive,"Value",AvailableHacks.Blatant[15].UpdateDisplays)
				setChangedAttribute(camera,"CameraSubject",AvailableHacks.Blatant[15].UpdateDisplays)
				setChangedAttribute(TSM:WaitForChild("Escaped"),"Value",AvailableHacks.Blatant[15].UpdateDisplays)
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
				local newTag=ToggleTag:Clone()
				local isInGame=isInLobby(workspace.Camera.CameraSubject.Parent)
				newTag.Parent=HackGUI
				newTag.Adornee=doorTrigger
				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplay2")
				task.wait()
				if newTag==nil or newTag.Parent==nil or newTag:FindFirstChild("Toggle")==nil then
					return
				end
				local function getState()
					return actionSign.Value==11--returns true if opened!
				end
				local function setToggleFunction()
					if actionSign.Value==0 then
						for s=5,1,-1 do
							if actionSign.Value~=0 then
								break
							end
							wait(.075)
						end
					end
					if actionSign.Value==0 then
						return
					end
					local isOpened,currentEvent=getState(),TSM.ActionEvent.Value
					trigger_setTriggers("RemoteDoorControl",false)
					for s=5,1,-1 do
						if isOpened~=getState() or actionSign.Value==0 then
							break
						end
						RS.RemoteEvent:FireServer("Input", "Trigger", true, doorTrigger.Event)
						RS.RemoteEvent:FireServer("Input", "Action", true)
						if isOpened then
							RS.RemoteEvent:FireServer("Input", "Trigger", false)
						end
						RunS.RenderStepped:Wait()
					end
					local function TaskSpawnDelayedFunction()
						while actionSign.Value==0 do
							actionSign.Changed:Wait()
						end
						trigger_setTriggers("RemoteDoorControl",true)
					end
					task.spawn(TaskSpawnDelayedFunction)
					--wait()
					if currentEvent~=nil then
						RS.RemoteEvent:FireServer("Input", "Trigger", true, currentEvent)
						--wait()
						--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
					end
				end
				AvailableHacks.Blatant[15].DoorFuncts[door] = setToggleFunction
				newTag.Toggle.MouseButton1Up:Connect(setToggleFunction)
				AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				newTag.Enabled=(enHacks.RemotelyOpenDoors and (camera.CameraType==Enum.CameraType.Custom and isInGame))
				wait(.075)
				local function actionSignChangedFunct()
					AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				end
				setChangedAttribute(actionSign,"Value", (actionSignChangedFunct))
			end,
		},
		[20]={
			["Type"]="ExTextButton",
			["Title"]="Remote Computers",
			["Desc"]="Remotely Hack Computers",
			["Shortcut"]="RemotelyHackComputers",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				local isInGame=isInLobby(camera.CameraSubject.Parent)
				local hackDisplayList = CS:GetTagged("HackDisplay3")
				for num,tag in ipairs(hackDisplayList) do
					tag.Enabled=newValue and camera.CameraType==Enum.CameraType.Custom and isInGame
				end
			end,
			["CleanUp"]=function()
				DestroyAllTaggedObjects("HackDisplay3")
			end,
			["UpdateDisplays"]=function()
				AvailableHacks.Blatant[15].ActivateFunction(enHacks.RemotelyHackComputers)
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				table.insert(functs,RS:WaitForChild("AnnouncementEvent").OnClientEvent:Connect(function(...)
					--print(...)
					if not ... then
						AvailableHacks.Blatant[15].UpdateDisplays()
					end
				end))--]]
				setChangedAttribute(RS.IsGameActive,"Value",AvailableHacks.Blatant[15].UpdateDisplays)
				setChangedAttribute(camera,"CameraSubject",AvailableHacks.Blatant[15].UpdateDisplays)
				setChangedAttribute(TSM:WaitForChild("Escaped"),"Value",AvailableHacks.Blatant[15].UpdateDisplays)
			end,
			["ComputerAdded"]=function(Computer)
				local ComputerBase = Computer.PrimaryPart
				local BestTrigger
				local bestAngle = 3
				for _, trigger_name in ipairs({"ComputerTrigger1","ComputerTrigger2","ComputerTrigger3"}) do
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
				
				local newTag=ToggleTag:Clone()
				local isInGame=isInLobby(workspace.Camera.CameraSubject.Parent)
				newTag.Parent=HackGUI
				newTag.ExtentsOffsetWorldSpace = Vector3.new(0, 12, 0)
				newTag.Adornee=ComputerBase
				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplay3")
				task.wait()
				if newTag==nil or newTag.Parent==nil or newTag:FindFirstChild("Toggle")==nil then
					return
				end
				local ToggleButton = newTag.Toggle
				ToggleButton.BackgroundColor3 = Color3.fromRGB(0,0,170)
				ToggleButton.Text = "Teleport"
				local function setToggleFunction()
					local goodTriggers = AvailableHacks.Bot[15].getGoodTriggers(Computer)
					if #goodTriggers>0 then
						local selectedTriggerKey = table.find(goodTriggers,BestTrigger) or 1
						teleportMyself(goodTriggers[selectedTriggerKey]:GetPivot())
					else
						teleportMyself(BestTrigger:GetPivot())
					end
					--TODO HERE					
				end
				ToggleButton.MouseButton1Up:Connect(setToggleFunction)
				newTag.Enabled=(enHacks.RemotelyHackComputers and (camera.CameraType==Enum.CameraType.Custom and isInGame))
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
				if not enHacks.Panic or char:FindFirstChild("Head")==nil or not TSM.Ragdoll.Value then
					return
				end
				local newVel=Instance.new("BodyVelocity",char.Head)
				newVel.MaxForce = (newVector3(3000,3000,3000)*2.25)
				newVel.P = 3e3
				CS:AddTag(newVel,"RemoveOnDestroy")
				local function RagdollPanicThreadFunction()
					while (enHacks.Panic and TSM.Ragdoll.Value and not TSM.Captured.Value and not isCleared) do
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
					AvailableHacks.Blatant[71].Triggered()
				end
				local theArg = ((enHacks.Panic and (theFunction)) or false)
				setChangedAttribute(TSM:WaitForChild("Ragdoll"),"Value",theArg)
				if shouldntTrigger~=true then
					AvailableHacks.Blatant[71].Triggered()
				end
			end,
			["ActivateFunction"]=function(newValue)
				AvailableHacks.Blatant[71].SetChanged()
			end,
			["MyPlayerAdded"]=function()
				AvailableHacks.Blatant[71].SetChanged(true)
			end,
			["MyStartUp"]=function()
				AvailableHacks.Blatant[71].Triggered()
			end,
		},
		[76] = (
			{
				["Type"]="ExTextButton",
				["Title"]="Respawn Before Hit",
				["Desc"]="Despawns and respawns character before hit",
				["Shortcut"]="RespawnBeforeHit",
				["Default"]=false,
				["OthersBeastAdded"] = function(myBeastPlr,myBeast)
					local TSM=plr:WaitForChild("TempPlayerStatsModule")
					while (myBeast~=nil and workspace:IsAncestorOf(myBeast) and myBeast.PrimaryPart and not isCleared and myBeast==Beast and char~=myBeast) do
						if (not TSM.Ragdoll.Value and enHacks.RespawnBeforeHit and not TSM.Captured.Value) then
							local whieList = {"Whitelist",Map,myBeast}
							local didHit,instance=raycast(char.PrimaryPart.Position,myBeast:GetPivot().Position,whieList,18,nil,true)
							if (didHit and myBeast:IsAncestorOf(instance) and not TSM.Ragdoll.Value and not TSM.Captured.Value) then
								AvailableHacks.Commands[24].ActivateFunction(true)




								local newChar = plr.CharacterAdded:Wait()
								repeat
									RunS.RenderStepped:Wait()
								until newChar.PrimaryPart
							end
						elseif not enHacks.RespawnBeforeHit then
							hackChanged.Event:Wait()
						end
						RunS.RenderStepped:Wait()
					end
				end,
			}
		),
		[60] = 
			{
				["Type"] = "ExTextButton",
				["Title"] = "Auto Capture",
				["Desc"] = "Instantly capture other survivors",
				["Shortcut"] = "AutoCapture",
				["Default"] = botModeEnabled,
				["ActivateFunction"] = (function(newValue)

					local TSM = plr:WaitForChild("TempPlayerStatsModule");
					local TSM_IsBeast = TSM:WaitForChild("IsBeast");

					local function BlatantChangedFunction()
						AvailableHacks.Blatant[60].ChangedFunction();
					end
					local inputChangedAttribute_INPUT = (newValue and BlatantChangedFunction);
					setChangedAttribute(TSM_IsBeast, "Value", inputChangedAttribute_INPUT);
					AvailableHacks.Blatant[60].ChangedFunction();
				end),
				["CaptureSurvivor"] = function(theirPlr,theirChar,override)
					local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
					if not TSM:WaitForChild("IsBeast") or not Beast then
						return
					end
					if Beast.CarriedTorso.Value==nil then
						return
					end
					if not enHacks.AutoCapture and not override then
						return
					end
					--if enHacks.AutoCapture=="Me" and theirPlr~=plr then return end
					local capsule,closestDist=nil,10000
					for num,cap in pairs(CS:GetTagged("Capsule")) do
						if cap.PrimaryPart~=nil then
							local dist=(cap.PrimaryPart.Position-theirChar.PrimaryPart.Position).magnitude
							if (dist<closestDist and cap:FindFirstChild("PodTrigger")~=nil and cap.PodTrigger:FindFirstChild("CapturedTorso")~=nil and cap.PodTrigger.CapturedTorso.Value==nil) then
								capsule,closestDist=cap,dist
							end
						end
					end
					--print("Capturing survivor!")
					local Trigger = capsule:WaitForChild("PodTrigger",5)
					for s=1,3,1 do
						local isOpened = (Trigger.ActionSign.Value==11)
						if capsule.PodTrigger.CapturedTorso.Value~=nil or not enHacks.AutoCapture then 
							break --we got ourselves a trapped survivor!
						elseif s~=1 then
							wait(.15)
						end
						if Trigger:FindFirstChild("Event") then
							game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
							game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
							if isOpened then
								game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false)
							end
						end
					end
				end,
				["ChangedFunction"]=function()
					local TSM=plr:WaitForChild("TempPlayerStatsModule")
					if not TSM:WaitForChild("IsBeast").Value then
						return
					end
					local CarriedTorso=char:WaitForChild("CarriedTorso",20)
					if CarriedTorso~=nil then
						local function captureSurvivorFunction()
							AvailableHacks.Blatant[60].CaptureSurvivor(plr,char)
						end
						local input = enHacks.AutoCapture and captureSurvivorFunction
						setChangedAttribute(CarriedTorso,"Value",input)
						AvailableHacks.Blatant[60].CaptureSurvivor(plr,char)
					else
						warn("rope not found!!!! hackssss bro!", char:GetFullName())
					end
				end,


				--["MyStartUp"]=function()
				--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
				setChangedAttribute(
					TSM:WaitForChild("IsBeast"),
					"Value",enHacks.AutoCapture and function()
						AvailableHacks.Blatant[60].ChangedFunction()
					end or false)--]]
				--AvailableHacks.Blatant[60].ChangedFunction()
				--end,


				["MyBeastAdded"]=function(theirPlr,theirChar)
					AvailableHacks.Blatant[60].ChangedFunction(theirPlr,theirChar)
				end,
				--["OthersBeastAdded"]=function(theirPlr,theirChar)
				--	AvailableHacks.Blatant[60].ChangedFunction(theirPlr,theirChar)
				--end,
			},
		[80]={
			["Type"]="ExTextButton",
			["Title"]="Auto Rescue",
			["Desc"]="Instantly rescue when NOT beast",
			["Shortcut"]="AutoRescue",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				for num, capsule in pairs(CS:GetTagged("Capsule")) do
					if capsule:FindFirstChild("PodTrigger")~=nil then
						setChangedAttribute(
							capsule.PodTrigger:FindFirstChild("CapturedTorso"),
							"Value",newValue and function()
								AvailableHacks.Blatant[80].RescueSurvivor(capsule)
							end or false)
						AvailableHacks.Blatant[80].RescueSurvivor(capsule)
					end
				end
			end,
			["RescueSurvivor"]=function(capsule,override)
				if capsule.PodTrigger.CapturedTorso.Value==nil then
					return
				end
				if not enHacks.AutoRescue and not override then
					return
				end
				if char:FindFirstChild("Hammer")~=nil then
					return
				end
				local Trigger=capsule.PodTrigger
				for s=1,5,1 do
					if not capsule.Parent then
						return
					end
					if capsule.PodTrigger.CapturedTorso.Value==nil then 
						return true
					elseif not workspace:IsAncestorOf(Trigger) then
						break
					elseif s~=1 then
						wait(.075)
					end
					local isOpened=Trigger.ActionSign.Value==30--30 for open, 31 for survivor
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
					if isOpened then
						game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false)
					end
					wait(.075)
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", false)
				end
			end,
			["CapsuleAdded"]=function(capsule)
				task.wait(.5)
				if capsule.Parent and capsule:FindFirstChild("PodTrigger") then
					local function RescueSurvivorFunction()
						AvailableHacks.Blatant[80].RescueSurvivor(capsule)
					end
					local setChangedAttribute_INPUT = enHacks.AutoRescue and (RescueSurvivorFunction) or false
					setChangedAttribute("Value", setChangedAttribute_INPUT, capsule.PodTrigger:FindFirstChild("CapturedTorso"))
				end
			end,
		},
		[86]=
			({
				["Type"]="ExTextButton",
				["Title"]="Auto Beast Troll",
				["Desc"]="Trolls beast automatically",
				["Shortcut"]="AutoTroll",
				["IsRunning"]=false,
				["Default"]=false,
				["CleanUp"]=(function()
					AvailableHacks.Blatant[86].IsRunning=false
				end),
				["ActivateFunction"]=(function(enabled)
					if enabled then
						AvailableHacks.Blatant[86].OthersBeastAdded()
					end
				end),
				["OthersBeastAdded"]=(function()
					if AvailableHacks.Blatant[86].IsRunning then
						return
					end
					if Beast==char then
						return
					end
					AvailableHacks.Blatant[86].IsRunning=true
					while AvailableHacks.Blatant[86].IsRunning and Beast~=nil and workspace:IsAncestorOf(Beast) and enHacks.AutoTroll do
						local Trigger,dist=findClosestObj(CS:GetTagged("DoorTrigger"),Beast.PrimaryPart.Position,20,1.5)
						if Trigger~=nil and Trigger.Parent~=nil and Trigger:FindFirstChild("ActionSign")~=nil
							and Trigger.ActionSign.Value~=0 then--Trigger.ActionSign.Value==11 then
							--print("closed door")
							--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", false)
							--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
							--task.wait()
							--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
							--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false, Trigger.Event)
							--task.wait()
							--AvailableHacks.Blatant[10].CloseDoor(Trigger)
							local wasClosed = Trigger.ActionSign.Value ~= 11 
							AvailableHacks.Blatant[15].DoorFuncts[Trigger.Parent]()
							if wasClosed then
								task.wait(2/3)
								RS.RemoteEvent:FireServer("Input", "Trigger", false)
							else
								RunS.RenderStepped:Wait()
							end
						else
							RunS.RenderStepped:Wait()
						end
					end
					AvailableHacks.Blatant[86].IsRunning=false
				--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local myChar=char
				while myChar~=nil and workspace:IsAncestorOf(myChar) 
					and myChar.PrimaryPart~=nil and plr.Character==myChar and not isCleared do
					if Beast~=nil and Beast~=char  
						and enHacks.AutoCamp and TSM.Captured.Value then
						teleportMyself(CFrame.new(Beast.PrimaryPart.CFrame*newVector3(0,0,-3)))
						--AvailableHacks.Basic[12].TeleportFunction(Beast.PrimaryPart.CFrame*newVector3(0,0,-3))
					elseif not enHacks.AutoCamp then
						hackChanged.Event:Wait()
					else
						workspace.DescendantAdded:Wait() wait(1/3)
					end
					wait()
				end--]]
				end),
			}),
		[90]=
			{
				["Type"]="ExTextButton",
				["Title"]="Perma Slow Beast",
				["Desc"]="Perm Slows Beast when its not u",
				["Shortcut"]="PermSlowBeast",
				["Default"]=false,
				["ActivateFunction"]=function()
					if Beast~=nil and Beast~=char then
					AvailableHacks.Blatant[90].OthersBeastAdded(nil,Beast);
				end;
				end,
				["OthersBeastAdded"] = function(nun,beastChar)
					local Humanoid=beastChar:WaitForChild("Humanoid",(waitForChildTimout))
					if ((not Humanoid) or ((Humanoid.Health) <=0)) then
					return
				end

					local function changeSpeed()
						local BeastPowers = beastChar:WaitForChild("BeastPowers", (waitForChildTimout));
						if (not BeastPowers) then
						return false;
					end
						local BeastEvent = BeastPowers:WaitForChild("PowersEvent", (waitForChildTimout)) ;
						if not BeastEvent then
						return false;
					end;
						if ((not enHacks.PermSlowBeast) or (not (workspace:IsAncestorOf(BeastEvent)))) then
						return false;
					end
						BeastEvent:FireServer("Jumped");
						return true;
					end
					local setChangedAttributeUpdate_INPUT = (enHacks.PermSlowBeast and changeSpeed) ;
					setChangedAttribute(Humanoid,"WalkSpeed", setChangedAttributeUpdate_INPUT);
					while (enHacks.PermSlowBeast and (changeSpeed())) do
					task.wait();
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
					setChangedAttribute(Humanoid,"WalkSpeed",nil)
				end,
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
			["BeastStartUp"]=function()
				local saveState=enHacks.AutoBeastHit
				local beast=Beast--the current Beast
				local Hammer=beast:WaitForChild("Hammer",2)
				while beast~=nil and beast.Parent~=nil and Hammer and Hammer.Parent and enHacks.AutoBeastHit==saveState
					and (enHacks.AutoBeastHit=="All" 
						or (enHacks.AutoBeastHit=="Me" and beast==char)) do
					for num,theirPlr in pairs(PS:GetPlayers()) do
						if theirPlr~=nil and theirPlr.Character~=nil then
							local theirChar=theirPlr.Character
							local TSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
							if TSM~=nil and not TSM.Captured.Value and not TSM.Ragdoll.Value then
								local Dist=(Hammer.Handle.Position-theirChar.PrimaryPart.Position).magnitude
								if Dist<10 then
									Hammer.HammerEvent:FireServer("HammerHit", theirChar.Head)

								end
							end
						end
					end
					RunS.PreAnimation:Wait()
				end
			end,
			["ActivateFunction"]=function(newValue)
				if newValue~="None" and Beast then
					AvailableHacks.Blatant[66].BeastStartUp()
				end
			end,
			["MyPlayerAdded"]=function(plr)
				AvailableHacks.Blatant[66].OthersBeastAdded=AvailableHacks.Blatant[66].BeastStartUp
				AvailableHacks.Blatant[66].MyBeastAdded=AvailableHacks.Blatant[66].BeastStartUp
			end,
		},
		[70]={
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
				local saveState=enHacks.AutoBeastRope
				local beast=Beast--the current Beast
				local Hammer=beast:WaitForChild("Hammer",2)
				local CarriedTorso = beast:WaitForChild("CarriedTorso",2)
				while (beast~=nil and beast.Parent~=nil and Hammer~=nil and enHacks.AutoBeastRope==saveState and CarriedTorso and (enHacks.AutoBeastRope=="All" or (enHacks.AutoBeastRope=="Me" and beast==char))) do
					for num,theirPlr in ipairs(PS:GetChildren()) do
						if theirPlr~=nil and theirPlr.Character~=nil then
							local theirChar=theirPlr.Character
							local TSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
							if TSM~=nil and not TSM.Captured.Value and TSM.Ragdoll.Value then
								local Dist=(Hammer.Handle.Position-theirChar.PrimaryPart.Position).magnitude
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
				if newValue~="None" and Beast then
					AvailableHacks.Blatant[70].BeastStartUp()
				end
			end,
			["MyPlayerAdded"]=function(plr)
				AvailableHacks.Blatant[70].OthersBeastAdded=AvailableHacks.Blatant[70].BeastStartUp
				AvailableHacks.Blatant[70].MyBeastAdded=AvailableHacks.Blatant[70].BeastStartUp
			end,
		},

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
				while enHacks.Util_AutoHack do
					while enHacks.Util_AutoHack and not plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle").Visible do
						plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle"):GetPropertyChangedSignal("Visible"):Wait()
					end
					while enHacks.Util_AutoHack and plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle").Visible do
						--plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("TimingCircle"):GetPropertyChangedSignal("Visible"):Wait()
						--TSM.OnTrigger.Value=false
						--print(plr.PlayerGui.ScreenGui.TimingCircle.TimingPin.Rotation,plr.PlayerGui.ScreenGui.TimingCircle.TimingBase.Rotation)
						if plr.PlayerGui.ScreenGui.TimingCircle.TimingPin.Rotation>=plr.PlayerGui.ScreenGui.TimingCircle.TimingBase.Rotation+45 then
							TSM.ActionInput.Value=true
							if not TSM.MinigameResult.Value then
								--RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
							end
						end
						task.wait()
					end	
					for s=3,1,-1 do
						if not enHacks.Util_AutoHack then
							return
						end
						if not TSM.MinigameResult.Value then
							--RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
						end 	
						task.wait()
					end
					if not enHacks.Util_AutoHack then
						return
					end
					--TSM.OnTrigger.Value=true
					TSM.ActionInput.Value=false
					--for s=1,1,-1 dof

					--end

				end
			end,
			["MyStartUp"]=function()
				AvailableHacks.Utility[1].ActivateFunction(enHacks.Util_AutoHack)
			end,
			["MyPlayerAdded"] = function()
				local minigameResult = myTSM:WaitForChild("MinigameResult")
				local function updateMiniGameResult()
					if minigameResult and enHacks.Util_AutoHack then
						RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
					end
				end
				setChangedAttribute(minigameResult,"Value",updateMiniGameResult)
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
					plr.CameraMode=(char==Beast and Enum.CameraMode.LockFirstPerson or Enum.CameraMode[SP.CameraMode.Name])
				else
					--plr:SetAttribute("CameraMinZoomDistance",plr.CameraMinZoomDistance)
					plr.CameraMinZoomDistance=.5--minimum
					--plr:SetAttribute("CameraMaxZoomDistance",plr.CameraMaxZoomDistance)
					plr.CameraMaxZoomDistance=50--maximum
					--plr:SetAttribute("CameraMode",plr.CameraMode.Name)
					plr.CameraMode=Enum.CameraMode.Classic
				end
			end,
			["ActivateFunction"]=function(newValue)
				local updateZoom=AvailableHacks.Utility[2].UpdateZoom
				if newValue then
					setChangedAttribute(plr,"CameraMinZoomDistance",updateZoom)
					setChangedAttribute(plr,"CameraMaxZoomDistance",updateZoom)
					setChangedAttribute(plr,"CameraMode",updateZoom)
				else
					setChangedAttribute(plr,"CameraMinZoomDistance",false)
					setChangedAttribute(plr,"CameraMaxZoomDistance",false)
					setChangedAttribute(plr,"CameraMode",false)
				end
				updateZoom(nil,not newValue)
			end,
		},
		[3]=({
			["Type"]="ExTextButton",
			["Title"]="Client Improvements",
			["Desc"]="Fixes elements",
			["Shortcut"]="Util_Fix",
			["Default"]=true,
			["DontActivate"] = true,
			--["Universes"]={"Global"},
			["ActivateFunction"]=function(newValue)
				local ScreenGui = PlayerGui:WaitForChild("ScreenGui");
				local MenusTabFrame = ScreenGui:WaitForChild("MenusTabFrame");
				local BeastPowerMenuFrame = ScreenGui:WaitForChild("BeastPowerMenuFrame")
				local SurvivorStartFrame = ScreenGui:WaitForChild("SurvivorStartFrame")
				local IsCheckingLoadData = plr:WaitForChild("IsCheckingLoadData");
				local function changedFunct()
					if enHacks.Util_Fix then
						MenusTabFrame.Visible=not IsCheckingLoadData.Value;
					end
				end
				setChangedAttribute(MenusTabFrame,"Visible", (newValue and changedFunct or nil));
				changedFunct()
				local function beastScreen()
					if enHacks.Util_Fix then
						BeastPowerMenuFrame.Visible=false;
					end
				end
				setChangedAttribute(BeastPowerMenuFrame, "Visible", (newValue and beastScreen or nil));
				beastScreen()
				local function survivorScreen()
					if enHacks.Util_Fix then
						SurvivorStartFrame.Visible=false;
					end
				end
				setChangedAttribute(SurvivorStartFrame, "Visible", (newValue and survivorScreen or nil));
				survivorScreen()

				if (UIS.TouchEnabled and newValue) and not AvailableHacks.Utility[3].Active then
					local chatBar = StringWaitForChild(PlayerGui,"Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar")
					local function slashPressed(name,state)
						if state == Enum.UserInputState.Begin then
							RunS.RenderStepped:Wait()
							chatBar:CaptureFocus()
						end
					end
					AvailableHacks.Utility[3].Active=true
					CAS:BindActionAtPriority("PushSlash"..saveIndex,slashPressed,false,10000,Enum.KeyCode.Slash)
				elseif (not UIS.TouchEnabled or not newValue) and AvailableHacks.Utility[3].Active then
					AvailableHacks.Utility[3].Active=nil
					CAS:UnbindAction("PushSlash"..saveIndex)
				end
				if ((newValue and Beast == char) and not AvailableHacks.Utility[3].Funct) then
					--[[AvailableHacks.Utility[3].Funct = UIS.InputBegan:Connect(function(input, gameprocesssed)
						if gameprocesssed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS.TouchEnabled then
							triggerConnection(UIS.TouchTapInWorld)
						end
					end)--]]
				elseif ((not newValue or Beast ~= char) and AvailableHacks.Utility[3].Funct) then
					AvailableHacks.Utility[3].Funct:Disconnect()
					AvailableHacks.Utility[3].Funct = nil
				end
			end,
			["MyBeastAdded"]=function()
				AvailableHacks.Utility[3].ActivateFunction(enHacks.Util_Fix)
			end,
			["CleanUp"]=function()
				AvailableHacks.Utility[3].ActivateFunction(enHacks.Util_Fix)
			end,
			["MyStartUp"]=function()
				RunS.RenderStepped:Wait()--Delay it
				AvailableHacks.Utility[3].ActivateFunction(enHacks.Util_Fix)
			end,
		}),
		[4]={
			["Type"]="ExTextButton",
			["Title"]="Crawl Type",
			["Desc"]="Allows you to zoom at any time",
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
			["ActivateFunction"]=function(newValue)
				local TouchGui = PlayerGui:WaitForChild("TouchGui");
				local function updateTouchScreenEnability()
					TouchGui.Enabled = not enHacks.Util_HideTouchscreen
				end
				setChangedAttribute(TouchGui,"Enabled",(enHacks.Util_HideTouchscreen and updateTouchScreenEnability))
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
				for s = #AvailableHacks.Utility[8].ClubFuncts, 1, -1 do
					local funct = AvailableHacks.Utility[8].ClubFuncts[s]
					if funct then
						funct:Disconnect()
					end
					table.remove(AvailableHacks.Utility[8].ClubFuncts,s)
				end
				if ClearFreezePodBillboardIcons then
					ClearFreezePodBillboardIcons()
				end
				local hammerAnims = {"AnimSwing","AnimWipe","AnimArmIdle"}
				for _, track in ipairs(human:WaitForChild("Animator"):GetPlayingAnimationTracks()) do
					if table.find(hammerAnims,track.Animation.Name) then
						track:Stop(0)
						track:Destroy()
					end
				end
			end,
			["ActivateFunction"]=function(newValue)
				AvailableHacks.Utility[8].CleanUp()
				if not myTSM.IsBeast.Value then
					return
				end
				local Hammer = char:WaitForChild("Hammer",30)
				if not Hammer then
					return warn("Hammer Not Found, Hacks Bro!")
				end
				local LocalClubScript = Hammer:WaitForChild("LocalClubScript",5)
				if not LocalClubScript then
					return warn("LocalClubScript Not Found, Hacks Bro!")
				end
				newValue = enHacks.Util_Hammer--reset it because we yielded!
				
				LocalClubScript.Disabled = newValue
				if newValue then
					task.delay(0,LocalClubScriptFunction,LocalClubScript)
				end--TODO HERE
			end,
			["MyPlayerAdded"] = function()
				if not enHacks.Util_Hammer then
					return
				end
				AvailableHacks.Utility[8].Funct = myTSM:WaitForChild("IsBeast").Changed:Connect(function()
					AvailableHacks.Utility[8].ActivateFunction(enHacks.Util_Hammer)
				end)
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
			["Default"]=botModeEnabled,
			["CurrentNum"]=0,
			["ActivateFunction"]=function(en)
				local TradeSpyEn=false

				plr:FindFirstChild("TradeMenuLocalScript",true).Enabled=not en

				--BuyShopBundle, "Solar Witch Bundle"
				--SendMyTradeOffer, {items}
				--GetPlayerInventory
				local ReceiveEvent=Instance.new("BindableEvent")
				local waitForThing
				local RemoteEvent=RS:WaitForChild("RemoteEvent")
				local function waitForReceive(thing2Wait,args,shouldntSend)
					while waitForThing do
						ReceiveEvent.Event:Wait()
					end
					waitForThing=thing2Wait
					if not shouldntSend then
						task.delay(.15,function()
							RemoteEvent:FireServer(RemoteEvent,thing2Wait,table.unpack(args or {}))
						end)
					end
					return ReceiveEvent.Event:Wait()
				end
				local canTrade=true
				local lastSend=0
				if AvailableHacks.Utility[10].Funct then
					AvailableHacks.Utility[10].Funct:Disconnect()
				end
				if en then
					local function remoteEventReceivedFunction(main,sec,third)
						if main=="StartTradeCoolDown" then
							lastSend=os.clock()
						end
						if main=="RecieveTradeRequest" then
							local user=PS:GetPlayerByUserId(sec)
							if ((myBots[user.Name:lower()] or whitelistedUsers[user.Name:lower()]) and canTrade) then
								RemoteEvent:FireServer("AcceptTradeRequest")
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
										print(theirUser.." has max limit of "..(item:sub(1,1)=="H" and "Hammer" or "Gem") .." "..RS.ItemDatabase[item]:GetAttribute("ItemName").."! ("..comma_value(Occurances).." Removed)")
									end
								end
								for s=1,#items2Trade-enHacks.Util_InstaTradeAmnt do
									table.remove(items2Trade,Random.new():NextInteger(1,#items2Trade))
								end
								local isStillSending=true
								task.spawn(function()
									waitForReceive("UpdateMyTradeOfferResult",nil,true)
									isStillSending=false
								end)
								--while isStillSending or not isStillSending do
								print("Sending "..comma_value(#items2Trade).." items: ", table.concat(items2Trade,", "))
								RemoteEvent:FireServer("SendMyTradeOffer",items2Trade)
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
										RemoteEvent:FireServer("CancelTrade")
										return
									end
									RemoteEvent:FireServer("AcceptTradeOffer")
									task.wait()
								end
								print("Trade Successfully Complete!")
							else
								RemoteEvent:FireServer("CancelTrade")
							end
						elseif waitForThing==main then
							waitForThing=nil
							ReceiveEvent:Fire(sec,third)
						elseif (TradeSpyEn and string.find(main:lower(),"trade")~=nil and main~="UpdateOpenTradePlayersList" and main~= "PlayerListJoined" and main~= "PlayerListRemoved") then
							print("Spy;",table.unpack({main,sec,third}))
						end
					end
					AvailableHacks.Utility[10].Funct = RemoteEvent.OnClientEvent:Connect(remoteEventReceivedFunction)
					RemoteEvent:FireServer("CancelTrade")
				else
					AvailableHacks.Utility[10].Funct = false
				end
			end
		},
	},
	["Basic"]={
		[1]={
			["Type"]="ExTextBox",
			["Title"]="Walkspeed",
			["Desc"]="Set to 16 to default",
			["Shortcut"]="WalkSpeed",
			["Default"]=(botModeEnabled and 48 or defaultCharacterWalkSpeed),
			["MinBound"]=0,
			["MaxBound"]=1e3,
			["DontActivate"]=true,
			["UpdateSpeed"]=function()
				local crawlSlowDown = 1/2
				local newSpeed = human:GetAttribute("OverrideSpeed")
				if isCleared or
					(not newSpeed and gameUniverse=="Flee" and enHacks.WalkSpeed==defaultCharacterWalkSpeed and myTSM:WaitForChild("NormalWalkSpeed",1/4)) then
					newSpeed=myTSM.NormalWalkSpeed.Value
				else
					newSpeed=enHacks.WalkSpeed or AvailableHacks.Basic[1].Default
				end
				if gameUniverse=="Flee" then
					newSpeed = newSpeed * (1-((myTSM.IsCrawling.Value and crawlSlowDown) or 0))
				end
				human.WalkSpeed=newSpeed
			end,
			["ActivateFunction"]=function(newValue)
				if newValue==defaultCharacterWalkSpeed then
					setChangedAttribute(human,"WalkSpeed",false)
				else
					setChangedAttribute(human,"WalkSpeed",AvailableHacks.Basic[1].UpdateSpeed)
				end 
				AvailableHacks.Basic[1].UpdateSpeed()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				AvailableHacks.Basic[1].Funct=human:GetAttributeChangedSignal("OverrideSpeed"):Connect(AvailableHacks.Basic[1].UpdateSpeed)
				AvailableHacks.Basic[1].ActivateFunction(enHacks.WalkSpeed)
			end,
			["MyPlayerAdded"]=function()
				if gameUniverse~="Flee" then
					return
				end
				table.insert(functs,myTSM:WaitForChild("IsCrawling").Changed:Connect(AvailableHacks.Basic[1].UpdateSpeed))
			end,
		},
		[2]={
			["Type"]="ExTextBox",
			["Title"]="JumpPower",
			["Desc"]="Set to 36 to default",
			["Shortcut"]="JumpPower",
			["Default"]=(gameUniverse=="Flee" and 36 or SP.CharacterJumpPower),
			["MinBound"]=0,
			["MaxBound"]=1e4,
			["DontActivate"]=true,
			["ActivateFunction"]=function(newValue)
				local function setJump()
					--print("Set Jump",isCleared)
					human.JumpPower=newValue;
				end;

				setJump();

				if ((newValue) == (50)) then
					setChangedAttribute(human,"JumpPower",false);
				else
					setChangedAttribute(human,"JumpPower",setJump);
				end;
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				AvailableHacks.Basic[2].ActivateFunction(enHacks.JumpPower);
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
					setChangedAttribute(workspace,"Gravity",false)
				else
					setChangedAttribute(workspace,"Gravity",setSpeed)
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
					gameUniverse~="Flee" and 
					{
						["Title"]="NOCLIP",
						["TextColor"]=newColor3(255,0,255)
					} or nil
				)--]]
			},
			["Title"]="Special Movement Type",
			["Desc"]="Z to Toggle, F and G to control",
			["Shortcut"]="Movement",
			["Default"]=false,
			["IsActive"]=false,
			["ToggleFunct"]=nil,
			["MovementFuncts"]={},
			["FlyScript"]=function()
				local speed = 6
				local allowedID={
					["rbxassetid://1416947241"]=true,
					["rbxassetid://939025537"]=true,
					["rbxassetid://894494203"]=true,
					["rbxassetid://894494919"]=true,
					["rbxassetid://961932719"]=true,
				}

				local hrp = char:WaitForChild("HumanoidRootPart")
				local animator = human:WaitForChild("Animator")

				while (not char.Parent) do
					char.AncestryChanged:Wait()
				end

				local bodyGyro = Instance.new("BodyGyro")
				bodyGyro.maxTorque = newVector3(1, 1, 1)*10^6
				bodyGyro.P = 10^6

				local bodyVel = Instance.new("BodyVelocity")
				bodyVel.maxForce = newVector3(1, 1, 1)*10^6
				bodyVel.P = 10^4

				local Attach = Instance.new("Attachment")
				local Attack2 = Attach:Clone()

				AvailableHacks.Basic[4].IsActive=false

				local IsActive = AvailableHacks.Basic[4].IsActive
				local movement = {forward = 0, backward = 0, right = 0, left = 0, down = 0, up = 0}
				local mouse = plr:GetMouse()
				local i = 0
				AvailableHacks.Basic[4].ToggleFunct=function(flying)
					AvailableHacks.Basic[4].IsActive = flying
					bodyGyro.Parent = AvailableHacks.Basic[4].IsActive and char.Head or nil
					bodyVel.Parent = AvailableHacks.Basic[4].IsActive and char.Head or nil
					bodyGyro.CFrame = hrp.CFrame
					bodyVel.Velocity = newVector3()
					--setCollisionGroupRecursive(character,flying and groupName or "Original")

					for i, v in pairs(animator:GetPlayingAnimationTracks()) do
						if allowedID[v.Animation.AnimationId]==nil then
							v:Stop()
						end
					end
					if char:FindFirstChild("Animate") ~=nil and game.GameId~=372226183 then
						char.Animate.Disabled=AvailableHacks.Basic[4].IsActive
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
					if (AvailableHacks.Basic[4].IsActive) then
						local cf = camera.CFrame

						local charCF = char:GetPivot()
						local MoveDirection = PlayerControlModule:GetMoveVector()
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
						bodyVel.Velocity = (direction * newVector3(enHacks.MovementHorizontalSpeed,enHacks.MovementVerticalSpeed,enHacks.MovementHorizontalSpeed)) * human.WalkSpeed * speed
					end
				end





				--CAS:BindAction("forward", movementBind, false, Enum.PlayerActions.CharacterForward)
				--CAS:BindAction("backward", movementBind, false, Enum.PlayerActions.CharacterBackward)
				--CAS:BindAction("left", movementBind, false, Enum.PlayerActions.CharacterLeft)
				--CAS:BindAction("right", movementBind, false, Enum.PlayerActions.CharacterRight)
				--CAS:BindAction("up", movementBind, false, Enum.PlayerActions.CharacterJump)
				--table.insert(AvailableHacks.Basic[4].MovementFuncts,human:GetPropertyChangedSignal("MoveDirection"))
				table.insert(AvailableHacks.Basic[4].MovementFuncts,RunS.RenderStepped:Connect(onUpdate))
				local function animatorPlayedFunction(animTrack)
					if AvailableHacks.Basic[4].IsActive
						and allowedID[animTrack.Animation.AnimationId]==nil then
						animTrack:Stop(0)
					end
				end
				table.insert(AvailableHacks.Basic[4].MovementFuncts,animator.AnimationPlayed:Connect(animatorPlayedFunction))
			end,
			["NoclipScript"] = (function()
				local i = 0

				local function setCollisionGroupRecursive(object,flying)
					if object:IsA("BasePart") and not object:HasTag("InviWalls") then
						if not flying then
							object.CanCollide=object:GetAttribute("OriginalCollide") or object.CanCollide
						else
							object:SetAttribute("OriginalCollide",object.CanCollide)
							object.CanCollide=false
						end
					end
					for _, child in ipairs(object:GetChildren()) do
						setCollisionGroupRecursive(child,flying)
					end
					i = i + 1
					if i==1250 then
						i=0
						task.wait()
					end
				end

				local speed = 6
				local allowedID={
					["rbxassetid://1416947241"]=true,
					["rbxassetid://939025537"]=true,
					["rbxassetid://894494203"]=true,
					["rbxassetid://894494919"]=true,
					["rbxassetid://961932719"]=true,
				}
				local RunS = game:GetService("RunService")

				local hrp = char:WaitForChild("HumanoidRootPart")
				local animator = human:WaitForChild("Animator")

				while (not char.Parent) do
					char.AncestryChanged:Wait()
				end

				local bodyGyro = Instance.new("BodyGyro")
				bodyGyro.maxTorque = newVector3(1, 1, 1)*10^6
				bodyGyro.P = 10^6

				local bodyVel = Instance.new("BodyVelocity")
				bodyVel.maxForce = newVector3(1, 1, 1)*10^6
				bodyVel.P = 10^4

				local Attach = Instance.new("Attachment")
				local Attack2 = Attach:Clone()

				AvailableHacks.Basic[4].IsActive=false
				local IsActive = AvailableHacks.Basic[4].IsActive
				local movement = {forward = 0, backward = 0, right = 0, left = 0, down = 0, up = 0}
				local mouse = plr:GetMouse()
				local i = 0
				AvailableHacks.Basic[4].ToggleFunct=function(flying)
					if not flying then
						setCollisionGroupRecursive(workspace, false)
					end
					AvailableHacks.Basic[4].IsActive = flying
					bodyGyro.Parent = (AvailableHacks.Basic[4].IsActive and char.Head or nil)
					bodyVel.Parent = (AvailableHacks.Basic[4].IsActive and char.Head or nil)
					bodyGyro.CFrame = hrp.CFrame
					bodyVel.Velocity = newVector3()
					--setCollisionGroupRecursive(character,flying and groupName or "Original")

					local getPlayingAnimationTracks = animator:GetPlayingAnimationTracks();

					for i, v in ipairs(getPlayingAnimationTracks) do
						if (allowedID[v.Animation.AnimationId]==nil) then
							v:Stop()
						end
					end
					local shouldActivate = (char:FindFirstChild("Animate") ~=nil and game.GameId~=372226183)
					if shouldActivate then
						char.Animate.Disabled = AvailableHacks.Basic[4].IsActive
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
					if (AvailableHacks.Basic[4].IsActive) then
						local cf = camera.CFrame

						local charCF = char:GetPivot()
						local MoveDirection = PlayerControlModule:GetMoveVector()
						local right = MoveDirection.X;
						local up = MoveDirection.Y;
						local forward = -MoveDirection.Z;
						local direction = cf.RightVector * right + cf.LookVector * forward + cf.UpVector * up; 

						if (direction:Dot(direction) > 0) then
							direction = direction.unit
						end
						bodyGyro.CFrame = cf
						bodyVel.Velocity = ((direction * newVector3(enHacks.MovementHorizontalSpeed,enHacks.MovementVerticalSpeed,enHacks.MovementHorizontalSpeed)) * human.WalkSpeed * speed)
					end
				end



				local function movementBind(actionName, inputState, inputObject)

					if (inputState == Enum.UserInputState.Begin) then
						movement[actionName] = 1
					elseif (inputState == Enum.UserInputState.End) then
						movement[actionName] = 0
					end
					--if (AvailableHacks.Basic[4].IsActive) then
					--	local isMoving = movement.right + movement.left + movement.forward + movement.backward > 0
					--end
					return Enum.ContextActionResult.Pass
				end

				--CAS:BindAction("forward", movementBind, false, Enum.PlayerActions.CharacterForward)
				--CAS:BindAction("backward", movementBind, false, Enum.PlayerActions.CharacterBackward)
				--CAS:BindAction("left", movementBind, false, Enum.PlayerActions.CharacterLeft)
				--CAS:BindAction("right", movementBind, false, Enum.PlayerActions.CharacterRight)
				--CAS:BindAction("up", movementBind, false, Enum.PlayerActions.CharacterJump)
				table.insert(AvailableHacks.Basic[4].MovementFuncts,RunS.RenderStepped:Connect(onUpdate))
				table.insert(AvailableHacks.Basic[4].MovementFuncts,animator.AnimationPlayed:Connect(function(animTrack)
					if AvailableHacks.Basic[4].IsActive and allowedID[animTrack.Animation.AnimationId]==nil then
						animTrack:Stop(0)
					end
				end))
			end),
			["InfJumpScript"]=function()
				local index=0
				local myConnections = {}
				local function forceJump()
					local saveIndex=index
					while (saveIndex==index and AvailableHacks.Basic[4].IsActive and enHacks.Movement=="InfJump" and (isJumpBeingHeld)) do
						human:ChangeState(Enum.HumanoidStateType.Jumping)
						task.wait((1.5/(enHacks.MovementVerticalSpeed)))
					end
				end
				AvailableHacks.Basic[4].ToggleFunct=function(isActive)
					if isActive then
						table.insert(myConnections, UIS.JumpRequest:Connect(forceJump));
						if isJumpBeingHeld then
							forceJump("up",Enum.UserInputState.Begin);
						end
						table.insert(AvailableHacks.Basic[4].MovementFuncts, jumpChangedEvent.Event:Connect(forceJump))
					elseif #myConnections>0 then
						for num, myConn in ipairs(myConnections) do
							myConn:Disconnect()
						end
						myConnections = {}
					end
				end
				table.insert(AvailableHacks.Basic[4].MovementFuncts,jumpChangedEvent.Event:Connect(forceJump))
				AvailableHacks.Basic[4].ToggleFunct(AvailableHacks.Basic[4].IsActive)
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
				local v5 = char:WaitForChild("HumanoidRootPart")
				local v7 = game:GetService("UserInputService")
				local v14 = Instance.new("BodyVelocity", v5.Parent.Head)
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
					while not isCleared and enHacks.Movement=="Jetpack" do
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
				AvailableHacks.Basic[4].ToggleFunct=(JetpackToggleFunction)
				local function jumpBoost()
					if not AvailableHacks.Basic[4].IsActive then
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
					if v7:GetFocusedTextBox()~=nil or isCleared then
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
					if isCleared then
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
				local Funct2Run = AvailableHacks.Basic[4].ToggleFunct;
				Funct2Run(AvailableHacks.Basic[4].IsActive);
				table.insert(AvailableHacks.Basic[4].MovementFuncts,inputEnded_1:connect(inputBegan));
				table.insert(AvailableHacks.Basic[4].MovementFuncts,v7.InputEnded:connect(inputEnded));
				local function taskSpawnJetpackUpdateVelFunction()
					while not isCleared and enHacks.Movement=="Jetpack" and workspace:IsAncestorOf(v14) do
						v14.Velocity=(v5.CFrame-v5.Position)*newVector3(0,60*enHacks.MovementVerticalSpeed,-60*enHacks.MovementHorizontalSpeed);
						task.wait();
					end
				end
				table.insert(AvailableHacks.Basic[4].MovementFuncts,jumpChangedEvent.Event:Connect(function(jumping)
					if jumping then
						inputBegan(SpaceKeyCodeTable)
					else
						inputEnded(SpaceKeyCodeTable)
					end
				end))

				task.spawn(taskSpawnJetpackUpdateVelFunction)
			end,
			["FloatScript"]=function()
				local v14 = Instance.new("BodyPosition", char:WaitForChild("Head"))
				v14.MaxForce = newVector3(0, 0, 0) v14.Name="JetpackVelocity"
				local height=0
				local baseHeight=0
				local isR6=human.RigType==Enum.HumanoidRigType.R6
				local function update(new,saveHeight)
					local blackListTable = {"Blacklist",char}
					local directionPosition1 = char.PrimaryPart.Size.Y/2+char["Right Leg"].Size.Y/2+3.03
					local directionPosition2 = getHumanoidHeight(char)
					local directionPosition
					if isR6 then
						directionPosition = directionPosition1
					else
						directionPosition = directionPosition2
					end
					local characterOffsetStartingPosition = (char.PrimaryPart.Position-newVector3(0,3,0))
					local didHit,hitPart=raycast(char.PrimaryPart.Position,characterOffsetStartingPosition,blackListTable,directionPosition,false,true)
					if (didHit) then
						baseHeight=char.HumanoidRootPart.Position.Y
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
					local saveIndex = index;
					if inputState == Enum.UserInputState.Begin then
						while saveIndex == index do
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
					local saveIndex = index;
					if inputState == Enum.UserInputState.Begin then
						while saveIndex == index do
							update(height-2);
							task.wait(.05);
						end
					end
				end
				CAS:BindAction("up"..saveIndex, ascend, true, Enum.KeyCode.F, Enum.KeyCode.ButtonY);
				CAS:BindAction("down"..saveIndex, descend, true, Enum.KeyCode.G, Enum.KeyCode.ButtonX);
				CAS:SetPosition("up"..saveIndex,UDim2.new(.3));
				CAS:SetPosition("down"..saveIndex,UDim2.new(.7));
				CAS:SetTitle("up"..saveIndex,"up");
				CAS:SetTitle("down"..saveIndex,"down");
				update(0)
			end,
			["DisableMovement"] = (function()
				if (AvailableHacks.Basic[4].IsActive and AvailableHacks.Basic[4].ToggleFunct) then
					AvailableHacks.Basic[4].ToggleFunct()
					AvailableHacks.Basic[4].ToggleFunct=nil
				end
				for num,funct in pairs(AvailableHacks.Basic[4].MovementFuncts) do
					funct:Disconnect()
				end
				AvailableHacks.Basic[4].MovementFuncts = {}
				AvailableHacks.Basic[4].ToggleFunct = nil
				CAS:UnbindAction("foward"..saveIndex)
				CAS:UnbindAction("backward"..saveIndex)
				CAS:UnbindAction("left"..saveIndex)
				CAS:UnbindAction("right"..saveIndex)
				CAS:UnbindAction("up"..saveIndex)
				CAS:UnbindAction("down"..saveIndex)
				local JetpackGUI=plr.PlayerGui:FindFirstChild("JetpackGUI")
				if JetpackGUI~=nil then 
					JetpackGUI:Destroy()
				end
				if char:FindFirstChild("Head") then
					local JetpackVelocity = char.Head:FindFirstChild("JetpackVelocity")
					if JetpackVelocity then 
						JetpackVelocity:Destroy()
					end
				end
			end),
			["ActivateFunction"]=(function(newValue)
				local function onKeyPress(actionName, inputState, _inputObject)
					if inputState == Enum.UserInputState.Begin and enHacks.Movement and not isCleared then
						if (not human or human:GetState() == Enum.HumanoidStateType.Dead) then
							return
						end
						AvailableHacks.Basic[4].IsActive=not AvailableHacks.Basic[4].IsActive
						if AvailableHacks.Basic[4].ToggleFunct~=nil then
							AvailableHacks.Basic[4].ToggleFunct(AvailableHacks.Basic[4].IsActive)
						end
					end
				end
				if newValue and newValue~="Float" then
					CAS:BindAction("en_movement"..saveIndex, onKeyPress, true, Enum.KeyCode.Z, Enum.KeyCode.ButtonA);
					CAS:SetPosition("en_movement"..saveIndex,UDim2.fromScale(.8, 0.3));
					CAS:SetTitle("en_movement"..saveIndex,newValue);
					table.insert(functs,UIS.InputBegan:Connect(onKeyPress));
				else
					CAS:UnbindAction("en_movement"..saveIndex);
				end

				AvailableHacks.Basic[4].DisableMovement()
				if enHacks.Movement then
					AvailableHacks.Basic[4].IsActive=true
					AvailableHacks.Basic[4][enHacks.Movement.."Script"]()
				end
			end),
			["MyStartUp"]=function(myPlr,myChar)
				AvailableHacks.Basic[4].DisableMovement()
				if enHacks.Movement then
					AvailableHacks.Basic[4].IsActive=true
					AvailableHacks.Basic[4][enHacks.Movement.."Script"]()
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
			["MaxBound"]=50.00,
		},
		[6]={
			["Type"]="ExTextBox",
			["Title"]="Movement Horizontal",
			["Desc"]="Set to 1 for default",
			["Shortcut"]="MovementHorizontalSpeed",
			["Default"]=1,
			["MinBound"]=0.01,
			["MaxBound"]=50.00,
		},
		[12]={
			["Type"]="ExTextButton",
			["Title"]="Teleport",
			["Desc"]='Keybind: "T"',
			["Shortcut"]="Teleport",
			["Default"]=true,
			["TeleportFunction"]=function(target,newOrien)
				local isCFrame=typeof(target)=="CFrame"
				local primPart=char.PrimaryPart
				if primPart==nil then
					return
				end
				local position1=(char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")).Position
				local position2=target+ newVector3(0,getHumanoidHeight(char)+(gameUniverse=="Flee" and 1.85 or 0),0)
				position2=isCFrame and position2.Position or position2
				local result,hitPart=raycast(position1,position2,{"Blacklist",char},(position1-position2).magnitude,1,true)
				if not result then
					result=({["Position"]=position2})
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
				objectFuncts[mouse]=objectFuncts[mouse] or {};
				for num,funct in pairs(objectFuncts[mouse]) do
					funct:Disconnect();
				end;
				if newValue then
					local function keyDownFunction(key)
						if key == "t" then
							local inputPosition = mouse.Hit.Position;
							local TPFunction = AvailableHacks.Basic[12].TeleportFunction;
							TPFunction(inputPosition);
						end;
					end;
					local objectFuncts_ADD = objectFuncts[mouse];
					local connection_1 = mouse.KeyDown:Connect(keyDownFunction);
					table.insert(objectFuncts_ADD, connection_1);
					local lastTouch = 0;
					local function TouchTapFunction(touchPositions,gameProcessedEvent)
						if gameProcessedEvent then
							return;
						end;
						if os.clock() - lastTouch <= .5 then
							lastTouch = 0;
							keyDownFunction("t");
						else
							lastTouch = os.clock();
						end;
					end;
					local connection_2 = UIS.TouchTap:Connect(TouchTapFunction);
					table.insert(objectFuncts_ADD,connection_2);
				end;

			end,
			["MyStartUp"]=function()
				local HRP = char:WaitForChild("HumanoidRootPart",30)
				if not char.PrimaryPart and HRP then
					char.PrimaryPart=HRP
				end
			end,
		},
		[20]={
			["Type"]="ExTextButton",
			["Title"]="Walk Through Invisible Walls",
			["Desc"]="Walk Through All Invisible Walls In The Game",
			["Shortcut"]="Basic_InviWalls",
			["Default"]="Visible",
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
			["InstanceAdded"]=function(object)
				CS:AddTag(object,"InviWalls")
				object.CanCollide = false
				object.CastShadow = false
				object.Transparency = enHacks.Basic_InviWalls=="Invisible" and 1 or .85
				object.Color = Color3.fromRGB(0,0,200)
			end,
			["ApplyInvi"]=function(instance)
				--local start = os.clock()
				local saveEn = enHacks.Basic_InviWalls
				for num, object in ipairs(instance:GetDescendants()) do
					if object:IsA("BasePart") and ((object.Transparency>=.95 and object.CanCollide) or object:HasTag("InviWalls")) then
						AvailableHacks.Basic[20].InstanceAdded(object)
					end
					if num%70==0 then
						RunS.RenderStepped:Wait()
					end
					if saveEn ~= enHacks.Basic_InviWalls then
						return
					end
				end
				--print(("search completed after %.2f"):format(os.clock()-start))
			end,
			["MapAdded"]=function(newMap)
				if not RS:WaitForChild("IsGameActive").Value then
					RS.IsGameActive.Changed:Wait()
				end
				if not enHacks.Basic_InviWalls or not newMap.Parent then
					return
				end
				AvailableHacks.Basic[20].ApplyInvi(newMap)
			end,
			["ActivateFunction"]=function(newValue)
				if newValue then
					AvailableHacks.Basic[20].ApplyInvi(workspace)
				else
					for num, object in ipairs(CS:GetTagged("InviWalls")) do
						object:RemoveTag(object,"InviWalls")
						object.CanCollide = true
						object.Transparency = 1
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
				if (not enHacks.Basic_ResetButton) then
					return
				end--it resets itself anyways!
				AvailableHacks.Basic[40].ActivateFunction(enHacks.Basic_ResetButton)
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
				if newValue and not AvailableHacks.Basic[60].Funct then
					local function IdleOccuredFunction(timeInSec)--runs every sec after 2m, and pulses every second after that
						if enHacks.AntiAFK1 and not isStudio then
							VU:CaptureController()
							VU:ClickButton2(Vector2.new())
						end
					end
					AvailableHacks.Basic[60].Funct=plr.Idled:connect(IdleOccuredFunction)
				elseif not newValue and AvailableHacks.Basic[60].Funct then
					AvailableHacks.Basic[60].Funct:Disconnect()
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
			["ActivateFunction"]=function(newValue)
				if reloadFunction then
					if lastRunningEnv.GlobalSettings then
						lastRunningEnv.GlobalSettings.enHacks = {}
						for hackID, value in pairs(enHacks) do
							lastRunningEnv.GlobalSettings.enHacks[hackID] = value
						end
					end
					reloadFunction()
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
				clear(true)
			end,
		},
	},
	["Bot"] = {
		[15] = {
			["Type"] = "ExTextButton",
			["Title"] = "Bot Farm",
			["Desc"] = "Automatically Bot Farms as Runner",
			["Shortcut"]="BotRunner",
			["Default"]=MyDefaults.BotFarmRunner, -- MyDefaults.BotFarmRunner
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
				local event = AvailableHacks.Bot[15].ChangedEvent
				AvailableHacks.Bot[15].DidAction = false
				AvailableHacks.Bot[15].CurrentTarget = target

				if isTeleportingAllowed then
					local setCFrame
					if (typeof(target)=="Instance") then
						setCFrame = CFrame.new(updatedTarget+newVector3(0,getHumanoidHeight(char)),target.Position)
					else
						setCFrame = CFrame.new(updatedTarget+newVector3(0,getHumanoidHeight(char)))
					end
					teleportMyself(setCFrame)
					return true
				end

				local startLoc=char.Torso.Position

				local isWaiting,start,lastTrigger = true, os.clock(), 0
				local Torso = char:FindFirstChild("Torso")
				local function taskSpawnFunction()
					while true do
						if not isWaiting or not Torso or not Torso.Parent then
							break
						end
						local currentPoso=Torso.Position
						if os.clock()-start>3 
							or (checkFunct and not checkFunct())then
							if os.clock()-start>3 and (startLoc-char.Torso.Position).Magnitude<4 then
								for s=1,2 do
									declareError(path, path.ErrorType.AgentStuck)
								end
							end
							event:Fire(false,false) break 
						end
						if os.clock()-lastTrigger>=1.5 then
							task.spawn(path.Run,path,updatedTarget)
							lastTrigger=os.clock()
							startLoc=char.Torso.Position
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

				if not canRun and char.Parent then
					if char.PrimaryPart then
						human:MoveTo(char.PrimaryPart.Position)
					end
					return false
				elseif result then
					path:Stop() task.wait()
					--human:MoveTo(updatedTarget)
					AvailableHacks.Bot[20].Funct(path,updatedTarget)
				end
				return result or ((updatedTarget-char.PrimaryPart.Position)/newVector3(1,4,1)).magnitude<2
			end),
			["UnlockDoor"]=function(shouldWait)
				if isActionProgress then
					return false
				end
				local TSM = plr:WaitForChild("TempPlayerStatsModule")
				local ActionSign 
				--if not skipWait and ActionSign==nil then --print("searching") 
				for s=60,1,-1 do

					--for num,part in pairs(char.Torso:GetTouchingParts()) do
					local firstHalf = TSM.ActionEvent.Value~=nil and TSM.ActionEvent.Value.Parent and TSM.ActionEvent.Value.Parent.Parent
					ActionSign=firstHalf and string.find(TSM.ActionEvent.Value.Parent.Parent.Name,"Door")~=nil and TSM.ActionEvent.Value.Parent:FindFirstChild("ActionSign")--part:FindFirstChild("ActionSign")
					--if ActionSign~=nil then break end
					--end
					--local hit=char.Torso.Touched:Wait() task.wait()
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
						isActionProgress=true AvailableHacks.Bot[15].DidAction=true
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
						isActionProgress=false
						return true
					end
				end 
				return false
			end,
			["CrawlVent"]=(function(shouldWait)
				local Torso = char:WaitForChild("Torso")
				for TimesLeft = 30, 1, -1 do
					local getTouchingPartsList = Torso:GetTouchingParts()
					for num,part in ipairs(getTouchingPartsList) do
						if part.Name=="VentPartWalkThru" then
							AvailableHacks.Blatant[2].Crawl(true)
							task.wait(.4)
							local startCrawlTime=os.clock()
							while ((table.find(Torso:GetTouchingParts(),part)~=nil) and (os.clock()-startCrawlTime < 2)) do --((part.Position-Torso.Position)/newVector3(0,math.huge,0)).magnitude<.5
								task.wait()
							end
							AvailableHacks.Blatant[(2)].Crawl(false)
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
				human:MoveTo(char.Torso.CFrame*(5*Random.new():NextUnitVector()))
				wait(1/3)
			end,
			["getGoodTriggers"]=function(pc)
				local screen = pc:FindFirstChild("Screen")
				if ((screen.Color.G*255)<128) and ((screen.Color.G*255)>126) then--check if its green, meaning no hack hecked pcs!
					return {}
				end
				local list={}
				for num,triggerName in pairs(({"ComputerTrigger1","ComputerTrigger2","ComputerTrigger3"})) do
					local trigger=pc:FindFirstChild(triggerName)
					local canContinue1 = (trigger~=nil and trigger.Parent~=nil and Map~=nil and workspace:IsAncestorOf(trigger))
					if canContinue1 then
						if (screen~=nil and trigger:FindFirstChild("ActionSign")~=nil and trigger.ActionSign.Value==20 and not trigger:GetAttribute("Unreachable"..saveIndex)) then
							table.insert(list,trigger)
						end
					end
				end
				return list
			end,
			["RUNNERHack"]=function(TSM,currentPath,savedDeb)
				local canRun;
				function canRun(fullLoop)
					local Check1 = enHacks.BotRunner=="Hack" and char~=nil and human~=nil and human.Health>0 and camera.CameraSubject==human;
					local Check2 = savedDeb==AvailableHacks.Bot[15].CurrentNum and not TSM.Escaped.Value and char.PrimaryPart;
					local Check3 = select(2,isInLobby(char))=="Runner" and not isCleared;--(not fullLoop or select(2,isInLobby(char))=="Runner") and not isCleared;
					return Check1 and Check2 and Check3;
				end
				AvailableHacks.Bot[15].CanRun=canRun;

				local function getComputerTriggers()
					local triggers = {}
					for num,pc in ipairs(CS:GetTagged("Computer")) do
						for num,goodTrigger in pairs(AvailableHacks.Bot[15].getGoodTriggers(pc)) do
							table.insert(triggers,goodTrigger)
						end
					end 
					if #triggers==0 and RS.IsGameActive.Value then 
						AvailableHacks.Bot[15].noComputeStuck() 
					end
					return triggers
				end
				local function getExitDoors()
					local exitAreas = {}
					for num,exit in ipairs(CS:GetTagged("Exit")) do
						local exitArea = exit:FindFirstChild("ExitArea")
						if exitArea~=nil and not exitArea:GetAttribute("Unreachable"..saveIndex) then
							table.insert(exitAreas,exitArea)
						end
					end 
					if #exitAreas == 0 and RS.IsGameActive.Value then 
						AvailableHacks.Bot[15].noComputeStuck() 
					end
					return exitAreas
				end
				AvailableHacks.Blatant[2].Crawl(UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.ButtonL2))
				while canRun(true) do
					human:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
					while #CS:GetTagged("Computer")==0 do
						human:Move(newVector3())
						CS:GetInstanceAddedSignal("Computer"):Wait()
						task.wait()
						task.spawn(function()
							AvailableHacks.Blatant[2].Crawl(AvailableHacks.Blatant[2].IsCrawling) --RS.IsGameActive.Changed:Wait() --wait(1)
						end)
					end
					while RS.CurrentMap.Value==nil do
						RS.CurrentMap.Changed:Wait()
					end
					--print(#CS:GetTagged("Computer"),string.sub(RS.GameStatus.Value,1,2),string.sub(RS.GameStatus.Value,1,2)=="15")
					if RS.ComputersLeft.Value>0 or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15") then--hack time :D
						local closestTrigger,dist=findClosestObj(getComputerTriggers(),char.PrimaryPart.Position,3000,6)
						while canRun() and closestTrigger~=nil and (RS.ComputersLeft.Value>0 or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15")) do --print("found trigger")
							local ActionSign=closestTrigger:FindFirstChild("ActionSign")
							local function walkPathFunct()
								return ActionSign~=nil and ActionSign.Value==20 and canRun()
							end
							local didReach=TSM.CurrentAnimation.Value=="Typing" or AvailableHacks.Bot[15].WalkPath(currentPath, closestTrigger, walkPathFunct)
							local distance=(closestTrigger.Position-char.Torso.Position).magnitude
							human:SetAttribute("OverrideSpeed",distance<13 and 35 or nil)
							if didReach or (closestTrigger.Position-char.Torso.Position).magnitude<2 or (TSM.ActionEvent.Value~=nil and closestTrigger:IsAncestorOf(TSM.ActionEvent.Value)) and ActionSign~=nil and ActionSign.Value==20 then--and table.find(closestTrigger:GetTouchingParts(),char.PrimaryPart) ~=nil then
								--print(TSM.ActionEvent.Value,TSM.CurrentAnimation.Value)
								--effective way of making the server wait!
								task.wait(.45)
								if TSM.CurrentAnimation.Value~="Typing" and (TSM.ActionEvent.Value==nil or plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("ActionBox").Text~="Hack")and closestTrigger.ActionSign.Value==20 then
									--AvailableHacks.Basic[12].TeleportFunction(CFrame.new(closestTrigger.Position-newVector3(0,human.HipHeight+char.Torso.Size.Y/2,0),closestTrigger.Parent.PrimaryPart.Position))
									human:MoveTo(closestTrigger.Position)
									human:ChangeState(Enum.HumanoidStateType.Jumping)
									task.wait(.6)
								end
								local screen=closestTrigger.Parent:FindFirstChild("Screen")
								while canRun() and closestTrigger and closestTrigger.Parent and TSM.ActionEvent.Value~=nil and closestTrigger.ActionSign.Value==20 and TSM.CurrentAnimation.Value~="Typing" and not (screen.Color.G*255<128 and screen.Color.G*255>126) do
									local distTraveled=(lastHackedPosition-closestTrigger.Position).Magnitude
									local timeElapsed=os.clock()-computerHackStartTime
									local minHackTimeBetweenPCs = (0.15+math.max(distTraveled/minSpeedBetweenPCs,absMinTimeBetweenPCs))
									if lastHackedPC~=closestTrigger.Parent and timeElapsed<minHackTimeBetweenPCs then
										timeElapsed = timeElapsed + (task.wait(minHackTimeBetweenPCs-timeElapsed))
									else
										print("Attempting to hack",closestTrigger.Parent.Name .."/"..closestTrigger.Parent.Parent.Name, "\nTime Elapsed:", math.round(timeElapsed*100)/100,"s".."\nDistance Traveled:",math.round(distTraveled*100)/100 .. "\nAvg Velocity:",math.round((distTraveled/timeElapsed)*100)/100)
										VU:SetKeyDown("e") --print("force 'e'")
										RunS.RenderStepped:Wait()
										VU:SetKeyUp("e")
										task.wait(1/3)
									end
								end --print("hacking ", closestTrigger.Parent:GetFullName())
								--if TSM.CurrentAnimation.Value=="Typing" then
								task.wait(1)
								if canRun() and TSM.CurrentAnimation.Value=="Typing" then
									while canRun() and TSM.CurrentAnimation.Value=="Typing" do
										task.wait(1/3)
										computerHackStartTime=os.clock() 
										lastHackedPC,lastHackedPosition=closestTrigger.Parent,closestTrigger.Position
									end
								end
									
							end
							if char.PrimaryPart~=nil then
								closestTrigger,dist=findClosestObj(AvailableHacks.Bot[15].getGoodTriggers(closestTrigger.Parent),char.PrimaryPart.Position,3000,1)
							end
							task.wait(0)
						end
						--print(AvailableHacks.Bot[15].WalkPath(currentPath,
						--	char.PrimaryPart.CFrame*newVector3(0,0,-15)))
					else--escape time :D
						local closestExitArea,dist=findClosestObj(getExitDoors(),(char.PrimaryPart and char.PrimaryPart.Position or newVector3()),3000,1)
						while canRun() and closestExitArea~=nil and not closestExitArea:GetAttribute("Unreachable"..saveIndex) and not TSM.Escaped.Value do
							local exitDoor = closestExitArea.Parent
							if exitDoor:FindFirstChild("ExitDoorTrigger") and (exitDoor.ExitDoorTrigger.ActionSign.Value == 12 or exitDoor.ExitDoorTrigger.ActionSign.Value == 10)
								and AvailableHacks.Blatant[15].DoorFuncts[exitDoor] then
								AvailableHacks.Blatant[15].DoorFuncts[exitDoor]()
							end
							local didReach=AvailableHacks.Bot[15].WalkPath(currentPath,closestExitArea,canRun)
							while ((table.find(workspace:GetPartsInPart(char.HumanoidRootPart),closestExitArea)) and (not TSM.Escaped.Value) 
								and (not exitDoor:FindFirstChild("ExitDoorTrigger") 
									or (exitDoor.ExitDoorTrigger.ActionSign.Value ~= 12 and exitDoor.ExitDoorTrigger.ActionSign.Value ~= 10))) do
								if human.FloorMaterial~=Enum.Material.Air then
									human:ChangeState(Enum.HumanoidStateType.Jumping)
									teleportMyself(char:GetPivot() * CFrame.new(0,0,-12))
								end
								task.wait(1/6)
							end
							wait(0)
						end
					end
					wait(0)
				end
				human:SetAttribute("OverrideSpeed",nil)
				human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
			end,
			["RUNNERFreeze"]=function(TSM,currentPath,savedDeb)
				local runnerPlrs={}
				local myRunerPlrKey
				local function canRun(fullLoop)
					local plrs = {}
					for num, theirPlr in ipairs(PS:GetPlayers()) do
						if theirPlr and theirPlr.Character and select(2,isInLobby(theirPlr.Character))=="Runner" then
							table.insert(plrs,theirPlr)
						end
					end
					runnerPlrs = sortPlayersByXPThenCredits(plrs)
					myRunerPlrKey = table.find(runnerPlrs,plr)
					--if Random.new():NextInteger(1,18)==1 then
					--	print(enHacks.BotRunner,savedDeb==AvailableHacks.Bot[15].CurrentNum,camera.CameraSubject==human,TSM.Escaped.Value,char.PrimaryPart)
					--end
					--if true then
					--error("CanRunBro")
					--end

					local Ret1 = (enHacks.BotRunner=="Freeze" and char and human and human.Health>0 and camera.CameraSubject==human and savedDeb==AvailableHacks.Bot[15].CurrentNum and not TSM.Escaped.Value and char.PrimaryPart and Beast and Beast.PrimaryPart)
					local Ret2 = ((select(2,isInLobby(char))=="Runner") and not isCleared)
					local Ret3 = Beast and myBots[Beast.Name:lower()]
					if not Ret3 and Beast then
						createCommandLine("Freeze Disabled: Unrecognized Player\n\tSet ")
						print("Freeze Disabled: Unrecognized Player")
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
							if AvailableHacks.Blatant[80].RescueSurvivor(targetCapsule,true) then
								return plr:SetAttribute("HasRescued",true)
							end
						end
						RunS.RenderStepped:Wait()
					end
				end)
				while canRun(true) do
					human:SetAttribute("OverrideSpeed",((Beast:GetPivot().Position-char:GetPivot().Position).Magnitude<16 and 25 or 42))
					local inRange = (Beast:GetPivot().Position-char:GetPivot().Position).Magnitude<8
					if not inRange and not myTSM.Captured.Value then
						local didReach=AvailableHacks.Bot[15].WalkPath(currentPath,Beast:GetPivot()*newVector3(0,0,-2),canRun)
					end
					while (canRun(true) and (Beast and Beast.PrimaryPart) and ((Beast:GetPivot().Position-char:GetPivot().Position).Magnitude<8 or TSM.Ragdoll.Value)) do
						if (myRunerPlrKey==1 and not plr:GetAttribute("HasCaptured")) or plr:GetAttribute("HasRescued") then
							task.wait(1/2)
							if not canRun(true) then
								return
							end
							if not TSM.Ragdoll.Value and Beast and Beast.Parent then
								Beast.Hammer.HammerEvent:FireServer("HammerHit", char.Head)
								task.wait(1/4)
							end
							if not canRun(true) then
								return
							end
							if TSM.Ragdoll.Value and Beast and Beast.Parent then
								teleportMyself(Beast:GetPivot()*CFrame.new(0,0,2))
								RunS.RenderStepped:Wait()
								AvailableHacks.Blatant[7].RopeSurvivor(TSM,plr,true)
								task.wait(1/2)
								--if Beast.CarriedTorso.Value and Beast.CarriedTorso.Value.Parent==char then
								--	AvailableHacks.Blatant[60].CaptureSurvivor(plr,char,true)
								--end
							end
						end
						--if human.FloorMaterial~=Enum.Material.Air then
						--	human:ChangeState(Enum.HumanoidStateType.Jumping)
						--end
						task.wait(1/6)
					end
					RunS.RenderStepped:Wait()
					while TSM.DisableCrawl.Value do
						TSM.DisableCrawl.Changed:Wait()
					end
				end

			end,
			["ActivateFunction"]=function()
				--print("Bot Function Activated")
				human:SetAttribute("OverrideSpeed",nil)
				local currentPath=AvailableHacks.Bot[15].CurrentPath
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				if currentPath==nil then 
					error("no path found!") 
					return 
				end
				currentPath:Stop()
				AvailableHacks.Bot[15].ChangedEvent:Fire(false,false) 
				if not enHacks.BotRunner then
					--print("b1")
					human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
					return 
				end
				local start = os.clock()
				for s=180,1,-1 do
					if isCleared or not enHacks.BotRunner then 
						return false 
					end
					local inGame,role = isInLobby(char)
					--print(role,enHacks.BotRunner,Beast,myTSM.Health.Value)
					if role=="Runner" and (enHacks.BotRunner~="Freeze" or (Beast and Beast.PrimaryPart)) then
						print("Bot "..enHacks.BotRunner.." Runner Activated After "..math.round(os.clock()-start).."/s="..s)
						task.wait(.5)
						break
					elseif s==1 then 
						return false
					end
					task.wait(.25)
				end

				AvailableHacks.Bot[15].CurrentNum = AvailableHacks.Bot[15].CurrentNum + 1
				local savedValue=AvailableHacks.Bot[15].CurrentNum
				AvailableHacks.Bot[15]["RUNNER"..enHacks.BotRunner](TSM,currentPath,savedValue)
			end,
			["MyStartUp"]=function(myPlr,myChar)

				isActionProgress=false;
				local Torso=char:WaitForChild("Torso",30) ;
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
						--Beast = math.huge,
						NoWalkThru = math.huge
					};
				};
				local newPath = Path.new(myChar, pathTable);
				newPath.Visualize = true;
				table.insert(functs,newPath.Reached:Connect(function(agent,lastWayPoint)
					--print("reached!")
					if lastWayPoint and lastWayPoint.Position~=nil then
						human:MoveTo(lastWayPoint.Position)
					end
					Errors=0--math.max(0,Errors-.2)
					AvailableHacks.Bot[15].ChangedEvent:Fire(true,true)
				end));
				table.insert(functs,newPath.Blocked:Connect(function(myChar,wayPoint)
					if RS.IsGameActive.Value then
						AvailableHacks.Bot[15].noComputeStuck()
					end
				end))
				local function waypointReached(agent,lastWayPoint,nextWayPoint)
					Errors=math.max(0,Errors-.2);
					if isActionProgress or not char.PrimaryPart then
						return false;
					end;
					local from=Torso.Position;
					local to = nextWayPoint.Position+newVector3(0,getHumanoidHeight(char),0);
					
					local didHit,instance=raycast(from,to,{"Whitelist",table.unpack(CS:GetTagged("DoorAndExit"))},5,0.001,true);
					local didHit2,instance2=raycast(from,to,{"Whitelist",Map},5,0.001,true);
					if nextWayPoint.Label=="DoorPath" or (didHit and (CS:HasTag(instance.Parent,"DoorAndExit") or CS:HasTag(instance.Parent.Parent,"DoorAndExit") or CS:HasTag(instance.Parent.Parent.Parent,"DoorAndExit"))) then
						return AvailableHacks.Bot[15].UnlockDoor(true);
					elseif (nextWayPoint.Label=="Vent" or (didHit2 and instance2.Name~="VentPartWalkThru") ) then
						return AvailableHacks.Bot[(15)].CrawlVent(true);
					elseif (to.Y>char.PrimaryPart.Position.Y and human.FloorMaterial~=Enum.Material.Air and not AvailableHacks.Blatant[(2)].IsCrawling and not isActionProgress) or nextWayPoint.Label=="Window" or (instance2~=nil and instance2.Name=="WindowWalkThru") then
						human:ChangeState(Enum.HumanoidStateType.Jumping);
						return true;
					end;
					return false;
				end;
				newPath.WaypointReached:Connect(waypointReached);
				table.insert(functs,TSM.ActionEvent.Changed:Connect(function(event)
					local path = AvailableHacks.Bot[(15)].CurrentPath
					if not isActionProgress and path~=nil and path._status==Path.StatusType.Active and event~=nil and string.find(event.Parent.Name,"DoorTrigger")~=nil and AvailableHacks.Bot[15].CurrentTarget~=nil then
						task.wait(3/5) --3/5s compromise APUSH letsgo
						local lastPath = path._currentWaypoint-1
						waypointReached(char,(path._waypoints[(1<lastPath) and (lastPath) or 1]),(path._waypoints[((#path._waypoints>=path._currentWaypoint) and path._currentWaypoint) or 1]))
					end
				end))
				local compCount = 0
				newPath.Error:Connect(function(errorType)
					if errorType == Path.ErrorType.ComputationError then
						--newPath:Run(AvailableHacks.Bot[15].CurrentTarget
						AvailableHacks.Bot[15].ChangedEvent:Fire(false,true)
						local failedTarget = AvailableHacks.Bot[15].CurrentTarget
						if (typeof(failedTarget)=="Instance") then
							local current=failedTarget:GetAttribute(("Unreachable"..saveIndex))
							failedTarget:SetAttribute(("Unreachable"..saveIndex),(current~=nil and (current+1) or 1))
							--print("set ",failedTarget:GetFullName(), "unreachable!")
							local function delayedFunction()
								if not workspace:IsAncestorOf(failedTarget) then 
									return
								end
								current=failedTarget:GetAttribute("Unreachable"..saveIndex)
								if current~=nil then
									failedTarget:SetAttribute("Unreachable"..saveIndex,current>1 and current-1 or nil)
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
						--createModifer(newPart,"NoWalkThru",false)
						Errors = Errors + 1;
						if Errors==3 then
							print("LEFT / err bruh",Errors);
							human:MoveTo(char.PrimaryPart.CFrame*newVector3(-4,0,0));
						elseif Errors>=10 then
							print("RESET / err bruh",Errors);
							AvailableHacks.Commands[24].ActivateFunction();
						else
							print("err bruh",Errors);
						end;
					end;
				end)
				local function TorsoTouched(hit)
					if hit.Name=="WindowWalkThru" and Path~=nil and AvailableHacks.Bot[15].CurrentTarget~=nil and human~=nil and human.Health>0 and human.FloorMaterial~=Enum.Material.Air then
						human:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end
				table.insert(functs,Torso.Touched:Connect(TorsoTouched))
				AvailableHacks.Bot[15].CurrentPath=newPath
				AvailableHacks.Bot[15].ActivateFunction(enHacks.BotRunner)
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local function EscapeChanged()
					if not TSM.Escaped.Value and enHacks.BotRunner then
						AvailableHacks.Bot[15].ActivateFunction(true)
					end
				end
				local function HealthChanged()
					--print("Health Changed",TSM.Health.Value,TSM.Escaped.Value,AvailableHacks.Bot[15].IsRunning)
					if TSM.Health.Value>0 and not TSM.Escaped.Value and enHacks.BotRunner and not AvailableHacks.Bot[15].IsRunning then
						--print("Activation Started")

						AvailableHacks.Bot[15].ActivateFunction(true)
						--warn("Activation Failed")
					end
				end
				local function CaptureChanged()
					if not TSM.Captured.Value and human then
						human:ChangeState(Enum.HumanoidStateType.Landed)
					end
					plr:SetAttribute("HasCaptured",true)
				end
				table.insert(functs,TSM.Escaped.Changed:Connect(EscapeChanged))
				table.insert(functs,TSM.Health.Changed:Connect(HealthChanged))
				table.insert(functs,TSM.Captured.Changed:Connect(CaptureChanged))
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
				RemoveAllTags(walkThruPart)
				walkThruPart.Name="WalkThru"
				walkThruPart.Parent=door
				walkThruPart.Transparency=hitBoxesEnabled and .6 or 1
				walkThruPart.Size=door.Name=="ExitDoor" and newVector3(6,7,8.6) or newVector3(3,7,2.25)--walkThruPart.Size+=newVector3(-.5,4,0)
				CS:AddTag(walkThruPart,"WalkThruDoor")
				local currentPoso=walkThruPart.Position
				if door.Name=="ExitDoor" then
					local setPoso=doorTrigger.Position:lerp(exitArea.Position,.4)
					walkThruPart.Position=newVector3(setPoso.X,doorTrigger.Position.Y,setPoso.Z)
					walkThruPart.Size=newVector3(6,7,(doorTrigger.Position-exitArea.Position).magnitude/2+5.5)
					exitArea:SetAttribute("Unreachable"..saveIndex,nil)
				end

				--if Map.Name=="Homestead by MrWindy" and door.Name=="ExitDoor" then
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
					if Map.Name=="Abandoned Prison by AtomixKing and Duck_Ify" then
						walkThruPart.CFrame = walkThruPart.CFrame * CFrame.Angles(0,math.rad(90),0)
					elseif Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda" then
						walkThruPart.Size=newVector3(3,5,walkThruPart.Size.Z)
					elseif Map.Name=="Airport by deadlybones28" then
						walkThruPart.Size=newVector3(3,7,walkThruPart.Size.Z)
					end
				else
					if Map.Name=="Abandoned Prison by AtomixKing and Duck_Ify" then
						walkThruPart.CFrame = walkThruPart.CFrame * CFrame.Angles(0,math.rad(90),0)
					elseif Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda" then
						walkThruPart.Size=newVector3(3,5,1.5)
					end
				end
				--walkThruPart.Size=newVector3(4,7,6)


				CS:AddTag(walkThruPart,"RemoveOnDestroy")
				createModifer(walkThruPart,(ActionSign~=nil and (ActionSign.Value==10 or ActionSign.Value==12)) and "DoorPath" or "DoorOpened",true)
			end,
			["OthersBeastAdded"]=function(theirPlr,theirChar)
				local theirTorso=theirChar:WaitForChild("Torso",3)
				if theirTorso==nil or not workspace:IsAncestorOf(theirTorso) then 
					return 
				end
				for num,part in pairs(AvailableHacks.Bot[15].AvoidParts) do
					part:Destroy()
				end
				AvailableHacks.Bot[15].AvoidParts={}
				local avoidPart=Instance.new("Part",theirChar)
				avoidPart.Shape=Enum.PartType.Ball
				avoidPart.Anchored=true
				avoidPart.Size=newVector3(20,20,20)
				avoidPart.Position=theirTorso.Position
				avoidPart.Transparency=(hitBoxesEnabled and .7 or 1)
				avoidPart.CanCollide=false
				avoidPart.Name="AvoidPart"
				table.insert(AvailableHacks.Bot[15].AvoidParts,avoidPart)
				--local newWeld=Instance.new("Weld",avoidPart)
				--newWeld.Part0=theirTorso
				--newWeld.Part1=avoidPart
				createModifer(avoidPart,"Beast",false)
				CS:AddTag(avoidPart,"RemoveOnDestroy")
				avoidPart.Parent=camera
			end,
			["CleanUp"]=function()
				local parts2Avoid = AvailableHacks.Bot[15].AvoidParts
				for num,part in ipairs(parts2Avoid) do
					part:Destroy()
				end
				AvailableHacks.Bot[15].AvoidParts={}
				local CurrentPath = AvailableHacks.Bot[15].CurrentPath
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
						newPart.Transparency = (hitBoxesEnabled and (0.6) or (1))
						newPart.Color = (PartColor or newPart.Color)
						newPart.CanCollide = (false)
						newPart.Anchored = true
						newPart.Size = (DefaultSize or newPart.Size)
						newPart.Parent = Map
						newPart.Name = PartName
						CS:AddTag(newPart, "RemoveOnDestroy")
						CS:AddTag(newPart, PartName)
						for property,setTo in pairs(ventData) do
							--print(property,setTo)
							newPart[property]=setTo
						end

						createModifer(newPart,LabelName,Collide)
					end
				end
				local function createSolidPart(cframe,size,shape,partName,place)
					local newPart=Instance.new((shape=="WedgePart" and shape or "Part"))
					newPart.Transparency=hitBoxesEnabled and .6 or 1
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
				local Data=AvailableHacks.Bot[15].MapData[Map.Name]
				if Data~=nil then
					--print("Found Map Data For "..Map.Name)
					createBoxPart(Data.Vents,Data.DefaultVentSize,"VentPartWalkThru","Vent",newColor3(165, 0, 2),true)
					createBoxPart(Data.Windows,Data.DefaultWindowSize,"WindowWalkThru","Window",newColor3(0,255,255),true)
					createBoxPart(Data.NoWalkThru,nil,"NoWalkThruPart","NoWalkThru",newColor3(255, 0, 191),true)
					for num,data in pairs((Data.CollideSpots or {})) do
						local orientation=(data.Orientation or newVector3())
						createSolidPart(CFrame.new(data.Position)*CFrame.Angles(math.rad(orientation.X),math.rad(orientation.Y),math.rad(orientation.Z)),data.Size,data.Shape,"SolidCollidable",Map)
					end
				else
					--TODO: actually make a system for pathfinding
					--warn(Map.Name,"not found!")
				end
				if Map.Name=="Airport by deadlybones28" and false then
					for num,box in pairs(Map:WaitForChild("Boxes"):GetChildren()) do
						local cframe,size=box:GetBoundingBox()
						createSolidPart(cframe,size,nil,"SolidCollidable",box)
					end
				elseif Map.Name=="Forgotten Facility by Kmart_Corp" or Map.Name=="Abandoned Facility Remake by Daniel_H407" or Map.Name=="Facility_0 by MrWindy" then
					for num,windowModel in pairs(Map:GetChildren()) do
						if windowModel.Name=="Window" then
							local Barrier=windowModel:FindFirstChild("Barrier")
							if Barrier~=nil then 
								Barrier.Parent=Map
							end
							local cframe,size=windowModel:GetBoundingBox()
							local sendTable = {
								{["CFrame"]=(cframe-newVector3(0,1.75,0))}
							}
							createBoxPart(sendTable,newVector3(3, 9.5, 2.5),"WindowWalkThru","Window",newColor3(0,255,255),true)
						end

					end
					for num,box in pairs(Map:GetChildren()) do
						if box:IsA("Model") and string.find(box.Name,"Crate")~=nil then
							local cframe,size=box:GetBoundingBox()
							createSolidPart(cframe,size,nil,"SolidCollidable",box)
						end
					end
				elseif Map.Name=="The Library by Drainhp" then
					for num,windowModel in ipairs((Map:WaitForChild("Misc"):WaitForChild("Windows"):GetChildren())) do
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
				human:MoveTo(nextPoso)
			end),
			["ActivateFunction"]=(function(newValue)
				local teleportOffset=newVector3(0,2,0)
				if newValue=="Walk" then
					AvailableHacks.Bot[20].Funct=AvailableHacks.Bot[20].WalkFunct
				elseif newValue=="Teleport" then
					AvailableHacks.Bot[20].Funct=function(currentPath,nextPoso)
						local function teleportSpawnFunct()
							if os.clock()<AvailableHacks.Bot[20].TeleportDelay then
								return AvailableHacks.Bot[20].WalkFunct(nextPoso)
							end
							local hrp=char:WaitForChild("HumanoidRootPart")
							local startPoso=(char:GetPivot().Position+teleportOffset)
							local result,hitPart=raycast(startPoso,nextPoso,{Map},nil,nil,true)
							local dist=(result and result.Distance or ((nextPoso-startPoso)/newVector3(1,5,1)).Magnitude)
							if dist>.3 then
								local endPoint=(result and CFrame.new(startPoso,result.Position)*newVector3(0,0,-(dist-1.5)) or nextPoso)
								local x,y,z=char:GetPivot():ToOrientation()
								teleportMyself(CFrame.new(endPoint+teleportOffset)*CFrame.Angles(x,y,z))
								--char.Torso.Anchored=true
								--wait()--print("Response",RS.DefaultChatSystemChatEvents.MutePlayerRequest:InvokeServer())--we wait for a response--task.wait(1/4)
								--char.Torso.Anchored=false
								if (startPoso-hrp:GetPivot().Position).Magnitude+2<(endPoint-hrp:GetPivot().Position).Magnitude then
									AvailableHacks.Bot[20].TeleportDelay=os.clock()+3
									print("Detected Cheating!")
									return
								end
								AvailableHacks.Bot[20].TeleportDelay=0
								if not AvailableHacks.Bot[15].IsRunning or not currentPath then 
									return 
								end
								dist=((char:GetPivot().Position-nextPoso)/newVector3(1,5,1)).Magnitude

								if dist<4 and AvailableHacks.Bot[15].IsRunning then
									return moveToFinished(currentPath,true)
								else
									return --AvailableHacks.Bot[20].WalkFunct(nextPoso)
								end
							else
								return AvailableHacks.Bot[20].WalkFunct(nextPoso)
							end
						end
						task.spawn(teleportSpawnFunct) -- runs the above function!
					end
				end
			end),--]]
		},
		[23]={
			["Type"]="ExTextButton",
			["Title"]="Auto Vote For Known Maps",
			["Desc"]="",
			["Shortcut"]="AutoVote/Known",
			["Default"]=botModeEnabled,
			["CurrentNum"]=0,
			["DontActivate"]=true,
			["CurrentPath"]=nil,
			["IsRunning"]=false,
			["CleanUp"]=function()
				AvailableHacks.Bot[23].CurrentNum = AvailableHacks.Bot[23].CurrentNum + 1
				AvailableHacks.Bot[23].IsRunning = false
			end,
			["ActivateFunction"]=function()
				AvailableHacks.Bot[23].CurrentNum = AvailableHacks.Bot[23].CurrentNum + 1
				local SaveNum=AvailableHacks.Bot[23].CurrentNum
				local newPath=AvailableHacks.Bot[23].CurrentPath
				if newPath==nil or SaveNum~=AvailableHacks.Bot[23].CurrentNum then 
					return 
				end
				if not enHacks["AutoVote/Known"] then
					newPath:Stop() 
					AvailableHacks.Bot[23].IsRunning=false
					human:MoveTo(char:GetPivot().Position)
					return
				end
				AvailableHacks.Bot[23].IsRunning=true
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
					if AvailableHacks.Bot[15].MapData[map.Name] then --map.Name=="Forgotten Facility by Kmart_Corp"
						--or map.Name=="Abandoned Facility Remake by Daniel_H407" then--enHacks["AutoVote/"..map.Name] or map.Name=="Homestead by MrWindy"
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
					local isInLobby = isInLobby(char)
					local Check1 = char~=nil and workspace:IsAncestorOf(char) and human~=nil and human.Health>0
					local Check2 = enHacks["AutoVote/Known"] and mapTarget and mapTarget.Board.SurfaceGui.Enabled
					local Check3 = not isInLobby and ((SaveNum)==(AvailableHacks.Bot[23].CurrentNum)) and not isCleared
					return Check1 and Check2 and Check3
				end
				local function calculteMapTarget()
					local sortedPlayers = sortPlayersByXPThenCredits()
					local topPlr = sortedPlayers[1]
					local topPlrStatsMod = topPlr:FindFirstChild("SavedPlayerStatsModule")




















					if topPlrStatsMod then
						local newRandom = Random.new(getTotalXP(topPlrStatsMod.Level.Value,topPlrStatsMod.Xp.Value)*topPlrStatsMod.Credits.Value)
						local tbl = {}
						for num, instance in ipairs(mapsToVoteFor) do
							table.insert(tbl,instance.Name)
						end
						--print("Random Creation: ",(getTotalXP(topPlrStatsMod.Level.Value,topPlrStatsMod.Xp.Value)
						--	*topPlrStatsMod.Credits.Value).." Maps: ",table.concat(tbl,", "))
						mapTarget=#mapsToVoteFor>=1 and mapsToVoteFor[newRandom:NextInteger(1,#mapsToVoteFor)] or nil
						if mapTarget and not mapTarget.Pad:GetAttribute("WalkToPoso") then
							mapTarget.Pad:SetAttribute("WalkToPoso", findRandomPositionOnBox(mapTarget.Pad.CFrame,mapTarget.Pad.Size/2))
						end
					end
					return true
				end

				local walkPath = AvailableHacks.Bot[15].WalkPath
				while calculteMapTarget() and canRun() do
					local didReach = walkPath(newPath, mapTarget.Pad, canRun)
					task.wait()
				end
				if SaveNum==AvailableHacks.Bot[23].CurrentNum then
					AvailableHacks.Bot[23].IsRunning=false
				end
			end,
			["MyStartUp"]=function()
				task.wait();
				local Torso=char:WaitForChild("Torso",30); 
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
				local newPath = Path.new(char, PathConfigurationTable);
				newPath.Visualize = true;
				AvailableHacks.Bot[23].CurrentPath=newPath;
				AvailableHacks.Bot[23].ActivateFunction(enHacks["AutoVote/Known"]);
			end,
			["MyPlayerAdded"]=function()
				local MapVotingBoard=workspace:WaitForChild("MapVotingBoard")
				--[[for num,board in pairs(MapVotingBoard:GetChildren()) do
					if string.sub(board.Name,1,8)=="MapBoard" then
						setChangedAttribute(board:WaitForChild("SurfaceGui"),
							"Enabled",
						function() 
							task.wait(1) 
							if not AvailableHacks.Bot[23].IsRunning then
								AvailableHacks.Bot[23].ActivateFunction() 
							end
						end)
					end
				end--]]
				local function RSUpdateGameStatusFunction()
					if (not AvailableHacks.Bot[23].IsRunning and not ({isInLobby(char)})[1]) then
						AvailableHacks.Bot[23].ActivateFunction() 
					else
						--print(AvailableHacks.Bot[23].IsRunning)
					end
				end
				setChangedAttribute(RS.GameStatus, "Value", (RSUpdateGameStatusFunction))
			end,
		},
		[30]={
			["Type"]="ExTextButton",
			["Title"]="Reset After "..tostring(botBeastBreakMin).."m or exit open",
			["Desc"]="Waits for runners to finish hacking (BEAST BOT ONLY)",
			["Shortcut"]="Bot/AutoReset",
			["Default"]=(botModeEnabled and false),
			["CurrentNum"]=0,
			["ShouldBreak"]=function()
				if (RS.GameTimer.Value<=(60 * (tonumber(botBeastBreakMin) or 0))) then 
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
				AvailableHacks.Bot[30].CurrentNum = AvailableHacks.Bot[30].CurrentNum + 1
				local saveNum=AvailableHacks.Bot[30].CurrentNum
				task.delay(3/2,function()
					while enHacks["Bot/AutoReset"] and Map and Beast==char and human and human.Health>0
						and saveNum==AvailableHacks.Bot[30].CurrentNum and not isCleared do
						if AvailableHacks.Bot[30].ShouldBreak() then
							AvailableHacks.Commands[24].ActivateFunction(true)
							break
						end
						RS:WaitForChild("GameTimer").Changed:Wait()
					end
				end)
			end,
			["MyBeastAdded"]=function()
				AvailableHacks.Bot[30].ActivateFunction(enHacks["Bot/AutoReset"])
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
			["Default"]=botModeEnabled,["IsRunning"]=false,
			["ActivateFunction"]=function(en)
				if AvailableHacks.Bot[150].IsRunning then
					createCommandLine("<font color='rgb(255,0,0)'>Stuff is being purchased!!</font>")
					return
				end
				AvailableHacks.Bot[150].IsRunning=true
				local thingsToGet={
					["BuyShopBundle"]={
						(enHacks["Bot/Bundle"] 
							and enHacks["Bot/BundleQty"]>0 and ({enHacks["Bot/Bundle"],enHacks["Bot/BundleQty"]}) or nil)
					},
					["BuyCrate"]={
						(enHacks["Bot/Crate"] 
							and enHacks["Bot/CrateQty"]>0 and ({enHacks["Bot/Crate"],enHacks["Bot/CrateQty"]}) or nil)
					}
				}

				local RemoteEvent=RS:WaitForChild("RemoteEvent")
				local totalLoopMult=1
				local totalCountToBuy,alreadyPurchasedCount=0,0

				local function purchaseCrateFunction(main,crateType,id)
					if main=="BoughtCrate" then
						createCommandLine("🎁Purchase Success:"..crateType.." "..
							RS.ItemDatabase[id]:GetAttribute("ItemName"))
						alreadyPurchasedCount = alreadyPurchasedCount + 1
					end
				end

				AvailableHacks.Bot[150].Funct=RemoteEvent.OnClientEvent:Connect(purchaseCrateFunction)

				local function makeOrders(orderName)
					for num,desc in pairs(thingsToGet[orderName]) do
						for s=1,desc[2] or 1 do
							RemoteEvent:FireServer(orderName,desc[1])
							if orderName=="BuyShopBundle" then
								createCommandLine("📦Purchase Success: "..desc[1])
							else
								totalCountToBuy = totalCountToBuy + 1
							end
						end
					end
				end

				for s=1,totalLoopMult do
					ShuffleArray(thingsToGet,"BuyShopBundle")
					ShuffleArray(thingsToGet,"BuyCrate")
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
						warn(ErrorMessage)
						createCommandLine("<font color='rgb(255,0,0)'>"..ErrorMessage.."</font>")
						AvailableHacks.Bot[150].Funct:Disconnect()
						AvailableHacks.Bot[150].IsRunning=false
						return
					end
					task.wait()
				end
				local combinedStringForCommandLine = "All "..comma_value(totalCountToBuy).." Purchase"..(totalCountToBuy~=1 and "s" or "").." Succeeded in "..(math.round((os.clock()-startPurchase)*100)/100).."s"
				createCommandLine(combinedStringForCommandLine)
				AvailableHacks.Bot[150].Funct:Disconnect()
				AvailableHacks.Bot[150].IsRunning=false
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
	},
	["Commands"]={
		[24]={
			["Type"]="ExTextButton",
			["Title"]="Reset",
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
					local obj=char:FindFirstChild(findName,recurseLoop)
					if obj~=nil then
						obj:Destroy()
					end
				end
				Remove("LocalClubScript",true)
				Remove("BackgroundMusicLocalScript")
				createCommandLine("Reset Sequence Activated")
			end,
			["ActivateFunction"]=function(newValue)
				if char~=nil and human~=nil and char.Parent~=nil then
					local saveChar = char
					AvailableHacks.Commands[24].BeforeReset()
					if char.PrimaryPart then
						char.PrimaryPart.Anchored=true
					end
					if char:FindFirstChild("Head") then
						char.Head:Destroy()
					elseif human.Health>0 then
						human.Health = 0
					end
					task.wait(1)
					teleportMyself(CFrame.new(1e3,1e-3,1e3))
					task.wait(.25)
					if char.Humanoid.Health<=0 then
						local chardescendants = char:GetDescendants();
						for num,part in ipairs(chardescendants) do
							if part:IsA("BasePart") then
								part:Destroy();
							end;
						end;
					end
					task.delay(30,function()
						if char==saveChar and botModeEnabled and enHacks.BotRunner and not isCleared then
							createCommandLine("<font color='rgb(255,0,0)'>Reset Activation Sequence Failed.".."Auto Kicking Sequence Begun</font>")
							plr:Kick("Reset Activation Failed")
							error("Reset Activation Sequence Failed. Auto Kicking Sequence Begun")
						end
					end)
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
			["Universe"]={"Flee"},
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

				local plrList = sortPlayersByXPThenCredits()

				local totString = "Players Found ("..comma_value(#plrList)..")"

				for num, theirPlr in ipairs(plrList) do
					local plrString = ""
					local searchKey = "Other"
					local SavedPlayerStatsModule=theirPlr:WaitForChild("SavedPlayerStatsModule")
					if myBots[theirPlr.Name:lower()] then
						searchKey="Bot"
						plrString = plrString .. emojiDesc.Level --"⭐"
					else
						plrString = plrString .. emojiDesc.Heart --"💟"
					end
					local theirCredits,theirXP=SavedPlayerStatsModule:WaitForChild("Credits"),SavedPlayerStatsModule:WaitForChild("Xp")
					local theirLevel = SavedPlayerStatsModule:WaitForChild("Level")
					local totXP = getTotalXP(theirLevel.Value,theirXP.Value)
					plrString = plrString .. comma_value(theirLevel.Value) .." "..theirPlr.Name.." | ".. emojiDesc.Money .. " "..comma_value(theirCredits.Value).." ".. emojiDesc.NumberOne .. " "..comma_value(totXP) -- 💰 🥇

					allStats.XP[searchKey] = allStats.XP[searchKey] + totXP
					allStats.Credits[searchKey] = allStats.Credits[searchKey] + theirCredits.Value
					totString = totString .. "\n"..plrString
				end

				for Type,Vals in pairs(allStats) do
					for UserType,NumValue in pairs(Vals) do
						if NumValue>0 then
							totString = totString .. "\n	>"..UserType.." "..Type..": "..comma_value(NumValue)
						end
					end
				end

				createCommandLine(totString)

			end,
			--[[["MyStartUp"]=function()
				local isChecking=plr:WaitForChild("IsCheckingLoadData")
				if not isChecking.Value then
					plr:WaitForChild("PlayerGui")
					:WaitForChild("ScreenGui"):WaitForChild("MenusTabFrame").Visible=true
				end
			end,--]]
		},

	}

}
local function defaultFunction(functName,args)
	if not AvailableHacks then
		return
	end
	for hackType,hackList in pairs(AvailableHacks) do
		for num,hackInfo in pairs(hackList) do
			local shouldPass = hackInfo[functName] ~= nil
			if shouldPass then
				local arg1, arg2, arg3, arg4, arg5 = table.unpack(args);
				local functToSpawn = hackInfo[functName];
				task.spawn(functToSpawn, arg1, arg2, arg3, arg4, arg5);
			end;
		end;
	end;
end;


--Multi Script Check:
local getID="HackGUI1"
saveIndex = ((plr:GetAttribute(getID) or 0)+1)
--if plr:GetAttribute("Cleared"..getID) then plr:SetAttribute("Cleared"..getID,false) end
local previousCopy = (plr:GetAttribute(getID)~=nil)
plr:SetAttribute(getID,saveIndex)
wait()
local function attributeAddedFunction()
	if clear==nil then
		isCleared=true
		DS:AddItem(script,5)
		return
	end
	if plr:GetAttribute(getID)~=saveIndex then
		clear()
	end
end

if script==nil or plr:GetAttribute(getID)~=saveIndex then
	setChangedAttribute()
	return "Saved Index Changed (Code 101)"
end
table.insert(functs,(plr:GetAttributeChangedSignal(getID):Connect(attributeAddedFunction)))

PlayerControlModule = require(plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

--DELETION--
clear = function(isManualClear)
	if true then
		--return--debugging lol
	end
	isCleared=true
	if HackGUI then
		HackGUI.Enabled=false
	end
	if DraggableMain then DraggableMain:Disable() end
	--plr:SetAttribute(getID,nil)
	if (AvailableHacks.Bot[15] and AvailableHacks.Bot[15].CurrentPath~=nil) then
		AvailableHacks.Bot[15].CurrentPath:Stop()
	end
	if gameName == "FleeMain" then
		AvailableHacks.Utility[8].CleanUp()
	end
	local searchList = objectFuncts or {}
	for obj,objectEventsList in pairs(searchList) do
		local insideSearchList = objectEventsList or {}
		for value,funct in pairs(insideSearchList) do
			if funct~=nil then
				funct:Disconnect()
				funct=nil
			end
		end
	end
	--[[for num,obj in ipairs(CS:GetTagged("RemoveOnDestroy")) do
		if obj~=nil then
			for _, tag in ipairs(obj:GetTags()) do
				obj:RemoveTag(tag)
			end
			obj:Destroy();
		end;
	end;--]]
	DestroyAllTaggedObjects("RemoveOnDestroy")
	for userID,functList in pairs(playerEvents) do
		for num,funct in pairs(functList or {}) do
			funct:Disconnect();
			funct=nil;
		end;
	end;
	if isManualClear then
		local LocalPlayerScript = char:WaitForChild("LocalPlayerScript")
		if LocalPlayerScript then
			LocalPlayerScript.Disabled = true
			LocalPlayerScript.Disabled = false
		end
		if Beast == char then
			task.delay(0,CAS.UnbindAction,CAS,"Crawl")

			task.spawn(function()
				local LocalClubScript = char:FindFirstChild("LocalClubScript",true)
				if LocalClubScript then
					LocalClubScript.Disabled = false
				end
			end)
		end
		--local CrawlScript=char:WaitForChild("CrawlScript") 
		--if CrawlScript then
		--	CrawlScript.Disabled=false
		--end
		AvailableHacks.Utility[2].ActivateFunction(false)--disable override zooming
		AvailableHacks.Basic[40].ActivateFunction(false)--disable reset button again!
		AvailableHacks.Basic[20].ActivateFunction(false)--make invisible walls unable to walk through again!
	else
		getgenv().enHacks = table.clone(enHacks)
	end
	for hackName,enabled in pairs(enHacks) do
		enHacks[hackName]=nil;  --disables all running hacks to stop them!
	end;--effectively disables all hacks!
	AvailableHacks.Basic[4].ActivateFunction(false);--disble hacks
	AvailableHacks.Basic[4].ActivateFunction(false);--disable hacks
	AvailableHacks.Basic[1].UpdateSpeed();--disable walkspeed
	human:SetAttribute("OverrideSpeed",nil)
	if AvailableHacks.Blatant then
		AvailableHacks.Blatant[2].IsCrawling=false;--disable crawl
		AvailableHacks.Blatant[2].Crawl(false);--disable crawl
	end
	trigger_setTriggers("Override",{})--Before it removes tags, undo setting triggers!
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
	for category, categoryList in pairs(AvailableHacks) do
		for index,tbl in pairs(categoryList) do
			local check = (tbl.Funct and typeof(tbl.Funct))
			if (check=="RBXScriptConnection") then
				tbl.Funct:Disconnect()
			end
		end
	end
	for num,funct in ipairs(functs) do
		funct:Disconnect()
		funct=nil
	end
	hackChanged:Fire()
	hackChanged:Destroy()
	CAS:UnbindAction("hack_jump"..saveIndex)
	CAS:UnbindAction("Crawl"..saveIndex)
	CAS:UnbindAction("CloseMenu"..saveIndex)
	CAS:UnbindAction("PushSlash"..saveIndex)

	plr:SetAttribute("Cleared"..getID,(plr:GetAttribute("Cleared") or 0)+1)
	getgenv()["ActiveScript"..getID][saveIndex] = nil
	DS:AddItem(HackGUI,1)
	DS:AddItem(script,1)
	clear=nil
end

--Anti Main Check:
local function iterPageItems(page)
	local PlayersFriends = {}
	repeat
		local info = (page and page:GetCurrentPage()) or ({})
		for i, friendInfo in pairs(info) do
			table.insert(PlayersFriends, friendInfo)
		end
		if not page.IsFinished then 
			page:AdvanceToNextPageAsync()
		end
	until page.IsFinished
	return PlayersFriends
end
getgenv()["ActiveScript"..getID] = getgenv()["ActiveScript"..getID] or {} 
if previousCopy then
	local changedEvent=Instance.new("BindableEvent")
	local startTime=os.clock()
	local maxWaitTime=1
	local function maxWaitTimeReturnFunction()
		if not changedEvent then
			return
		end
		changedEvent:Fire()
	end
	task.delay(maxWaitTime,maxWaitTimeReturnFunction)
	local function clearFunct()
		changedEvent:Fire()
	end
	local clearedConnection=(plr:GetAttributeChangedSignal("Cleared"..getID):Connect(clearFunct))
	while getDictLength(getgenv()["ActiveScript"..getID])>0 do
		changedEvent.Event:Wait()
		if isCleared then
			DS:AddItem(script,1)
			return "Cleared While Waiting (Code 102)"
		end
		if os.clock()-startTime>=maxWaitTime then
			warn(( "Maximum Wait Time Reached ("..maxWaitTime.."s), Starting Script..." ))
			break
		end
	end
	changedEvent:Destroy()
	clearedConnection:Disconnect()
	clearedConnection=nil
end
if isCleared then
	DS:AddItem(script,1)
	return "After Waiting Cleared (Code 103)"
end
getgenv()["ActiveScript"..getID][saveIndex] = true

local numOfFriends = (0) 

local function checkFriendsPCALLFunction()
	local friendsPages = PS:GetFriendsAsync(plr.UserId)
	local friendsTable = iterPageItems(friendsPages)
	for item, pageNo in ipairs(friendsTable) do
		numOfFriends = numOfFriends + 1
	end
end

local success, err = pcall(checkFriendsPCALLFunction);

if (not success) then
	warn(("Error getting friends!"), (err));
end;
local mainAccountDetected = (success and ((numOfFriends)>=(15)) and not isStudio);
if mainAccountDetected then
	plr:Kick("Anti Main Hack: Main Account Detected!");
end;

local function resetEventFunction()
	if AvailableHacks.Commands[24] then
		AvailableHacks.Commands[24].ActivateFunction();
	end;
end;
ResetEvent = Instance.new("BindableEvent");
ResetEvent.Event:Connect(resetEventFunction);
CS:AddTag(ResetEvent, "RemoveOnDestroy");
ResetEvent.Parent = RS;

-- GUI CREATION / Instances:

GuiCreationFunction();
GuiCreationFunction = nil;

--JUMP CONTROL
jumpChangedEvent = Instance.new("BindableEvent")
function jumpAction(actionName, inputState, inputObject)
	if inputState == Enum.UserInputState.Begin then
		isJumpBeingHeld = true
	elseif inputState == Enum.UserInputState.End then
		isJumpBeingHeld = false
	else
		return
	end
	jumpChangedEvent:Fire(isJumpBeingHeld)
end
task.spawn(function()
	local JumpButton = plr.PlayerGui:WaitForChild("TouchGui",math.huge):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton",math.huge);
	table.insert(functs, JumpButton:GetPropertyChangedSignal("ImageRectOffset"):Connect(function()
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

CAS:BindAction("hack_jump"..saveIndex,jumpAction,false, Enum.PlayerActions.CharacterJump)

--GUI CODING
local refreshTypes = ({
	ExTextButton = function(hackFrame,hackInfo,isFirstRun)
		local selectedKey = (enHacks[hackInfo.Shortcut]);
		local selectedOption = hackInfo.Options[selectedKey];
		--print(hackInfo.Shortcut, selectedKey, selectedOption);
		assert(selectedOption, hackInfo.Title.." doesn't have a Title!")

		hackFrame.Toggle.Text = selectedOption.Title;
		hackFrame.Toggle.TextColor3 = selectedOption.TextColor;
		if hackInfo.ActivateFunction then
			if not hackInfo.DontActivate then
				task.spawn(hackInfo.ActivateFunction, enHacks[hackInfo.Shortcut], isFirstRun);
			else
				hackInfo.DontActivate=false;
			end;
		end;
		hackChanged:Fire();
	end,
	ExTextBox = function(hackFrame,hackInfo,isFirstRun)
		hackFrame.TextBox.Text = enHacks[hackInfo.Shortcut]
		if hackInfo.ActivateFunction then
			if not hackInfo.DontActivate then
				task.spawn(hackInfo.ActivateFunction, enHacks[hackInfo.Shortcut], isFirstRun)
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
		local function cycle(delta)
			local totalNum, shortCutNum = 0, 0;
			for Type,Vals in pairs(hackInfo.Options) do
				totalNum = totalNum + 1;
				local condition = Type==enHacks[hackInfo.Shortcut]; 
				if (condition) then
					shortCutNum = totalNum;
				end;
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
			local loopThru = hackInfo.Options
			for Type,Vals in pairs(loopThru) do
				totalNum = totalNum + 1
				if (totalNum==shortCutNum) then
					enHacks[hackInfo.Shortcut] = Type
					break
				end
			end
			refreshTypes.ExTextButton(hackFrame,hackInfo)
		end
		local function hackFrameToggleButtonFunction()
			cycle(1)
		end
		local HackFrameMSBUp = hackFrame.Toggle.MouseButton1Up:Connect(hackFrameToggleButtonFunction)
		table.insert(functs,HackFrameMSBUp)
		if ((getDictLength(hackInfo.Options))>(2)) then
			local function hackFrameReverseToggleButtonFunction()
				cycle(-1)
			end
			local MSBUp = hackFrame.Toggle.MouseButton2Up:Connect(hackFrameReverseToggleButtonFunction)
			table.insert(functs,MSBUp)
		end
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
				enHacks[hackInfoShortcut] = setNumber;
			else
				local defaultBracket = hackInfo.Default;
				enHacks[hackInfoShortcut] = defaultBracket;
			end;
			refreshTypes.ExTextBox(hackFrame, hackInfo);
		end);
		table.insert(functs, myFocusLost_CONNECTION);
	end,
})


local hacks2LoopThru = (AvailableHacks or {})
for categoryName, differentHacks in pairs(hacks2LoopThru) do
	local newButton, newProperty
	for num,hack in pairs(differentHacks) do
		if isCleared then
			return "Load Hacks Cleared (Code 104)"
		end
		local canPass = categoryName=="Basic" or (((hack.Universes and (table.find(hack.Universes,"Global") or table.find(hack.Universes,gameUniverse))) or (not hack.Universes and not hack.Places and gameName=="FleeMain")) or (hack.Places and table.find(hack.Places,gameName)));
		if canPass then
			if not newButton or not newProperty then
				newButton = MainListEx:Clone()
				newButton.Text = categoryName
				newButton.Name = categoryName
				newButton.LayoutOrder = (categoryName=="Commands" and 1 or 0)
				newButton.Parent=myList

				newProperty = PropertiesEx:Clone()
				newProperty.Parent = Properties
				newProperty.Name = categoryName
				newProperty.Visible=false
				local function newButtonMB1Up()
					Console.Visible = false
					Properties.Visible = true
					for num,prop in pairs(Properties:GetChildren()) do
						if prop.ClassName=="ScrollingFrame" then
							prop.Visible = (prop==newProperty)
						end
					end
					for num,button in pairs(myList:GetChildren()) do
						if button.ClassName=="TextButton" then
							button.Font = (button==newButton and textFontBold or textFont)
						end
					end
				end
				newButton.MouseButton1Up:Connect(newButtonMB1Up)
			end

			hack.Options = (hack.Options or (defaultOptionsTable))
			assert(getDictLength(hack.Options)>0,("Options Table Empty for "..categoryName.." "..hack.Title))
			local overrideDefault = (GlobalSettings.enHacks and GlobalSettings.enHacks[hack.Shortcut])
			if overrideDefault==nil and getgenv().enHacks then
				overrideDefault = getgenv().enHacks[hack.Shortcut]
			end
			if (hack.Type=="ExTextButton" and hack.Options[overrideDefault] == nil) or 
				(hack.Type=="ExTextBox" and (overrideDefault > hack.MinBound or overrideDefault < hack.MaxBound)) then
				warn("Invalid Option For "..hack.Title..": "..overrideDefault..". Reverting To Original...")
				overrideDefault = nil
			end
			if overrideDefault~=nil then
				enHacks[hack.Shortcut]=overrideDefault;
			else
				enHacks[hack.Shortcut]=hack.Default;
			end
			--print(hack.Shortcut,hack.Type);
			local miniHackFrame = TextBoxExamples[hack.Type]:Clone();
			miniHackFrame.Parent = newProperty;
			miniHackFrame.Name = hack.Title;
			miniHackFrame.Title.Text = hack.Title;
			miniHackFrame.Desc.Text = hack.Desc;
			miniHackFrame.LayoutOrder = num;
			hack.MiniHackFrame = miniHackFrame
			task.spawn(refreshTypes[hack.Type], miniHackFrame, hack, true);
			--pls work!
			local initilizationType_FUNCTION = initilizationTypes[hack.Type];
			task.spawn(initilizationType_FUNCTION,hack);
		else
			differentHacks[num]=nil
		end
	end
end

--COMMAND BAR CONTROL

local function consoleButtonControlFunction()
	Console.Visible = not Console.Visible
	Properties.Visible = not Properties.Visible
end

ConsoleButton.MouseButton1Up:Connect(consoleButtonControlFunction)

--HACK CONTROL
local function BeastAdded(theirPlr,theirChar)
	local Hammer = theirChar:WaitForChild("Hammer",30)
	if not Hammer or not theirChar.Parent or not Hammer.Parent then
		return
	end
	Beast=theirChar;
	local inputArray = {
		theirPlr, 
		theirChar
	};
	local function2Input = theirPlr==plr and "MyBeastAdded" or "OthersBeastAdded";
	defaultFunction(function2Input,inputArray);
	table.insert(functs,Hammer.AncestryChanged:Connect(function(newParent)
		Beast=nil
		local inputArray = {theirPlr,theirChar}
		defaultFunction((theirPlr==plr and "MyBeastRemoved" or "OthersBeastRemoved"),(inputArray))
	end))
end
local function CharacterAdded(theirChar)
	if isCleared then
		return
	end
	task.wait()
	local theirPlr=PS:GetPlayerFromCharacter(theirChar)
	local theirHumanoid=theirChar:WaitForChild("Humanoid")
	local hrp=theirChar:WaitForChild("HumanoidRootPart",1) or theirChar.PrimaryPart

	local isMyChar=theirPlr==plr
	if isMyChar then
		char=theirChar
		human=theirHumanoid
	end
	local inputFunctions = ({theirPlr,theirChar})
	defaultFunction(isMyChar and "MyStartUp" or "OthersStartUp",inputFunctions)
end
local function CharacterRemoving(theirPlr,theirChar)
	if isCleared then 
		return 
	end
	local isMyChar=theirPlr==plr
	local inputFunctions = ({theirPlr,theirChar})
	defaultFunction((isMyChar and "MyShutDown" or "OthersShutDown"),inputFunctions)
end
local function PlayerAdded(theirPlr)
	local isMe = (plr==theirPlr)
	playerEvents[theirPlr.UserId] = {}
	if theirPlr.Character~=nil then
		CharacterAdded(theirPlr.Character)
	end
	local myPlayerAddedInputArray = {theirPlr}
	local characterFunctionName = "OthersPlayerAdded";
	if isMe then
		characterFunctionName = "MyPlayerAdded";
	end
	defaultFunction(characterFunctionName, myPlayerAddedInputArray);
	local CharacterAddedConnection = theirPlr.CharacterAdded:Connect(CharacterAdded);
	table.insert(playerEvents[theirPlr.UserId], CharacterAddedConnection);
	local function characterRemovingFunction(removingChar)
		CharacterRemoving(theirPlr,removingChar);
	end
	--bro please work!

	local PlayerAddedConnection = theirPlr.CharacterRemoving:Connect(characterRemovingFunction);
	table.insert(playerEvents[theirPlr.UserId], PlayerAddedConnection);
	if myBots[theirPlr.Name:lower()] and botModeEnabled then
		table.insert(playerEvents[theirPlr.UserId], theirPlr.Chatted:Connect(function(message)
			if message == "/re" then
				AvailableHacks.Basic[99].ActivateFunction()
			end
		end))
	end

	if gameUniverse=="Flee" then
		local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule");
		if theirTSM then
			local isBeastValue = theirTSM:WaitForChild("IsBeast");
			if isBeastValue then
				if isBeastValue.Value then
					BeastAdded(theirPlr,theirPlr.Character);
				end
				table.insert(playerEvents[theirPlr.UserId], isBeastValue.Changed:Connect(function(new)
					if new then
						BeastAdded(theirPlr,theirPlr.Character);
					end
				end))
			end;
		end;
	end
end;
local function DescendantRemoving(child)
	if string.sub(child.Name,1,13)=="ComputerTable" then
		defaultFunction("ComputerRemoved",{child})
	elseif string.sub(child.Name,1,9)=="FreezePod" then
		CS:RemoveTag(child,"Capsule")
		defaultFunction("CapsuleRemoved",{child})
	elseif child.Name=="SingleDoor" or child.Name=="DoubleDoor" or child.Name=="ExitDoor" then
		CS:RemoveTag(child,"DoorAndExit")
		CS:RemoveTag(child,"Door")
		CS:RemoveTag(child,"Exit")
		local inputArray = {child,child.Name}
		defaultFunction("DoorRemoved",inputArray)
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
			trigger.Transparency=(hitBoxesEnabled and .6 or 1);
			if (Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda") then
				trigger:SetAttribute("WalkToPoso",Vector3.new(Screen.Position.X,trigger.Position.Y,Screen.Position.Z):lerp(trigger.Position,1.17));
			end;
		end;
		child.Name = "ComputerTable/"..(#CS:GetTagged("Computer"));
		defaultFunction("ComputerAdded",{child});
	elseif string.sub(child.Name,1,9)=="FreezePod" then
		local PodTrigger=child:WaitForChild("PodTrigger",3);
		CS:AddTag(child,"Capsule");
		if PodTrigger~=nil then
			CS:AddTag(PodTrigger,"Trigger");
		end;
		defaultFunction("CapsuleAdded",({child}));
		table.insert(functs,child.AncestryChanged:Connect(DescendantRemoving));
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
		else
			CS:AddTag(child,"Door");
			CS:AddTag(doorTrigger,doorTrigger_NAME);
		end;
		local doorAdded_NAME = "DoorAdded";
		defaultFunction(doorAdded_NAME, inputArray);
	end
end
local function registerObject(object,registerfunct,shouldntWait)
	if isCleared then return end
	table.insert(functs,object.ChildAdded:Connect(function(child)
		if isCleared then return end
		local function IntermediateDescendantRemovingFunction(newParent)
			DescendantRemoving(child);
		end;
		table.insert(functs,child.AncestryChanged:Connect(IntermediateDescendantRemovingFunction));
		registerfunct(child,false)
	end))
	for num, lowerobject in ipairs(object:GetChildren()) do
		local function IntermediateDescendantRemovingFunction(newParent)
			DescendantRemoving(lowerobject);
		end;
		task.spawn(registerfunct,lowerobject,shouldntWait)
		table.insert(functs,lowerobject.AncestryChanged:Connect(IntermediateDescendantRemovingFunction));
	end
end
local function updateCurrentMap(newMap)
	if newMap ~= Map and newMap then
		Map = newMap;
		task.wait(1);
		if isCleared then return end
		local inputArray = {newMap};
		defaultFunction("MapAdded",{newMap});
		task.spawn(registerObject,newMap,MapChildAdded)
		table.insert(functs,newMap.AncestryChanged:Connect(function(newParent)
			updateCurrentMap(nil)
		end))
	elseif Map and not newMap then
		local clonedMap = Map
		Map = nil; Beast = nil;
		defaultFunction("CleanUp",{clonedMap})
	end
end


if gameName == "FleeMain" then
	local MapChangedValue = RS:WaitForChild("CurrentMap")

	task.spawn(updateCurrentMap,MapChangedValue.Value)
	table.insert(functs,MapChangedValue.Changed:Connect(updateCurrentMap))
end

table.insert(functs,PS.PlayerAdded:Connect(PlayerAdded))

local function intermediatePlayerRemovingFunction(theirPlr)
	if plr==theirPlr then
		return
	end
	for num,funct in pairs((playerEvents[theirPlr.UserId] or ({}))) do
		funct:Disconnect()
	end
	playerEvents[theirPlr.UserId]=nil
end
table.insert(functs,(PS.PlayerRemoving:Connect(intermediatePlayerRemovingFunction)))
for num,theirPlr in ipairs(PS:GetPlayers()) do
	PlayerAdded(theirPlr)
end


--MENU FUNCTS
if gameName=="FleeMain" then
	local lastPC_time
	local lastPC
	local currentAnimation = myTSM:WaitForChild("CurrentAnimation")
	local lastAnimationName
	local function getPC(obj)
		if obj:HasTag("Computer") then
			return obj
		elseif obj == workspace or obj == Map then
			return
		end
		return getPC(obj.Parent)
	end
	local function updateAnimation()
		if currentAnimation.Value=="Typing" then
			lastPC = getPC(myTSM.ActionEvent.Value)
			if not lastPC then
				if not myTSM.ActionEvent.Value then
					warn("PC Not Found: ActionEvent.Value nil")
				else
					warn("PC Not Found:",myTSM.ActionEvent.Value:GetFullName())
				end
			end
		elseif lastPC and lastAnimationName=="Typing" then
			lastPC_time = os.clock()
			trigger_setTriggers("LastPC",{Computer=false,AllowExceptions = {lastPC}})
			task.delay(15,function()
				if (os.clock() - lastPC_time) >= 15 then
					trigger_setTriggers("LastPC",{Computer=true})
				end
			end)
		end
		lastAnimationName = currentAnimation.Value
	end
	setChangedAttribute(currentAnimation,"Value",updateAnimation)
	updateAnimation()
	
	
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
			local newXP = getTotalXP(currentLvl.Value, currentXP.Value)
			local deltaXP = (newXP - startXP)
			startXP = newXP
			xpEarned = xpEarned + deltaXP
			totalXPEarned = totalXPEarned + deltaXP

			local serverXPEarned = totalXPEarned + totXPOffset

			ServerXPGained.Text = ("Server XP: +"..comma_value(serverXPEarned).."/"..comma_value(math.round((serverXPEarned/time())*3600)))
			if theirPlr==plr then
				XPGained.Text = ("XP: +"..comma_value(xpEarned).."/"..comma_value(math.round((xpEarned/time())*3600)))
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

			ServerCreditsGained.Text="Server Credits: +"..comma_value(serverCreditsEarned).."/"..comma_value(math.round((serverCreditsEarned/time())*3600))
			if theirPlr==plr then
				CreditsGained.Text="Credits: +"..comma_value(creditsEarned).."/"..comma_value(math.round((creditsEarned/time())*3600))
			end
		end
		local function ancestryChangedFunction()
			PS:SetAttribute("TotalServerXPOffset",(currentXP and currentXP.Value or xpEarned)+(PS:SetAttribute("TotalServerXPOffset") or 0))
			PS:SetAttribute("TotalServerCreditsOffset",(currentCredits and currentCredits.Value or creditsEarned)+(PS:SetAttribute("TotalServerCreditsOffset") or 0))
		end
		local ancestryChangedInput_CONNECTION = theirPlr.AncestryChanged:Connect(ancestryChangedFunction);
		table.insert(functs,ancestryChangedInput_CONNECTION)
		local function instantFunction()
			local theirSSM=theirPlr:WaitForChild("SavedPlayerStatsModule")
			currentLvl=theirSSM:WaitForChild("Level",1e5)
			if not currentLvl then
				return
			end
			currentXP, currentCredits = theirSSM:WaitForChild("Xp"), theirSSM:WaitForChild("Credits");
			startXP = theirPlr:GetAttribute("StartXP") or getTotalXP(currentLvl.Value,currentXP.Value);
			startCredits = theirPlr:GetAttribute("StartCredits") or currentCredits.Value;
			theirPlr:SetAttribute("StartXP",startXP);
			theirPlr:SetAttribute("StartCredits",startCredits);
			setChangedAttribute(currentXP,"Value",updateXPStats);
			setChangedAttribute(currentCredits,"Value",updateCreditStats);
			updateXPStats();
			updateCreditStats();
		end
		task.spawn(instantFunction)
	end
	PS.PlayerAdded:Connect(calculateCreditsForPlayer);

	for num,theirPlr in pairs(PS:GetPlayers()) do
		calculateCreditsForPlayer(theirPlr);
	end;
end;

DraggableMain=DraggableObject.new(Main)
DraggableMain:Enable()

local function CloseMenu(actionName, inputState, inputObject)
	if inputState==Enum.UserInputState.Begin and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or inputObject.UserInputType ~= Enum.UserInputType.Keyboard) then
		Main.Visible=not Main.Visible
		if Main.Visible then
			DraggableMain:Enable()
		else
			DraggableMain:Disable()
		end
	end
end
CAS:BindActionAtPriority("CloseMenu"..saveIndex,CloseMenu,true,1e5,Enum.KeyCode.V)


return "Hack Successfully Executed V1.02!"
