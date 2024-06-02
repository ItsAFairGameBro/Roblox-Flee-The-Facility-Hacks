local RS = game:GetService("ReplicatedStorage")
return function(C,createToggleButton,textFont,textFont2,textFont3,mainZIndex)
	local GuiElements = {}
	
	--local Instance.new = Instance["new"];
	local ExTextButton = Instance.new("Frame");

	local Toggle = Instance.new("TextButton");

	createToggleButton(Toggle, ExTextButton);


	local ExTextBox = Instance.new("Frame");


	local Desc = Instance.new("TextLabel");



	local Title_2 = Instance.new("TextLabel");
	--pls work
	local Desc_2 = Instance.new("TextLabel");
	GuiElements.MyTextBox = Instance.new("TextBox");

	GuiElements.MainListEx = Instance.new("TextButton");
	GuiElements.HackGUI = Instance["new"]("ScreenGui");

	GuiElements.Main = Instance.new("Frame")


	--pls work
	local UIListLayout = Instance.new("UIListLayout");
	GuiElements.Properties = Instance.new("Frame");
	GuiElements.PropertiesEx = Instance.new("ScrollingFrame");
	local UIListLayout_2 = Instance.new("UIListLayout");
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder;
	UIListLayout_2.Padding = UDim.new(0, 20);
	UIListLayout_2.Parent = GuiElements.PropertiesEx;

	GuiElements.NameTagEx = Instance.new("BillboardGui");
	local ExpandingBar = Instance.new("Frame");
	local AmtFinished = Instance.new("Frame");
	C.ToggleTag = Instance.new("BillboardGui");
	local ToggleButton = Instance.new("TextButton");
	C.TestPart = Instance.new("Part");
	C.TestPart.Parent = RS;
	GuiElements.XPGained = Instance.new("TextLabel");
	GuiElements.CreditsGained = Instance.new("TextLabel");
	GuiElements.ServerXPGained = Instance.new("TextLabel");
	GuiElements.ServerCreditsGained = Instance.new("TextLabel");
	C.Console = Instance.new("ScrollingFrame");
	local UIListLayout2 = Instance.new("UIListLayout");
	C.ConsoleButton = Instance.new("ImageButton");
	C.CommandBarLine = Instance.new("TextLabel");

	GuiElements.TextBoxExamples = {};

	GuiElements.HackGUI.DisplayOrder = (50);

	ExTextButton.Name = "ExTextButton";
	ExTextButton.Parent = RS;
	ExTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	ExTextButton.BackgroundTransparency = 1.000;
	ExTextButton.Size = UDim2.new(1, -6, 0, 40);
	GuiElements.TextBoxExamples["ExTextButton"] = ExTextButton;

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
	GuiElements.TextBoxExamples["ExTextBox"] = ExTextBox;
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
	GuiElements.MyTextBox.AnchorPoint = Vector2.new(1, 0);
	GuiElements.MyTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	GuiElements.MyTextBox.BackgroundTransparency = 1.000;
	GuiElements.MyTextBox.Position = UDim2.new(1, 0, 0, 0);
	GuiElements.MyTextBox.Size = UDim2.new(0.442999989, 0, 1, 0);
	GuiElements.MyTextBox.Font = textFont;
	GuiElements.MyTextBox.Text = "0";
	GuiElements.MyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
	GuiElements.MyTextBox.TextScaled = true;
	GuiElements.MyTextBox.TextSize = C.textBoxSize;
	GuiElements.MyTextBox.TextStrokeTransparency = 0.000;
	GuiElements.MyTextBox.TextWrapped = true;
	GuiElements.MyTextBox.ClearTextOnFocus = false;
	GuiElements.MyTextBox.Parent = ExTextBox;


	GuiElements.MainListEx.Name = "MainListEx";
	GuiElements.MainListEx.BackgroundTransparency = 1;
	GuiElements.MainListEx.Size = UDim2.new(1, 0, 0, 25);
	GuiElements.MainListEx.Font = textFont;
	GuiElements.MainListEx.TextStrokeColor3 = Color3.fromRGB();
	GuiElements.MainListEx.TextStrokeTransparency = 0
	GuiElements.MainListEx.TextScaled = true;
	GuiElements.MainListEx.TextWrapped = true;

	GuiElements.HackGUI.Name = "HackGUI";
	GuiElements.HackGUI.ResetOnSpawn = false;

	GuiElements.HackGUI.Parent = C.hackGUIParent;
	GuiElements.HackGUI.DisplayOrder = (-100);

	GuiElements.Main.Name = "Main"
	GuiElements.Main.Parent = GuiElements.HackGUI
	GuiElements.Main.AnchorPoint = Vector2.new(0.5, 0.5)
	GuiElements.Main.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
	GuiElements.Main.Position = UDim2.new(0.25, 0, 0.75, 0)

	GuiElements.Main["Size"] = (UDim2.new(0.39, 0, 0.3375, 0))

	GuiElements.myList = Instance.new("ScrollingFrame");
	GuiElements.myList.Parent = GuiElements.Main;
	GuiElements.myList.BackgroundColor3 = Color3.fromRGB(52, 52, 52);
	GuiElements.myList.BackgroundTransparency = (1);
	GuiElements.myList.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	GuiElements.myList.ScrollingDirection = Enum.ScrollingDirection.Y;
	GuiElements.myList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
	GuiElements.myList.ScrollBarThickness = 3;
	GuiElements.myList.Size = UDim2.new(0.245, 0, 1, 0)
	GuiElements.myList.CanvasSize = UDim2.new(0, 0, 0, 0)
	GuiElements.myList.Name = ("myList")
	UIListLayout.Parent = GuiElements.myList
	UIListLayout.Padding = UDim.new(0, 20)

	GuiElements.Properties.Name = "Properties"
	GuiElements.Properties.Parent = GuiElements.Main
	GuiElements.Properties.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GuiElements.Properties.BackgroundTransparency = (1)
	GuiElements.Properties.Size = UDim2.new(1, 0, 1, 0)

	GuiElements.PropertiesEx.Name = "PropertiesEx"
	GuiElements.TextBoxExamples.PropertiesEx = GuiElements.PropertiesEx
	GuiElements.PropertiesEx.Size = UDim2.new(0.71, 0, 1, 0);
	GuiElements.PropertiesEx.ScrollBarThickness = (6);
	GuiElements.PropertiesEx.BackgroundColor3 = Color3.fromRGB(52, 52, 52);
	GuiElements.PropertiesEx.Position = UDim2.new(0.291, 0, 0, 0);
	GuiElements.PropertiesEx.CanvasSize = UDim2.new(0, 0, 0, 0);
	GuiElements.PropertiesEx.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	GuiElements.PropertiesEx.ScrollingDirection = Enum.ScrollingDirection.Y;



	GuiElements.PropertiesEx.BackgroundTransparency = 1;

	GuiElements.NameTagEx.Size = UDim2.new(3, 40, 0.7, 10);
	GuiElements.NameTagEx.LightInfluence = (1);
	GuiElements.NameTagEx.Name = "NameTagEx";
	GuiElements.NameTagEx.ExtentsOffsetWorldSpace = Vector3.new(0, 3, 0);
	GuiElements.NameTagEx.AlwaysOnTop = (true);




	local Username = Instance.new("TextLabel");
	Username.BackgroundColor3 = Color3.new(1,1,1);

	Username.Name = "Username";
	Username.Parent = GuiElements.NameTagEx;



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
	DistanceTL.Font = textFont3;
	DistanceTL.TextColor3 = distanceTLColor3;
	DistanceTL.TextScaled = true;
	DistanceTL.TextSize = 14;
	DistanceTL.BackgroundTransparency = 1;
	DistanceTL.TextStrokeTransparency = 0;
	DistanceTL.TextWrapped = true;
	DistanceTL.Name = "Distance";
	DistanceTL.Parent = GuiElements.NameTagEx;







	DistanceTL.Position = distanceTLPOSO;


	Username.TextColor3 = Color3.fromRGB(0, 0, 255)


	ExpandingBar.Name = ("ExpandingBar")
	ExpandingBar.Parent = (GuiElements.NameTagEx)
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

	C.ToggleTag.Name = "ToggleTag"
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

	GuiElements.XPGained.Name = "XPGained"
	GuiElements.XPGained.Parent = GuiElements.Main
	GuiElements.XPGained.BackgroundColor3 = Color3.new(1, 1, 1)
	GuiElements.XPGained.BackgroundTransparency = 1
	GuiElements.XPGained.Position = UDim2.new(0.5, 0, 1, 0)
	GuiElements.XPGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	GuiElements.XPGained.ZIndex = (mainZIndex + 1)
	GuiElements.XPGained.Font = textFont
	GuiElements.XPGained.Text = " "
	GuiElements.XPGained.TextColor3 = Color3.new(0, 1, 0)
	GuiElements.XPGained.TextScaled = true
	GuiElements.XPGained.TextStrokeTransparency = 0
	GuiElements.XPGained.TextWrapped = true
	GuiElements.XPGained.TextXAlignment = Enum.TextXAlignment.Right

	GuiElements.CreditsGained.Name = "CreditsGained"
	GuiElements.CreditsGained.Parent = GuiElements.Main
	GuiElements.CreditsGained.BackgroundColor3 = Color3.new(1, 1, 1)
	GuiElements.CreditsGained.BackgroundTransparency = 1
	GuiElements.CreditsGained.Position = UDim2.new(-0, 0, 1, 0)
	GuiElements.CreditsGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	GuiElements.CreditsGained.ZIndex = (mainZIndex + 1)
	GuiElements.CreditsGained.Font = textFont
	GuiElements.CreditsGained.Text = " "
	GuiElements.CreditsGained.TextColor3 = Color3.new(1, 0.8, 0)
	GuiElements.CreditsGained.TextScaled = true
	GuiElements.CreditsGained.TextStrokeTransparency = 0
	GuiElements.CreditsGained.TextWrapped = true
	GuiElements.CreditsGained.TextXAlignment = Enum.TextXAlignment.Left

	GuiElements.ServerXPGained.Name = "ServerXPGained"
	GuiElements.ServerXPGained.Parent = GuiElements.Main
	GuiElements.ServerXPGained.BackgroundColor3 = Color3.new(1, 1, 1)
	GuiElements.ServerXPGained.BackgroundTransparency = 1
	GuiElements.ServerXPGained.Position = UDim2.new(0.5, 0, 1.12, 0)
	GuiElements.ServerXPGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	GuiElements.ServerXPGained.Font = textFont
	GuiElements.ServerXPGained.Text = " "
	GuiElements.ServerXPGained.TextColor3 = Color3.new(0, 1, 0)
	GuiElements.ServerXPGained.TextScaled = true
	GuiElements.ServerXPGained.TextStrokeTransparency = 0
	GuiElements.ServerXPGained.TextWrapped = true
	GuiElements.ServerXPGained.TextXAlignment = Enum.TextXAlignment.Right

	GuiElements.ServerCreditsGained.Name = "ServerCreditsGained"
	GuiElements.ServerCreditsGained.Parent = GuiElements.Main
	GuiElements.ServerCreditsGained.BackgroundColor3 = Color3.new(1, 1, 1)
	GuiElements.ServerCreditsGained.BackgroundTransparency = 1
	GuiElements.ServerCreditsGained.Position = UDim2.new(-0, 0, 1.12, 0)
	GuiElements.ServerCreditsGained.Size = UDim2.new(0.5, 0, 0.12, 0)
	GuiElements.ServerCreditsGained.ZIndex = (mainZIndex + 1)
	GuiElements.ServerCreditsGained.Font = textFont
	GuiElements.ServerCreditsGained.Text = " "
	GuiElements.ServerCreditsGained.TextColor3 = Color3.new(1, 0.8, 0)
	GuiElements.ServerCreditsGained.TextScaled = true
	GuiElements.ServerCreditsGained.TextStrokeTransparency = 0
	GuiElements.ServerCreditsGained.TextWrapped = true
	GuiElements.ServerCreditsGained.TextXAlignment = Enum.TextXAlignment.Left

	C.Console.Name = "C.Console"
	C.Console.Parent = GuiElements.Main
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

	C.ConsoleButton.Name = "ConsoleButton"
	C.ConsoleButton.Parent = GuiElements.Main
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

	C.CommandBarLine.Name = "CommandBarLine"
	GuiElements.TextBoxExamples["CommandBarLine"] = C.CommandBarLine
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
	
	
	
	
	
	
	
	
	
	
	local Actions = Instance.new("Frame")
	local ActionsList = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ActionsEx = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local StopButton = Instance.new("TextButton")
	local Time = Instance.new("TextLabel")
	local ActionsTitleLabel = Instance.new("TextLabel")

	--Properties:

	Actions.Name = "Actions"
	Actions.Parent = GuiElements.HackGUI
	Actions.AnchorPoint = Vector2.new(0, 0.5)
	Actions.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
	Actions.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Actions.BorderSizePixel = 0
	Actions.Position = UDim2.new(0, 0, 0.5, 0)
	Actions.Size = UDim2.new(0.100000001, 0, 0.200000003, 0)

	ActionsList.Name = "ActionsList"
	ActionsList.Parent = Actions
	ActionsList.AnchorPoint = Vector2.new(0, 1)
	ActionsList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ActionsList.BackgroundTransparency = 1.000
	ActionsList.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ActionsList.BorderSizePixel = 0
	ActionsList.Position = UDim2.new(0, 0, 0.958245993, 0)
	ActionsList.Size = UDim2.new(1, 0, 0.80384773, 0)
	ActionsList.ZIndex = 5001
	ActionsList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ActionsList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

	UIListLayout.Parent = ActionsList
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	ActionsEx.Name = "ActionsEx"
	ActionsEx.Parent = script
	ActionsEx.BackgroundColor3 = Color3.fromRGB(255, 204, 74)
	ActionsEx.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ActionsEx.BorderSizePixel = 0
	ActionsEx.Size = UDim2.new(1, 0, 0, 35)

	Title.Name = "Title"
	Title.Parent = ActionsEx
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(1, 0, 0.5, 0)
	Title.Font = Enum.Font.SourceSans
	Title.Text = "HACKING COMPUTER 5"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextStrokeTransparency = 0.000
	Title.TextWrapped = true

	StopButton.Name = "StopButton"
	StopButton.Parent = ActionsEx
	StopButton.AnchorPoint = Vector2.new(1, 1)
	StopButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	StopButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	StopButton.BorderSizePixel = 0
	StopButton.Position = UDim2.new(1, 0, 1, 0)
	StopButton.Size = UDim2.new(0.5, 0, 0.5, 0)
	StopButton.Font = Enum.Font.SourceSans
	StopButton.Text = "STOP"
	StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	StopButton.TextScaled = true
	StopButton.TextSize = 14.000
	StopButton.TextStrokeTransparency = 0.000
	StopButton.TextWrapped = true

	Time.Name = "Time"
	Time.Parent = ActionsEx
	Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Time.BackgroundTransparency = 1.000
	Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Time.BorderSizePixel = 0
	Time.Position = UDim2.new(0, 0, 0.485714287, 0)
	Time.Size = UDim2.new(0.519761801, 0, 0.5, 0)
	Time.Font = Enum.Font.SourceSans
	Time.Text = "34 m, 24 s"
	Time.TextColor3 = Color3.fromRGB(255, 255, 255)
	Time.TextScaled = true
	Time.TextSize = 14.000
	Time.TextStrokeTransparency = 0.000
	Time.TextWrapped = true

	ActionsTitleLabel.Name = "ActionsTitleLabel"
	ActionsTitleLabel.Parent = Actions
	ActionsTitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ActionsTitleLabel.BackgroundTransparency = 1.000
	ActionsTitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ActionsTitleLabel.BorderSizePixel = 0
	ActionsTitleLabel.Size = UDim2.new(1, 0, 0.100000001, 0)
	ActionsTitleLabel.Font = Enum.Font.Fondamento
	ActionsTitleLabel.Text = "Current Actions"
	ActionsTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ActionsTitleLabel.TextScaled = true
	ActionsTitleLabel.TextSize = 14.000
	ActionsTitleLabel.TextStrokeTransparency = 0.000
	ActionsTitleLabel.TextWrapped = true
	
	GuiElements.Actions = Actions
	GuiElements.ActionsList = ActionsList
	GuiElements.ActionsEx = ActionsEx
	ActionsEx:AddTag("RemoveOnDestroy")
	
	function C.AddAction(info)
		if ActionsList:FindFirstChild(info.Name) then
			warn("Duplicate Action Name `"..info.Name.."` Requested, Cancelling...")
			return
		end
		local ActionClone = ActionsEx:Clone()
		ActionClone.Name = info.Name
		ActionClone.Title.Text = info.Name:gsub("/"," "):gsub("_"," "):gsub("%l%u",function(old) return old:sub(1,1) .. " " .. old:sub(2) end)
		ActionClone.Visible = true
		local StopEvent = Instance.new("BindableEvent",ActionClone)
		StopEvent.Name = "StopEvent"
		StopEvent.Event:Connect(function(onRequest)
			StopEvent:Destroy()
			info.Stop(onRequest)
			Actions.Visible = #ActionsList:GetChildren()-1 > 1 -- If there's something else apart from UIListLayout and the deleted instance!
			ActionClone:Destroy()
		end)
		ActionClone.StopButton.MouseButton1Click:Connect(function()
			StopEvent:Fire(true)
		end)
		ActionClone.Parent = ActionsList
		if typeof(info.Time) == "number" then
			task.spawn(function()
				for s = info.Time, 1, -1 do
					if not ActionClone.Parent then
						return
					end
					ActionClone.Time.Text = s
					task.wait(1)
				end
				if StopEvent.Parent then
					StopEvent:Fire()
				end
			end)
		else
			task.spawn(info.Time,ActionClone,info)
		end
		Actions.Visible = true
	end
	
	function C.RemoveAction(name)
		local actionInstance = ActionsList:FindFirstChild(name)
		if actionInstance then
			local event = actionInstance:FindFirstChild("StopEvent")
			if event then
				event:Fire()
			end
		end
	end

	return GuiElements
end
