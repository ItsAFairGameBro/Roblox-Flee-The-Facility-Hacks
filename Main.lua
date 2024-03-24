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
local LS=game:GetService("LogService")
local PathfindingService = game:GetService("PathfindingService")



local gameName=((game.PlaceId==1738581510 and "FleeTrade") or (game.PlaceId==893973440 and "FleeMain") or "Unknown")
local gameUniverse=gameName:find("Flee") and "Flee" or "Unknown"
newVector3, newColor3 = Vector3.new, Color3.fromRGB
isStudio=RunS:IsStudio()
--C.functs,C.refreshEnHack = {}, {}

local C={enHacks = {},playerEvents={},objectFuncts={},functs={},refreshEnHack={},
Map=nil,char=nil,Beast=nil,TestPart=nil,ToggleTag=nil,clear=nil,saveIndex=nil,AvailableHacks=nil,ResetEvent=nil,
CommandBarLine=nil,Console=nil,ConsoleButton=nil,PlayerControlModule=nil}
--local C.Map,C.char,C.Beast,C.TestPart,C.C.ToggleTag,clear,C.saveIndex,C.AvailableHacks,ResetEvent,C.C.C.CommandBarLine,C.Console,C.ConsoleButton,C.PlayerControlModule
--= nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,nil
--comma_value=nil
--local clear,C.saveIndex,C.AvailableHacks
local myTSM,mySSM
local plr = PS.LocalPlayer
local human
local PlayerGui = plr:WaitForChild("PlayerGui");
local isActionProgress=false
local isCleared=false
local isJumpBeingHeld = false

local lastRunningEnv = getfenv()
local reloadFunction = lastRunningEnv.ReloadFunction
local GlobalSettings = lastRunningEnv.GlobalSettings or {}
local isTeleportingAllowed = GlobalSettings.isTeleportingAllowed~=false
GlobalSettings.MinimumHeight = GlobalSettings.MinimumHeight or 1.5

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
if not myBots[plr.Name:lower()] then
	if not botModeEnabled and not GlobalSettings.ForceBotMode then
		myBots={};
		botModeEnabled = false;
	else
		botModeEnabled = true;
	end
end
local MyDefaults = {BotFarmRunner = (botModeEnabled and "Freeze")}
local hitBoxesEnabled=((botModeEnabled and false) or GlobalSettings.hitBoxesEnabled)
local minSpeedBetweenPCs=18 --minimum time to hack between computers is 6 sec otherwise kick
local absMinTimeBetweenPCs=30 --abs min time to hack, overrides minspeed
local botBeastBreakMin=13.5 --in minutes
local waitForChildTimout = 20
local max_tpStackSize = 1
local minTimeBetweenTeleport = .5
local defaultCharacterWalkSpeed=SP.CharacterWalkSpeed
local defaultCharacterJumpPower=SP.CharacterJumpPower


local NameTagEx,HackGUI


--INTERFACE/GUI CREATION
local MainListEx,myList,PropertiesEx,Properties,ServerCreditsGained,Main;
local BetterConsole_ClearConsoleFunction;
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
local function StartBetterConsole()
	--GUI CREATION FOR BETTER CONSOLE:

	local BetterConsole = Instance.new("Frame")
	C.BetterConsole = BetterConsole
	local SearchConsoleTextBox = Instance.new("TextBox")
	local SearchConsoleResults = Instance.new("TextLabel")
	local FilterCheckBoxes = Instance.new("Frame")
	local UIGridLayout = Instance.new("UIGridLayout")
	local BetterConsoleFilterBox = Instance.new("Frame")
	local InviClicker = Instance.new("TextButton")
	local CheckboxImage = Instance.new("ImageLabel")
	local FilterBoxName = Instance.new("TextLabel")
	local BetterConsoleList = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local BetterConsoleTextEx = Instance.new("TextLabel")
	local BetterConsoleDesc = Instance.new("TextLabel")
	local BetterConsoleQuitButton = Instance.new("ImageButton")
	local Buttons = Instance.new("Frame")
	local UIGridLayout_2 = Instance.new("UIGridLayout")
	local Clear = Instance.new("TextButton")
	local Bottom = Instance.new("TextButton")
	local Top = Instance.new("TextButton")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UICorner.CornerRadius = UDim.new(0,40)

	BetterConsole.Name = "BetterConsole"
	BetterConsole.Parent = HackGUI
	BetterConsole.AnchorPoint = Vector2.new(0.5, 0.5)
	BetterConsole.BackgroundColor3 = Color3.new(0.203922, 0.203922, 0.203922)
	BetterConsole.BackgroundTransparency = 0.25
	BetterConsole.BorderColor3 = Color3.new(0, 0, 0)
	BetterConsole.BorderSizePixel = 0
	BetterConsole.Position = UDim2.new(0.5, 0, 0.5, 0)
	BetterConsole.Size = UDim2.new(0.600000024, 0, 0.560000002, 0)
	BetterConsole.Visible = false
	BetterConsole.ZIndex = 5000
	UIStroke:Clone().Parent=BetterConsole
	UICorner:Clone().Parent=BetterConsole

	SearchConsoleTextBox.Name = "SearchConsoleTextBox"
	SearchConsoleTextBox.Parent = BetterConsole
	SearchConsoleTextBox.BackgroundColor3 = Color3.new(0, 0.65098, 1)
	SearchConsoleTextBox.BorderColor3 = Color3.new(0, 0, 0)
	SearchConsoleTextBox.BorderSizePixel = 0
	SearchConsoleTextBox.Position = UDim2.new(0.0199999996, 0, 0, 0)
	SearchConsoleTextBox.Size = UDim2.new(0.320734084, 0, 0.0500000007, 0)
	SearchConsoleTextBox.ZIndex = 5001
	SearchConsoleTextBox.Font = Enum.Font.Arial
	SearchConsoleTextBox.PlaceholderColor3 = Color3.new(1,1,1)
	SearchConsoleTextBox.PlaceholderText = "Filter Search Results"
	SearchConsoleTextBox.Text = ""
	SearchConsoleTextBox.TextColor3 = Color3.new(1,1,1)
	SearchConsoleTextBox.TextScaled = true
	SearchConsoleTextBox.TextSize = 14
	SearchConsoleTextBox.TextStrokeColor3 = Color3.new(0,0,0)
	SearchConsoleTextBox.TextStrokeTransparency = 0
	SearchConsoleTextBox.TextWrapped = true
	SearchConsoleTextBox.RichText = true
	UIStroke:Clone().Parent=SearchConsoleTextBox
	UICorner:Clone().Parent=SearchConsoleTextBox

	SearchConsoleResults.Name = "SearchConsoleResults"
	SearchConsoleResults.Parent = BetterConsole
	SearchConsoleResults.AnchorPoint = Vector2.new(0.5, 0)
	SearchConsoleResults.BackgroundColor3 = Color3.new(1, 1, 1)
	SearchConsoleResults.BackgroundTransparency = 1
	SearchConsoleResults.BorderColor3 = Color3.new(0, 0, 0)
	SearchConsoleResults.BorderSizePixel = 0
	SearchConsoleResults.Position = UDim2.new(0.5, 0, 0.0590000004, 0)
	SearchConsoleResults.Size = UDim2.new(0.937323153, 0, 0.0528666973, 0)
	SearchConsoleResults.ZIndex = 5002
	SearchConsoleResults.Font = Enum.Font.Arial
	SearchConsoleResults.RichText = true
	SearchConsoleResults.Text = "<font color='rgb(0,255,0)'>1,402</font> search results for found \"potato\""
	SearchConsoleResults.TextColor3 = Color3.new(1, 1, 1)
	SearchConsoleResults.TextScaled = true
	SearchConsoleResults.TextSize = 14
	SearchConsoleResults.TextStrokeTransparency = 0
	SearchConsoleResults.TextWrapped = true

	FilterCheckBoxes.Name = "FilterCheckBoxes"
	FilterCheckBoxes.Parent = BetterConsole
	FilterCheckBoxes.BackgroundColor3 = Color3.new(1, 1, 1)
	FilterCheckBoxes.BackgroundTransparency = 1
	FilterCheckBoxes.BorderColor3 = Color3.new(0, 0, 0)
	FilterCheckBoxes.BorderSizePixel = 0
	FilterCheckBoxes.Position = UDim2.new(0.565277815, 0, -7.26609031e-08, 0)
	FilterCheckBoxes.Size = UDim2.new(0.40223217, 0, 0.0500000007, 0)
	FilterCheckBoxes.ZIndex = 5002

	UIGridLayout.Parent = FilterCheckBoxes
	UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
	UIGridLayout.CellSize = UDim2.new(0.200000003, 0, 1, 0)

	BetterConsoleFilterBox.Name = "BetterConsoleFilterBox"
	BetterConsoleFilterBox.Parent = nil
	BetterConsoleFilterBox.BackgroundColor3 = Color3.new(0.219608, 0.219608, 0.219608)
	BetterConsoleFilterBox.BorderColor3 = Color3.new(0, 0, 0)
	BetterConsoleFilterBox.BorderSizePixel = 0
	BetterConsoleFilterBox.Size = UDim2.new(0, 100, 0, 100)
	BetterConsoleFilterBox.ZIndex = 5003
	BetterConsoleFilterBox:AddTag("RemoveOnDestroy")
	UIStroke:Clone().Parent=BetterConsoleFilterBox
	UICorner:Clone().Parent=BetterConsoleFilterBox


	InviClicker.Name = "InviClicker"
	InviClicker.Parent = BetterConsoleFilterBox
	InviClicker.AnchorPoint = Vector2.new(0.5, 0)
	InviClicker.BackgroundColor3 = Color3.new(1, 1, 1)
	InviClicker.BackgroundTransparency = 1
	InviClicker.BorderColor3 = Color3.new(0, 0, 0)
	InviClicker.BorderSizePixel = 0
	InviClicker.Position = UDim2.new(0.5, 0, 0, 0)
	InviClicker.Size = UDim2.new(0.899999976, 0, 1, 0)
	InviClicker.ZIndex = 5004
	InviClicker.Font = Enum.Font.SourceSans
	InviClicker.Text = " "
	InviClicker.TextColor3 = Color3.new(0, 0, 0)
	InviClicker.TextSize = 14

	CheckboxImage.Name = "CheckboxImage"
	CheckboxImage.Parent = BetterConsoleFilterBox
	CheckboxImage.BackgroundColor3 = Color3.new(1, 1, 1)
	CheckboxImage.BackgroundTransparency = 1
	CheckboxImage.BorderColor3 = Color3.new(0, 0, 0)
	CheckboxImage.BorderSizePixel = 0
	CheckboxImage.Size = UDim2.new(0.300000012, 0, 1, 0)
	CheckboxImage.ZIndex = 5004
	CheckboxImage.Image = "rbxassetid://4458804262"
	CheckboxImage.ImageColor3 = Color3.new(0.0509804, 1, 0)
	CheckboxImage.ScaleType = Enum.ScaleType.Fit

	FilterBoxName.Name = "FilterBoxName"
	FilterBoxName.Parent = BetterConsoleFilterBox
	FilterBoxName.AnchorPoint = Vector2.new(1, 0)
	FilterBoxName.BackgroundColor3 = Color3.new(1, 1, 1)
	FilterBoxName.BackgroundTransparency = 1
	FilterBoxName.BorderColor3 = Color3.new(0, 0, 0)
	FilterBoxName.BorderSizePixel = 0
	FilterBoxName.Position = UDim2.new(1, 0, 0, 0)
	FilterBoxName.Size = UDim2.new(0.699999988, 0, 1, 0)
	FilterBoxName.ZIndex = 5004
	FilterBoxName.Font = Enum.Font.SourceSans
	FilterBoxName.Text = "Errors"
	FilterBoxName.TextColor3 = Color3.new(1, 1, 1)
	FilterBoxName.TextScaled = true
	FilterBoxName.TextSize = 14
	FilterBoxName.TextStrokeTransparency = 0
	FilterBoxName.TextWrapped = true

	BetterConsoleList.Name = "BetterConsoleList"
	BetterConsoleList.Parent = BetterConsole
	BetterConsoleList.Active = false
	BetterConsoleList.AnchorPoint = Vector2.new(0, 1)
	BetterConsoleList.BackgroundColor3 = Color3.new(1, 1, 1)
	BetterConsoleList.BackgroundTransparency = 1
	BetterConsoleList.BorderColor3 = Color3.new(0, 0, 0)
	BetterConsoleList.BorderSizePixel = 0
	BetterConsoleList.Position = UDim2.new(0, 0, 0.958246052, 0)
	BetterConsoleList.Size = UDim2.new(1, 0, 0.846379399, 0)
	BetterConsoleList.CanvasSize = UDim2.new(0, 0, 0, 0)
	BetterConsoleList.ZIndex = 5001
	BetterConsoleList.ElasticBehavior = Enum.ElasticBehavior.Always
	BetterConsoleList.ScrollingDirection = Enum.ScrollingDirection.Y
	BetterConsoleList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	BetterConsoleList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

	UIListLayout.Parent = BetterConsoleList
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	BetterConsoleTextEx.Name = "BetterConsole"
	BetterConsoleTextEx.Parent = nil
	BetterConsoleTextEx.AutoLocalize = false
	BetterConsoleTextEx.BackgroundColor3 = Color3.new(1, 1, 1)
	BetterConsoleTextEx.BackgroundTransparency = 1
	BetterConsoleTextEx.BorderColor3 = Color3.new(0, 0, 0)
	BetterConsoleTextEx.BorderSizePixel = 0
	BetterConsoleTextEx.Size = UDim2.new(1, 0, 0, 0)
	BetterConsoleTextEx.RichText = true
	BetterConsoleTextEx.AutomaticSize = Enum.AutomaticSize.Y
	BetterConsoleTextEx.ZIndex = 5001
	BetterConsoleTextEx.Font = Enum.Font.Arial
	BetterConsoleTextEx.Text = " <font color='rgb(200,50,50)'>[6:29:29 PM, Game]:</font> Random errorr occured!"
	BetterConsoleTextEx.TextColor3 = Color3.new(1, 1, 1)
	BetterConsoleTextEx.TextSize = 22
	BetterConsoleTextEx.TextStrokeTransparency = 0
	BetterConsoleTextEx.TextWrapped = true
	BetterConsoleTextEx.TextXAlignment = Enum.TextXAlignment.Left
	BetterConsoleTextEx:AddTag("RemoveOnDestroy")

	BetterConsoleDesc.Name = "BetterConsoleDesc"
	BetterConsoleDesc.Parent = BetterConsole
	BetterConsoleDesc.BackgroundColor3 = Color3.new(1, 1, 1)
	BetterConsoleDesc.BackgroundTransparency = 1
	BetterConsoleDesc.BorderColor3 = Color3.new(0, 0, 0)
	BetterConsoleDesc.BorderSizePixel = 0
	BetterConsoleDesc.Position = UDim2.new(0, 0, 0.958246052, 0)
	BetterConsoleDesc.Size = UDim2.new(1, 0, 0.0404888801, 0)
	BetterConsoleDesc.ZIndex = 5001
	BetterConsoleDesc.Font = Enum.Font.Arial
	BetterConsoleDesc.Text = "Press F9 or the mobile button to open/close"
	BetterConsoleDesc.TextColor3 = Color3.new(1, 1, 1)
	BetterConsoleDesc.TextScaled = true
	BetterConsoleDesc.TextSize = 14
	BetterConsoleDesc.TextStrokeTransparency = 0
	BetterConsoleDesc.TextWrapped = true

	BetterConsoleQuitButton.Name = "BetterConsoleQuitButton"
	BetterConsoleQuitButton.Parent = BetterConsole
	BetterConsoleQuitButton.AnchorPoint = Vector2.new(1, 0)
	BetterConsoleQuitButton.BackgroundColor3 = Color3.new(1, 1, 1)
	BetterConsoleQuitButton.BackgroundTransparency = 1
	BetterConsoleQuitButton.BorderColor3 = Color3.new(0, 0, 0)
	BetterConsoleQuitButton.BorderSizePixel = 0
	BetterConsoleQuitButton.Position = UDim2.new(1.017, 0, -0.03, 0)
	BetterConsoleQuitButton.Rotation = 0
	BetterConsoleQuitButton.Size = UDim2.new(0.052, 0, 0.1, 0)
	BetterConsoleQuitButton.ZIndex = 5001
	BetterConsoleQuitButton.Image = "rbxassetid://5100480132"
	BetterConsoleQuitButton.ScaleType = Enum.ScaleType.Fit

	Buttons.Name = "Buttons"
	Buttons.Parent = BetterConsole
	Buttons.BackgroundColor3 = Color3.new(1, 1, 1)
	Buttons.BackgroundTransparency = 1
	Buttons.BorderColor3 = Color3.new(0, 0, 0)
	Buttons.BorderSizePixel = 0
	Buttons.Position = UDim2.new(0.340734154, 0, -7.25641485e-08, 0)
	Buttons.Size = UDim2.new(0.224543512, 0, 0.0500000007, 0)
	Buttons.ZIndex = 5002

	UIGridLayout_2.Parent = Buttons
	UIGridLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout_2.CellPadding = UDim2.new(0, 0, 0, 0)
	UIGridLayout_2.CellSize = UDim2.new(0.333333343, 0, 1, 0)

	Clear.Name = "Clear"
	Clear.Parent = Buttons
	Clear.BackgroundColor3 = Color3.new(1, 0, 0)
	Clear.BorderColor3 = Color3.new(0, 0, 0)
	Clear.BorderSizePixel = 0
	Clear.Size = UDim2.new(0, 200, 0, 50)
	Clear.ZIndex = 5001
	Clear.Font = Enum.Font.Arial
	Clear.Text = "Clear"
	Clear.TextColor3 = Color3.new(1, 1, 1)
	Clear.TextScaled = true
	Clear.TextSize = 14
	Clear.TextStrokeTransparency = 0
	Clear.TextWrapped = true
	UIStroke:Clone().Parent=Clear
	UICorner:Clone().Parent=Clear

	Bottom.Name = "Bottom"
	Bottom.Parent = Buttons
	Bottom.BackgroundColor3 = Color3.new(0, 0.533333, 1)
	Bottom.BorderColor3 = Color3.new(0, 0, 0)
	Bottom.BorderSizePixel = 0
	Bottom.LayoutOrder = 1
	Bottom.Size = UDim2.new(0, 200, 0, 50)
	Bottom.ZIndex = 5001
	Bottom.Font = Enum.Font.Arial
	Bottom.Text = "Bottom"
	Bottom.TextColor3 = Color3.new(1, 1, 1)
	Bottom.TextScaled = true
	Bottom.TextSize = 14
	Bottom.TextStrokeTransparency = 0
	Bottom.TextWrapped = true
	UIStroke:Clone().Parent=Bottom
	UICorner:Clone().Parent=Bottom

	Top.Name = "Top"
	Top.Parent = Buttons
	Top.BackgroundColor3 = Color3.new(0.0156863, 1, 0)
	Top.BorderColor3 = Color3.new(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.LayoutOrder = 2
	Top.Size = UDim2.new(0, 200, 0, 50)
	Top.ZIndex = 5001
	Top.Font = Enum.Font.Arial
	Top.Text = "Top"
	Top.TextColor3 = Color3.new(1, 1, 1)
	Top.TextScaled = true
	Top.TextSize = 14
	Top.TextStrokeTransparency = 0
	Top.TextWrapped = true
	UIStroke:Clone().Parent=Top
	UICorner:Clone().Parent=Top

	--CODING FOR BETTER CONSOLE:

	local allMessages, visibleMessages = 0, 0
	local isSorted = false
	local wasMainFrameVisible 
	local function BetterConsoleFrameToggle(_,inputState)
		if inputState == Enum.UserInputState.Begin then
			local newVisible = not BetterConsole.Visible
			BetterConsole.Visible = newVisible
			if newVisible then
				wasMainFrameVisible = Main.Visible
				Main.Visible = false
			elseif wasMainFrameVisible then
				Main.Visible = true
			end
		end
	end
	CAS:BindActionAtPriority("OpenBetterConsole"..C.saveIndex,BetterConsoleFrameToggle,true,1e4,Enum.KeyCode.M)
	CAS:SetImage("OpenBetterConsole"..C.saveIndex,"rbxassetid://12350781258")
	CAS:SetTitle("OpenBetterConsole"..C.saveIndex,"")
	table.insert(C.functs,BetterConsoleQuitButton.MouseButton1Up:Connect(function()
		BetterConsoleFrameToggle("OpenBetterConsole"..C.saveIndex,Enum.UserInputState.Begin)
	end))
	local MessageTypeSettings = {
		[Enum.MessageType.MessageOutput.Name] = {Color='<font color="rgb(170,170,170)">',Layout=0,Active=true},
		[Enum.MessageType.MessageInfo.Name] = {Color='<font color="rgb(255,0,255)">',Layout=1,Active=true},
		[Enum.MessageType.MessageWarning.Name] = {Color='<font color="rgb(255,255,0)">',Layout=2,Active=true},
		[Enum.MessageType.MessageError.Name] = {Color='<font color="rgb(255,0,0)">',Layout=3,Active=true},
		["FromGMEGame"] = {Color="<font color='rgb(70,70,170)'>",Layout=4,Active=false},
	}
	local noMessagesFound = BetterConsoleTextEx:Clone()
	noMessagesFound.RichText = false
	noMessagesFound.TextXAlignment = Enum.TextXAlignment.Center
	noMessagesFound.Parent = script
	noMessagesFound:AddTag("RemoveOnDestroy")
	local function BetterConsole_SetMessagesVisibility(_,MessageLabel)
		if not MessageLabel then
			visibleMessages = 0
		end
		noMessagesFound.Parent = script
		local currentText = SearchConsoleTextBox.Text:lower()
		local includeALL = currentText=="" or currentText == " " or currentText:sub(1,1)=="/"
		isSorted = not includeALL
		for num, object in ipairs((MessageLabel and {MessageLabel} or BetterConsoleList:GetChildren())) do
			if object:IsA("TextLabel") and object ~= noMessagesFound then
				local theirText=object:GetAttribute("OrgText")
				local willBeVisible = includeALL or theirText:lower():find(currentText)
				willBeVisible = willBeVisible and MessageTypeSettings[object:GetAttribute("Type")].Active
					and (not object:GetAttribute("IsGame") or MessageTypeSettings.FromGMEGame.Active)
				if willBeVisible then
					if includeALL then
						object.Text = theirText 

					else
						local lastChars = ""
						local newText = ""
						local canReplace = true
						for s = 1, theirText:len(),1 do
							local char = theirText:sub(s,s)
							if char=="<" then
								canReplace = false
							elseif char == ">" then
								canReplace = true
							end
							local combined = lastChars..char
							if combined:lower() == currentText:sub(1,combined:len()) and canReplace then
								lastChars = combined
								if combined:lower() == currentText then
									newText..='<stroke color="#00A2FF" joins="miter" thickness="1" transparency="0">'..combined.."</stroke>"
									lastChars=""
								end
							else
								newText..=combined
								lastChars = ""
							end
						end
						object.Text=newText
						willBeVisible = newText ~= theirText--make sure we found an ACTUAL occurance!
					end
				end
				object.Visible = willBeVisible
				if willBeVisible then
					visibleMessages += 1
				end
			end
		end
		BetterConsoleList:TweenSize(includeALL and UDim2.fromScale(1,.9) or UDim2.fromScale(1,.846),"Out","Quad",.6,true)
		SearchConsoleResults.Text = includeALL and "" or '<font color="rgb(0,255,0)">'..comma_value(visibleMessages) ..'</font> search results for found "'..currentText..'"'
		if visibleMessages==0 then
			if allMessages > 0 then
				noMessagesFound.Text = "No Messages Found!"
				noMessagesFound.TextColor3 = Color3.fromRGB(200,50,50)
			else
				noMessagesFound.Text = "No Messages Yet!"
				noMessagesFound.TextColor3 = Color3.fromRGB(50,50,200)
			end
			noMessagesFound.Parent = BetterConsoleList
			noMessagesFound.Visible = true
		else
			noMessagesFound.Parent = HackGUI
			noMessagesFound.Visible = false
		end
		UIListLayout.VerticalAlignment = visibleMessages==0 and Enum.VerticalAlignment.Center or Enum.VerticalAlignment.Top
	end
	for messageType, messageData in pairs(MessageTypeSettings) do
		local BoxFrame = BetterConsoleFilterBox:Clone()
		BoxFrame:WaitForChild("FilterBoxName").Text = messageType:sub(8)
		local R, G, B = table.unpack(messageData.Color:sub(messageData.Color:find("%(")+1,messageData.Color:find("%)")-1):split(","))
		BoxFrame:WaitForChild("FilterBoxName").TextColor3 = Color3.fromRGB(tonumber(R),tonumber(G),tonumber(B))
		BoxFrame.LayoutOrder = messageData.Layout
		local tweenInstance
		local updImage = BoxFrame:WaitForChild("CheckboxImage")
		local function update()
			if tweenInstance and tweenInstance.PlaybackState == Enum.PlaybackState.Playing then
				tweenInstance:Cancel()
				tweenInstance:Destroy()
			end
			local active = messageData.Active
			local tweenObj = TweenInfo.new(.5)
			local myTweenInstance = TS:Create(updImage,tweenObj,{ImageColor3=(active and Color3.fromRGB(13,255) or Color3.fromRGB(255,13))})
			tweenInstance = myTweenInstance
			task.delay(.2,function()
				if myTweenInstance ~= tweenInstance then
					return
				end
				if active then
					updImage.Image = "rbxassetid://4458804262"
				else
					updImage.Image = "rbxassetid://4458801905"
				end
			end)
			tweenInstance:AddTag("RemoveOnDestroy")
			tweenInstance:Play()
		end
		table.insert(C.functs,BoxFrame:WaitForChild("InviClicker").MouseButton1Up:Connect(function()
			messageData.Active = not messageData.Active
			update()
			BetterConsole_SetMessagesVisibility()
		end))
		update()
		BoxFrame.Parent = FilterCheckBoxes
	end
	table.insert(C.functs,SearchConsoleTextBox:GetPropertyChangedSignal("Text"):Connect(BetterConsole_SetMessagesVisibility))
	function BetterConsole_ClearConsoleFunction()
		allMessages, visibleMessages = 0, 0
		for num, object in ipairs(BetterConsoleList:GetChildren()) do
			if object:IsA("TextLabel") and object ~= noMessagesFound then
				object:Destroy()
			end
		end
		BetterConsole_SetMessagesVisibility()
	end
	local BetterConsole_TweenList
	local function BetterConsole_DoCmd(msg,instant)
		if msg == "/clear" then
			C.AvailableHacks.Commands[2].ActivateFunction(true)
			task.spawn(function()
				--delay this!
				SearchConsoleTextBox.Text = ""
			end)
		elseif msg=="/top" or msg=="/bottom" then
			if BetterConsole_TweenList and BetterConsole_TweenList.PlaybackState == Enum.PlaybackState then
				BetterConsole_TweenList:Cancel()
				BetterConsole_TweenList:Destroy()
			end
			local targetPosition = msg=="/top" and Vector2.new(0,0) 
				or Vector2.new(0,math.max(0,BetterConsoleList.AbsoluteCanvasSize.Y - BetterConsoleList.AbsoluteWindowSize.Y+10))
			if instant then
				BetterConsoleList.CanvasPosition = targetPosition
			else
				local duration = math.clamp(math.abs(targetPosition.Y - BetterConsoleList.CanvasPosition.Y)/1200,.2,1)
				BetterConsole_TweenList = TS:Create(BetterConsoleList,TweenInfo.new(duration),{["CanvasPosition"] = targetPosition})
				BetterConsole_TweenList:Play()
			end
		end
	end
	table.insert(C.functs,SearchConsoleTextBox.FocusLost:Connect(function(enterPressed)
		local currentText = SearchConsoleTextBox.Text
		if enterPressed then
			BetterConsole_DoCmd(currentText:lower())
		end
	end))
	table.insert(C.functs,Clear.MouseButton1Up:Connect(function()
		BetterConsole_DoCmd("/clear")
	end))
	table.insert(C.functs,Top.MouseButton1Up:Connect(function()
		BetterConsole_DoCmd("/top")
	end))
	table.insert(C.functs,Bottom.MouseButton1Up:Connect(function()
		BetterConsole_DoCmd("/bottom")
	end))
	--if isStudio then
	--CHECKCALLER is not working correctly, so we'll take over from here
	local BetterConsole_CheckCaller_MsgStart = {"TextScraper text too long: ","Failed to load sound ",
		"Font family ","Preloaded game image: ","load size ","HTTP error ","Unhandled Promise rejection:"
	}
	local BetterConsole_CheckCaller_MsgEnd = {" Died"}
	local BetterConsole_CheckCaller_MsgExact = {"local beast power script destroyed","Playing Announcements","not Playing Announcements",
		"ContextActionService could not find the function passed in, doing nothing.","beast landed","Power Activated","Power Recharge","Power Recharge Done"
	}
	local function checkmycaller(msg)
		for _, text in ipairs(BetterConsole_CheckCaller_MsgExact) do
			if text==msg then
				return false
			end
		end
		for _, text in ipairs(BetterConsole_CheckCaller_MsgStart) do
			if msg:sub(1,text:len()) == text then
				return false
			end
		end
		for _, text in ipairs(BetterConsole_CheckCaller_MsgEnd) do
			if msg:sub(msg:len()-text:len()+1) == text then
				return false
			end
		end
		return isStudio or checkcaller()
	end
	--end
	local function printFunction(message,messageType,isFromMe)
		allMessages += 1
		local wasAtBottom =  BetterConsoleList.CanvasPosition.Y+40 >= BetterConsoleList.AbsoluteCanvasSize.Y - BetterConsoleList.AbsoluteWindowSize.Y
		local MessageLabel = BetterConsoleTextEx:Clone()
		if not isFromMe then
			MessageLabel:SetAttribute("IsGame",true)
		end
		MessageLabel:SetAttribute("Type",messageType.Name)
		MessageLabel:SetAttribute("OrgText",message)
		MessageLabel.Text = message
		MessageLabel.LayoutOrder = allMessages
		MessageLabel.Name = allMessages
		MessageLabel.Parent = BetterConsoleList
		BetterConsole_SetMessagesVisibility(nil,MessageLabel)
		if wasAtBottom then
			BetterConsole_DoCmd("/bottom",true)
		end
	end
	local escapeCharacters = {
		["<"] = "&lt;",
		[">"] = "&gt;",
		['"'] = "&quot;",
		["'"] = "&apos;",
		["&"] = "&amp;"
	}
	local function formatMessage(message,messageType,isFromMe,customTime)
		if not message:find("</") or not message:find(">") then -- Check to see if it is rich text formatted!
			for toReplace,escapedStr in pairs(escapeCharacters) do
				message = message:gsub(toReplace,escapedStr)
			end
		end
		local dateTime = (customTime and DateTime.fromUnixTimestamp(customTime) or DateTime.now())
		printFunction(message:format(dateTime:FormatLocalTime("LTS","en-us"):gsub(" AM",""):gsub(" PM", "")),messageType,isFromMe)
	end

	local function onMessageOut(message, messageType,...)
		local myMessageColor = MessageTypeSettings[messageType.Name].Color
		local isFromMe = checkmycaller(message)
		local inputMessage = "  "..myMessageColor .. "[%s"
			.. " ".. messageType.Name:sub(8).. (isFromMe and "" or ("</font>"..MessageTypeSettings.FromGMEGame.Color.." Game</font>"..myMessageColor))
			.."] ".. "</font>" .. (message:sub(1,1)==":" and "Custom" or "") .. message
		formatMessage(inputMessage,messageType,isFromMe,...)
	end
	table.insert(C.functs,LS.MessageOut:Connect(onMessageOut))
	local logSuccess,logResult = pcall(LS.GetLogHistory,LS)
	if logSuccess then
		for _, logData in ipairs(logResult) do
			task.spawn(onMessageOut,logData.message,logData.messageType,logData.timestamp)
		end
	else
		onMessageOut("LogService:GetLogHistory has failed: "..tostring(logResult),Enum.MessageType.MessageError)
	end
end
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
	C.ToggleTag = Instance.new("BillboardGui");
	local ToggleButton = Instance.new("TextButton");
	C.TestPart = Instance.new("Part");
	C.TestPart.Parent = RS;
	XPGained = Instance.new("TextLabel");
	CreditsGained = Instance.new("TextLabel");
	ServerXPGained = Instance.new("TextLabel");
	ServerCreditsGained = Instance.new("TextLabel");
	C.Console = Instance.new("ScrollingFrame");
	local UIListLayout2 = Instance.new("UIListLayout");
	C.ConsoleButton = Instance.new("ImageButton");
	C.CommandBarLine = Instance.new("TextLabel");

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
	MyTextBox.Font = textFont;
	MyTextBox.Text = "0";
	MyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
	MyTextBox.TextScaled = true;
	MyTextBox.TextSize = 14.000;
	MyTextBox.TextStrokeTransparency = 0.000;
	MyTextBox.TextWrapped = true;
	MyTextBox.ClearTextOnFocus = false;
	MyTextBox.Parent = ExTextBox;


	MainListEx.Name = "MainListEx";
	MainListEx.BackgroundTransparency = 1;
	MainListEx.Size = UDim2.new(1, 0, 0, 25);
	MainListEx.Font = textFont;
	MainListEx.TextStrokeColor3 = Color3.fromRGB();
	MainListEx.TextStrokeTransparency = 0
	MainListEx.TextScaled = true;
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

	C.ToggleTag.Name = "C.ToggleTag"
	TextBoxExamples["C.ToggleTag"] = C.ToggleTag
	C.ToggleTag["Active"] = true
	C.ToggleTag.AlwaysOnTop = true
	C.ToggleTag.Enabled = false	
	C.ToggleTag.LightInfluence = 1.000
	C.ToggleTag.Size = UDim2.new(1, 30, 0.75, 10)
	C.ToggleTag.ExtentsOffsetWorldSpace = Vector3.new(0, 4, 0)

	ToggleButton.Name = "Toggle"
	ToggleButton.Parent = C.ToggleTag
	ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	ToggleButton.Size = UDim2.new(1, 0, 1, 0)
	ToggleButton.Font = textFont
	ToggleButton.Text = "Close"
	ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	ToggleButton.TextScaled = true
	ToggleButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	ToggleButton.TextStrokeTransparency = 0
	ToggleButton.TextWrapped = true

	C.TestPart.Size=Vector3.new(1.15,1.15,1.15)
	C.TestPart.BrickColor=BrickColor.Red()
	C.TestPart.Anchored=true
	C.TestPart.CanCollide=false
	C.TestPart.Transparency=.35

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

	C.Console.Name = "C.Console"
	C.Console.Parent = Main
	C.Console.AutomaticCanvasSize = Enum.AutomaticSize.Y
	C.Console.ScrollingDirection = Enum.ScrollingDirection.Y
	C.Console.BackgroundColor3 = Color3.new(0.203922, 0.203922, 0.203922)
	C.Console.BackgroundTransparency = 1
	C.Console.ZIndex=(mainZIndex + 100)
	C.Console.Position = UDim2.new(0.290841579, 0, 0, 0)
	C.Console.Size = UDim2.new(0.709158421, 0, 1, 0)
	C.Console.CanvasSize = UDim2.new(0, 0, 0, 0)

	UIListLayout2.Parent = C.Console
	UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Top
	UIListLayout2.Padding = UDim.new(0, 3)

	C.ConsoleButton.Name = "C.ConsoleButton"
	C.ConsoleButton.Parent = Main
	C.ConsoleButton.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
	C.ConsoleButton.BackgroundTransparency = 1
	C.ConsoleButton.BorderColor3 = Color3.new(0, 0, 0)
	C.ConsoleButton.BorderSizePixel = 0
	C.ConsoleButton.Position = UDim2.new(0.916, 0, .9, 0)
	C.ConsoleButton.Size = UDim2.new(0.0818077475, 0, 0.10969051, 0)
	C.ConsoleButton.ZIndex = (mainZIndex + 9)
	C.ConsoleButton.Visible = false
	C.ConsoleButton.Image = "rbxassetid://12350781258"
	C.ConsoleButton.ScaleType = Enum.ScaleType.Fit

	C.CommandBarLine.Name = "C.CommandBarLine"
	TextBoxExamples["C.CommandBarLine"] = C.CommandBarLine
	C.CommandBarLine.BackgroundColor3 = Color3.new(1, 1, 1)
	C.CommandBarLine.BackgroundTransparency = 1
	C.CommandBarLine.LayoutOrder = 1
	C.CommandBarLine.Size = UDim2.new(1, 0, 0, 0)
	C.CommandBarLine.ZIndex = (mainZIndex + 1)
	C.CommandBarLine.Font = textFont
	C.CommandBarLine.AutomaticSize = Enum.AutomaticSize.Y
	C.CommandBarLine.TextColor3 = Color3.new(1, 1, 1)
	C.CommandBarLine.TextSize = 14
	C.CommandBarLine.TextStrokeTransparency = 0
	C.CommandBarLine.TextXAlignment = Enum.TextXAlignment.Left
	C.CommandBarLine.RichText = true
	C.CommandBarLine.TextWrapped = true

	StartBetterConsole()
end

--BIGGIE FUNCTIONS
local TPStack = {}
local isTeleporting = false

local function teleport_module_teleportQueue()
	if isTeleporting then return end isTeleporting = true
	while #TPStack>0 and isTeleporting do
		local currentTP = TPStack[1]
		if os.clock()-(plr:GetAttribute("LastTP") or 0) >= minTimeBetweenTeleport then
			local teleportPart = C.char.PrimaryPart or 
				(human.RigType == Enum.HumanoidRigType.R6 and C.char:FindFirstChild("Torso"))
				or (human.RigType == Enum.HumanoidRigType.R15 and C.char:FindFirstChild("UpperTorso"))
			if C.char.PrimaryPart then
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
end--]]
local function isInGame(theirChar,noDefactoAllowed)
	--[[local a=Vector3.new(410.495, 59.4767, -197.00)
	local b=Vector3.new(-54.505, 59.4767, -547.007)
	return (point.X >= a.X and point.X <= b.X) and (point.Z >= a.Z and point.Z <= b.Z)--]]
	if theirChar~=nil and
		theirChar:FindFirstChild("Hammer")~=nil or (C.Map~=nil and C.Map:IsAncestorOf(theirChar)) then
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
	if TSM.Health.Value>0
		or (not noDefactoAllowed and theirChar.PrimaryPart and 
			(theirChar:GetPivot().Position-workspace.MapBackgroundMusicBox.Position).Magnitude 
			< (theirChar:GetPivot().Position-workspace.LobbyMusicBox.Position).Magnitude
			and (theirChar:GetPivot().Position-workspace.MapBackgroundMusicBox.Position).Magnitude 
			< (theirChar:GetPivot().Position-workspace.BeastCaveMusicBox.Position).Magnitude) then
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
local oldWarn = warn
local oldPrint = print
local function warn(...)
	oldWarn(recurseLoopPrint({...},"",0))
end
local function print(...)
	oldPrint(recurseLoopPrint({...},"",0))
end
local RemoteEvent
if gameUniverse=="Flee" then
	RemoteEvent = RS:WaitForChild("RemoteEvent")
end
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
	local newPart=C.TestPart:Clone()
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
function comma_value(amount)
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
local function clearCommandLines()
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
	local currentEvent = myTSM and myTSM:WaitForChild("ActionEvent").Value
	local beforeEn,afterEn
	for num,trigger in ipairs(CS:GetTagged("Trigger")) do
		if trigger and trigger:IsA("BasePart") and workspace:IsAncestorOf(trigger) then
			local triggerParent = trigger.Parent
			if triggerParent then
				local triggerType = trigger_gettype(triggerParent)
				assert(triggerType,"Unknown Trigger Type: "..trigger:GetFullName())
				local enabled = name=="Override" or trigger_params[triggerType]<=(triggerParent:GetAttribute("Trigger_AllowException") or 0)
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

			end
		end
	end
	if currentEvent then
		if beforeEn and not afterEn then
			--myTSM.ActionInput.Value = false
			--myTSM.ActionEvent.Value = nil
			task.spawn(stopCurrentAction)
		end
	end
end


function stopCurrentAction(override)
	if not override and myTSM.ActionEvent.Value and myTSM.ActionEvent.Value.Parent and 
		(trigger_params[trigger_gettype(myTSM.ActionEvent.Value.Parent.Parent)] or -1) > 0 then
		return
	end
	for s = 2, 1, -1 do
		RemoteEvent:FireServer("Input", "Action", false)
		RemoteEvent:FireServer("Input", "Trigger", false)
		myTSM:WaitForChild("DisableInteraction").Value = true
		RunS.RenderStepped:Wait()
		myTSM:WaitForChild("DisableInteraction").Value = false
		RunS.RenderStepped:Wait()
	end
end

--SAVE/LOAD MODULE
local loadedEnData = {}
local function loadSaveData()
	if isStudio then return end
	local path = getID.."/enHacks/"..gameName..".txt"
	if isfile(path) then
		local success, result = pcall(readfile,path)
		if success then
			local success2, result2 = pcall(HS.JSONDecode,HS,result)
			if success2 then
				loadedEnData = result2
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
	writefile(getID.."/enHacks/"..gameName..".txt",result)
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

	function tableSortFunction(a,b)
		local aStats=a:FindFirstChild("SavedPlayerStatsModule")
		local bStats=b:FindFirstChild("SavedPlayerStatsModule")
		local doesExistA, doesExistB = aStats and aStats.Parent, bStats and bStats.Parent
		if not doesExistA or not doesExistB then
			return doesExistA and not doesExistB
		end
		local isABot=myBots[a.Name:lower()]
		local isBBot=myBots[b.Name:lower()]
		if isABot~=isBBot then
			return true
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
		if (aStats.Credits.Value ~= bStats.Credits.Value) then
			return (aStats.Credits.Value>bStats.Credits.Value)
		end
		return a.Name:lower() > b.Name:lower()
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
		visualWaypointClone.Parent = C.char
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
	C.AvailableHacks.Bot[20].Funct(self, arg1)
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
				if not C.AvailableHacks.Bot[15].UnlockDoor(false) and not C.AvailableHacks.Bot[15].CrawlVent(false) then
					self._agent.Humanoid:MoveTo(self._agent.PrimaryPart.CFrame*Vector3.new(0,0,1.35));
					task.wait((0.1));
					setJumpState(self);
					declareError(self, self.ErrorType.AgentStuck);
				end;
			end;
			return;
		end;
		local inputTbl = {C.Map};
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
	if not C.AvailableHacks.Beast[2].IsCrawling then
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
	local excludeRaycastTable = ({"Exclude",nil,nil,C.char,C.Beast})
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
	if C.AvailableHacks.Bot[15].AvoidParts[1]~=nil and C.Beast~=nil and C.Beast:FindFirstChild("Torso")~=nil then
		if not myBots[C.Beast.Name:lower()] then
			C.AvailableHacks.Bot[15].AvoidParts[1].Position=(C.Beast.Torso.Position)
		end
	end
	task.spawn(C.AvailableHacks.Bot[15].UnlockDoor)
	local function mtf(...)
		moveToFinished(self, ...)
	end
	self._moveConnection = self._humanoid and (self._moveConnection or self._humanoid.MoveToFinished:Connect(mtf))

	--Begin pathfinding
	if self._humanoid then
		--self._humanoid:MoveTo(self._waypoints[self._currentWaypoint].Position)
		if self._waypoints[self._currentWaypoint] then
			C.AvailableHacks.Bot[20].Funct(self,self._waypoints[self._currentWaypoint].Position)
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

	local ClubConnections = C.AvailableHacks.Utility[8].ClubFuncts
	local ShowFreezeConnections = C.AvailableHacks.Utility[8].ShowFreezeConnections

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
		for s = #C.AvailableHacks.Utility[8].ShowFreezeConnections, 1, -1 do
			local funct = C.AvailableHacks.Utility[8].ShowFreezeConnections[s]
			if funct then
				funct:Disconnect()
			end
			table.remove(C.AvailableHacks.Utility[8].ShowFreezeConnections,s)
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
		if not v23.Parent or not v23:FindFirstChild("Head") then return end
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
				--print(v182)
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
	local LArm = C.char:FindFirstChild("Left Arm")
	local RArm = C.char:FindFirstChild("Right Arm")
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
		v24.CameraMode = Enum.CameraMode.Classic
	end))
	if (C.enHacks.Util_CanZoom==false) then
		v24.CameraMode = Enum.CameraMode.LockFirstPerson
	end
	v19:WaitForChild("SoundHeartBeat").Volume = 0
	v19:WaitForChild("SoundChaseMusic").Volume = 0
	v48:Play(0.100000001, 1, 0.5)
	carriedTorsoChangedFunction()
end

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
human=C.char:WaitForChild("Humanoid")
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
	if not C.objectFuncts[object] then
		C.objectFuncts[object] = {};
	end
	if C.objectFuncts[object][value]~=nil then
		C.objectFuncts[object][value]:Disconnect();
		C.objectFuncts[object][value] = nil;
	end
	if funct~=nil and funct~=false then
		if value=="Value" and object:IsA("ValueBase") then
			C.objectFuncts[object][value] = object.Changed:Connect(funct);
		else

			C.objectFuncts[object][value] = object:GetPropertyChangedSignal(value):Connect(funct);
		end
	else
		C.objectFuncts[object][value]=nil;
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
				local Head=theirChar:WaitForChild("Head",1e5) 
				if not Head then
					return
				end
				local newTag=NameTagEx:Clone()
				newTag.Username.Text=theirPlr.Name
				newTag.Distance.Visible=C.enHacks.ESP_Distance
				newTag.Parent=Head
				newTag.Enabled=C.enHacks.ESP_Players
				theirChar.Humanoid.DisplayDistanceType=(C.enHacks.ESP_Players and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer)
				CS:AddTag(newTag,"HackDisplays")
				CS:AddTag(newTag,"RemoveOnDestroy")
				local function childChanged(child)
					if not newTag:FindFirstChild("Username") then
						return
					end
					newTag.Username.TextColor3=(theirChar:FindFirstChild("Hammer")~=nil and newColor3(255) or newColor3(0,0,255))
				end
				table.insert(C.playerEvents[theirPlr.UserId],(theirChar.ChildAdded:Connect(childChanged)))
				table.insert(C.playerEvents[theirPlr.UserId],(theirChar.ChildRemoved:Connect(childChanged)))
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
						if isInGame(NameTag.Parent.Parent)==isInGame(camera.CameraSubject.Parent) then
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
				NameTag.Distance.Visible=C.enHacks.ESP_Distance
				C.AvailableHacks.Render[2].UpdateDistFunct(NameTag,Head)
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
				if not C.objectFuncts[computerTable] then
					C.objectFuncts[computerTable] = {};
				end
				local primPart,Screen=computerTable.PrimaryPart,computerTable:FindFirstChild("Screen",true);
				local newTag=NameTagEx:Clone();
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
				--if not C.enHacks.ESP_Highlight then
				changeVisibility(robloxHighlight,1)	--changeRenderVisibility(theirViewportChar,1)
				--end
				local key
				delay(.25,function()
					C.objectFuncts[theirChar]=C.objectFuncts[theirChar] or {}
					while not isCleared and theirChar~=nil and theirChar.Parent~=nil do
						--if C.enHacks.ESP_Highlight then
						--key=#C.objectFuncts[theirChar]+1
						while C.enHacks.ESP_Highlight and nameTag.Parent~=nil and nameTag.Parent.Parent~=nil and not isCleared do--table.insert(C.objectFuncts[theirChar],key,RunS.RenderStepped:Connect(function(dt)
							if (Head.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance and (({isInGame(theirChar)})[1])==({isInGame(camera.CameraSubject.Parent)})[1] then
								--local didHit,instance=true,theirChar.PrimaryPart
								local didHit,instance=raycast(camera.CFrame.p, Head.Position, {"Blacklist",camera.CameraSubject.Parent}, 100, 0.001)
								changeVisibility(robloxHighlight,(didHit and theirChar:IsAncestorOf(instance)) and 1 or 0,(C.Beast==theirChar and newColor3(255) or newColor3(0,0,255)))--changeRenderVisibility(theirViewportChar,(didHit and theirChar:IsAncestorOf(instance)) and 1 or 0, (theirChar:FindFirstChild("Hammer")==nil and newColor3(0,0,255) or newColor3(255)))
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
				local VPF=HackGUI:FindFirstChild("ViewportFrame")
				if VPF~=nil then
					VPF.Visible=newValue
				end
			end,
			["CleanUp"]=function()
				--[[if isCleared then return end
				for num, computerElement in pairs(HackGUI:GetChildren()) do
					if string.sub(computerElement.Name,1,13)=="ComputerTable" then
						DestroyInstance(computerElement)
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
					while not isCleared and Computer~=nil and Computer.Parent~=nil do
						while C.enHacks.ESP_PCHighlight and not isCleared do
							if (((primPart.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance) and isInGame(camera.CameraSubject.Parent)) then
								local didHit = false
								local instance = primPart
								if (C.Map~=nil and Screen~=nil) then    
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
					nameTag.ExpandingBar.Visible=(C.enHacks.ESP_PlayerProg and ActionProgress.Value~=0 and TSM.CurrentAnimation.Value~="Typing")
					if TSM.CurrentAnimation.Value=="Typing" then
						C.AvailableHacks.Render[7].RefreshBar(theirPlr,Head,ActionProgress)
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
				if (closestPC~=nil) then
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
				local progress=PC:GetAttribute("Progress")
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
					local Head=theirChar:FindFirstChild("Head")
					if Head==nil then
						return
					end
					if TSM.CurrentAnimation.Value=="Typing" then
						--lastEvent = ActionEvent.Value or lastEvent
						C.AvailableHacks.Render[7].RefreshBar(plr,Head,ActionProgress,ActionEvent.Value)
					end
					--[[local function SetMiniGameResultFunction()
						for s=1,1,-1 do
							if not C.enHacks.Util_AutoHack then
								return
							end
							RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
							task.wait((0.05))
						end
					end
					task.spawn(SetMiniGameResultFunction)--]]
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
				setChangedAttribute(plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("Ragdoll"),"Value",newValue and 
					C.AvailableHacks.Blatant[4].EnableScript or false)
				if newValue then
					spawn(C.AvailableHacks.Blatant[4].EnableScript)
				end
			end,
		},--]]
		[10]={
			["Type"]="ExTextButton",
			["Title"]="Auto Close",
			["Desc"]="Instantly close doors!",
			["Shortcut"]="AutoDoorClose",
			["CloseDoor"]=function(Trigger)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local ActionEventVal=TSM:WaitForChild("ActionEvent") 
				local CurrentActionEvent=ActionEventVal.Value
				RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
				task.wait()
				RemoteEvent:FireServer("Input", "Action", true)
				RemoteEvent:FireServer("Input", "Trigger", false, Trigger.Event)
				ActionEventVal.Value=nil
				while Trigger.ActionSign.Value~=10 do--wait for it to be opened
					Trigger.ActionSign.Changed:Wait()
				end
				for s=5,1,-1 do
					if Trigger.ActionSign.Value==11 then
						break
					end
					RemoteEvent:FireServer("Trigger", "Input", true, Trigger.Event)
					RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
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
				setChangedAttribute(plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("ActionInput"),"Value",(newValue and C.AvailableHacks.Blatant[10].EnableScript or false))
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
				local modifier=door:WaitForChild("WalkThru",20)
				if modifier~=nil then
					modifier.PathfindingModifier.Label = ((currentSign==10 or currentSign==12) and "DoorPath" or "DoorOpened")
				end
			end,
			["ActivateFunction"]=function(newValue)
				local isInGame=isInGame(camera.CameraSubject.Parent)
				local hackDisplayList = CS:GetTagged("HackDisplay2")
				for num,tag in ipairs(hackDisplayList) do
					tag.Enabled=newValue and camera.CameraType==Enum.CameraType.Custom and isInGame
				end
			end,
			["CleanUp"]=function()
				DestroyAllTaggedObjects("HackDisplay2")
				C.AvailableHacks.Blatant[15].DoorFuncts = {}
			end,
			["UpdateDisplays"]=function()
				C.AvailableHacks.Blatant[15].ActivateFunction(C.enHacks.RemotelyOpenDoors)
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				table.insert(C.functs,RS:WaitForChild("AnnouncementEvent").OnClientEvent:Connect(function(...)
					--print(...)
					if not ... then
						C.AvailableHacks.Blatant[15].UpdateDisplays()
						C.AvailableHacks.Blatant[20].UpdateDisplays()
					end
				end))--]]
				local function updateDisplays()
					C.AvailableHacks.Blatant[15].UpdateDisplays()
					C.AvailableHacks.Blatant[20].UpdateDisplays()
				end
				setChangedAttribute(RS.IsGameActive,"Value",updateDisplays)
				setChangedAttribute(camera,"CameraSubject",updateDisplays)
				setChangedAttribute(TSM:WaitForChild("Escaped"),"Value",updateDisplays)
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
				local newTag=C.ToggleTag:Clone()
				local isInGame=isInGame(workspace.Camera.CameraSubject.Parent)
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
					trigger_setTriggers("RemoteDoorControl",false)
					for s=5,1,-1 do
						if isOpened~=getState() or not doorTriggerEvent or not doorTriggerEvent.Parent or (saveActionSign ~= actionSign.Value and actionSign.Value ~= 0) then
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
					if currentEvent~=nil and not isOpened and false then--and saveActionSign == actionSign.Value then
						RS.RemoteEvent:FireServer("Input", "Trigger", true, currentEvent)
						--wait()
						--RemoteEvent:FireServer("Input", "Action", true)
					end
				end
				C.AvailableHacks.Blatant[15].DoorFuncts[door] = setToggleFunction
				newTag.Toggle.MouseButton1Up:Connect(setToggleFunction)
				C.AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				newTag.Enabled=(C.enHacks.RemotelyOpenDoors and (camera.CameraType==Enum.CameraType.Custom and isInGame))
				local function actionSignChangedFunct()
					C.AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				end
				setChangedAttribute(actionSign,"Value", (actionSignChangedFunct))
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
						while not saveDoorFunct and C.AvailableHacks.Blatant[18].SaveDeb == saveDeb and C.Map and human and human.Parent and human.Health>0
							and not isCleared do
							RunS.RenderStepped:Wait()
							saveDoorFunct = C.AvailableHacks.Blatant[15].DoorFuncts[door]
						end
						if C.AvailableHacks.Blatant[18].SaveDeb ~= saveDeb or isCleared then
							return
						end
						local actionSign = StringWaitForChild(door,"DoorTrigger.ActionSign")
						local function updateFunct()
							if isCleared or actionSign.Value == 0 then
								return
							end
							if (C.enHacks.Blatant_KeepDoorsOpen and actionSign.Value == 10) or (C.enHacks.Blatant_KeepDoorsClosed and actionSign.Value == 11) then
								saveDoorFunct()
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
		[20]={
			["Type"]="ExTextButton",
			["Title"]="Remote Computers and Freezing Pods",
			["Desc"]="Remotely Hack Computers & Interact with Freezing Pods",
			["Shortcut"]="RemotelyHackComputers",
			["Options"]={
				[false]={
					["Title"]="NOTHING",
					["TextColor"]=newColor3(255),
				},
				["PCs"]={
					["Title"]="PCs ONLY",
					["TextColor"]=newColor3(255,0,255),
				},
				["Pods"]={
					["Title"]="Pods ONLY",
					["TextColor"]=newColor3(0, 0, 255),
				},
				[true]={
					["Title"]="Both",
					["TextColor"]=newColor3(0, 255, 255),
				},
			},
			["Default"]=false,
			["Event"]=nil,
			["SetEnabled"]=function(tag)
				local isInGame=isInGame(camera.CameraSubject.Parent)
				local newValue = C.enHacks.RemotelyHackComputers

				local canBeActive = newValue == true or (tag.Name=="Pod" and newValue=="Pods") or (tag.Name=="PC" and newValue=="PCs")
				tag.Enabled=canBeActive and camera.CameraType==Enum.CameraType.Custom and isInGame
				if tag:FindFirstChild("Toggle") and tag.Name=="Pod" then
					tag.Toggle.Text = myTSM.IsBeast.Value and "Capture" or "Rescue"
				end
			end,
			["ActivateFunction"]=function(newValue)
				local isInGame=isInGame(camera.CameraSubject.Parent)
				local hackDisplayList = CS:GetTagged("HackDisplay3")
				for num,tag in ipairs(hackDisplayList) do
					C.AvailableHacks.Blatant[20].SetEnabled(tag)
				end
			end,
			["CleanUp"]=function()
				DestroyAllTaggedObjects("HackDisplay3")
				if C.AvailableHacks.Blatant[20].Event then
					C.AvailableHacks.Blatant[20].Event:Destroy()
				end
				C.AvailableHacks.Blatant[20].Event=nil
				if C.objectFuncts[C.AvailableHacks.Blatant[20].Event] then
					C.objectFuncts[C.AvailableHacks.Blatant[20].Event][1]:Disconnect()
					C.objectFuncts[C.AvailableHacks.Blatant[20].Event] = nil
				end
			end,
			["UpdateDisplays"]=function()
				C.AvailableHacks.Blatant[20].ActivateFunction(C.enHacks.RemotelyHackComputers)
			end,
			--CHECKED UNDER REMOTE DOORS HACK!
			["ComputerAdded"]=function(Computer)
				local Screen = Computer:WaitForChild("Screen")
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

				local newTag=C.ToggleTag:Clone()
				local isInGame=isInGame(workspace.Camera.CameraSubject.Parent)
				newTag.Name = "PC"
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
				ToggleButton.Text = "Teleport"
				local function setToggleFunction()
					local ActionEventVal = myTSM:WaitForChild("ActionEvent").Value
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
				C.AvailableHacks.Blatant[20].SetEnabled(newTag)
				setChangedAttribute(Screen, "Color", hackedTeleportFunction)
				hackedTeleportFunction()
			end,
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
					if C.Map then
						print("uh oh! not found")
					end
					return
				end
				local isBeast = myTSM:WaitForChild("IsBeast")

				local newTag=C.ToggleTag:Clone()
				local isInGame=isInGame(workspace.Camera.CameraSubject.Parent)
				newTag.Name = "Pod"
				newTag.Parent=HackGUI
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
				ToggleButton.Text = myTSM.IsBeast.Value and "Capture" or "Rescue"
				C.AvailableHacks.Blatant[20].SetEnabled(newTag)
				local function setToggleFunction()
					if isBeast.Value then
						local theirChar = C.Beast.CarriedTorso.Value.Parent
						C.AvailableHacks.Beast[60].CaptureSurvivor(PS:GetPlayerFromCharacter(theirChar),theirChar, true)
					else
						if myTSM.Health.Value > 0 then
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
				C.objectFuncts[ToggleButton]={ToggleButton.MouseButton1Up:Connect(setToggleFunction),
					CapturedTorso.Changed:Connect(setVisible),
					ActionSign.Changed:Connect(setVisible),
					carriedTorso.Event:Connect(setVisible)
				}
				setVisible()
			end,
			["MapAdded"]=function()
				C.AvailableHacks.Blatant[20].Event = C.AvailableHacks.Blatant[20].Event or Instance.new("BindableEvent")
				C.AvailableHacks.Blatant[20].Event:AddTag("RemoveOnDestroy")
				C.AvailableHacks.Blatant[20].Event.Name="CarriedTorsoChanged"
				C.AvailableHacks.Blatant[20].Event.Parent = workspace
			end,
			["MyBeastAdded"]=function()
				repeat
					RunS.RenderStepped:Wait()
				until C.AvailableHacks.Blatant[20].Event
				if not C.Beast then return end
				C.objectFuncts[C.AvailableHacks.Blatant[20].Event]={C.Beast:WaitForChild("CarriedTorso").Changed:Connect(function()
					C.AvailableHacks.Blatant[20].Event:Fire()
				end)}
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
								--RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
							end
						end
						task.wait()
					end	
					for s=3,1,-1 do
						if not C.enHacks.Util_AutoHack then
							return
						end
						if not TSM.MinigameResult.Value then
							--RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
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
				local minigameResult = myTSM:WaitForChild("MinigameResult")
				local function updateMiniGameResult()
					if minigameResult and C.enHacks.Util_AutoHack then
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
					plr.CameraMode=(C.char==C.Beast and Enum.CameraMode.LockFirstPerson or Enum.CameraMode[SP.CameraMode.Name])
				else
					--plr:SetAttribute("CameraMinZoomDistance",plr.CameraMinZoomDistance)
					plr.CameraMinZoomDistance=.5--minimum
					--plr:SetAttribute("CameraMaxZoomDistance",plr.CameraMaxZoomDistance)
					plr.CameraMaxZoomDistance=1e3--maximum
					--plr:SetAttribute("CameraMode",plr.CameraMode.Name)
					plr.CameraMode=Enum.CameraMode.Classic
				end
			end,
			["ActivateFunction"]=function(newValue)
				local updateZoom=C.AvailableHacks.Utility[2].UpdateZoom
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
			["Funct"]=nil,
			["DontActivate"] = true,
			["Universes"]={"Global"},
			["ActivateFunction"]=function(newValue)
				if gameUniverse=="Flee" then
					local ScreenGui = PlayerGui:WaitForChild("ScreenGui");
					local MenusTabFrame = ScreenGui:WaitForChild("MenusTabFrame");
					local BeastPowerMenuFrame = ScreenGui:WaitForChild("BeastPowerMenuFrame")
					local SurvivorStartFrame = ScreenGui:WaitForChild("SurvivorStartFrame")
					local IsCheckingLoadData = plr:WaitForChild("IsCheckingLoadData");
					local function changedFunct()
						if C.enHacks.Util_Fix then
							MenusTabFrame.Visible=not IsCheckingLoadData.Value;
						end
					end
					setChangedAttribute(MenusTabFrame,"Visible", (newValue and changedFunct or nil));
					changedFunct()
					local function beastScreen()
						if C.enHacks.Util_Fix then
							BeastPowerMenuFrame.Visible=false;
						end
					end
					setChangedAttribute(BeastPowerMenuFrame, "Visible", (newValue and beastScreen or nil));
					beastScreen()
					local function survivorScreen()
						if C.enHacks.Util_Fix then
							SurvivorStartFrame.Visible=false;
						end
					end
					setChangedAttribute(SurvivorStartFrame, "Visible", (newValue and survivorScreen or nil));
					survivorScreen()
				end

				local chatTextLabel = StringWaitForChild(PlayerGui,"Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.TextLabel")

				if (UIS.TouchEnabled and newValue) and not C.AvailableHacks.Utility[3].Active then
					local chatButton = gameUniverse=="Flee" and StringWaitForChild(PlayerGui,"ScreenGui.ChatIconFrame.Button")
					--local chatMain = requireModule(StringWaitForChild(plr,"PlayerScripts.ChatScript.ChatMain"))
					local chatBar = StringWaitForChild(PlayerGui,"Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar")
					local action1 = (UIS.MouseEnabled and UIS.TouchEnabled  and "select") 
						or (UIS.MouseEnabled and "click") or (UIS.TouchEnabled and "tap") or "<idk>"
					chatTextLabel.Text = "To chat ".. action1 .." here".. (UIS.KeyboardEnabled and ' or press "/" key' or "")
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
					if UIS.TouchEnabled then
						chatTextLabel.Text = "Tap here to chat"
					else
						chatTextLabel.Text = 'To chat click here or press "/" key'
					end
					CAS:UnbindAction("PushSlash"..C.saveIndex)
				end
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
			["MyBeastAdded"]=function()
				C.AvailableHacks.Utility[3].ActivateFunction(C.enHacks.Util_Fix)
			end,
			["CleanUp"]=function()
				C.AvailableHacks.Utility[3].ActivateFunction(C.enHacks.Util_Fix)
			end,
			["MyStartUp"]=function()
				RunS.RenderStepped:Wait()--Delay it
				C.AvailableHacks.Utility[3].ActivateFunction(C.enHacks.Util_Fix)
				task.wait(2)
				for s = 300, 1, -1 do
					if not SG:GetCore("ChatActive") then
						pcall(SG.SetCore,SG,"ChatActive",true)
						pcall(SG.SetCoreGuiEnabled,SG,Enum.CoreGuiType.Chat, false)
						pcall(function()
							requireModule(((game:GetService("Chat")):WaitForChild("ClientChatModules")):WaitForChild("ChatSettings")).ChatOnWithTopBarOff = true
						end)
						task.spawn(error,"[client improvement]: Fix Enabled")
					end
					RunS.RenderStepped:Wait()
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
			["ActivateFunction"]=function(newValue)
				if isCleared then return end
				local ContextActionGui = PlayerGui:WaitForChild("ContextActionGui")
				local TouchGui = PlayerGui:WaitForChild("TouchGui");
				local function updateTouchScreenEnability()
					TouchGui.Enabled = not C.enHacks.Util_HideTouchscreen
					ContextActionGui.Enabled = not C.enHacks.Util_HideTouchscreen
				end
				setChangedAttribute(TouchGui,"Enabled",(C.enHacks.Util_HideTouchscreen and updateTouchScreenEnability))
				setChangedAttribute(ContextActionGui,"Enabled",(C.enHacks.Util_HideTouchscreen and updateTouchScreenEnability))
				human.AutoJumpEnabled = not C.enHacks.Util_HideTouchscreen
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
				C.AvailableHacks.Utility[8].CleanUp()
				if not myTSM.IsBeast.Value then
					return
				end
				local Hammer = C.char:WaitForChild("Hammer",30)
				if not Hammer then
					return warn("Hammer Not Found, Hacks Bro!")
				end
				local LocalClubScript = Hammer:WaitForChild("LocalClubScript",5)
				if not LocalClubScript then
					return warn("LocalClubScript Not Found, Hacks Bro!")
				end
				newValue = C.enHacks.Util_Hammer--reset it because we yielded!

				LocalClubScript.Disabled = newValue
				if newValue then
					task.delay(0,LocalClubScriptFunction,LocalClubScript)
				end
			end,
			["MyPlayerAdded"] = function()
				if not C.enHacks.Util_Hammer then
					return
				end
				C.AvailableHacks.Utility[8].Funct = myTSM:WaitForChild("IsBeast").Changed:Connect(function()
					C.AvailableHacks.Utility[8].ActivateFunction(C.enHacks.Util_Hammer)
				end)
			end,
		},
		[9]={
			["Type"]="ExTextButton",
			["Title"]="Auto Mute Music",
			["Desc"]="Activate To Force Stop Lobby and/or Beast Music",
			["Shortcut"]="Util_MuteMusic",
			["Default"]=botModeEnabled and "Both",
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
				["Beast"] = ({
					["Title"] = "BEAST",
					["TextColor"] = newColor3(0,255,255),
				}),
				["Both"]={
					["Title"] = "BOTH",
					["TextColor"] = newColor3(255,255,0),
				},
			},
			["Universes"]={"Flee"},
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
				C.AvailableHacks.Utility[9].MusicValue2 = hammerHandle:WaitForChild("SoundHeartBeat")
				C.AvailableHacks.Utility[9].MusicValue3 = hammerHandle:WaitForChild("SoundChaseMusic")
				C.AvailableHacks.Utility[9].ActivateFunction()
			end,

			["MyStartUp"] = function()
				local musicSound
				if gameName=="FleeMain" then
					musicSound = C.char:WaitForChild("BackgroundMusicLocalScript"):WaitForChild("Sound")
				elseif gameName=="FleeTrade" then
					musicSound = plr:WaitForChild("PlayerScripts"):WaitForChild("BackgroundMusicLocalScript"):WaitForChild("Sound")
				end
				C.AvailableHacks.Utility[9].MusicValue = musicSound
				setChangedAttribute(musicSound,"IsPlaying",C.AvailableHacks.Utility[9].ActivateFunction)
				C.AvailableHacks.Utility[9].ActivateFunction()
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
				if C.AvailableHacks.Utility[10].Funct then
					C.AvailableHacks.Utility[10].Funct:Disconnect()
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
								for s=1,#items2Trade-C.enHacks.Util_InstaTradeAmnt do
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
					C.AvailableHacks.Utility[10].Funct = RemoteEvent.OnClientEvent:Connect(remoteEventReceivedFunction)
					RemoteEvent:FireServer("CancelTrade")
				else
					C.AvailableHacks.Utility[10].Funct = false
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
				if (isCleared and myTSM and myTSM:FindFirstChild("NormalWalkSpeed")) or
					(not newSpeed and gameUniverse=="Flee" and C.enHacks.WalkSpeed==defaultCharacterWalkSpeed and myTSM:WaitForChild("NormalWalkSpeed",1/4)) then
					newSpeed=myTSM.NormalWalkSpeed.Value
				elseif isCleared then
					newSpeed=SP.CharacterWalkSpeed
				else
					newSpeed=C.enHacks.WalkSpeed or C.AvailableHacks.Basic[1].Default
				end
				if gameUniverse=="Flee" then
					newSpeed = newSpeed * (1-((myTSM.IsCrawling.Value and crawlSlowDown) or 0))
				end
				human.WalkSpeed=newSpeed
			end,
			["ActivateFunction"]=function(newValue)
				if newValue==defaultCharacterWalkSpeed or isCleared then
					setChangedAttribute(human,"WalkSpeed",false)
				else
					setChangedAttribute(human,"WalkSpeed",C.AvailableHacks.Basic[1].UpdateSpeed)
				end 
				C.AvailableHacks.Basic[1].UpdateSpeed()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				RunS.RenderStepped:Wait()
				C.AvailableHacks.Basic[1].Funct=human:GetAttributeChangedSignal("OverrideSpeed"):Connect(C.AvailableHacks.Basic[1].UpdateSpeed)
				if C.enHacks.WalkSpeed ~= defaultCharacterWalkSpeed then
					C.AvailableHacks.Basic[1].ActivateFunction(C.enHacks.WalkSpeed)
				end
			end,
			["MyPlayerAdded"]=function()
				if gameUniverse~="Flee" then
					return
				end
				table.insert(C.functs,myTSM:WaitForChild("IsCrawling").Changed:Connect(C.AvailableHacks.Basic[1].UpdateSpeed))
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

				local hrp = C.char:WaitForChild("HumanoidRootPart")
				local animator = human:WaitForChild("Animator")

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
					bodyGyro.Parent = C.AvailableHacks.Basic[4].IsActive and C.char.Head or nil
					bodyVel.Parent = C.AvailableHacks.Basic[4].IsActive and C.char.Head or nil
					bodyGyro.CFrame = hrp.CFrame
					bodyVel.Velocity = newVector3()
					--setCollisionGroupRecursive(character,flying and groupName or "Original")

					for i, v in pairs(animator:GetPlayingAnimationTracks()) do
						if allowedID[v.Animation.AnimationId]==nil then
							v:Stop()
						end
					end
					if C.char:FindFirstChild("Animate") ~=nil and game.GameId~=372226183 then
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
						local MoveDirection = C.PlayerControlModule:GetMoveVector()
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
						bodyVel.Velocity = (direction * newVector3(C.enHacks.MovementHorizontalSpeed,C.enHacks.MovementVerticalSpeed,C.enHacks.MovementHorizontalSpeed)) * human.WalkSpeed * speed
					end
				end





				--CAS:BindAction("forward", movementBind, false, Enum.PlayerActions.CharacterForward)
				--CAS:BindAction("backward", movementBind, false, Enum.PlayerActions.CharacterBackward)
				--CAS:BindAction("left", movementBind, false, Enum.PlayerActions.CharacterLeft)
				--CAS:BindAction("right", movementBind, false, Enum.PlayerActions.CharacterRight)
				--CAS:BindAction("up", movementBind, false, Enum.PlayerActions.CharacterJump)
				--table.insert(C.AvailableHacks.Basic[4].MovementFuncts,human:GetPropertyChangedSignal("MoveDirection"))
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
						RunS.RenderStepped:Wait()
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

				local hrp = C.char:WaitForChild("HumanoidRootPart")
				local animator = human:WaitForChild("Animator")

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
					bodyGyro.Parent = (C.AvailableHacks.Basic[4].IsActive and C.char.Head or nil)
					bodyVel.Parent = (C.AvailableHacks.Basic[4].IsActive and C.char.Head or nil)
					bodyGyro.CFrame = hrp.CFrame
					bodyVel.Velocity = newVector3()
					--setCollisionGroupRecursive(character,flying and groupName or "Original")

					local getPlayingAnimationTracks = animator:GetPlayingAnimationTracks();

					for i, v in ipairs(getPlayingAnimationTracks) do
						if (allowedID[v.Animation.AnimationId]==nil) then
							v:Stop()
						end
					end
					local shouldActivate = (C.char:FindFirstChild("Animate") ~=nil and game.GameId~=372226183)
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
						local MoveDirection = C.PlayerControlModule:GetMoveVector()
						local right = MoveDirection.X;
						local up = MoveDirection.Y;
						local forward = -MoveDirection.Z;
						local direction = cf.RightVector * right + cf.LookVector * forward + cf.UpVector * up; 

						if (direction:Dot(direction) > 0) then
							direction = direction.unit
						end
						bodyGyro.CFrame = cf
						bodyVel.Velocity = ((direction * newVector3(C.enHacks.MovementHorizontalSpeed,C.enHacks.MovementVerticalSpeed,C.enHacks.MovementHorizontalSpeed)) * human.WalkSpeed * speed)
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
						human:ChangeState(Enum.HumanoidStateType.Jumping)
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
					while not isCleared and C.enHacks.Movement=="Jetpack" do
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
				local Funct2Run = C.AvailableHacks.Basic[4].ToggleFunct;
				Funct2Run(C.AvailableHacks.Basic[4].IsActive);
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,inputEnded_1:connect(inputBegan));
				table.insert(C.AvailableHacks.Basic[4].MovementFuncts,v7.InputEnded:connect(inputEnded));
				local function taskSpawnJetpackUpdateVelFunction()
					while not isCleared and C.enHacks.Movement=="Jetpack" and workspace:IsAncestorOf(v14) do
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
				local v14 = Instance.new("BodyPosition", C.char:WaitForChild("Head"))
				v14.MaxForce = newVector3(0, 0, 0) v14.Name="JetpackVelocity"
				local height=0
				local baseHeight=0
				local isR6=human.RigType==Enum.HumanoidRigType.R6
				local function update(new,saveHeight)
					local blackListTable = {"Blacklist",C.char}
					local directionPosition1 = C.char.PrimaryPart.Size.Y/2+(isR6 and C.char["Right Leg"] or C.char["Lower Leg"]).Size.Y/2+3.03
					local directionPosition2 = getHumanoidHeight(C.char)
					local directionPosition
					if isR6 then
						directionPosition = directionPosition1
					else
						directionPosition = directionPosition2
					end
					local characterOffsetStartingPosition = (C.char.PrimaryPart.Position-newVector3(0,3,0))
					local didHit,hitPart=raycast(C.char.PrimaryPart.Position,characterOffsetStartingPosition,blackListTable,directionPosition,false,true)
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
				local JetpackGUI=plr.PlayerGui:FindFirstChild("JetpackGUI")
				if JetpackGUI~=nil then 
					JetpackGUI:Destroy()
				end
				if C.char:FindFirstChild("Head") then
					local JetpackVelocity = C.char.Head:FindFirstChild("JetpackVelocity")
					if JetpackVelocity then 
						JetpackVelocity:Destroy()
					end
				end
			end),
			["ActivateFunction"]=(function(newValue)
				local function onKeyPress(actionName, inputState, _inputObject)
					if inputState == Enum.UserInputState.Begin and C.enHacks.Movement and not isCleared then
						if (not human or human:GetState() == Enum.HumanoidStateType.Dead) then
							return
						end
						C.AvailableHacks.Basic[4].IsActive=not C.AvailableHacks.Basic[4].IsActive
						if C.AvailableHacks.Basic[4].ToggleFunct~=nil then
							C.AvailableHacks.Basic[4].ToggleFunct(C.AvailableHacks.Basic[4].IsActive)
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
				local primPart=C.char.PrimaryPart
				if primPart==nil then
					return
				end
				local position1=(C.char:FindFirstChild("Torso") or C.char:FindFirstChild("UpperTorso")).Position
				local position2=target+ newVector3(0,getHumanoidHeight(C.char)+(gameUniverse=="Flee" and 1.85 or 0),0)
				position2=isCFrame and position2.Position or position2
				local result,hitPart
				if GlobalSettings.discreteTeleportsOnly then
					result,hitPart = raycast(position1,position2,{"Blacklist",C.char},(position1-position2).magnitude,1,true)
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
				C.objectFuncts[mouse]=C.objectFuncts[mouse] or {};
				for num,funct in pairs(C.objectFuncts[mouse]) do
					funct:Disconnect();
				end;
				if newValue then
					local function keyDownFunction(key)
						if key == "t" then
							local inputPosition = mouse.Hit.Position;
							local TPFunction = C.AvailableHacks.Basic[12].TeleportFunction;
							TPFunction(inputPosition);
						end;
					end;
					local objectFuncts_ADD = C.objectFuncts[mouse];
					local connection_1 = mouse.KeyDown:Connect(keyDownFunction);
					table.insert(objectFuncts_ADD, connection_1);
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
					table.insert(objectFuncts_ADD,connection_2);
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
			["FirstClean"]=false,
			["GetStructure"]=function(object)
				local doorNames = {"Door","DoorL","DoorR"}

				if table.find(doorNames,object.Parent.Name) or table.find(doorNames,object.Parent.Parent.Name) then
					return "Door"
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
				local structure = C.AvailableHacks.Basic[20].GetStructure(object)
				object:RemoveTag(object,"InviWalls")
				object.CanCollide = not object:GetAttribute("WeirdCanCollide")
				object.Color = object:GetAttribute("OrgColor") or object.Color
				object.Transparency = object:GetAttribute("OrgTrans") or object.Transparency
				object.CastShadow = true
				if structure == "Door" then
					setChangedAttribute(object,"CanCollide",false)
				end
			end,
			["InstanceAdded"]=function(object)
				if not object:IsA("BasePart") or not object.Parent or not object.Parent.Parent then 
					return
				end
				local structure = C.AvailableHacks.Basic[20].GetStructure(object)
				local isDoor,isWall = structure=="Door",structure=="Wall"
				if not object.Parent then
					return
				elseif (isDoor and not C.enHacks.Blatant_WalkThruDoors) or (isWall and not C.enHacks.Blatant_WalkThruWalls) then
					return C.AvailableHacks.Basic[20].InstanceRemoved(object)	
				end
				local shouldBeInvi = ((object:GetAttribute("OrgTrans") or object.Transparency)>=.95 and object.CanCollide) 
					or (C.enHacks.Blatant_WalkThruDoors and isDoor) or (C.enHacks.Blatant_WalkThruWalls and isWall)
				if (shouldBeInvi) and (GlobalSettings.MinimumHeight<=GetAbsoluteWorldSize(object).Y or isDoor or isWall) then
					if object:GetAttribute("OrgColor")==nil then
						object:SetAttribute("OrgColor",object.Color)
					end
					if object:GetAttribute("OrgTrans")==nil then
						object:SetAttribute("OrgTrans",object.Transparency)
					end
					if object:GetAttribute("WeirdCanCollide")==nil then
						object:SetAttribute("WeirdCanCollide",not object.CanCollide)
					end
					CS:AddTag(object,"InviWalls")
					object.CanCollide = false
					object.CastShadow = false
					object.Transparency = C.enHacks.Basic_InviWalls=="Invisible" and 1 or .85
					object.Color = Color3.fromRGB(0,0,200)
					if isDoor then
						setChangedAttribute(object,"CanCollide",function()
							object:SetAttribute("WeirdCanCollide",not object.CanCollide)
							C.AvailableHacks.Basic[20].InstanceAdded(object)
						end)
					end
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
				local BasePlate = workspace:FindFirstChild("MapBaseplate")
				if BasePlate then
					BasePlate.CanCollide = newValue
				end
				if newValue then
					C.AvailableHacks.Basic[20].ApplyInvi(workspace)
				else
					for num, object in ipairs(CS:GetTagged("InviWalls")) do
						C.AvailableHacks.Basic[20].InstanceRemoved(object)
					end
				end
			end,
		},
		[30]={
			["Type"]="ExTextButton",
			["Title"]="Invisible Character",
			["Desc"]="Warning: Not Everything Replicates. Do Not Leave This On For Too Long!",
			["Shortcut"]="Basic_InvisibleChar",
			["Default"]=false,
			["DontActivate"]=true,
			["Active"] = false,
			["Universes"]={"Global"},
			["Functs"]={},
			["RunFunction"]=function(connections)
				local function doAnimate(Figure,connections2Add)
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
						if (anim ~= currentAnimInstance) then

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

					---- setup emote chat hook
					game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
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

					end)

					-- main program

					-- initialize to idle
					playAnimation("idle", 0.1, Humanoid)
					pose = "Standing"

					while Figure.Parent ~= nil do
						local _, time = wait(0.1)
						move(time)
					end
				end

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
				orgChar.Archivable = true
				local clonedChar = C.char:Clone()
				C.ClonedChar = clonedChar
				clonedChar.Name = "InviClone"
				clonedChar:AddTag("RemoveOnDestroy")
				local clonedHuman = clonedChar:WaitForChild("Humanoid")
				orgChar.Archivable = false
				orgChar:PivotTo(CFrame.new(0,1e4,0))
				removeAllClasses(clonedChar,"Sound")
				--for s = 2, 1, -1 do
					RunS.RenderStepped:Wait()
				--end
				orgChar.PrimaryPart.Anchored = true

				clonedChar.Parent = workspace

				--C.plr.Character = clonedChar
				camera.CameraSubject = clonedHuman

				table.insert(connections,human:GetPropertyChangedSignal("MoveDirection"):Connect(function()
					clonedHuman:Move(human.MoveDirection)
				end))
				table.insert(connections,human:GetPropertyChangedSignal("Jump"):Connect(function()
					if human.Jump and clonedHuman and clonedHuman.FloorMaterial ~= Enum.Material.Air then
						clonedHuman:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end))
				local replicateProperties = {
					{"Humanoid","HipHeight"},
					{"Humanoid","WalkSpeed"},
					{"Humanoid","JumpPower"}
				}
				for _, propTable in ipairs(replicateProperties) do
					local propertyToReplicate = propTable[2]
					local oldObject = orgChar:WaitForChild(propTable[1])
					local newObject = clonedChar:WaitForChild(propTable[1])
					local function updFunction()
						if isCleared then
							warn("[AHH]: Property Running After Shutdown: "..table.concat(propTable,"."))
							return
						end
						clonedChar[propTable[1]][propertyToReplicate] = oldObject[propertyToReplicate]
					end
					table.insert(connections, oldObject:GetPropertyChangedSignal(propertyToReplicate):Connect(updFunction))
					updFunction()
				end

				for _, basePart in ipairs(clonedChar:GetDescendants()) do
					if basePart.Name=="Weight" then
						basePart:Destroy()
					elseif basePart:IsA("BasePart") and basePart.Name ~= "HumanoidRootPart" then
						--local local function updLocalTrans()
						basePart.Transparency = .5
						--end
						--updLocalTrans()
					elseif basePart:IsA("Decal") then
						basePart.Transparency = .5
					end
				end
				local SavedAnimsTracks = {}
				local canRun = false
				table.insert(connections, human.Animator.AnimationPlayed:Connect(function(animTrack)
					if animTrack.Animation.AnimationId ~= "rbxassetid://961932719" then
						return
					end
					local animation = animTrack.Animation
					local myTrack = SavedAnimsTracks[animation.AnimationId]
					if not myTrack then
						myTrack = clonedHuman.Animator:LoadAnimation(animation)
						myTrack.Looped = animTrack.Looped
						myTrack.Priority = animTrack.Priority
						SavedAnimsTracks[animation.AnimationId] = myTrack

						local function update()
							if animTrack.IsPlaying and not myTrack.IsPlaying then
								myTrack:Play()
							elseif not animTrack.IsPlaying and myTrack.IsPlaying then
								myTrack:Stop()
							end
						end
						table.insert(connections,animTrack:GetPropertyChangedSignal("Speed"):Connect(update))
						table.insert(connections,animTrack:GetPropertyChangedSignal("IsPlaying"):Connect(update))
						table.insert(connections,animTrack.Stopped:Connect(update))
						myTrack:AdjustSpeed(2)
						update()
					else
						myTrack:Play()
					end
				end))
				task.spawn(doAnimate,clonedChar,connections)
				table.insert(connections, clonedHuman.Running:Connect(function(speed)
					local myTrack = SavedAnimsTracks["rbxassetid://961932719"]
					if not myTrack then return end
					if speed > .5 then
						myTrack:AdjustSpeed(2)
					else
						myTrack:AdjustSpeed(0)
					end
				end))
			end,
			["ActivateFunction"] = function(enabled, characterSpawn)
				if enabled == C.AvailableHacks.Basic[30].Active then
					return
				end
				C.AvailableHacks.Basic[30].Active = enabled
				if enabled then
					C.AvailableHacks.Basic[30].RunFunction(C.AvailableHacks.Basic[30].Functs)
				else
					if not characterSpawn then
						if C.char and C.char.Parent then
							if C.ClonedChar then
								C.char:PivotTo(C.ClonedChar:GetPivot())
							end
							C.char.PrimaryPart.Anchored = false
							C.char.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
							C.char.PrimaryPart.AssemblyAngularVelocity = Vector3.new()
						end
					end
					if C.ClonedChar then
						C.ClonedChar:Destroy()
						C.ClonedChar = nil
					end
					camera.CameraSubject = human
					for index = #C.AvailableHacks.Basic[30].Functs, 1, -1 do
						local connection = C.AvailableHacks.Basic[30].Functs[index]
						connection:Disconnect()
						table.remove(C.AvailableHacks.Basic[30].Functs,index)
					end
				end
			end,
			["MyStartUp"] = function()
				C.AvailableHacks.Basic[30].ActivateFunction(false,true)
				if C.enHacks["Basic_InvisibleChar"] then
					C.AvailableHacks.Basic[30].ActivateFunction(C.enHacks["Basic_InvisibleChar"])
				end
			end,
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
				if isCleared then
					return warn("Instance "..(C.saveIndex or "Unknown").." is trying to delete itself but has already been cleared!")
				end
				clear(true)
			end,
		},
	},
	["Beast"]={

		[2]={
			["Type"]="ExTextButton",
			["Title"]="Crawl as Beast",
			["Desc"]="Very obvious",
			["Shortcut"]="OverrideCrawl",
			["LoadedAnim"]=nil,
			["Default"]=false,
			["DontActivate"]=true,
			["ActivateFunction"]=function(newValue)
				--C.AvailableHacks.Beast[2].SetScriptActive()
				if not newValue then
					C.AvailableHacks.Beast[2].Crawl(false)
				end
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
						human.HipHeight=0
					end
				end
				CrawlScript.Disabled=true
				local animTrack=human:WaitForChild("Animator"):LoadAnimation(CrawlScript:WaitForChild("AnimCrawl"))
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
				local button = getDictLength(CAS:GetBoundActionInfo("Crawl"))>0 and CAS:GetButton("Crawl")
				local setPosition = plr:GetAttribute("CrawlPosition") or UDim2_new(1, -220, 1, -90)
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
				table.insert(C.functs,(human.Running:Connect(HumanRunningFunction)))
				local inputToCrawlFunction_INPUT = UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.ButtonL2)
				C.AvailableHacks.Beast[2].Crawl(inputToCrawlFunction_INPUT)
			end,
			["MyPlayerAdded"]=function()
				local function crawlFunction()
					C.AvailableHacks.Blatant[(2)].Crawl()
				end

				table.insert(C.functs, myTSM:WaitForChild("DisableCrawl").Changed:Connect(function()
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					RunS.RenderStepped:Wait() -- wait so that it can be added before I can remove it!
					CAS:UnbindAction("Crawl")
				end))
			end,
			["IsCrawling"]=false,
			["Crawl"]=function(set)
				local TSM = plr:WaitForChild("TempPlayerStatsModule");
				local animTrack = C.AvailableHacks.Beast[2].LoadedAnim;
				local shouldReturn = not animTrack or not human or human.Health <= 0;
				if shouldReturn then
					return;
				end
				local argument = set and (C.enHacks.OverrideCrawl or not TSM.DisableCrawl.Value);
				if argument then
					local hipHeight = -2;
					human.HipHeight = hipHeight;
					local arg1 = 0.1;
					local arg2 = 1.0;
					local arg3 = 0.0;
					animTrack:Play(arg1, arg2, arg3);
					human.WalkSpeed = 8;
					C.AvailableHacks.Beast[2].IsCrawling = true;
				else
					human.HipHeight = 0;
					animTrack:Stop();
					human.WalkSpeed = (((human.WalkSpeed==8) and 16) or human.WalkSpeed);
					C.AvailableHacks.Beast[2].IsCrawling=false;
				end
				RemoteEvent:FireServer("Input", "Crawl", C.AvailableHacks.Beast[2].IsCrawling)
				--TSM.IsCrawling.Value = C.AvailableHacks.Beast[2].IsCrawling;
			end,
		},
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
						C.AvailableHacks.Beast[60].ChangedFunction();
					end
					local inputChangedAttribute_INPUT = (newValue and BlatantChangedFunction);
					setChangedAttribute(TSM_IsBeast, "Value", inputChangedAttribute_INPUT);
					C.AvailableHacks.Beast[60].ChangedFunction();
				end),
				["CaptureSurvivor"] = function(theirPlr,theirChar,override)
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
					if not capsule then
					warn("Capsule Not Found For",theirPlr,theirChar)
					return
				end
					local Trigger = capsule:WaitForChild("PodTrigger",5)
					for s=1,3,1 do
					local isOpened = (Trigger.ActionSign.Value==11)
					if (Trigger and Trigger.CapturedTorso.Value~=nil) then 
						break --we got ourselves a trapped survivor!
					elseif not C.enHacks.AutoCapture and not override then
						break
					elseif s~=1 then
						wait(.15)
					end
					if Trigger:FindFirstChild("Event") then
						RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
						RemoteEvent:FireServer("Input", "Action", true)
						if isOpened then
							RemoteEvent:FireServer("Input", "Trigger", false)
						end
					end
				end
				end,
				["ChangedFunction"]=function()
					local TSM=plr:WaitForChild("TempPlayerStatsModule")
					if not TSM:WaitForChild("IsBeast").Value then
					return
				end
					local CarriedTorso=C.char:WaitForChild("CarriedTorso",20)
					if CarriedTorso~=nil then
					local function captureSurvivorFunction()
						C.AvailableHacks.Beast[60].CaptureSurvivor(plr,C.char)
					end
					local input = C.enHacks.AutoCapture and captureSurvivorFunction
					setChangedAttribute(CarriedTorso,"Value",input)
					C.AvailableHacks.Beast[60].CaptureSurvivor(plr,C.char)
				else
					warn("rope not found!!!! hackssss bro!", C.char:GetFullName())
				end
				end,


				--["MyStartUp"]=function()
				--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
				setChangedAttribute(
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
			["Title"]="Auto.Beast Hit",
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
				local Dist=(Handle.Position-theirChar.PrimaryPart.Position).magnitude
				if Dist<15 then
					local closestPart, closestDist = nil, 12
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
							local TSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
							if TSM~=nil and not TSM.Captured.Value and not TSM.Ragdoll.Value then
								C.AvailableHacks.Beast[66].HitFunction(Hammer,Handle,theirChar)
							end
						end
					end
					RunS.PreAnimation:Wait()
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
		},
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
					local retValue = savedDeb == C.AvailableHacks.Beast[77].SaveDeb and not isCleared and C.char == C.Beast

					if not retValue and not noReset then--CLEANUP CHECK!
						trigger_setTriggers("Beast_CaptureAllSurvivors",true)
					end
					return retValue
				end
				local function canRunPlr(theirPlr)
					return theirPlr and theirPlr.Parent and theirPlr.Character 
						and theirPlr.Character:FindFirstChild("Humanoid") and theirPlr.Character.Humanoid.Health>0
				end
				C.refreshEnHack["Beast_CaptureAllSurvivors"]("In Progress")
				trigger_setTriggers("Beast_CaptureAllSurvivors",false)
				while true do
					if not canRun() then return end
					for num, theirPlr in ipairs(PS:GetPlayers()) do
						local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule",1)
						local theirChar = theirPlr.Character
						if theirChar and theirChar.PrimaryPart and theirTSM then
							local theirHuman = theirChar:FindFirstChild("Humanoid")
							if theirHuman and theirHuman.Health > 0 and select(2,isInGame(theirChar,true))=="Runner" then
								--PROCESS SEQUENCE
								local loopInstance = 1
								while not theirTSM.Captured.Value and canRunPlr(theirPlr) do
									if not canRun() then return elseif not canRunPlr(theirPlr) then break end
									teleportMyself(C.char:GetPivot() - C.char:GetPivot().Position + (theirChar:GetPivot() * CFrame.new(0,0,1)).Position)
									while canRun(true) and canRunPlr(theirPlr) 
										and not theirTSM.Ragdoll.Value do

										if not C.AvailableHacks.Beast[66].HitFunction(Hammer,Handle,theirChar) then
											teleportMyself(C.char:GetPivot() - C.char:GetPivot().Position + (theirChar:GetPivot() * CFrame.new(0,0,1)).Position + Vector3.new(0,getHumanoidHeight(C.char)))
											--TELEPORT IF IT RETURNS FALSE (WE'RE OUT OF RANGE!)
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
									while canRun(true) and canRunPlr(theirPlr) and theirTSM.Ragdoll.Value and CarriedTorso.Value and CarriedTorso.Value.Parent == theirChar.Parent and not theirTSM.Captured.Value do
										C.AvailableHacks.Beast[60].CaptureSurvivor(theirPlr,theirChar,true)
										print("Capturing")
										RunS.RenderStepped:Wait()
									end
									print("Ragodll",theirTSM.Ragdoll.Value,CarriedTorso.Value,theirTSM.Captured.Value,canRun(true),canRunPlr(theirPlr),CarriedTorso.Value.Parent == theirChar.Parent)
									if loopInstance > 1 then
										warn("<font color='rgb(255,255,0)'>[INSTA CAPTURE]: LOOP INSTANCE = "..loopInstance.."!</font>")
										task.wait()
									end
									loopInstance+=1
								end
							end
						end
					end
					if not canRun() then return end
					local isFinished = true
					for num, theirPlr in ipairs(PS:GetPlayers()) do
						local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule",1)
						if theirTSM and theirTSM.Health.Value > 0 and not theirTSM.Captured.Value then
							isFinished = false
							break--performance reasons!
						end
					end
					if isFinished then
						break
					else
						task.wait()
					end
				end
				if not canRun() then return end
				warn("<font color='rgb(255,255,0)'>Finished Capturing!</font>")
				C.refreshEnHack["Beast_CaptureAllSurvivors"](true)
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
			["ChangedFunction"]=function(newSet)
				--print("begun")
				if C.Beast==nil then
					return
				end
				local CarriedTorso=C.Beast:FindFirstChild("CarriedTorso")
				if CarriedTorso==nil then
					return
				end
				while newSet~=nil and CarriedTorso.Value~=newSet do
					--print("waiting")
					task.wait(1/3)
				end
				local Hammer=C.Beast:WaitForChild("Hammer")
				if Hammer==nil or not C.enHacks.AutoRemoveRope then
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
					setChangedAttribute(C.Beast:WaitForChild("CarriedTorso",30),"Value",false)--deletes the last function!
					C.AvailableHacks.Runner[3].OthersBeastAdded(PS:GetPlayerFromCharacter(C.Beast),C.Beast)
				end
				--C.AvailableHacks.Runner[3].ChangedFunction()
			end,
			["OthersBeastAdded"]=function(theirPlr,theirChar)
				local CarriedTorso=theirChar:WaitForChild("CarriedTorso",30)
				if CarriedTorso==nil then
					return
				end
				setChangedAttribute(CarriedTorso,"Value",C.enHacks.AutoRemoveRope and (function(newRopee)
					C.AvailableHacks.Runner[3].ChangedFunction(newRopee)
				end) or false)
				C.AvailableHacks.Runner[3].ChangedFunction()
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
			["Default"]=true,
			["Funct"]=nil,
			["ActivateFunction"]=function(newValue)

				local actionEvent = myTSM:WaitForChild("ActionEvent")
				local function currentAnimationUpdate(actionValue)
					if actionValue and actionValue.Parent and actionValue.Parent.Parent and trigger_gettype(actionValue.Parent.Parent)=="Computer" then
						if C.enHacks.Blatant_RemoteHackPCs then
							C.char.Torso.CanTouch = false
							trigger_setTriggers("Typing",false)
							local changed
							changed = myTSM.CurrentAnimation.Changed:Connect(function()
								RunS.RenderStepped:Wait()
								myTSM.CurrentAnimation.Value = ""
								table.remove(C.functs,table.find(C.functs,changed))
								changed:Disconnect()
							end)
							table.insert(C.functs,changed)
							return
						else
							if actionValue.Parent and not table.find(C.char.Torso:GetTouchingParts(),actionValue.Parent) then
								task.spawn(stopCurrentAction,true)
							end
						end
					end
					trigger_setTriggers("Typing",true)
					C.char.Torso.CanTouch = true
				end

				if not C.AvailableHacks.Runner[4].Funct and newValue then
					C.AvailableHacks.Runner[4].Funct = actionEvent.Changed:Connect(currentAnimationUpdate)
				elseif C.AvailableHacks.Runner[4].Funct and not newValue then
					C.AvailableHacks.Runner[4].Funct:Disconnect()
					C.AvailableHacks.Runner[4].Funct=nil
				end
				--setChangedAttribute(currentAnimation,"Value",newValue and currentAnimationUpdate)
				currentAnimationUpdate()
			end,
		},

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
				while (C.Beast and CarriedTorso.Value and TSM.Ragdoll.Value and loop and not isCleared) do
					CarriedTorso.Changed:Wait()
				end
				C.AvailableHacks.Runner[7].RopeSurvivor(TSM,theirPlr)
				--deletes the last function!
			end,
			["ActivateFunction"]=function(newVal)
				if newVal then
					--for num, theirPlr in ipairs(PS:GetPlayers()) do
					--	C.AvailableHacks.Runner[7].ChangedFunction(theirPlr:WaitForChild("TempPlayerStatsModule"),theirPlr)
					--end
					for num,theirPlr in ipairs(PS:GetPlayers()) do
						C.AvailableHacks.Runner[7].PlayerAdded(theirPlr)
					end
				end
			end,
			["PlayerAdded"]=function(theirPlr)
				local TSM = theirPlr:WaitForChild("TempPlayerStatsModule")
				local funct = function()
					C.AvailableHacks.Runner[7].ChangedFunction(TSM,theirPlr,true)
				end
				local myInput = (C.enHacks.AutoAddRope and funct)
				setChangedAttribute(TSM:WaitForChild("Ragdoll",30),"Value", myInput)
				C.AvailableHacks.Runner[7].ChangedFunction(TSM,theirPlr,false)
			end,
			["MyPlayerAdded"]=function(myPlr)
				C.AvailableHacks.Runner[7].PlayerAdded(myPlr)
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				C.AvailableHacks.Runner[7].PlayerAdded(theirPlr)
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
				if not C.enHacks.Panic or C.char:FindFirstChild("Head")==nil or not TSM.Ragdoll.Value then
					return
				end
				local newVel=Instance.new("BodyVelocity",C.char.Head)
				newVel.MaxForce = (newVector3(3000,3000,3000)*2.25)
				newVel.P = 3e3
				CS:AddTag(newVel,"RemoveOnDestroy")
				local function RagdollPanicThreadFunction()
					while (C.enHacks.Panic and TSM.Ragdoll.Value and not TSM.Captured.Value and not isCleared) do
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
				local theArg = ((C.enHacks.Panic and (theFunction)) or false)
				setChangedAttribute(TSM:WaitForChild("Ragdoll"),"Value",theArg)
				if shouldntTrigger~=true then
					C.AvailableHacks.Runner[71].Triggered()
				end
			end,
			["ActivateFunction"]=function(newValue)
				C.AvailableHacks.Runner[71].SetChanged()
			end,
			["MyPlayerAdded"]=function()
				C.AvailableHacks.Runner[71].SetChanged(true)
			end,
			["MyStartUp"]=function()
				C.AvailableHacks.Runner[71].Triggered()
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
					while (myBeast~=nil and workspace:IsAncestorOf(myBeast) and myBeast.PrimaryPart and not isCleared and myBeast==C.Beast and C.char~=myBeast) do
						if (not TSM.Ragdoll.Value and C.enHacks.RespawnBeforeHit and not TSM.Captured.Value) then
							local whieList = {"Whitelist",C.Map,myBeast}
							local didHit,instance=raycast(C.char.PrimaryPart.Position,myBeast:GetPivot().Position,whieList,18,nil,true)
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
			}
		),
		[80]={
			["Type"]="ExTextButton",
			["Title"]="Auto Rescue",
			["Desc"]="Instantly rescue when NOT beast",
			["Shortcut"]="AutoRescue",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				for num, capsule in pairs(CS:GetTagged("Capsule")) do
					local PodTrigger = capsule:FindFirstChild("PodTrigger")
					if PodTrigger then
						local CapturedTorso = PodTrigger:FindFirstChild("CapturedTorso")
						if CapturedTorso and PodTrigger.Parent then
							setChangedAttribute(
								CapturedTorso,
								"Value",newValue and function()
									C.AvailableHacks.Runner[80].RescueSurvivor(capsule)
								end or false)
							C.AvailableHacks.Runner[80].RescueSurvivor(capsule)
						end
					end
				end
			end,
			["RescueSurvivor"]=function(capsule,override)
				if not capsule or not capsule:FindFirstChild("PodTrigger")
					or not capsule.PodTrigger.CapturedTorso.Value then return end
				if not C.enHacks.AutoRescue and not override then return end
				if C.char:FindFirstChild("Hammer")~=nil and myTSM.Health.Value > 0 then return end
				local Trigger=capsule:FindFirstChild("PodTrigger")
				if not Trigger then return end
				for s=5,1,-1 do
					if not workspace:IsAncestorOf(Trigger) then 
						break
					elseif Trigger.CapturedTorso.Value==nil then
						return true
					end
					local isOpened=Trigger.ActionSign.Value==11
					RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
					RemoteEvent:FireServer("Input", "Action", true)
					if isOpened then
						RemoteEvent:FireServer("Input", "Trigger", false)
					end
					wait(.075)
					RemoteEvent:FireServer("Input", "Action", false)
					wait(.075)
				end
			end,
			["CapsuleAdded"]=function(capsule)
				if capsule:FindFirstChild("PodTrigger")~=nil then
					wait(.5)
					setChangedAttribute(
						capsule.PodTrigger:FindFirstChild("CapturedTorso"),
						"Value",C.enHacks.AutoRescue and (function()
							C.AvailableHacks.Runner[80].RescueSurvivor(capsule)
						end) or false)
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
					local Trigger,dist=findClosestObj(CS:GetTagged("DoorTrigger"),C.Beast.PrimaryPart.Position,20,1.5)
					if Trigger~=nil and Trigger.Parent~=nil and Trigger:FindFirstChild("ActionSign")~=nil
						and Trigger.ActionSign.Value~=0 then--Trigger.ActionSign.Value==11 then
						--print("closed door")
						--RemoteEvent:FireServer("Input", "Action", false)
						--RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
						--task.wait()
						--RemoteEvent:FireServer("Input", "Action", true)
						--RemoteEvent:FireServer("Input", "Trigger", false, Trigger.Event)
						--task.wait()
						--C.AvailableHacks.Blatant[10].CloseDoor(Trigger)
						local wasClosed = Trigger.ActionSign.Value ~= 11 
						C.AvailableHacks.Blatant[15].DoorFuncts[Trigger.Parent]()
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
					C.AvailableHacks.Runner[86].IsRunning=false
				--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local myChar=C.char
				while myChar~=nil and workspace:IsAncestorOf(myChar) 
					and myChar.PrimaryPart~=nil and plr.Character==myChar and not isCleared do
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
			}),
		[90]=
			{
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
						if ((not C.enHacks.PermSlowBeast) or (not (workspace:IsAncestorOf(BeastEvent)))) then
						return false;
					end
						BeastEvent:FireServer("Jumped");
						return true;
					end
					local setChangedAttributeUpdate_INPUT = (C.enHacks.PermSlowBeast and changeSpeed) ;
					setChangedAttribute(Humanoid,"WalkSpeed", setChangedAttributeUpdate_INPUT);
					while (C.enHacks.PermSlowBeast and (changeSpeed())) do
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
				local event = C.AvailableHacks.Bot[15].ChangedEvent
				C.AvailableHacks.Bot[15].DidAction = false
				C.AvailableHacks.Bot[15].CurrentTarget = target

				if isTeleportingAllowed then
					local setVector3 = updatedTarget+newVector3(0,getHumanoidHeight(C.char))
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
									declareError(path, path.ErrorType.AgentStuck)
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
					if C.char.PrimaryPart then
						human:MoveTo(C.char.PrimaryPart.Position)
					end
					return false
				elseif result then
					path:Stop() task.wait()
					--human:MoveTo(updatedTarget)
					C.AvailableHacks.Bot[20].Funct(path,updatedTarget)
				end
				return result or ((updatedTarget-C.char.PrimaryPart.Position)/newVector3(1,4,1)).magnitude<2
			end),
			["UnlockDoor"]=function(shouldWait)
				if isActionProgress then
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
						isActionProgress=true C.AvailableHacks.Bot[15].DidAction=true
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
				human:MoveTo(C.char.Torso.CFrame*(5*Random.new():NextUnitVector()))
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
					local Check1 = C.enHacks.BotRunner=="Hack" and C.char~=nil and human~=nil and human.Health>0 and camera.CameraSubject==human;
					local Check2 = savedDeb==C.AvailableHacks.Bot[15].CurrentNum and C.char.PrimaryPart;
					local Check3 = select(2,isInGame(C.char,true))=="Runner" and not isCleared;--(not fullLoop or select(2,isInGame(C.char,true))=="Runner") and not isCleared;
					return Check1 and Check2 and Check3;
				end
				C.AvailableHacks.Bot[15].CanRun=canRun;

				local function getComputerTriggers()
					local triggers = {}
					for num,pc in ipairs(CS:GetTagged("Computer")) do
						for num,goodTrigger in pairs(C.AvailableHacks.Bot[15].getGoodTriggers(pc)) do
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
					human:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
					while #CS:GetTagged("Computer")==0 do
						print("[Bot Runner]: Waiting For Computers!")
						human:Move(newVector3())
						CS:GetInstanceAddedSignal("Computer"):Wait()
						task.wait()
						task.spawn(function()
							C.AvailableHacks.Beast[2].Crawl(C.AvailableHacks.Beast[2].IsCrawling) --RS.IsGameActive.Changed:Wait() --wait(1)
						end)
					end
					while RS.CurrentMap.Value==nil do
						print("[Bot Runner]: Waiting For C.Map!")
						RS.CurrentMap.Changed:Wait()
					end
					--print(#CS:GetTagged("Computer"),string.sub(RS.GameStatus.Value,1,2),string.sub(RS.GameStatus.Value,1,2)=="15")
					if RS.ComputersLeft.Value>0 or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15") then--hack time :D
						local closestTrigger,dist=findClosestObj(getComputerTriggers(),C.char.PrimaryPart.Position,3000,6)
						while canRun() and closestTrigger~=nil and (RS.ComputersLeft.Value>0 or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15")) do --print("found trigger")
							local ActionSign=closestTrigger:FindFirstChild("ActionSign")
							local function walkPathFunct()
								return ActionSign~=nil and ActionSign.Value==20 and canRun()
							end
							local didReach=TSM.CurrentAnimation.Value=="Typing" or C.AvailableHacks.Bot[15].WalkPath(currentPath, closestTrigger, walkPathFunct)
							local distance=(closestTrigger.Position-C.char.Torso.Position).magnitude
							human:SetAttribute("OverrideSpeed",distance<13 and 35 or nil)
							if didReach or (closestTrigger.Position-C.char.Torso.Position).magnitude<2 or (TSM.ActionEvent.Value~=nil and closestTrigger:IsAncestorOf(TSM.ActionEvent.Value)) and ActionSign~=nil and ActionSign.Value==20 then--and table.find(closestTrigger:GetTouchingParts(),C.char.PrimaryPart) ~=nil then
								--print(TSM.ActionEvent.Value,TSM.CurrentAnimation.Value)
								--effective way of making the server wait!
								task.wait(.45)
								if TSM.CurrentAnimation.Value~="Typing" and (TSM.ActionEvent.Value==nil or plr.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("ActionBox").Text~="Hack")and closestTrigger.ActionSign.Value==20 then
									--C.AvailableHacks.Basic[12].TeleportFunction(CFrame.new(closestTrigger.Position-newVector3(0,human.HipHeight+C.char.Torso.Size.Y/2,0),closestTrigger.Parent.PrimaryPart.Position))
									human:MoveTo(closestTrigger.Position)
									human:ChangeState(Enum.HumanoidStateType.Jumping)
									task.wait(.6)
								end
								local screen=closestTrigger.Parent:FindFirstChild("Screen")
								while canRun() and closestTrigger and closestTrigger.Parent and TSM.ActionEvent.Value~=nil and closestTrigger.ActionSign.Value==20 and TSM.CurrentAnimation.Value~="Typing" and not (screen.Color.G*255<128 and screen.Color.G*255>126) do
									local distTraveled=(lastHackedPosition-closestTrigger.Position).Magnitude
									local timeElapsed=os.clock()-computerHackStartTime
									local minHackTimeBetweenPCs = (0.15+math.max(distTraveled/minSpeedBetweenPCs,lastHackedPC==closestTrigger.Parent and 0 or absMinTimeBetweenPCs))
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
										computerHackStartTime=os.clock() 
										lastHackedPosition=closestTrigger.Position
									end
								end

							end
							if C.char.PrimaryPart~=nil then
								closestTrigger,dist=findClosestObj(C.AvailableHacks.Bot[15].getGoodTriggers(closestTrigger.Parent),C.char.PrimaryPart.Position,3000,1)
							end
							task.wait(0)
						end
						--print(C.AvailableHacks.Bot[15].WalkPath(currentPath,
						--	C.char.PrimaryPart.CFrame*newVector3(0,0,-15)))
					else--escape time :D
						local closestExitArea,dist=findClosestObj(getExitDoors(),(C.char.PrimaryPart and C.char.PrimaryPart.Position or newVector3()),3000,1)
						while canRun() and closestExitArea~=nil and not closestExitArea:GetAttribute("Unreachable"..C.saveIndex) do
							local exitDoor = closestExitArea.Parent
							if exitDoor:FindFirstChild("ExitDoorTrigger") and (exitDoor.ExitDoorTrigger.ActionSign.Value == 12 or exitDoor.ExitDoorTrigger.ActionSign.Value == 10)
								and C.AvailableHacks.Blatant[15].DoorFuncts[exitDoor] and isInGame(C.char,true) and isInGame(C.char) then
								trigger_setTriggers("BotRunner",{Exit=false})
								C.AvailableHacks.Blatant[15].DoorFuncts[exitDoor]()
							end
							local didReach=C.AvailableHacks.Bot[15].WalkPath(currentPath,closestExitArea,canRun)
							RunS.RenderStepped:Wait()
							while ((table.find(workspace:GetPartsInPart(C.char.HumanoidRootPart),closestExitArea)) and isInGame(C.char,true) and isInGame(C.char)
								and (not exitDoor:FindFirstChild("ExitDoorTrigger") 
									or (exitDoor.ExitDoorTrigger.ActionSign.Value ~= 12 and exitDoor.ExitDoorTrigger.ActionSign.Value ~= 10))) do
								if human.FloorMaterial~=Enum.Material.Air then
									human:ChangeState(Enum.HumanoidStateType.Jumping)
									teleportMyself(C.char:GetPivot() * CFrame.new(0,0,-2))
								end
								task.wait(1/6)
							end
							wait(0)
						end
					end
					RunS.RenderStepped:Wait()
				end
				human:SetAttribute("OverrideSpeed",nil)
				human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
			end,
			["RUNNERFreeze"]=function(TSM,currentPath,savedDeb)
				local runnerPlrs={}
				local warningPrint = true
				local myRunerPlrKey
				local function canRun(fullLoop)
					local plrs = {}
					for num, theirPlr in ipairs(PS:GetPlayers()) do
						if theirPlr and theirPlr.Character and select(2,isInGame(theirPlr.Character,true))=="Runner" then
							table.insert(plrs,theirPlr)
						end
					end
					runnerPlrs = sortPlayersByXPThenCredits(plrs)
					myRunerPlrKey = table.find(runnerPlrs,plr)
					--if Random.new():NextInteger(1,18)==1 then
					--	print(C.enHacks.BotRunner,savedDeb==C.AvailableHacks.Bot[15].CurrentNum,camera.CameraSubject==human,TSM.Escaped.Value,C.char.PrimaryPart)
					--end
					--if true then
					--error("CanRunBro")
					--end

					local Ret1 = (C.enHacks.BotRunner=="Freeze" and C.char and human and human.Health>0 and camera.CameraSubject==human and savedDeb==C.AvailableHacks.Bot[15].CurrentNum and C.char.PrimaryPart and C.Beast and C.Beast.PrimaryPart)
					local Ret2 = ((select(2,isInGame(C.char,true))=="Runner") and not isCleared)
					local Ret3 = C.Beast and myBots[C.Beast.Name:lower()]
					if not Ret3 and C.Beast and warningPrint then
						createCommandLine("Freeze Disabled: Unrecognized Player",print)
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
				while canRun(true) do
					human:SetAttribute("OverrideSpeed",((C.Beast:GetPivot().Position-C.char:GetPivot().Position).Magnitude<16 and 25 or 42))
					local inRange = (C.Beast:GetPivot().Position-C.char:GetPivot().Position).Magnitude<8
					if not inRange and not myTSM.Captured.Value then
						local didReach=C.AvailableHacks.Bot[15].WalkPath(currentPath,C.Beast:GetPivot()*newVector3(0,0,-2),canRun)
					end
					local i = 0
					while (canRun(true) and (C.Beast and C.Beast.PrimaryPart) and ((C.Beast:GetPivot().Position-C.char:GetPivot().Position).Magnitude<8 or TSM.Ragdoll.Value))  do
						local keyNeeded = 0
						for key, theirPlr in ipairs(runnerPlrs) do
							if not theirPlr:GetAttribute("HasCaptured") then
								keyNeeded = key
							end
						end
						i+=1
						if i==10 then
							i = 0
						elseif i>1 then
							RunS.RenderStepped:Wait()
						end
						if (myRunerPlrKey==keyNeeded and not plr:GetAttribute("HasCaptured")) or plr:GetAttribute("HasRescued") or #runnerPlrs==1 then
							--task.wait(1/2)
							if not canRun(true) then
								return
							end
							if not TSM.Ragdoll.Value and C.Beast and C.Beast.Parent then
								StringWaitForChild(C.Beast,"Hammer.HammerEvent"):FireServer("HammerHit", C.char.Head)
								--task.wait(1/4)
							end
							if not canRun(true) then
								return
							end
							if TSM.Ragdoll.Value and C.Beast and C.Beast.Parent then
								--teleportMyself(C.Beast:GetPivot()*CFrame.new(0,0,2))
								--RunS.RenderStepped:Wait()
								C.AvailableHacks.Runner[7].RopeSurvivor(TSM,plr,true)
								--task.wait(1/2)
								--if C.Beast.CarriedTorso.Value and C.Beast.CarriedTorso.Value.Parent==C.char then
								--	C.AvailableHacks.Beast[60].CaptureSurvivor(plr,C.char,true)
								--end
							end
						end
						--if human.FloorMaterial~=Enum.Material.Air then
						--	human:ChangeState(Enum.HumanoidStateType.Jumping)
						--end
						--task.wait(1/6)
					end
					RunS.RenderStepped:Wait()
					while TSM.DisableCrawl.Value do
						TSM.DisableCrawl.Changed:Wait()
					end
				end

			end,
			["ActivateFunction"]=function()
				--print("Bot Function Activated")
				trigger_setTriggers("BotRunner",true)
				local saveValue = C.enHacks.BotRunner
				human:SetAttribute("OverrideSpeed",nil)
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
					human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
					return 
				end
				local maxDurationLeft = 45
				local start = os.clock()
				while true do--for s=180,1,-1 do
					if isCleared or C.enHacks.BotRunner ~= saveValue then 
						return false 
					end
					local inGame,role = isInGame(C.char)
					--print(role,C.enHacks.BotRunner,C.Beast,myTSM.Health.Value)
					if role=="Runner" and (saveValue~="Freeze" or (C.Beast and C.Beast.PrimaryPart)) then
						--print("Bot "..saveValue.." Runner Activated After "..math.round(os.clock()-start).."/s="..s)
						break
					elseif maxDurationLeft <= 0 then 
						return false
					end
					maxDurationLeft-=RunS.RenderStepped:Wait() --task.wait(.25)
				end
				if C.enHacks.BotRunner ~= saveValue then
					return false
				end
				local savedValue=C.AvailableHacks.Bot[15].CurrentNum + 1
				C.AvailableHacks.Bot[15].CurrentNum = savedValue
				RunS.RenderStepped:Wait()--maybe wait a frame just in case, yk?
				if C.enHacks.BotRunner ~= saveValue then
					return false
				end
				C.AvailableHacks.Bot[15]["RUNNER"..saveValue](TSM,currentPath,savedValue)
			end,
			["MyStartUp"]=function(myPlr,myChar)

				isActionProgress=false;
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
						human:MoveTo(lastWayPoint.Position)
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
					if isActionProgress or not C.char.PrimaryPart then
						return false;
					end;
					local from=Torso.Position;
					local to = nextWayPoint.Position+newVector3(0,getHumanoidHeight(C.char),0);

					local didHit,instance=raycast(from,to,{"Whitelist",table.unpack(CS:GetTagged("DoorAndExit"))},5,0.001,true);
					local didHit2,instance2=raycast(from,to,{"Whitelist",C.Map},5,0.001,true);
					if nextWayPoint.Label=="DoorPath" or (didHit and (CS:HasTag(instance.Parent,"DoorAndExit") or CS:HasTag(instance.Parent.Parent,"DoorAndExit") or CS:HasTag(instance.Parent.Parent.Parent,"DoorAndExit"))) then
						return C.AvailableHacks.Bot[15].UnlockDoor(true);
					elseif (nextWayPoint.Label=="Vent" or (didHit2 and instance2.Name~="VentPartWalkThru") ) then
						return C.AvailableHacks.Bot[(15)].CrawlVent(true);
					elseif (to.Y>C.char.PrimaryPart.Position.Y and human.FloorMaterial~=Enum.Material.Air and not C.AvailableHacks.Blatant[(2)].IsCrawling and not isActionProgress) or nextWayPoint.Label=="Window" or (instance2~=nil and instance2.Name=="WindowWalkThru") then
						human:ChangeState(Enum.HumanoidStateType.Jumping);
						return true;
					end;
					return false;
				end;
				newPath.WaypointReached:Connect(waypointReached);
				table.insert(C.functs,TSM.ActionEvent.Changed:Connect(function(event)
					local path = C.AvailableHacks.Bot[(15)].CurrentPath
					if not isActionProgress and path~=nil and path._status==Path.StatusType.Active and event~=nil and string.find(event.Parent.Name,"DoorTrigger")~=nil and C.AvailableHacks.Bot[15].CurrentTarget~=nil then
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
						--createModifer(newPart,"NoWalkThru",false)
						Errors = Errors + 1;
						if Errors==3 then
							print("LEFT / err bruh",Errors);
							human:MoveTo(C.char.PrimaryPart.CFrame*newVector3(-4,0,0));
						elseif Errors>=10 then
							print("RESET / err bruh",Errors);
							C.AvailableHacks.Commands[24].ActivateFunction();
						else
							print("err bruh",Errors);
						end;
					end;
				end)
				local function TorsoTouched(hit)
					if hit.Name=="WindowWalkThru" and Path~=nil and C.AvailableHacks.Bot[15].CurrentTarget~=nil and human~=nil and human.Health>0 and human.FloorMaterial~=Enum.Material.Air then
						human:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end
				table.insert(C.functs,Torso.Touched:Connect(TorsoTouched))
				C.AvailableHacks.Bot[15].CurrentPath=newPath
				C.AvailableHacks.Bot[15].ActivateFunction(C.enHacks.BotRunner)
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				local function CaptureChanged()
					if not TSM.Captured.Value and human and theirPlr==plr then
						human:ChangeState(Enum.HumanoidStateType.Landed)
					end
					theirPlr:SetAttribute("HasCaptured",true)
				end
				table.insert(C.functs,TSM.Captured.Changed:Connect(CaptureChanged))
			end,
			["MyPlayerAdded"]=function()
				local function EscapeChanged()
					if not myTSM.Escaped.Value and C.enHacks.BotRunner then
						C.AvailableHacks.Bot[15].ActivateFunction(true)
					end
				end
				local function HealthChanged()
					--print("Health Changed",TSM.Health.Value,TSM.Escaped.Value,C.AvailableHacks.Bot[15].IsRunning)
					if myTSM.Health.Value>0 and not myTSM.Escaped.Value and C.enHacks.BotRunner and not C.AvailableHacks.Bot[15].IsRunning then
						--print("Activation Started")

						C.AvailableHacks.Bot[15].ActivateFunction(true)
						--warn("Activation Failed")
					end
				end
				table.insert(C.functs,myTSM.Escaped.Changed:Connect(EscapeChanged))
				table.insert(C.functs,myTSM.Health.Changed:Connect(HealthChanged))
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
				createModifer(walkThruPart,(ActionSign~=nil and (ActionSign.Value==10 or ActionSign.Value==12)) and "DoorPath" or "DoorOpened",true)
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
				avoidPart.Transparency=(hitBoxesEnabled and .7 or 1)
				avoidPart.CanCollide=false
				avoidPart.Name="AvoidPart"
				table.insert(C.AvailableHacks.Bot[15].AvoidParts,avoidPart)
				--local newWeld=Instance.new("Weld",avoidPart)
				--newWeld.Part0=theirTorso
				--newWeld.Part1=avoidPart
				createModifer(avoidPart,"Beast",false)
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
						newPart.Transparency = (hitBoxesEnabled and (0.6) or (1))
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
				local Data=C.AvailableHacks.Bot[15].MapData[C.Map.Name]
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
				elseif C.Map.Name=="The Library by Drainhp" then
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
				human:MoveTo(nextPoso)
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
							local result,hitPart=raycast(startPoso,nextPoso,{C.Map},nil,nil,true)
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
									return moveToFinished(currentPath,true)
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
					human:MoveTo(C.char:GetPivot().Position)
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
					local isInGame = isInGame(C.char)
					local Check1 = C.char~=nil and workspace:IsAncestorOf(C.char) and human~=nil and human.Health>0
					local Check2 = C.enHacks["AutoVote/Known"] and mapTarget and mapTarget.Board.SurfaceGui.Enabled
					local Check3 = not isInGame and ((SaveNum)==(C.AvailableHacks.Bot[23].CurrentNum)) and not isCleared
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
				--[[for num,board in pairs(MapVotingBoard:GetChildren()) do
					if string.sub(board.Name,1,8)=="MapBoard" then
						setChangedAttribute(board:WaitForChild("SurfaceGui"),
							"Enabled",
						function() 
							task.wait(1) 
							if not C.AvailableHacks.Bot[23].IsRunning then
								C.AvailableHacks.Bot[23].ActivateFunction() 
							end
						end)
					end
				end--]]
				local function RSUpdateGameStatusFunction()
					if (not C.AvailableHacks.Bot[23].IsRunning and not ({isInGame(C.char)})[1]) then
						C.AvailableHacks.Bot[23].ActivateFunction() 
					else
						--print(C.AvailableHacks.Bot[23].IsRunning)
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
				C.AvailableHacks.Bot[30].CurrentNum = C.AvailableHacks.Bot[30].CurrentNum + 1
				local saveNum=C.AvailableHacks.Bot[30].CurrentNum
				task.delay(3/2,function()
					while C.enHacks["Bot/AutoReset"] and C.Map and C.Beast==C.char and human and human.Health>0
						and saveNum==C.AvailableHacks.Bot[30].CurrentNum and not isCleared do
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
			["Default"]=botModeEnabled,["IsRunning"]=false,
			["ActivateFunction"]=function(en)
				if C.AvailableHacks.Bot[150].IsRunning then
					createCommandLine("<font color='rgb(255,0,0)'>Stuff is being purchased!!</font>")
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

				C.AvailableHacks.Bot[150].Funct=RemoteEvent.OnClientEvent:Connect(purchaseCrateFunction)

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
						createCommandLine("<font color='rgb(255,0,0)'>"..ErrorMessage.."</font>",warn)
						C.AvailableHacks.Bot[150].Funct:Disconnect()
						C.AvailableHacks.Bot[150].IsRunning=false
						return
					end
					task.wait()
				end
				local combinedStringForCommandLine = "All "..comma_value(totalCountToBuy).." Purchase"..(totalCountToBuy~=1 and "s" or "").." Succeeded in "..(math.round((os.clock()-startPurchase)*100)/100).."s"
				createCommandLine(combinedStringForCommandLine)
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
	},
	["Commands"]={
		[2]={
			["Type"]="ExTextButton",
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
				LS:ClearOutput() --rconsoleclear()
				BetterConsole_ClearConsoleFunction()
				clearCommandLines()
			end,
		},
		[3]={
			["Type"]="ExTextButton",
			["Title"]="Get Console Logs",
			["Desc"]="Activate To See Console Logs",
			["Shortcut"]="ClearConsole",
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
					createCommandLine(C.AvailableHacks.Commands[3].MessageTypeColors[logItem.messageType]..logItem.message.."</font>")
				end
				--for num, logItem in ipairs() do
				--if  - (100 - (#fullHistory - num) > 0 then
				--end
				--end
			end,
		},
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
					local obj=C.char:FindFirstChild(findName,recurseLoop)
					if obj~=nil then
						obj:Destroy()
					end
				end
				Remove("LocalClubScript",true)
				Remove("BackgroundMusicLocalScript")
				createCommandLine("Reset Sequence Activated")
			end,
			["ActivateFunction"]=function(newValue)
				if C.char~=nil and human~=nil and C.char.Parent~=nil then
					local saveChar = C.char
					C.AvailableHacks.Commands[24].BeforeReset()
					if C.char.PrimaryPart then
						C.char.PrimaryPart.Anchored=true
					end
					if C.char:FindFirstChild("Head") then
						C.char.Head:Destroy()
					elseif human.Health>0 then
						human.Health = 0
					end
					task.wait(1);
					teleportMyself(CFrame.new(1e3,1e-3,1e3))
					task.wait(.25);
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
						if C.char==saveChar and botModeEnabled and C.enHacks.BotRunner and not isCleared then
							createCommandLine("<font color='rgb(255,0,0)'>Reset Activation Sequence Failed.".."Auto Kicking Sequence Begun</font>",error)
							plr:Kick("Reset Activation Failed")
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
					return not isCleared and savedDeb == C.AvailableHacks.Commands[30].SaveDeb and C.refreshEnHack["Cmds_HackAllPCs"]
				end

				if not newValue then return end
				local ActionProgress = myTSM:WaitForChild("ActionProgress")
				local actionTable = {}
				C.AvailableHacks.Commands[30].Funct = ActionProgress.Changed:Connect(function(newValue)
					if newValue > .97 then
						print("Stopped Hacking On Purpose!")
						local event = actionTable[1]
						table.remove(actionTable,1)
						RemoteEvent:FireServer("Input","Trigger",false,event)
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
						teleportMyself(trigger:GetPivot()*CFrame.new(0,0,.1)+Vector3.new(0,-trigger.Size.Y/2+getHumanoidHeight(C.char)))
						task.wait(.5)
						if not canRun() then return end
						table.insert(actionTable,trigger.Event)
						print("LastPC2",trigger_enabledNames["LastPC"])
						while trigger_enabledNames["LastPC"] and not trigger_enabledNames["LastPC"].Computer do

							RunS.RenderStepped:Wait()
						end
						myTSM:WaitForChild("ActionEvent").Value = trigger.Event
						task.wait(.5)
						local lastPCSave = lastHackedPC
						for s = 15, 1, -1 do
							if not canRun() then return end--or hackedPCS>=1 then return end
							myTSM:WaitForChild("ActionEvent").Value = trigger.Event
							task.wait()
							RemoteEvent:FireServer("Input","Trigger",true,trigger.Event)
							task.wait(.3)
							if not canRun() then return end
							RemoteEvent:FireServer("Input","Action",true)
							task.wait(.3)
							if not canRun() then return end
							if lastHackedPC ~= lastPCSave then
								print("PC Hack Change Detected")
							end
							if lastHackedPC == pc or s == 5 then
								print("PC Hack Successful!")
								myTSM.CurrentAnimation.Value = ""
								hackedPCS+=1
								break
							elseif s == 1 then
								createCommandLine("[Hack All PCs]: PC HACK FAIL TIMEOUT!",warn)
								hackedPCS+=1
								return C.refreshEnHack["Cmds_HackAllPCs"](false)
							end
						end
						task.wait(.1)
						if not canRun() then return end
						RemoteEvent:FireServer("Input","Action",false)

					end

				end
				if not canRun() then return end
				C.refreshEnHack["Cmds_HackAllPCs"](true)
				task.wait(3)
				if not canRun() then return end
				C.refreshEnHack["Cmds_HackAllPCs"](false)
			end,
			["CleanUp"]=function()
				if isCleared or C.refreshEnHack["Cmds_HackAllPCs"] then
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
	if not C.AvailableHacks then
		return
	end
	for hackType,hackList in pairs(C.AvailableHacks) do
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
--BOT TRADE SYS--
if gameName=="FleeTrade" then
	for crateName, crateData in pairs(requireModule(RS:WaitForChild("ShopCrates"))) do
		if not crateData.CostRobux then
			C.AvailableHacks.Bot[143].Options[crateName]={
				["Title"]=crateData.Name.. " ("..comma_value(crateData.Price)..")",
				["TextColor"]=ComputeNameColor(crateData.Name),
			}
			if not C.AvailableHacks.Bot[143].Default then
				C.AvailableHacks.Bot[143].Default = crateName
			end
		end
	end
	local HasBundles = false
	for bundleName, bundleData in pairs(requireModule(RS:WaitForChild("ShopBundles"))) do
		if not bundleData.CostRobux then
			C.AvailableHacks.Bot[146].Options[bundleName]={
				["Title"]=bundleData.Name.. " ("..comma_value(bundleData.Price)..")",
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
--if plr:GetAttribute("Cleared"..getID) then plr:SetAttribute("Cleared"..getID,false) end
local previousCopy = (plr:GetAttribute(getID)~=nil)
plr:SetAttribute(getID,C.saveIndex)
local attributeChangedSignal
local function attributeAddedFunction()
	if attributeChangedSignal then
		attributeChangedSignal:Disconnect()
		attributeChangedSignal=nil
	end
	local newIndex = plr:GetAttribute(getID)
	if clear==nil then
		isCleared=true
		print("Clear Not Found!",C.saveIndex)
		DS:AddItem(script,15)
		return
	end
	--if newIndex~=C.saveIndex then
	clear()
	--end
end

if script==nil or plr:GetAttribute(getID)~=C.saveIndex then
	setChangedAttribute()
	return "Saved Index Changed (Code 101)"
end
attributeChangedSignal = plr:GetAttributeChangedSignal(getID):Connect(attributeAddedFunction)
table.insert(C.functs,attributeChangedSignal)

C.PlayerControlModule = require(plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

--DELETION--
clear = function(isManualClear)
	isCleared=true
	if HackGUI then
		HackGUI.Enabled=false
	end
	if DraggableMain then DraggableMain:Disable() end
	--plr:SetAttribute(getID,nil)
	if (C.AvailableHacks.Bot[15] and C.AvailableHacks.Bot[15].CurrentPath~=nil) then
		C.AvailableHacks.Bot[15].CurrentPath:Stop()
	end
	if gameName == "FleeMain" then
		C.AvailableHacks.Utility[8].CleanUp()--beast hammer
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
	for userID,functList in pairs(C.playerEvents) do
		for num,funct in pairs(functList or {}) do
			funct:Disconnect();
			funct=nil;
		end;
	end;
	if isManualClear then
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
		--local CrawlScript=C.char:WaitForChild("CrawlScript") 
		--if CrawlScript then
		--	CrawlScript.Disabled=false
		--end
		C.AvailableHacks.Utility[2].ActivateFunction(false)--disable override zooming
		C.AvailableHacks.Basic[40].ActivateFunction(false)--disable reset button again!
		C.AvailableHacks.Basic[20].ActivateFunction(false)--make invisible walls unable to walk through again!
	else
		getgenv().enHacks = table.clone(C.enHacks)
	end
	saveSaveData()--save before we delete stuff!
	for hackName,enabled in pairs(C.enHacks) do
		C.enHacks[hackName]=nil;  --disables all running hacks to stop them!
	end;--effectively disables all hacks!
	C.AvailableHacks.Basic[4].ActivateFunction(false);--disble hacks
	C.AvailableHacks.Basic[4].ActivateFunction(false);--disable hacks
	C.AvailableHacks.Basic[1].UpdateSpeed();--disable walkspeed
	human:SetAttribute("OverrideSpeed",nil)

	if gameUniverse=="Flee" then
		if C.AvailableHacks.Beast and C.AvailableHacks.Beast[2]  then
			C.AvailableHacks.Beast[2].IsCrawling=false;--disable crawl
			C.AvailableHacks.Beast[2].Crawl(false);--disable crawl
		end
	end
	if C.AvailableHacks.Basic and C.AvailableHacks.Basic[30]  then
		C.AvailableHacks.Basic[30].ActivateFunction(false);--disable crawl
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
	for category, categoryList in pairs(C.AvailableHacks) do
		for index,tbl in pairs(categoryList) do
			local funcList = tbl.Functs or {}
			table.insert(funcList,tbl.Funct)
			for _, funct in ipairs(funcList) do
				local check = (funct and typeof(funct))
				if (check=="RBXScriptConnection") then
					funct:Disconnect()
				end
			end
		end
	end
	for num,funct in ipairs(C.functs) do
		funct:Disconnect()
		funct=nil
	end
	hackChanged:Fire()
	hackChanged:Destroy()
	CAS:UnbindAction("hack_jump"..C.saveIndex)
	CAS:UnbindAction("Crawl"..C.saveIndex)
	CAS:UnbindAction("CloseMenu"..C.saveIndex)
	CAS:UnbindAction("PushSlash"..C.saveIndex)
	CAS:UnbindAction("OpenBetterConsole"..C.saveIndex)

	local searchList = C.objectFuncts or {}
	for obj,objectEventsList in pairs(searchList) do
		local insideSearchList = objectEventsList or {}
		for value,funct in pairs(insideSearchList) do
			if funct~=nil then
				funct:Disconnect()
				funct=nil
			end
		end
	end


	getgenv()["ActiveScript"..getID][C.saveIndex] = nil

	plr:SetAttribute("Cleared"..getID,(plr:GetAttribute("Cleared") or 0)+1)
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
	local maxWaitTime=3
	local function maxWaitTimeReturnFunction()
		if not changedEvent then
			return
		end
		changedEvent:Fire()
	end
	task.delay(maxWaitTime,maxWaitTimeReturnFunction)
	changedEvent:AddTag("RemoveOnDestroy")
	local function clearFunct()
		changedEvent:Fire()
	end
	local clearedConnection=(plr:GetAttributeChangedSignal("Cleared"..getID):Connect(clearFunct))
	local currentSize = getDictLength(getgenv()["ActiveScript"..getID])
	while currentSize>0 do
		changedEvent.Event:Wait()
		--[[while currentSize == getDictLength(getgenv()["ActiveScript"..getID]) do
			warn("waiting",getDictLength(getgenv()["ActiveScript"..getID]),currentSize,getgenv()["ActiveScript"..getID])
			RunS.RenderStepped:Wait()
		end--]]
		currentSize = getDictLength(getgenv()["ActiveScript"..getID])
		if isCleared then
			DS:AddItem(script,1)
			clearedConnection:Disconnect()
			return "Cleared While Waiting (Code 102)"
		end
		if os.clock()-startTime>=maxWaitTime then
			warn(( "Maximum Wait Time Reached ("..maxWaitTime.."s), Starting Script..." ))
			break
		elseif currentSize>0 then
			createCommandLine("Dict Length Still Larger Than Zero After One Cycle!\nThis may have occured if one or more instances already exist!",print)
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
getgenv()["ActiveScript"..getID][C.saveIndex] = true
--local startTime = os.clock()--DEL
--print(("Starting Instance %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

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
	JumpButton = plr.PlayerGui:WaitForChild("TouchGui",math.huge):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton",math.huge);
	table.insert(C.functs, JumpButton:GetPropertyChangedSignal("ImageRectOffset"):Connect(function()
		org = isJumpBeingHeld
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
		selectedKey = (C.enHacks[hackInfo.Shortcut]);
		selectedOption = hackInfo.Options[selectedKey];
		ToggleButton = hackFrame:WaitForChild("Toggle",60)
		if isCleared then
			if not ToggleButton then
				return error("SEEMS GOOD: TOGGLE DOESN'T EXIST FOR "..hackInfo.Title)
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
		local function cycle(delta)
			local totalNum, shortCutNum = 0, 0;
			for Type,Vals in pairs(hackInfo.Options) do
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
			local loopThru = hackInfo.Options
			for Type,Vals in pairs(loopThru) do
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
		local function hackFrameToggleButtonFunction()
			cycle(1)
		end
		local HackFrameMSBUp = hackFrame.Toggle.MouseButton1Up:Connect(hackFrameToggleButtonFunction)
		table.insert(C.functs,HackFrameMSBUp)
		if ((getDictLength(hackInfo.Options))>(2)) then
			local function hackFrameReverseToggleButtonFunction()
				cycle(-1)
			end
			local MSBUp = hackFrame.Toggle.MouseButton2Up:Connect(hackFrameReverseToggleButtonFunction)
			table.insert(C.functs,MSBUp)
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

local hacks2LoopThru = (C.AvailableHacks or {})
for categoryName, differentHacks in pairs(hacks2LoopThru) do
	local newButton, newProperty
	for num,hack in pairs(differentHacks) do
		if isCleared then
			return "Load Hacks Cleared (Code 104)"
		elseif not hack then
			differentHacks[num] = nil -- clear this so that it isn't referenced again-
			continue -- skip this lol!
		end
		local canPass = categoryName=="Basic" or (((hack.Universes and (table.find(hack.Universes,"Global") or table.find(hack.Universes,gameUniverse))) or (not hack.Universes and not hack.Places and gameName=="FleeMain")) or (hack.Places and table.find(hack.Places,gameName)));
		if canPass then
			if not newButton or not newProperty then
				newButton = MainListEx:Clone()
				newButton.Text = categoryName
				newButton.TextColor3 = ComputeNameColor(categoryName)
				newButton.Name = categoryName
				newButton.LayoutOrder = (categoryName=="Commands" and 1 or 0)
				newButton.Parent=myList

				newProperty = PropertiesEx:Clone()
				newProperty.Parent = Properties
				newProperty.Name = categoryName
				newProperty.Visible=false
				local function newButtonMB1Up()
					C.Console.Visible = false
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
			local overrideDefault
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
				(hack.Type=="ExTextBox" and (overrideDefault < hack.MinBound or overrideDefault > hack.MaxBound))) then
				warn("Invalid Option For "..tostring(hack.Title)..": "..tostring(overrideDefault)..". Reverting To Original...")
				overrideDefault = nil
			end
			if overrideDefault~=nil then
				C.enHacks[hack.Shortcut]=overrideDefault;
			else
				C.enHacks[hack.Shortcut]=hack.Default;
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

			local initilizationType_FUNCTION = initilizationTypes[hack.Type];
			task.spawn(initilizationType_FUNCTION,hack);
			local update_Function = refreshTypes[hack.Type]
			C.refreshEnHack[hack.Shortcut] = function(new)
				C.enHacks[hack.Shortcut] = new
				update_Function(miniHackFrame,hack)
			end
		else
			differentHacks[num]=nil
		end
	end
end

--print(("Hacks Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

--COMMAND BAR CONTROL

local function consoleButtonControlFunction()
	C.Console.Visible = not C.Console.Visible
	Properties.Visible = not Properties.Visible
end

C.ConsoleButton.MouseButton1Up:Connect(consoleButtonControlFunction)

--HACK CONTROL
local function BeastAdded(theirPlr,theirChar)
	local Hammer = theirChar:WaitForChild("Hammer",30)
	if not Hammer or not theirChar.Parent or not Hammer.Parent then
		return
	end
	C.Beast=theirChar;
	local inputArray = {
		theirPlr, 
		theirChar
	};
	local function2Input = theirPlr==plr and "MyBeastAdded" or "OthersBeastAdded";
	defaultFunction(function2Input,inputArray);
	defaultFunction("BeastAdded",inputArray);
	table.insert(C.functs,Hammer.AncestryChanged:Connect(function(newParent)
		C.Beast=nil
		local inputArray = {theirPlr,theirChar}
		defaultFunction((theirPlr==plr and "MyBeastRemoved" or "OthersBeastRemoved"),(inputArray))
	end))
end
local function CharacterAdded(theirChar)
	if isCleared then
		return
	end
	TPStack = {}--clears TPStack!
	isTeleporting = false--if its still teleporting then stap it!
	task.wait()
	local theirPlr=PS:GetPlayerFromCharacter(theirChar)
	local theirHumanoid=theirChar:WaitForChild("Humanoid")
	local hrp=theirChar:WaitForChild("HumanoidRootPart",1) or theirChar.PrimaryPart

	local isMyChar=theirPlr==plr
	if isMyChar then
		C.char=theirChar
		human=theirHumanoid
	end
	local inputFunctions = ({theirPlr,theirChar})
	defaultFunction(isMyChar and "MyStartUp" or "OthersStartUp",inputFunctions)
	if gameUniverse=="Flee" then
		local theirTSM = theirPlr:WaitForChild("TempPlayerStatsModule");
		if theirTSM then
			local isBeastValue = theirTSM:WaitForChild("IsBeast");
			if isBeastValue and isBeastValue.Value then
				BeastAdded(theirPlr,theirPlr.Character);
			end
		end
	end
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
	C.playerEvents[theirPlr.UserId] = {}
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
	table.insert(C.playerEvents[theirPlr.UserId], CharacterAddedConnection);
	local function characterRemovingFunction(removingChar)
		CharacterRemoving(theirPlr,removingChar);
	end
	--bro please work!

	local PlayerAddedConnection = theirPlr.CharacterRemoving:Connect(characterRemovingFunction);
	table.insert(C.playerEvents[theirPlr.UserId], PlayerAddedConnection);
	if myBots[theirPlr.Name:lower()] and botModeEnabled then
		--print("Listening For",theirPlr.Name)
		table.insert(C.playerEvents[theirPlr.UserId], theirPlr.Chatted:Connect(function(message)
			--print(theirPlr.Name,"Messaged:!",message)
			if message:lower() == "/re" then
				C.AvailableHacks.Basic[99].ActivateFunction()
			elseif message:lower() == "/reset" then
				C.AvailableHacks.Basic[99].ActivateFunction(true,true)
			end
		end))
	end

	if gameUniverse=="Flee" then
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
			if (C.Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda") then
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
		table.insert(C.functs,child.AncestryChanged:Connect(DescendantRemoving));
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
	table.insert(C.functs,object.ChildAdded:Connect(function(child)
		if isCleared then return end
		local function IntermediateDescendantRemovingFunction(newParent)
			DescendantRemoving(child);
		end;
		table.insert(C.functs,child.AncestryChanged:Connect(IntermediateDescendantRemovingFunction));
		registerfunct(child,false)
	end))
	for num, lowerobject in ipairs(object:GetChildren()) do
		local function IntermediateDescendantRemovingFunction(newParent)
			DescendantRemoving(lowerobject);
		end;
		task.spawn(registerfunct,lowerobject,shouldntWait)
		table.insert(C.functs,lowerobject.AncestryChanged:Connect(IntermediateDescendantRemovingFunction));
	end
end
local function updateCurrentMap(newMap)
	if newMap ~= C.Map and newMap then
		C.Map = newMap;
		task.wait(1);
		if isCleared then return end
		local inputArray = {newMap};
		defaultFunction("MapAdded",{newMap});
		task.spawn(registerObject,newMap,MapChildAdded)
		table.insert(C.functs,newMap.AncestryChanged:Connect(function(newParent)
			updateCurrentMap(nil)
		end))
	elseif C.Map and not newMap then
		local clonedMap = C.Map
		C.Map = nil; C.Beast = nil;
		defaultFunction("CleanUp",{clonedMap})
	end
end

--print(("Functions Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

if gameName == "FleeMain" then
	local MapChangedValue = RS:WaitForChild("CurrentMap")

	task.spawn(updateCurrentMap,MapChangedValue.Value)
	table.insert(C.functs,MapChangedValue.Changed:Connect(updateCurrentMap))
end

table.insert(C.functs,PS.PlayerAdded:Connect(PlayerAdded))

local function intermediatePlayerRemovingFunction(theirPlr)
	if plr==theirPlr then
		if not isCleared then
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
	task.spawn(PlayerAdded,theirPlr)
end

--print(("Players Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

--MENU FUNCTS
if gameName=="FleeMain" then
	local lastPC_time
	local currentAnimation = myTSM:WaitForChild("CurrentAnimation")
	local lastAnimationName
	local function getPC(obj)
		if obj:HasTag("Computer") then
			return obj
		elseif obj == workspace or obj == C.Map then
			return
		end
		return getPC(obj.Parent)
	end
	local function updateAnimation(newValue)
		if newValue=="Typing" then
			print("New PC Found!")
			lastHackedPC = getPC(myTSM.ActionEvent.Value)
			if not lastHackedPC then
				if not myTSM.ActionEvent.Value then
					warn("PC Not Found: ActionEvent.Value nil")
				else
					warn("PC Not Found:",myTSM.ActionEvent.Value:GetFullName())
				end
			end
		elseif lastHackedPC and lastAnimationName=="Typing" then
			lastPC_time = os.clock() print("Triggers Disabled")
			trigger_setTriggers("LastPC",{Computer=false,AllowExceptions = {lastHackedPC}})
			local timeNeeded = (0.15+math.max((70)/minSpeedBetweenPCs,absMinTimeBetweenPCs))

			task.delay(timeNeeded,function()
				if (os.clock() - lastPC_time) >= timeNeeded then
					trigger_setTriggers("LastPC",{Computer=true})
					print("Triggers Enabled After",timeNeeded)
				end
			end)
		end
		lastAnimationName = newValue
		defaultFunction("AnimationChanged",newValue)
	end
	setChangedAttribute(currentAnimation,"Value",updateAnimation)
	updateAnimation()
	trigger_setTriggers("StartUp",{Computer=false})
	task.delay(5,trigger_setTriggers,"StartUp",{Computer=true})--careful with computers at the start!


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
		table.insert(C.functs,ancestryChangedInput_CONNECTION)
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

	for _,theirPlr in pairs(PS:GetPlayers()) do
		calculateCreditsForPlayer(theirPlr);
	end;
end;

--print(("Game Specific Functs Loaded %i (%.2f)"):format(C.saveIndex,os.clock()-startTime))--DEL

DraggableMain=DraggableObject.new(Main)
DraggableMain:Enable()

local function CloseMenu(actionName, inputState, inputObject)
	if inputState==Enum.UserInputState.Begin and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or inputObject.UserInputType ~= Enum.UserInputType.Keyboard) then
		local newMain = not Main.Visible
		Main.Visible=newMain
		if newMain then
			DraggableMain:Enable()
			C.BetterConsole.Visible = false
		else
			DraggableMain:Disable()
		end
	end
end
CAS:BindActionAtPriority("CloseMenu"..C.saveIndex,CloseMenu,true,1e5,Enum.KeyCode.V)


return "Hack Successfully Executed V1.02!"
