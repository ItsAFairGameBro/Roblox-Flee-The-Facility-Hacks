--Classes:
local PS=game:GetService("Players")
local CS=game:GetService("CollectionService")
local RS=game:GetService("ReplicatedStorage")
local DS=game:GetService("Debris")
local CAS=game:GetService("ContextActionService")
local UIS=game:GetService("UserInputService")
local RunS=game:GetService("RunService")
local VU=game:GetService('VirtualUser')
local PathfindingService = game:GetService("PathfindingService")
local isCleared=false
local gameName=(game.PlaceId==1738581510 and "FleeTrade")
	or (game.PlaceId==893973440 and "FleeMain") or "Unknown"
local isStudio=RunS:IsStudio()
local functs={}
local Map,plr,char,Beast,TestPart,ToggleTag,clear,saveIndex,AvailableHacks
local isActionProgress=false
--DEBUG--
local botModeEnabled=true
local myBots={--has faster default walkspeed for all my bot's and their usernames;
	["itsafairgamebro"]=true,
	["molliethetroller"]=true,
	["calorytr"]=true,
	["averynotafkbot3"]=true,
	["suitedforbans"]=true,
	["suitedforbans8"]=true,
}
if not botModeEnabled then myBots={} end
local hitBoxesEnabled=false
local minSpeedBetweenPCs=18--minimum time to hack between computers is 6 sec otherwise kick;
local absMinTimeBetweenPCs=9.5--abs min time to hack, overrides minspeed
local botBeastBreakMin=9--in minutes

--BIGGIE FUNCTIONS
local NameTagEx,HackGUI,Map
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
	local player=PS:GetPlayerFromCharacter(theirChar) if player==nil then return false,"Unknown" end
	local TSM=player:WaitForChild("TempPlayerStatsModule",4) if TSM==nil then return false,"Unknown" end

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
local function findClosestObj(objs,poso,maxDist,yMult)
	local closest,closestDist=nil,maxDist or 2000
	for num,current in pairs(objs) do
		local dist=((poso-current.Position)*Vector3.new(1,yMult or 1,1)).magnitude
		if dist<=closestDist then
			closest,closestDist=current,dist
		end
	end
	return closest,closestDist
end
local function removeAllTags(obj)
	for num,tag in pairs(CS:GetTags(obj)) do
		CS:RemoveTag(obj,tag)
	end
end
local function createModifer(obj,label,passThru)
	local modifer=Instance.new("PathfindingModifier")
	modifer.Label=label
	modifer.PassThrough=passThru
	modifer.Parent=obj
	CS:AddTag(modifer,"RemoveOnDestroy")
end
local function createTestPart(position,timer)
	if not hitBoxesEnabled then return end
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
		return 
			model:WaitForChild("Left Leg").Size.Y + (0.5 * RootPart.Size.Y) + Humanoid.HipHeight
	end
end
local function getDictLength(dict)
	local num=0
	for key,val in pairs(dict) do
		num+=1
	end
	return num
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

--Module 2: HIGHLIGHTER
--highlight--
local DEFAULT_PROPS = {
	target = nil,
	color = Color3.fromRGB(255, 255, 255),
	transparency = 1,
}

local HighlightFuncts = {}

function HighlightFuncts.new(props)
	assert(type(props) == "table", "Highlight.new expects a table of props.")
	assert(props.target, "Highlight requires a target to be set!")
	assert(props.target:IsA("Model"), "Highlight requires target to be a Model!")

	local state = {
		target = props.target,
		color = props.color or DEFAULT_PROPS.color,
		transparency = 1,--props.transparency or DEFAULT_PROPS.transparency,
	}

	return setmetatable(state, HighlightFuncts)
end

function HighlightFuncts.fromTarget(target)
	assert(target and target:IsA("Model"), "Highlight.fromTarget requires a Model target to be set!")

	return HighlightFuncts.new({
		target = target,
	})
end
--viewportframe--
local Workspace = game:GetService("Workspace")

local ViewportFrame = {}
ViewportFrame.__index = ViewportFrame

function ViewportFrame.withReferences(objectRef)
	local state = {
		objectRef = objectRef,
		rbx = nil,
	}
	local self = setmetatable(state, ViewportFrame)

	local rbx = Instance.new("ViewportFrame")
	rbx.CurrentCamera = Workspace.CurrentCamera
	rbx.BackgroundTransparency = 1
	rbx.ZIndex=-100
	rbx.Size = UDim2.new(1, 0, 1, 0)
	self.rbx = rbx

	objectRef.rbx.Parent = self.rbx

	return self
end

function ViewportFrame:getReference()
	return self.objectRef
end

function ViewportFrame:requestParent(newParent)
	return pcall(function()
		self.rbx.Parent = newParent
	end)
end

function ViewportFrame:destruct()
	self.rbx:Destroy()
end
--createBasePartCopy--
local createBasePartCopy=function(basePart)
	assert(basePart:IsA("BasePart"), "createBasePartCopy must only receive a basePart!")

	local result
	if basePart:IsA("MeshPart") or basePart:IsA("UnionOperation") then
		result = basePart:Clone()
	else
		-- TODO: Manually clone simple BaseParts
		result = basePart:Clone()
	end
	while result:IsA("BasePart") and result:FindFirstChildOfClass("Sound",true)~=nil do
		result:FindFirstChildOfClass("Sound",true):Destroy()
	end
	while result:IsA("BasePart") and result:FindFirstChildOfClass("BillboardGui",true)~=nil do
		result:FindFirstChildOfClass("BillboardGui",true):Destroy()
	end
	result.Name=basePart.Name
	-- TODO: Consider whitelisting children applicable to rendering instead
	for _, object in pairs(result:GetDescendants()) do
		if object:IsA("BasePart") then
			object:Destroy()
		end
	end

	return result
end
--createInstanceCopy--

local createInstanceCopy=function(instance)
	if instance:IsA("BasePart") then
		return createBasePartCopy(instance)
	elseif instance:IsA("Humanoid") then
		local humanoid = Instance.new("Humanoid")
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		return humanoid
	elseif instance:IsA("Shirt") or instance:IsA("Pants") or instance:IsA("CharacterMesh") then
		local newClone=instance:Clone()
		newClone.Name=instance.Name
		return 
	end
end
--ObjectRefMap--

local ObjectRefMap = {}

function ObjectRefMap.fromModel(model)
	local newModel = Instance.new("Model")

	local alreadyHasAHumanoid = false
	local clonedPrimaryPart
	local dataModel = {}
	local map = {}
	for _, object in ipairs(model:GetDescendants()) do
		local clone = createInstanceCopy(object)
		if clone then
			clone.Parent = newModel

			if clone:IsA("BasePart") then
				map[object] = clone
				if not clonedPrimaryPart and object == model.PrimaryPart then
					clonedPrimaryPart = clone
				end
			elseif object:IsA("Humanoid") then
				if alreadyHasAHumanoid then
					clone:Destroy()
				else
					alreadyHasAHumanoid = true
				end
			end
		end
	end
	newModel.PrimaryPart = clonedPrimaryPart

	dataModel.map = map
	dataModel.rbx = newModel
	dataModel.worldModel = model

	return dataModel
end
--Implementations.worldColor--
local DEFAULT_IMPLEMENTATION=function()
	local connections = {}

	return {
		onBeforeRender = function(_, _)
			return true
		end,

		onRender = function(_, worldPart, viewportPart, _)
			viewportPart.CFrame = worldPart.CFrame
		end,

		onAdded = function(worldPart, viewportPart, _)
			viewportPart.Color = worldPart.Color

			connections[worldPart] = worldPart:GetPropertyChangedSignal("Color"):Connect(function()
				viewportPart.Color = worldPart.Color
			end)
		end,

		onRemoved = function(worldPart, _, _)
			if connections[worldPart] then
				connections[worldPart]:Disconnect()
				connections[worldPart] = nil
			end
		end,
	}
end
--renderer--

local Renderer = {}
Renderer.__index = Renderer

local function onAddedToStack(self, highlight)
	local objectRef = ObjectRefMap.fromModel(highlight.target)
	local viewport = ViewportFrame.withReferences(objectRef)

	if self.onAddedImpl then
		for worldPart, viewportPart in pairs(objectRef.map) do
			self.onAddedImpl(worldPart, viewportPart, highlight)
		end
	end

	viewport:requestParent(self.targetScreenGui)
	self._viewportMap[highlight] = viewport
	return viewport.rbx
end

local function onRemovedFromStack(self, highlight)
	if self.onRemovedImpl then
		local viewport = self._viewportMap[highlight]
		local objectRef = viewport:getReference()
		for worldPart, viewportPart in pairs(objectRef.map) do
			self.onRemovedImpl(worldPart, viewportPart, highlight)
		end
	end

	local viewport = self._viewportMap[highlight]
	viewport:requestParent(nil)
	viewport:destruct()
	self._viewportMap[highlight] = nil
end

function Renderer.new(targetScreenGui)
	assert(targetScreenGui, "Renderer.new must be provided with a targetScreenGui.")

	local state = {
		_stack = {},
		_viewportMap = {},
		targetScreenGui = targetScreenGui,
	}
	setmetatable(state, Renderer)

	targetScreenGui.IgnoreGuiInset = true

	return state:withRenderImpl(DEFAULT_IMPLEMENTATION)
end

function Renderer:withRenderImpl(implementationFunc)
	local resultImpl = implementationFunc()

	self.onAddedImpl = resultImpl.onAdded
	self.onRemovedImpl = resultImpl.onRemoved
	self.onBeforeRenderImpl = resultImpl.onBeforeRender
	self.onRenderImpl = resultImpl.onRender

	return self
end

function Renderer:addToStack(highlight)
	if self._viewportMap[highlight] then
		return
	end

	table.insert(self._stack, highlight)
	return onAddedToStack(self, highlight)
end

function Renderer:removeFromStack(highlight)
	local wasRemovedSuccessfully = false

	for index = #self._stack, 1, -1 do
		if highlight == self._stack[index] then
			table.remove(self._stack, index)
			wasRemovedSuccessfully = true
			break
		end
	end

	if wasRemovedSuccessfully then
		onRemovedFromStack(self, highlight)
	end
end

function Renderer:step(dt)
	if not self.onRenderImpl then
		return
	end

	for index = #self._stack, 1, -1 do
		local highlight = self._stack[index]
		local viewport = self._viewportMap[highlight]
		local objectRef = viewport:getReference()

		if self.onBeforeRenderImpl then
			local beforeRenderResult = self.onBeforeRenderImpl(dt, objectRef.worldModel)
			if beforeRenderResult == false then
				viewport.rbx.Visible = false
				return
			end
		end
		for worldPart, viewportPart in pairs(objectRef.map) do
			self.onRenderImpl(dt, worldPart, viewportPart, highlight)
		end
		viewport.rbx.Visible = true

	end
end
--highlightColor--
local highlightColor=function()
	return {
		onBeforeRender = function(_, _)
			return true
		end,

		onRender = function(_, worldPart, viewportPart, highlight)
			viewportPart.CFrame = worldPart.CFrame
			viewportPart.Color = highlight.color
		end,

		onAdded = function(_, viewportPart, highlight)
			local function clearTextures(instance)
				if instance:IsA("MeshPart") then
					instance.TextureID = ""
				elseif instance:IsA("UnionOperation") then
					instance.UsePartColor = true
				elseif instance:IsA("SpecialMesh") then
					instance.TextureId = ""
				end
			end

			local function colorObject(instance)
				if instance:IsA("BasePart") then
					instance.Color = highlight.color
				end
			end

			for _, object in pairs(viewportPart:GetDescendants()) do
				clearTextures(object)
				colorObject(object)
			end
			clearTextures(viewportPart)
			colorObject(viewportPart)
		end,
	}
end

local funct1,funct2,funct3=function(target)
	assert(target and target:IsA("Model"), "Highlight.fromTarget requires a Model target to be set!")

	return HighlightFuncts.new({
		target = target,
	})
end, function(screenGui)
	return Renderer.new(screenGui)
end, function()
	return {
		worldColor = DEFAULT_IMPLEMENTATION,
		highlightColor = highlightColor,
	}
end

local ObjectHighlighter = {
	createFromTarget = funct1,
	createRenderer = funct2,
	Implementations = funct3,
}
--Module 3: RAYCAST
local whitelistCashe={}
local whitelistDataCashe={}
local function compareArrays(arr1, arr2)
	for i, v in pairs(arr1) do
		if (typeof(v) == "table") then
			if (compareArrays(arr2[i], v) == false) then
				return false
			end
		else
			if (v ~= arr2[i]) then
				return false
			end
		end
	end
	return true
end
local raycast=function(from, target, filter, distance, passThroughTransparency,passThroughCanCollide)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
	if filter[1]~=nil and (filter[1]=="Whitelist" or filter[1]=="Blacklist") then
		raycastParams.FilterType=Enum.RaycastFilterType[filter[1]]
		table.remove(filter,1)
	end
	if raycastParams.FilterType==Enum.RaycastFilterType.Whitelist then
		local newFilter={}
		for num, cashedData in pairs(whitelistCashe) do
			if compareArrays(cashedData, filter) then
				newFilter=whitelistDataCashe[num]
			end
		end
		if #newFilter==0 then
			for num,model in pairs(filter) do
				for num,part in pairs(model:GetDescendants()) do
					if part:IsA("BasePart") and ((not passThroughTransparency or 
						part.Transparency<(passThroughTransparency or 1))
						and (not passThroughCanCollide or part.CanCollide)) then
						table.insert(newFilter,part)
					end
				end
			end
			local nextIndex=#whitelistCashe+1
			table.insert(whitelistCashe,nextIndex,filter)
			table.insert(whitelistDataCashe,nextIndex,newFilter)
		end
		filter = newFilter--{char,workspace.Map}
	end
	raycastParams.FilterDescendantsInstances = filter
	raycastParams.IgnoreWater = true
	local direction=(target-from)
	local result,lastInstance
	while true do
		result = workspace:Raycast(from, direction.Unit*(distance or direction.magnitude+.5), raycastParams)
		--print(result~=nil and result.Instance or "no hit")
		--print(result,passThroughTransparency,passThroughTransparency,passThroughCanCollide)
		if raycastParams.FilterType==Enum.RaycastFilterType.Whitelist or 
			(result==nil or result.Instance==nil) or ((not passThroughTransparency or 
			result.Instance.Transparency<(passThroughTransparency or 1))
			and (not passThroughCanCollide or result.Instance.CanCollide)) then
			break
		elseif result~=nil and lastInstance==result.Instance then
			break
		else
			from=result.Position:lerp(target,.01)
			lastInstance=result.Instance
			table.insert(filter,lastInstance)
			raycastParams.FilterDescendantsInstances = filter
		end
	end
	if result~=nil and result.Instance~=nil and result.Instance.Parent~=nil then
		return result,result.Instance
	else
		return false
	end
end
--Module 4: SIMPLE PATH (PATHFINDING MODULE)
local DEFAULT_SETTINGS = {

	TIME_VARIANCE = 0.03;

	COMPARISON_CHECKS = 1;

	JUMP_WHEN_STUCK = true;
}
local function output(func, msg)
	func(((func == error and "SimplePath Error: ") or "SimplePath: ")..msg)
end
local Path = {
	StatusType = {
		Idle = "Idle";
		Active = "Active";
	};
	ErrorType = {
		LimitReached = "LimitReached";
		TargetUnreachable = "TargetUnreachable";
		ComputationError = "ComputationError";
		AgentStuck = "AgentStuck";
	};
}
Path.__index = function(table, index)
	if index == "Stopped" and not table._humanoid then
		output(error, "Attempt to use Path.Stopped on a non-humanoid.")
	end
	return (table._events[index] and table._events[index].Event)
		or (index == "LastError" and table._lastError)
		or (index == "Status" and table._status)
		or Path[index]
end

--Used to visualize waypoints
local visualWaypoint = Instance.new("Part",script)
visualWaypoint.Size = Vector3.new(0.3, 0.3, 0.3)
visualWaypoint.Anchored = true
visualWaypoint.CanCollide = false
visualWaypoint.Material = Enum.Material.Neon
visualWaypoint.Shape = Enum.PartType.Ball
CS:AddTag(visualWaypoint,"RemoveOnDestroy")

--[[ PRIVATE FUNCTIONS ]]--
local function declareError(self, errorType)
	self._lastError = errorType
	self._events.Error:Fire(errorType)
end

--Create visual waypoints
local function createVisualWaypoints(waypoints)
	if isCleared then return end
	local visualWaypoints = {}
	for _, waypoint in ipairs(waypoints) do
		local visualWaypointClone = visualWaypoint:Clone()
		visualWaypointClone.Position = waypoint.Position
		visualWaypointClone.Parent = workspace
		visualWaypointClone.Color =
			(waypoint == waypoints[#waypoints] and Color3.fromRGB(0, 255, 0))
			or (waypoint.Action == Enum.PathWaypointAction.Jump and Color3.fromRGB(255, 0, 0))
			or Color3.fromRGB(255, 139, 0)
		table.insert(visualWaypoints, visualWaypointClone)
	end
	return visualWaypoints
end

--Destroy visual waypoints
local function destroyVisualWaypoints(waypoints)
	if waypoints then
		for _, waypoint in ipairs(waypoints) do
			waypoint:Destroy()
		end
	end
	return
end

--Get initial waypoint for non-humanoid
local function getNonHumanoidWaypoint(self)
	--Account for multiple waypoints that are sometimes in the same place
	for i = 2, #self._waypoints do
		if (self._waypoints[i].Position - self._waypoints[i - 1].Position).Magnitude > 0.1 then
			return i
		end
	end
	return 2
end

--Make NPC jump
local function setJumpState(self)
	pcall(function()
		if (self._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and self._humanoid.FloorMaterial~=Enum.Material.Air
			and not isActionProgress and not isCleared
			and game.Players.LocalPlayer.PlayerGui.ScreenGui.ActionBox.Text~="Open Door") then
			self._humanoid:ChangeState(Enum.HumanoidStateType.Jumping) --print("jump!")
		end
	end)
end

--Primary move function
local function move(self)
	while isActionProgress do
		wait()--don't move!
	end
	if self._status == Path.StatusType.Idle or self._waypoints==nil then return end
	if self._waypoints[self._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
		setJumpState(self)
	elseif self._currentWaypoint>1 and 
		self._waypoints[self._currentWaypoint-1].Action == Enum.PathWaypointAction.Jump then
		--and self._humanoid:GetState()~=Enum. then
		setJumpState(self)
	end
	--self._humanoid:MoveTo(self._waypoints[self._currentWaypoint].Position)
	AvailableHacks.Bot[20].Funct(self,self._waypoints[self._currentWaypoint].Position)
end

--Disconnect MoveToFinished connection when pathfinding ends
local function disconnectMoveConnection(self)
	if self~=nil and self._moveConnection~=nil then
		self._moveConnection:Disconnect()
	end
	self._moveConnection = nil
end

--Fire the WaypointReached event
local function invokeWaypointReached(self)
	local lastWaypoint = self._currentWaypoint>=2
		and self._waypoints[self._currentWaypoint - 1]
	local nextWaypoint = self._waypoints[self._currentWaypoint]
	self._events.WaypointReached:Fire(self._agent, lastWaypoint, nextWaypoint)
end
local function waitForFall(self)
	if self._currentWaypoint==1 then return end
	local lastWaypoint = self._waypoints[self._currentWaypoint - 1]
	local currentWaypoint = self._waypoints[self._currentWaypoint]
	if lastWaypoint.Position.Y-currentWaypoint.Position.Y>6 then
		task.wait(1/3)
	end
end
local function moveToFinished(self, reached)

	--Stop execution if Path is destroyed
	if not getmetatable(self) then return end
	--if self._status~=Path.StatusType.Active then return end

	--Handle case for non-humanoids
	if not self._humanoid then
		if reached and self._currentWaypoint + 1 <= #self._waypoints then
			invokeWaypointReached(self)
			self._currentWaypoint += 1
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

	if reached and self._currentWaypoint + 1 <= #self._waypoints  then --Waypoint reached
		waitForFall(self)
		if self._currentWaypoint + 1 < #self._waypoints then
			invokeWaypointReached(self)
		end
		self._currentWaypoint += 1
		move(self)
	elseif reached then --Target reached, pathfinding ends
		disconnectMoveConnection(self)
		self._status = Path.StatusType.Idle
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
		self._events.Reached:Fire(self._agent, self._waypoints[self._currentWaypoint])
	else --Target unreachable
		disconnectMoveConnection(self)
		self._status = Path.StatusType.Idle
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
		declareError(self, self.ErrorType.TargetUnreachable)
	end
end

--Refer to Settings.COMPARISON_CHECKS
local function comparePosition(self)
	if self._currentWaypoint == #self._waypoints then return end
	--print("compared")
	self._position._count = (((self._agent.PrimaryPart.Position - self._position._last)/Vector3.new(1,math.huge,1)).Magnitude <= 3.5 and (self._position._count + 1)) or 0
	self._position._last = self._agent.PrimaryPart.Position
	if not isActionProgress then
		if self._position._count >= self._settings.COMPARISON_CHECKS then
			--declareError(self, errorType)
			if self._settings.JUMP_WHEN_STUCK then
				if not AvailableHacks.Bot[15].UnlockDoor(false)
					and not AvailableHacks.Bot[15].CrawlVent(false) then
					self._agent.Humanoid:MoveTo(self._agent.PrimaryPart.CFrame*Vector3.new(0,0,1.35))
					wait(.1)
					setJumpState(self)
					declareError(self, self.ErrorType.AgentStuck)
				end
			end
		else
			--(from, target, filter, distance, passThroughTransparency,passThroughCanCollide)
			local result,hitPart = raycast(self._agent.PrimaryPart.Position,
				self._agent.Head.Position,{Map},4,nil,true)
			if hitPart then
				print("He is stuck in wall!")
				declareError(self, self.ErrorType.AgentStuck)
			end
		end
	end
end

--[[ STATIC METHODS ]]--
function Path.GetNearestCharacter(fromPosition)
	local character, dist = nil, math.huge
	for _, player in ipairs(PS:GetPlayers()) do
		if player.Character and (player.Character.PrimaryPart.Position - fromPosition).Magnitude < dist then
			character, dist = player.Character, (player.Character.PrimaryPart.Position - fromPosition).Magnitude
		end
	end
	return character
end

--[[ CONSTRUCTOR ]]--
function Path.new(agent, agentParameters, override)
	if not (agent and agent:IsA("Model") and agent.PrimaryPart) then
		output(error, "Pathfinding agent must be a valid Model Instance with a set PrimaryPart.")
	end

	local self = setmetatable({
		_settings = override or DEFAULT_SETTINGS;
		_events = {
			Reached = Instance.new("BindableEvent");
			WaypointReached = Instance.new("BindableEvent");
			Blocked = Instance.new("BindableEvent");
			Error = Instance.new("BindableEvent");
			Stopped = Instance.new("BindableEvent");
		};
		_agent = agent;
		_humanoid = agent:FindFirstChildOfClass("Humanoid");
		_path = PathfindingService:CreatePath(agentParameters);
		_status = "Idle";
		_t = 0;
		_position = {
			_last = Vector3.new();
			_count = 0;
		};
	}, Path)

	--Configure settings
	for setting, value in pairs(DEFAULT_SETTINGS) do
		self._settings[setting] = self._settings[setting] == nil and value or self._settings[setting]
	end

	--Path blocked connection
	self._path.Blocked:Connect(function(...)
		if (not ... or (self._currentWaypoint <= ... and self._currentWaypoint + 1 >= ...))
			and self._humanoid and not isActionProgress then
			self._events.Blocked:Fire(self._agent, self._waypoints[...])
			setJumpState(self)
		end
	end)

	return self
end


--[[ NON-STATIC METHODS ]]--
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
	if isCleared then return false end
	--Non-humanoid handle case
	if not target and not self._humanoid and self._target then
		moveToFinished(self, true)
		return
	end

	--Parameter check
	if not (target and (typeof(target) == "Vector3" or target:IsA("BasePart"))) then
		output(error, "Pathfinding target must be a valid Vector3 or BasePart.")
	end
	if not AvailableHacks.Blatant[2].IsCrawling then
		isActionProgress=plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("ActionProgress").Value%1~=0
	end

	while self._humanoid.Health>0 and self._humanoid.FloorMaterial==Enum.Material.Air do
		self._humanoid:GetPropertyChangedSignal("FloorMaterial"):Wait()
	end

	--Refer to Settings.TIME_VARIANCE
	if os.clock() - self._t <= self._settings.TIME_VARIANCE and self._humanoid then
		task.wait(os.clock() - self._t)
		declareError(self, self.ErrorType.LimitReached)
		return false
	elseif self._humanoid then
		self._t = os.clock()
	end

	--Compute path
	local pathComputed, _ = pcall(function()
		self._path:ComputeAsync(self._agent.PrimaryPart.Position, (typeof(target) == "Vector3" and target) or target.Position)
	end)

	--Make sure path computation is successful
	if not pathComputed
		or self._path.Status == Enum.PathStatus.NoPath
		or #self._path:GetWaypoints() < 2
		or (self._humanoid and self._humanoid:GetState() == Enum.HumanoidStateType.Freefall) then
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)

		if self._target~=target or self._waypoints==nil or self._currentWaypoint==nil or self._waypoints[self._currentWaypoint]==nil
			or ((self._waypoints[self._currentWaypoint].Position-self._agent.PrimaryPart.Position)/Vector3.new(1,1,1)).magnitude>=6 then
			declareError(self, self.ErrorType.ComputationError)
			return false
		else
			--self._currentWaypoint = self._currentWaypoint or 2
			--print("using old data!")
		end

	else
		self._target = target
		self._waypoints = self._path:GetWaypoints()
		self._currentWaypoint = 2
	end

	--Set status to active; pathfinding starts
	self._status = (self._humanoid and Path.StatusType.Active) or Path.StatusType.Idle


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
			AvailableHacks.Bot[15].AvoidParts[1].Position=Beast.Torso.Position
		end
	end
	task.spawn(AvailableHacks.Bot[15].UnlockDoor)
	self._moveConnection = self._humanoid and (self._moveConnection or self._humanoid.MoveToFinished:Connect(function(...)
		moveToFinished(self, ...)
	end))

	--Begin pathfinding
	if self._humanoid then
		--self._humanoid:MoveTo(self._waypoints[self._currentWaypoint].Position)
		AvailableHacks.Bot[20].Funct(self,self._waypoints[self._currentWaypoint].Position)
		--self._currentWaypoint-=1--subtract the current waypoint to add it later!
		--moveToFinished(self,true)
		if self._waypoints[self._currentWaypoint].Action==Enum.PathWaypointAction.Jump
			or (self._currentWaypoint>1 and
				self._waypoints[self._currentWaypoint-1].Action==Enum.PathWaypointAction.Jump)
			or self._waypoints[self._currentWaypoint].Position.Y>self._agent.PrimaryPart.Position.Y-2 then
			setJumpState(self)
		end
	elseif #self._waypoints == 2 then
		self._target = nil
		self._visualWaypoints = destroyVisualWaypoints(self._visualWaypoints)
		self._events.Reached:Fire(self._agent, self._waypoints[2])
	else
		self._currentWaypoint = getNonHumanoidWaypoint(self)
		moveToFinished(self, true)
	end--]]
	return true
end
--Important Variables:
plr=PS.LocalPlayer
char=plr.Character or plr.CharacterAdded:Wait()
local human=char:WaitForChild("Humanoid")
local camera=workspace:WaitForChild("Camera")
local hackChanged=Instance.new("BindableEvent")
local enHacks,playerEvents,objectFuncts={},{},{}
local computerHackStartTime=os.clock()
local lastHackedPC,lastHackedPosition=nil,Vector3.new(100,100,100)
local myTSM,mySSM

if gameName=="FleeMain" then

	if plr:WaitForChild("IsCheckingLoadData").Value then
		local WaitEvent=Instance.new("BindableEvent")
		plr.IsCheckingLoadData.Changed:Connect(function()
			WaitEvent:Fire(true)
		end)
		task.delay(10,function()
			if WaitEvent then
				WaitEvent:Fire(false) 
			end
		end)
		if not WaitEvent.Event:Wait() then
			warn("Player data has failed to load; waited max time, continuing..") 
		end
		WaitEvent:Destroy()
	end
end
if gameName=="FleeMain" or gameName=="FleeTrade" then
	myTSM=plr:WaitForChild("TempPlayerStatsModule")
	mySSM=plr:WaitForChild("SavedPlayerStatsModule")
end

local function setChangedAttribute(object,value,funct)
	if object==nil or object.Parent==nil then return end
	objectFuncts[object]=objectFuncts[object]~=nil and objectFuncts[object] or {}
	if objectFuncts[object][value]~=nil then
		objectFuncts[object][value]:Disconnect() objectFuncts[object][value]=nil
	end
	if funct~=nil and funct~=false then
		if value=="Value" and object:IsA("ValueBase") then--print("set ",object," to changed!")
			objectFuncts[object][value]=object.Changed:Connect(funct)
		else

			objectFuncts[object][value]=object:GetPropertyChangedSignal(value):Connect(funct)
		end
	else --print("disabled ",object,value)
		objectFuncts[object][value]=nil
	end
end
--Settings:
AvailableHacks={
	["Render"]={
		[1]={
			["Type"]="ExTextButton",
			["Title"]="ESP Players",
			["Desc"]="See players through walls",
			["Shortcut"]="ESP_Players",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays")) do
					tag.Enabled=newValue
					if tag.Parent.Parent:FindFirstChild("Humanoid")~=nil then
						tag.Parent.Parent.Humanoid.DisplayDistanceType=newValue and
							Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
					end
				end
			end,
			["OthersStartUp"]=function(theirPlr,theirChar)
				local Head=theirChar:WaitForChild("Head",1e5) if not Head then return end
				local newTag=NameTagEx:Clone()
				newTag.Username.Text=theirPlr.Name
				newTag.Distance.Visible=enHacks.ESP_Distance
				newTag.Parent=Head
				newTag.Enabled=enHacks.ESP_Players
				theirChar.Humanoid.DisplayDistanceType=enHacks.ESP_Players and
					Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
				CS:AddTag(newTag,"HackDisplays")
				CS:AddTag(newTag,"RemoveOnDestroy")
				local function childChanged(child)
					if not newTag:FindFirstChild("Username") then return end
					newTag.Username.TextColor3=theirChar:FindFirstChild("Hammer")~=nil
						and Color3.fromRGB(255) or Color3.fromRGB(0,0,255)
				end
				table.insert(playerEvents[theirPlr.UserId],theirChar.ChildAdded:Connect(childChanged))
				table.insert(playerEvents[theirPlr.UserId],theirChar.ChildRemoved:Connect(childChanged))
				childChanged()
			end,
		},
		[2]={
			["Type"]="ExTextButton",
			["Title"]="ESP Display Distance",
			["Desc"]="Displays distance in studs",
			["Shortcut"]="ESP_Distance",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays")) do
					tag.Distance.Visible=newValue
				end
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					tag.Distance.Visible=newValue
				end
			end,
			["UpdateDistFunct"]=function(NameTag,CenterObject)
				task.spawn(function()--prevents yielding if this function was called from elsewhere.
					local DistanceTag=NameTag:WaitForChild("Distance",10)
					if not DistanceTag then return end
					while NameTag~=nil and NameTag.Parent~=nil and NameTag.Parent.Parent~=nil and DistanceTag~=nil and not isCleared do
						local dist=math.round((camera.CFrame.p-(CenterObject.Position+NameTag.StudsOffset)).Magnitude)
						DistanceTag.Text=dist.."m"
						if isInLobby(NameTag.Parent.Parent)==isInLobby(camera.CameraSubject.Parent) then
							NameTag.PlayerToHideFrom=nil
						else
							NameTag.PlayerToHideFrom=plr
						end--]]
						wait()
					end
				end)
			end,
			["OthersStartUp"]=function(theirPlr,theirChar)
				local Head=theirChar:WaitForChild("Head",1e5) if not Head then return end
				local NameTag=Head:WaitForChild("NameTagEx",1e5) if not NameTag then return end
				NameTag.Distance.Visible
					=enHacks.ESP_Distance
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
				objectFuncts[computerTable]=objectFuncts[computerTable] or {}
				local primPart,Screen=computerTable.PrimaryPart,computerTable:FindFirstChild("Screen",true)
				local newTag=NameTagEx:Clone()
				newTag.Username.TextColor3=Color3.fromRGB(84, 84, 84)
				newTag.Distance.Visible=enHacks.ESP_Distance
				newTag.ExtentsOffsetWorldSpace+=Vector3.new(0,4,0)
				newTag.Parent=primPart
				newTag.Enabled=enHacks.ESP_PC

				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplays2")
				local function updateText()
					if not workspace:IsAncestorOf(newTag) then return end
					newTag.Username.Text="Computer"..string.sub(computerTable.Name,14)-- ..(
					--AvailableHacks.Render[3].ScreenColors[Screen.BrickColor.Name]
					--	or "[INTERNAL ERROR]")
					newTag.Username.TextColor3=Screen.BrickColor.Color
					newTag.ExpandingBar.Visible=Screen.BrickColor.Name~="Dark green" 
						and (math.abs(newTag.ExpandingBar.AmtFinished.Size.X.Scale%1)<=.00001)
						and enHacks.ESP_PCProg
				end
				setChangedAttribute(Screen,"Color",updateText)
				updateText()
				--end
			end,
		},

		[4]={
			["Type"]="ExTextButton",
			["Title"]="ESP Player Highlight",
			["Desc"]="Highlight other players",
			["Shortcut"]="ESP_Highlight",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				local VPF=HackGUI:FindFirstChild("ViewportFrame")
				if VPF~=nil then
					VPF.Visible=newValue
				end
			end,
			["OthersShutDown"]=function(theirPlr,theirChar)
				local VPF=HackGUI:FindFirstChild(theirPlr.Name)
				if VPF~=nil then 
					VPF:Destroy()
				end
			end,
			["OthersStartUp"]=function(theirPlr,theirChar)
				local Head=theirChar:WaitForChild("Head",1e5) if not Head then return end
				local nameTag=Head:WaitForChild("NameTagEx",1e5) if not Head then return end
				local function changeRenderVisibility(Place,Trans,Color)
					if Place:GetAttribute("Color")==Color and Place:GetAttribute("Trans")==Trans then
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
				end
				local myRenderer = ObjectHighlighter.createRenderer(HackGUI)
				local myHighlight = ObjectHighlighter.createFromTarget(theirChar)
				local VPF=myRenderer:addToStack(myHighlight) task.wait()
				VPF.Name=theirPlr.Name

				local theirViewportChar=VPF:WaitForChild("Model")
				if not enHacks.ESP_Highlight then
					changeRenderVisibility(theirViewportChar,1)
				end
				local key
				delay(.25,function()
					objectFuncts[theirChar]=objectFuncts[theirChar] or {}
					while not isCleared and theirChar~=nil and theirChar.Parent~=nil do
						--if enHacks.ESP_Highlight then
						--key=#objectFuncts[theirChar]+1
						while enHacks.ESP_Highlight and nameTag.Parent~=nil and nameTag.Parent.Parent~=nil and not isCleared do--table.insert(objectFuncts[theirChar],key,RunS.RenderStepped:Connect(function(dt)
							if (Head.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance and ({isInLobby(theirChar)})[1]==({isInLobby(camera.CameraSubject.Parent)})[1] then
								--local didHit,instance=true,theirChar.PrimaryPart
								local didHit,instance=raycast(camera.CFrame.p, Head.Position, {"Blacklist",char}, 100, 0.001)
								changeRenderVisibility(theirViewportChar,(didHit and theirChar:IsAncestorOf(instance)) and 1 or 0,
									(theirChar:FindFirstChild("Hammer")==nil and Color3.fromRGB(0,0,255)
										or Color3.fromRGB(255)))
								myRenderer:step(0)
							else
								changeRenderVisibility(theirViewportChar,1,
									(theirChar:FindFirstChild("Hammer")==nil and Color3.fromRGB(0,0,255)
										or Color3.fromRGB(255)))
							end
							task.wait()
							while theirChar.Humanoid==camera.CameraSubject do
								changeRenderVisibility(theirViewportChar,1)
								camera:GetPropertyChangedSignal("CameraSubject"):Wait()
							end
						end
						--end))
						--elseif objectFuncts[theirChar][key]~=nil then
						--objectFuncts[theirChar][key]:Disconnect()
						--table.remove(objectFuncts[theirChar],key) task.wait()
						changeRenderVisibility(theirViewportChar,1)
						--end
						hackChanged.Event:Wait()
					end
					--if objectFuncts[theirChar][key] ~=nil then
					--	objectFuncts[theirChar][key]:Disconnect()--do a favor
					--end
				end)
			end,
		},
		[5]={
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
						computerElement:Destroy()
					end
				end
			end,
			["ComputerAdded"]=function(Computer)
				local primPart,Screen=Computer.PrimaryPart,Computer:FindFirstChild("Screen")
				local nameTag=primPart:WaitForChild("NameTagEx")
				local function changeRenderVisibility(Place,Trans,Color)
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
				end
				--table.find(Computer.Parent:GetChildren(),Computer))
				local myRenderer = ObjectHighlighter.createRenderer(HackGUI)
				local myHighlight = ObjectHighlighter.createFromTarget(Computer)
				myRenderer:addToStack(myHighlight) task.wait()
				local VPF=HackGUI:WaitForChild("ViewportFrame") VPF.Name=Computer.Name

				local theirViewportChar=VPF:WaitForChild("Model")
				--local key
				task.spawn(function()
					--objectFuncts[Computer]=objectFuncts[Computer] or {}
					while not isCleared and Computer~=nil and Computer.Parent~=nil do
						--if enHacks.ESP_PCHighlight then
						--key=#objectFuncts[Computer]+1
						while enHacks.ESP_PCHighlight and not isCleared do--table.insert(objectFuncts[Computer],key,RunS.RenderStepped:Connect(function(dt)
							if (primPart.Position-camera.CFrame.p).magnitude<=nameTag.MaxDistance 
								and isInLobby(camera.CameraSubject.Parent) then
								local didHit,instance=false,primPart
								if Map~=nil and Screen~=nil then
									didHit,instance=raycast(camera.CFrame.p, Screen.Position, {"Blacklist",(camera.CameraSubject~=nil and camera.CameraSubject.Parent)}, 100,.001)
								end 
								changeRenderVisibility(theirViewportChar,(didHit and Computer:IsAncestorOf(instance) and 1 or 0),
									Screen.Color)
							else
								changeRenderVisibility(theirViewportChar,1)
							end
							task.wait()
						end
						--end--end))
						--else--if objectFuncts[Computer][key]~=nil then
						--objectFuncts[Computer][key]:Disconnect()
						--table.remove(objectFuncts[Computer],key) task.wait()
						changeRenderVisibility(theirViewportChar,1)
						hackChanged.Event:Wait()
						--end
					end
					--if objectFuncts[Computer][key] ~=nil then
					--	objectFuncts[Computer][key]:Disconnect()--do a favor
					--end
				end)


			end,
		},
		[6]={
			["Type"]="ExTextButton",
			["Title"]="ESP Player Progress",
			["Desc"]="See player's progress",
			["Shortcut"]="ESP_PlayerProg",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays")) do
					local theirChar=tag.Parent.Parent
					local Plr=PS:GetPlayerFromCharacter(theirChar)
					local TSM=Plr:WaitForChild("TempPlayerStatsModule")
					tag.ExpandingBar.Visible=(newValue and TSM.ActionProgress.Value~=0
						and TSM.CurrentAnimation.Value~="Typing")
				end
			end,
			["OthersPlayerAdded"]=function(theirPlr)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				local ActionProgress=TSM:WaitForChild("ActionProgress")
				local function ActionChanged()
					local theirChar=theirPlr.Character if theirChar==nil then return end
					local Head=theirChar:FindFirstChild("Head") if Head==nil then return end
					local nameTag=Head:WaitForChild("NameTagEx")
					nameTag.ExpandingBar.Visible=(enHacks.ESP_PlayerProg and ActionProgress.Value~=0
						and TSM.CurrentAnimation.Value~="Typing")
					if TSM.CurrentAnimation.Value=="Typing" then
						AvailableHacks.Render[7].RefreshBar(theirPlr,Head,ActionProgress)
					else
						nameTag.ExpandingBar.AmtFinished.Size=UDim2.new(ActionProgress.Value, 0, 1, 0)
					end
				end
				setChangedAttribute(ActionProgress,"Value",ActionChanged) ActionChanged()
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
				if TSM.ActionEvent.Value==nil or TSM.CurrentAnimation.Value~="Typing"
					or string.sub(TSM.ActionEvent.Value.Parent.Name,1,15)~="ComputerTrigger" then return end
				local closestPC,dist=nil,15
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					local Screen=tag.Parent
					local PC=Screen.Parent
					local newDist=(Screen.Position-CenterPoso.Position).magnitude
					if newDist<dist then
						closestPC,dist=PC,newDist
					end
				end
				if closestPC~=nil then
					AvailableHacks.Render[7].SetBar(closestPC,ActionProgress.Value)
				end
			end,
			["SetBar"]=function(PC,Progress)
				local ExpandingBar=PC.PrimaryPart:WaitForChild("NameTagEx"):WaitForChild("ExpandingBar")
				ExpandingBar.AmtFinished.Size=UDim2.new(Progress, 0, 1, 0)
				ExpandingBar.Visible=PC.Screen.BrickColor.Name~="Dark green"
					and Progress>0.001 and enHacks.ESP_PCProg
				PC:SetAttribute("Progress",Progress)
			end,
			["ActivateFunction"]=function(newValue)
				for num, tag in pairs(CS:GetTagged("HackDisplays2")) do
					tag.ExpandingBar.Visible=newValue and tag.ExpandingBar.AmtFinished.Size.X.Scale>0.0001
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
					local theirChar=plr.Character if theirChar==nil then return end
					local Head=theirChar:FindFirstChild("Head") if Head==nil then return end
					if TSM.CurrentAnimation.Value=="Typing" then
						AvailableHacks.Render[7].RefreshBar(plr,Head,ActionProgress)
					end
					task.spawn(function()
						for s=1,1,-1 do
							if not enHacks.Util_AutoHack then return end
							RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
							wait(.05)
						end
					end)
				end
				setChangedAttribute(ActionProgress,"Value",ActionChanged) ActionChanged()
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
			["DisableScript"]=function()
				--[[local enableCrawl=enHacks.OverrideCrawl or ({isInLobby(char)})[2]~="Beast"
				local CrawlScript=char:WaitForChild("CrawlScript",1) if CrawlScript==nil then return end
				if (plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("DisableCrawl").Value~=enableCrawl
					and CrawlScript.Disabled~=enableCrawl)
					or (AvailableHacks.Blatant[2].IsRunning) then
					return
				end 
				if char:FindFirstChild("Hammer")==nil then
					char:WaitForChild("Hammer",18)
				end
				wait(.1)
				AvailableHacks.Blatant[2].IsRunning=true
				--if CrawlScript.Disabled then

				--end
				CrawlScript.Disabled=not enableCrawl
				wait(.65)
				plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("DisableCrawl").Value=not enableCrawl
				--s%2==0 and (not enableCrawl) or enableCrawl
				--wait(.075)
				for num,animTrack in pairs(char.Humanoid.Animator:GetPlayingAnimationTracks()) do
					if animTrack.Animation.AnimationId=="rbxassetid://961932719" then
						animTrack:Stop(0) animTrack:Destroy()
						human.HipHeight=0
					end
				end
				AvailableHacks.Blatant[2].IsRunning=false--]]

			end,
			["Default"]=false,
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
				if CrawlScript==nil then return end
				--if CrawlScript.Disabled then return end
				for num,animTrack in pairs(char.Humanoid.Animator:GetPlayingAnimationTracks()) do
					if animTrack.Animation.AnimationId=="rbxassetid://961932719" then
						animTrack:Stop(0) animTrack:Destroy()
						human.HipHeight=0
					end
				end
				CrawlScript.Disabled=true
				local animTrack=human:WaitForChild("Animator"):LoadAnimation(CrawlScript:WaitForChild("AnimCrawl"))
				AvailableHacks.Blatant[2].LoadedAnim=animTrack
				local function keyAction(actionName, inputState, inputObject)
					if inputState==Enum.UserInputState.Begin then
						AvailableHacks.Blatant[2].Crawl(true)
					elseif inputState==Enum.UserInputState.End then
						AvailableHacks.Blatant[2].Crawl(false)
					end
				end
				--CAS:BindAction("Crawl",(function() print("faulty crawl script bro!") end),false,Enum.KeyCode.Menu)
				--task.wait()
				CAS:BindActionAtPriority("Crawl2", keyAction, true,100, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL2)
				CAS:SetTitle("Crawl2", "C")

				table.insert(functs,human.Running:Connect(function(speed)
					if speed > .5 then
						animTrack:AdjustSpeed(2)
					else
						animTrack:AdjustSpeed(0)
					end
				end))
				AvailableHacks.Blatant[2].Crawl(UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.ButtonL2))
			end,
			--["MyBeastAdded"]=function()
			--	wait(1)
			--	AvailableHacks.Blatant[2].SetScriptActive()
			--end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				TSM.DisableCrawl.Changed:Connect(function()
					AvailableHacks.Blatant[2].Crawl()
				end)
			end,
			["IsCrawling"]=false,
			["Crawl"]=function(set)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local animTrack=AvailableHacks.Blatant[2].LoadedAnim
				if animTrack==nil or human==nil or human.Health<=0 then return end
				if set and (enHacks.OverrideCrawl or not TSM.DisableCrawl.Value) then
					human.HipHeight = -2
					animTrack:Play(0.1, 1, 0)
					human.WalkSpeed = 8
					AvailableHacks.Blatant[2].IsCrawling=true
				else
					human.HipHeight = 0
					animTrack:Stop()
					human.WalkSpeed = human.WalkSpeed==8 and 16 or human.WalkSpeed
					AvailableHacks.Blatant[2].IsCrawling=false
				end
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
					["TextColor"]=Color3.fromRGB(255),
				},
				["Me"]={
					["Title"]="ME",
					["TextColor"]=Color3.fromRGB(0,0,255),
				},
				["Everyone"]={
					["Title"]="EVERYONE",
					["TextColor"]=Color3.fromRGB(255, 255, 0),
				},
			},
			["Default"]=false,
			["ChangedFunction"]=function(newSet)
				--print("begun")
				if Beast==nil then return end
				local CarriedTorso=Beast:FindFirstChild("CarriedTorso")
				if CarriedTorso==nil then return end
				while newSet~=nil and CarriedTorso.Value~=newSet do
					--print("waiting")
					task.wait(1/3)
				end
				local Hammer=Beast:WaitForChild("Hammer")
				if Hammer==nil or not enHacks.AutoRemoveRope then return end
				if not char:IsAncestorOf(CarriedTorso.Value) and enHacks.AutoRemoveRope=="Me" then
					--print("cancelled ", char:GetFullName())
					return
				end
				for s=2,1,-1 do
					if CarriedTorso.Value==nil then break end
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
				if CarriedTorso==nil then return end
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
		[4]={
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
					if Trigger.ActionSign.Value==11 then break end
					game.ReplicatedStorage.RemoteEvent:FireServer("Trigger", "Input", true, Trigger.Event)
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
					ActionEventVal.Value=CurrentActionEvent
					TSM.OnTrigger.Value=true
					wait(.05)
				end
			end,
			["EnableScript"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local ActionEventVal=TSM:WaitForChild("ActionEvent") 
				if ActionEventVal==nil or TSM.ActionProgress.Value%1~=0
					or ActionEventVal.Value==nil then return end 
				if not TSM.ActionInput.Value 
					and plr.PlayerGui
					:WaitForChild("ScreenGui"):WaitForChild("ActionBox").Visible then
					return
				end
				local ActionEvent=ActionEventVal.Value
				local Trigger=ActionEvent.Parent
				local isOpened=Trigger.ActionSign.Value==11 or Trigger.ActionSign.Value==0
				if isOpened then
					AvailableHacks.Blatant[4].CloseDoor(Trigger)
				end
			end,
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				setChangedAttribute(plr:WaitForChild("TempPlayerStatsModule"):WaitForChild("ActionInput"),"Value",newValue and 
					AvailableHacks.Blatant[4].EnableScript or false)
				if newValue then
					AvailableHacks.Blatant[4].EnableScript()
				end
			end,
		},
		[15]={
			["Type"]="ExTextButton",
			["Title"]="Remote Doors",
			["Desc"]="Remotely open doors!",
			["Shortcut"]="RemotelyOpenDoors",
			["Default"]=false,
			["DifferentColors"]={
				[12]={"Exit",Color3.fromRGB(255,255)},
				[11]={"Close",Color3.fromRGB(0,255)},
				[10]={"Open",Color3.fromRGB(255,255)},
				[0]={"...",Color3.fromRGB(255)},
			},
			["ChangedFunction"]=function(door,tag,doorType)
				local doorTrigger=door:FindFirstChild("DoorTrigger")
					or door:FindFirstChild("ExitDoorTrigger")
				local Toggle=tag:WaitForChild("Toggle",8) if Toggle==nil then return end
				--local tag=doorTrigger.ToggleTag
				local ActionSign=doorTrigger:WaitForChild("ActionSign",1e5) if not ActionSign then return end
				ActionSign=ActionSign.Value
				local currentSign=(ActionSign==10 and door.Name=="ExitDoor") and 12 or ActionSign
				Toggle.Text=
					AvailableHacks.Blatant[15].DifferentColors[currentSign][1]
				Toggle.BackgroundColor3=
					AvailableHacks.Blatant[15].DifferentColors[currentSign][2]
				Toggle.Visible=door.Name~="ExitDoor" or currentSign~=0
				local modifier=door:
				WaitForChild("WalkThru",20)
				if modifier~=nil then
					modifier.PathfindingModifier.Label=(currentSign==10 or currentSign==12) and "DoorPath" or "DoorOpened"
				end
			end,
			["ActivateFunction"]=function(newValue)
				local isInGame=isInLobby(camera.CameraSubject.Parent)
				for num,tag in pairs(CS:GetTagged("HackDisplay2")) do
					tag.Enabled=newValue and camera.CameraType==Enum.CameraType.Custom
						and isInGame
				end
			end,
			["CleanUp"]=function()
				for num,tag in pairs(CS:GetTagged("HackDisplay2")) do
					tag:Destroy()
				end
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
				local doorTrigger=doorType~="ExitDoor" and door:WaitForChild("DoorTrigger",100)
					or door:WaitForChild("ExitDoorTrigger",(15*60)+20)
				if not doorTrigger then return end
				local actionSign=doorTrigger:WaitForChild("ActionSign",1e5) if not actionSign then return end
				local newTag=ToggleTag:Clone()
				local isInGame=isInLobby(workspace.Camera.CameraSubject.Parent)
				newTag.Enabled=enHacks.RemotelyOpenDoors and (camera.CameraType==Enum.CameraType.Custom
					and isInGame)
				newTag.Parent=HackGUI
				newTag.Adornee=doorTrigger
				CS:AddTag(newTag,"RemoveOnDestroy")
				CS:AddTag(newTag,"HackDisplay2")
				task.wait()
				if newTag==nil or newTag.Parent==nil or newTag:FindFirstChild("Toggle")==nil then return end
				local function getState()
					return actionSign.Value==11--returns true if opened!
				end
				local function setTriggers(enabled)
					for num,trigger in pairs(CS:GetTagged("Trigger")) do
						if trigger:IsA("BasePart") and workspace:IsAncestorOf(trigger) then
							if enabled and trigger:GetAttribute("OrgSize")~=nil then
								trigger.Size=trigger:GetAttribute("OrgSize") trigger:SetAttribute("OrgSize",nil)
							elseif not enabled and trigger:GetAttribute("OrgSize")==nil then
								trigger:SetAttribute("OrgSize",trigger.Size)
								trigger.Size=Vector3.new(.0001,trigger.Size.Y,.0001)
							end
							trigger.CanTouch=enabled
						end
					end
				end
				newTag.Toggle.MouseButton1Up:Connect(function()
					if actionSign.Value==0 then
						for s=5,1,-1 do
							if actionSign.Value~=0 then break end
							wait(.075)
						end
					end
					if actionSign.Value==0 then return end
					local isOpened,currentEvent=getState(),TSM.ActionEvent.Value
					setTriggers(false)
					for s=5,1,-1 do
						if isOpened~=getState() or actionSign.Value==0 then break end
						game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, doorTrigger.Event)
						game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
						if isOpened then
							game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false)
						end
						wait()
					end
					task.spawn(function()
						while actionSign.Value==0 do
							actionSign.Changed:Wait()
						end
						setTriggers(true)
					end)
					wait()
					if currentEvent~=nil then
						game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, currentEvent)
						--wait()
						--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
					end
				end)
				AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				wait(.075)
				setChangedAttribute(actionSign,"Value", (function()
					AvailableHacks.Blatant[15].ChangedFunction(door,newTag,doorTrigger)
				end))
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
				if not enHacks.Panic or char:FindFirstChild("Head")==nil
					or not TSM.Ragdoll.Value then return end
				local newVel=Instance.new("BodyVelocity",char.Head)
				newVel.MaxForce=Vector3.new(3000,3000,3000)*2.25
				newVel.P=3e3
				CS:AddTag(newVel,"RemoveOnDestroy")
				spawn(function()
					while enHacks.Panic and TSM.Ragdoll.Value and not TSM.Captured.Value
						and not isCleared do
						newVel.Velocity=Random.new():NextUnitVector()*5e2
						task.wait(.065)
					end newVel.Velocity=Vector3.new(0,0,0) DS:AddItem(newVel,.1)
				end)

			end,
			["SetChanged"]=function(shouldntTrigger)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				setChangedAttribute(
					TSM:WaitForChild("Ragdoll"),
					"Value",enHacks.Panic and function()
						AvailableHacks.Blatant[71].Triggered()
					end or false)
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
		[76]={
			["Type"]="ExTextButton",
			["Title"]="Respawn Before Hit",
			["Desc"]="Despawns and respawns character before hit",
			["Shortcut"]="RespawnBeforeHit",
			["Default"]=false,
			["OthersBeastAdded"]=function(myBeastPlr,myBeast)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				while myBeast~=nil and workspace:IsAncestorOf(myBeast) and myBeast.PrimaryPart
					and not isCleared and myBeast==Beast and char~=myBeast do
					if not TSM.Ragdoll.Value 
						and enHacks.RespawnBeforeHit and not TSM.Captured.Value then
						local didHit,instance=raycast(char.PrimaryPart.Position,myBeast:GetPivot().Position,
							{"Whitelist",Map,myBeast},18,nil,true)
						if didHit and myBeast:IsAncestorOf(instance) 
							and not TSM.Ragdoll.Value 
							and not TSM.Captured.Value then
							AvailableHacks.Basic[24].ActivateFunction(true)
							local newChar=plr.CharacterAdded:Wait()
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
		},
		[60]={
			["Type"]="ExTextButton",
			["Title"]="Auto Capture",
			["Desc"]="Instantly capture other survivors",
			["Shortcut"]="AutoCapture",
			["Default"]=false,
			["ActivateFunction"]=function(newValue)
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				setChangedAttribute(
					TSM:WaitForChild("IsBeast"),
					"Value",newValue and function()
						AvailableHacks.Blatant[60].ChangedFunction()
					end or false)
				AvailableHacks.Blatant[60].ChangedFunction()
			end,
			["CaptureSurvivor"]=function(theirPlr,theirChar)
				local TSM=theirPlr:WaitForChild("TempPlayerStatsModule")
				if not TSM:WaitForChild("IsBeast") then return end
				if theirChar.CarriedTorso.Value==nil or not enHacks.AutoCapture then return end
				--if enHacks.AutoCapture=="Me" and theirPlr~=plr then return end
				local capsule,closestDist=nil,10000
				for num,cap in pairs(CS:GetTagged("Capsule")) do
					if cap.PrimaryPart~=nil then
						local dist=(cap.PrimaryPart.Position-theirChar.PrimaryPart.Position).magnitude
						if dist<closestDist and cap:FindFirstChild("PodTrigger")~=nil and 
							cap.PodTrigger:FindFirstChild("CapturedTorso")~=nil
							and cap.PodTrigger.CapturedTorso.Value==nil then
							capsule,closestDist=cap,dist
						end
					end
				end
				local Trigger=capsule.PodTrigger
				local isOpened=Trigger.ActionSign.Value==11
				for s=3,1,-1 do
					if capsule.PodTrigger.CapturedTorso.Value~=nil then break end--we got ourselves a trapped survivor!
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
					if isOpened then
						game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false)
					end
					wait(.15)
				end
			end,
			["ChangedFunction"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				if not TSM:WaitForChild("IsBeast").Value then return end
				local CarriedTorso=char:WaitForChild("CarriedTorso",16)
				if CarriedTorso~=nil then
					setChangedAttribute(
						CarriedTorso,
						"Value",enHacks.AutoCapture and function()
							AvailableHacks.Blatant[60].CaptureSurvivor(plr,char)
						end or false)
					AvailableHacks.Blatant[60].CaptureSurvivor(plr,char)
				else
					warn("rope not found!!!! hackssss bro!", char:GetFullName())
				end
			end,
			["MyStartUp"]=function()
				--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
				setChangedAttribute(
					TSM:WaitForChild("IsBeast"),
					"Value",enHacks.AutoCapture and function()
						AvailableHacks.Blatant[60].ChangedFunction()
					end or false)--]]
				--AvailableHacks.Blatant[60].ChangedFunction()
			end,
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
			["RescueSurvivor"]=function(capsule)
				if capsule.PodTrigger.CapturedTorso.Value==nil then return end
				if not enHacks.AutoRescue then return end
				if char:FindFirstChild("Hammer")~=nil then return end
				local Trigger=capsule.PodTrigger
				for s=5,1,-1 do
					if capsule.PodTrigger.CapturedTorso.Value==nil or not workspace:IsAncestorOf(Trigger) then break end
					local isOpened=Trigger.ActionSign.Value==11
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
					if isOpened then
						game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false)
					end
					wait(.075)
					game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", false)
					wait(.075)
				end
			end,
			["CapsuleAdded"]=function(capsule)
				if capsule:FindFirstChild("PodTrigger")~=nil then
					wait(.5)
					setChangedAttribute(
						capsule.PodTrigger:FindFirstChild("CapturedTorso"),
						"Value",enHacks.AutoRescue and (function()
							AvailableHacks.Blatant[80].RescueSurvivor(capsule)
						end) or false)
				end
			end,
		},
		[86]={
			["Type"]="ExTextButton",
			["Title"]="Auto Beast Troll",
			["Desc"]="Trolls beast automatically",
			["Shortcut"]="AutoTroll",
			["IsRunning"]=false,
			["Default"]=false,
			["CleanUp"]=function()
				AvailableHacks.Blatant[86].IsRunning=false
			end,
			["ActivateFunction"]=function(enabled)
				if enabled then
					AvailableHacks.Blatant[86].OthersBeastAdded()
				end
			end,
			["OthersBeastAdded"]=function()
				if AvailableHacks.Blatant[86].IsRunning then return end
				if Beast==char then return end
				AvailableHacks.Blatant[86].IsRunning=true
				while AvailableHacks.Blatant[86].IsRunning and Beast~=nil and workspace:IsAncestorOf(Beast)
					and enHacks.AutoTroll do
					local Trigger,dist=findClosestObj(CS:GetTagged("DoorTrigger"),Beast.PrimaryPart.Position,12,1.5)
					if Trigger~=nil and Trigger.Parent~=nil and Trigger:FindFirstChild("ActionSign")~=nil
						and Trigger.ActionSign.Value==11 then
						--print("closed door")
						--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", false)
						--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", true, Trigger.Event)
						--task.wait()
						--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
						--game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Trigger", false, Trigger.Event)
						--task.wait()
						AvailableHacks.Blatant[4].CloseDoor(Trigger)
					end
					task.wait()
				end
				AvailableHacks.Blatant[86].IsRunning=false
				--[[local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local myChar=char
				while myChar~=nil and workspace:IsAncestorOf(myChar) 
					and myChar.PrimaryPart~=nil and plr.Character==myChar and not isCleared do
					if Beast~=nil and Beast~=char  
						and enHacks.AutoCamp and TSM.Captured.Value then
						char:SetPrimaryPartCFrame(CFrame.new(Beast.PrimaryPart.CFrame*Vector3.new(0,0,-3)))
						--AvailableHacks.Basic[12].TeleportFunction(Beast.PrimaryPart.CFrame*Vector3.new(0,0,-3))
					elseif not enHacks.AutoCamp then
						hackChanged.Event:Wait()
					else
						workspace.DescendantAdded:Wait() wait(1/3)
					end
					wait()
				end--]]
			end,
		},
		[90]={
			["Type"]="ExTextButton",
			["Title"]="Perma Slow Beast",
			["Desc"]="Perm Slows Beast when its not u",
			["Shortcut"]="PermSlowBeast",
			["Default"]=false,
			["ActivateFunction"]=function()
				if Beast~=nil and Beast~=char then
					AvailableHacks.Blatant[90].OthersBeastAdded(nil,Beast)
				end
			end,
			["OthersBeastAdded"]=function(nun,beastChar)
				local Humanoid=beastChar:WaitForChild("Humanoid",20) if Humanoid==nil or Humanoid.Health<=0 then return end

				local function changeSpeed()
					local BeastPowers=beastChar:WaitForChild("BeastPowers",20) if BeastPowers==nil then return false end
					local BeastEvent=BeastPowers:WaitForChild("PowersEvent",20) if BeastEvent==nil then return false end
					if not enHacks.PermSlowBeast or not workspace:IsAncestorOf(BeastEvent) then return false end
					BeastEvent:FireServer("Jumped")
					return true
				end
				setChangedAttribute(Humanoid,"WalkSpeed",enHacks.PermSlowBeast and changeSpeed or false)
				while enHacks.PermSlowBeast and changeSpeed() do
					task.wait()
				end
			end,
			["OthersBeastRemoved"]=function(nun,beastChar)
				if beastChar==nil then return end
				local Humanoid=beastChar:WaitForChild("Humanoid",20) if Humanoid==nil or Humanoid.Health<=0 then return end
				setChangedAttribute(Humanoid,"WalkSpeed",nil)
			end,
		},
		[66]={
			["Type"]="ExTextButton",
			["Title"]="Auto Beast Hit",
			["Desc"]="Beast AUTO hits when near",
			["Shortcut"]="AutoBeastHit",
			["DontStartUp"]=false,
			["Default"]="None",
			["Options"]={
				["None"]={
					["Title"]="NONE",
					["TextColor"]=Color3.fromRGB(255)
				},
				["Me"]={
					["Title"]="ME ONLY",
					["TextColor"]=Color3.fromRGB(255,255)
				},
				["All"]={
					["Title"]="ALL",
					["TextColor"]=Color3.fromRGB(0,255)
				}
			},
			["BeastStartUp"]=function()
				local saveState=enHacks.AutoBeastHit
				local beast=Beast--the current Beast
				local Hammer=beast:WaitForChild("Hammer",2)
				while beast~=nil and beast.Parent~=nil and Hammer~=nil and enHacks.AutoBeastHit==saveState
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
			["DontStartUp"]=false,
			["Default"]="None",
			["Options"]={
				["None"]={
					["Title"]="NONE",
					["TextColor"]=Color3.fromRGB(255)
				},
				["Me"]={
					["Title"]="ME ONLY",
					["TextColor"]=Color3.fromRGB(255,255)
				},
				["All"]={
					["Title"]="ALL",
					["TextColor"]=Color3.fromRGB(0,255)
				}
			},
			["BeastStartUp"]=function()
				local saveState=enHacks.AutoBeastRope
				local beast=Beast--the current Beast
				local Hammer=beast:WaitForChild("Hammer",2)
				local CarriedTorso = beast:WaitForChild("CarriedTorso",2)
				while beast~=nil and beast.Parent~=nil and Hammer~=nil and enHacks.AutoBeastRope==saveState
					and CarriedTorso and (enHacks.AutoBeastRope=="All" 
						or (enHacks.AutoBeastRope=="Me" and beast==char)) do
					for num,theirPlr in pairs(PS:GetChildren()) do
						if theirPlr~=nil and theirPlr.Character~=nil then
							local theirChar=theirPlr.Character
							local TSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
							if TSM~=nil and not TSM.Captured.Value and TSM.Ragdoll.Value then
								local Dist=(Hammer.Handle.Position-theirChar.PrimaryPart.Position).magnitude
								if Dist<14 then
									Hammer.HammerEvent:FireServer("HammerTieUp",theirChar.Torso,
										theirChar.Torso.Position)
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
			["DontStartUp"]=true,
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
							RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
						end
						task.wait()
					end	
					for s=3,1,-1 do
						if not enHacks.Util_AutoHack then return end
						RS.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
						task.wait()
					end
					if not enHacks.Util_AutoHack then return end
					--TSM.OnTrigger.Value=true
					TSM.ActionInput.Value=false
					--for s=1,1,-1 dof

					--end

				end
			end,
			["MyStartUp"]=function()
				AvailableHacks.Utility[1].ActivateFunction(enHacks.Util_AutoHack)
			end,
		},
		[2]={
			["Type"]="ExTextButton",
			["Title"]="Override Zooming",
			["Desc"]="Allows you to zoom at any time",
			["Shortcut"]="Util_CanZoom",
			["Default"]=true,
			["UpdateZoom"]=function(void,reset)--NOT e-learning!
				if reset then
					plr.CameraMinZoomDistance=plr:GetAttribute("CameraMinZoomDistance") or plr.CameraMinZoomDistance
					plr.CameraMaxZoomDistance=plr:GetAttribute("CameraMaxZoomDistance") or plr.CameraMaxZoomDistance
					plr.CameraMode=Enum.CameraMode[plr:GetAttribute("CameraMode") or plr.CameraMode.Name]
				else
					plr:SetAttribute("CameraMinZoomDistance",plr.CameraMinZoomDistance)plr.CameraMinZoomDistance=.5--minimum
					plr:SetAttribute("CameraMaxZoomDistance",plr.CameraMaxZoomDistance)plr.CameraMaxZoomDistance=50--maximum
					plr:SetAttribute("CameraMode",plr.CameraMode.Name)plr.CameraMode=Enum.CameraMode.Classic
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
		[3]={
			["Type"]="ExTextButton",
			["Title"]="Client Performance Improvements",
			["Desc"]="Fixes elements of the GUI",
			["Shortcut"]="Util_Fix",
			["Default"]=true,
			["ActivateFunction"]=function(newValue)
				local MenusTabFrame=plr:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")
				:WaitForChild("MenusTabFrame")
				local IsCheckingLoadData=plr:WaitForChild("IsCheckingLoadData")
				local function changedFunct()
					if enHacks.Util_Fix then
						MenusTabFrame.Visible=not IsCheckingLoadData.Value
					end
				end
				setChangedAttribute(MenusTabFrame,"Visible",newValue and changedFunct or nil)
				changedFunct()
			end,
			["MyStartUp"]=function()
				AvailableHacks.Utility[3].ActivateFunction(enHacks.Util_Fix)
			end,
		},
	},
	["Basic"]={
		[1]={
			["Type"]="ExTextBox",
			["Title"]="Walkspeed",
			["Desc"]="Set to 16 to default",
			["Shortcut"]="WalkSpeed",
			["Default"]=(myBots[plr.Name:lower()] and game.PlaceId==893973440) and 48 or 16,
			["MinBound"]=0,
			["MaxBound"]=1e3,
			["ActivateFunction"]=function(newValue)
				local function setSpeed()
					human.WalkSpeed=human:GetAttribute("OverrideSpeed") or 
						(newValue==16 and (plr:WaitForChild("TempPlayerStatsModule",.5) and
							plr.TempPlayerStatsModule.NormalWalkSpeed.Value) or newValue)
				end

				if newValue==16 then
					setChangedAttribute(human,"WalkSpeed",false)
				else
					setChangedAttribute(human,"WalkSpeed",setSpeed)
					table.insert(functs,human:GetAttributeChangedSignal("OverrideSpeed"):Connect(setSpeed))
				end
				setSpeed()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				AvailableHacks.Basic[1].ActivateFunction(enHacks.WalkSpeed)
			end,
		},
		[2]={
			["Type"]="ExTextBox",
			["Title"]="JumpPower",
			["Desc"]="Set to 36 to default",
			["Shortcut"]="JumpPower",
			["Default"]=36,
			["MinBound"]=0,
			["MaxBound"]=1e4,
			["ActivateFunction"]=function(newValue)
				local function setJump()
					human.JumpPower=newValue
				end

				if newValue==50 then
					setChangedAttribute(human,"JumpPower",false)
				else
					setChangedAttribute(human,"JumpPower",setJump)
				end
				setJump()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				AvailableHacks.Basic[2].ActivateFunction(enHacks.JumpPower)
			end,
		},
		[3]={
			["Type"]="ExTextBox",
			["Title"]="Gravity",
			["Desc"]="Set to 196.2 to default",
			["Shortcut"]="Gravity",
			["Default"]=196.2,
			["MinBound"]=0,
			["MaxBound"]=1e3,
			["ActivateFunction"]=function(newValue)
				local function setSpeed()
					workspace.Gravity=newValue
				end
				if math.abs(newValue-196.2)<1e-5 then
					setChangedAttribute(workspace,"Gravity",false)
				else
					setChangedAttribute(workspace,"Gravity",setSpeed)
				end
				setSpeed()
			end,
			["MyStartUp"]=function(theirPlr,theirChar)
				AvailableHacks.Basic[3].ActivateFunction(enHacks.Gravity)
			end,
		},
		[4]={
			["Type"]="ExTextButton",
			["Options"]={
				[false]={
					["Title"]="OFF",
					["TextColor"]=Color3.fromRGB(255),
				},
				["Fly"]={
					["Title"]="FLY",
					["TextColor"]=Color3.fromRGB(0,0,255),
				},
				["InfJump"]={
					["Title"]="INFINITE JUMP",
					["TextColor"]=Color3.fromRGB(0,255,255),
				},
				["Jetpack"]={
					["Title"]="JETPACK",
					["TextColor"]=Color3.fromRGB(255,255,0)
				},
				["Float"]={
					["Title"]="FLOAT",
					["TextColor"]=Color3.fromRGB(0,255)
				}
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
				local RunS = game:GetService("RunService")

				local hrp = char:WaitForChild("HumanoidRootPart");
				local animator = human:WaitForChild("Animator");

				while (not char.Parent) do char.AncestryChanged:Wait(); end

				local bodyGyro = Instance.new("BodyGyro");
				bodyGyro.maxTorque = Vector3.new(1, 1, 1)*10^6;
				bodyGyro.P = 10^6;

				local bodyVel = Instance.new("BodyVelocity");
				bodyVel.maxForce = Vector3.new(1, 1, 1)*10^6;
				bodyVel.P = 10^4;

				local Attach = Instance.new("Attachment")
				local Attack2 = Attach:Clone()

				AvailableHacks.Basic[4].IsActive=false
				local IsActive = AvailableHacks.Basic[4].IsActive;
				local movement = {forward = 0, backward = 0, right = 0, left = 0, down = 0, up = 0};
				local mouse = plr:GetMouse()
				local i = 0
				AvailableHacks.Basic[4].ToggleFunct=function(flying)
					AvailableHacks.Basic[4].IsActive = flying;
					bodyGyro.Parent = AvailableHacks.Basic[4].IsActive and char.Head or nil;
					bodyVel.Parent = AvailableHacks.Basic[4].IsActive and char.Head or nil;
					bodyGyro.CFrame = hrp.CFrame;
					bodyVel.Velocity = Vector3.new();
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
						local cf = camera.CFrame;
						local direction = cf.rightVector*(movement.right - movement.left)
							+ cf.lookVector*(movement.forward - movement.backward)
							+ cf.UpVector*(movement.up-movement.down);
						if (direction:Dot(direction) > 0) then
							direction = direction.unit;
						end
						bodyGyro.CFrame = cf;
						bodyVel.Velocity = (direction * Vector3.new(enHacks.MovementHorizontalSpeed,enHacks.MovementVerticalSpeed,enHacks.MovementHorizontalSpeed)) 
							* human.WalkSpeed * speed;
					end
				end



				local function movementBind(actionName, inputState, inputObject)
					if (inputState == Enum.UserInputState.Begin) then
						movement[actionName] = 1;--enHacks[ActionSettings[actionName]];
					elseif (inputState == Enum.UserInputState.End) then
						movement[actionName] = 0;
					end
					if (AvailableHacks.Basic[4].IsActive) then
						local isMoving = movement.right + movement.left + movement.forward + movement.backward > 0;
					end
					return Enum.ContextActionResult.Pass;
				end

				CAS:BindAction("forward", movementBind, false, Enum.PlayerActions.CharacterForward);
				CAS:BindAction("backward", movementBind, false, Enum.PlayerActions.CharacterBackward);
				CAS:BindAction("left", movementBind, false, Enum.PlayerActions.CharacterLeft);
				CAS:BindAction("right", movementBind, false, Enum.PlayerActions.CharacterRight);
				CAS:BindAction("up", movementBind, false, Enum.PlayerActions.CharacterJump);
				table.insert(AvailableHacks.Basic[4].MovementFuncts,RunS.RenderStepped:Connect(onUpdate))
				table.insert(AvailableHacks.Basic[4].MovementFuncts,animator.AnimationPlayed:Connect(function(animTrack)
					if AvailableHacks.Basic[4].IsActive
						and allowedID[animTrack.Animation.AnimationId]==nil then
						animTrack:Stop(0) 
					end
				end))
			end,
			["InfJumpScript"]=function()
				local index=0
				local function forceJump(actionName, inputState, inputObject)
					if inputState==Enum.UserInputState.Begin then
						local saveIndex=index
						while saveIndex==index and AvailableHacks.Basic[4].IsActive
							and enHacks.Movement=="InfJump" do
							human:ChangeState(Enum.HumanoidStateType.Jumping)
							wait(.4/enHacks.MovementVerticalSpeed)
						end
					elseif inputState==Enum.UserInputState.End then
						index+=1
					end
				end
				AvailableHacks.Basic[4].ToggleFunct=function(isActive)
					if isActive then
						CAS:BindAction("up", forceJump, false, Enum.KeyCode.Space, Enum.KeyCode.ButtonX)
						if UIS:IsKeyDown(Enum.KeyCode.Space) then
							forceJump("up",Enum.UserInputState.Begin)
						end
					else
						CAS:UnbindAction("up")
					end
				end
				AvailableHacks.Basic[4].ToggleFunct(AvailableHacks.Basic[4].IsActive)
			end,
			["JetpackScript"]=function()
				local isOnLand,jumpEnd,jumpBoost,inputBegan,inputEnded,v167
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
				Jetpack.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Jetpack.BackgroundTransparency = 0.300
				Jetpack.Position = UDim2.new(0.978341579, 0, 0.251152068, 0)
				Jetpack.Size = UDim2.new(0.0147277517, 0, 0.369124442, 0)

				Frame.Parent = Jetpack
				Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
				Frame.Size = UDim2.new(1, 0, 1, 0)

				UICorner.Parent = Frame

				UICorner_2.Parent = Jetpack

				local v5 = char:WaitForChild("HumanoidRootPart")
				local v7 = game:GetService("UserInputService")
				local v14 = Instance.new("BodyVelocity", v5.Parent.Head)
				v14.MaxForce = Vector3.new(0, 0, 0) v14.Name="JetpackVelocity"
				local v32 = 7
				local v39 = Frame
				local fadePerc = function(p1, p2)
					v39:TweenSizeAndPosition(UDim2.new(1, 0, p1, 0), UDim2.new(0, 0, 1 - p1, 0), "Out", "Linear", p2, true)
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
					local v91, v87 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v5.Position, Vector3.new(0, -4, 0)), v86)
					if not v91 then
						return true
					end
					return false
				end
				isOnLand = isOnLand_1
				isOnLand_1 = true
				local v98 = 0
				jumpEnd = function()
					v98 = v98 + 1
					local v120 = v98
					v14.MaxForce = Vector3.new(0, 0, 0)
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
				AvailableHacks.Basic[4].ToggleFunct=function(isActive)
					Jetpack.Visible=isActive
					if not isActive then
						jumpEnd()
					elseif isActive and UIS:IsKeyDown(Enum.KeyCode.Space) then
						spawn(function()
							inputBegan({["KeyCode"]=Enum.KeyCode.Space})
						end)
					end
				end
				jumpBoost = function()
					if not AvailableHacks.Basic[4].IsActive then return end
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
					v14.MaxForce = Vector3.new(12000, 12000, 12000)
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
					if isCleared then return end
					local v171 = Enum.KeyCode.Space
					if p4.KeyCode == v171 then
						v171 = jumpEnd
						v171()
					end
				end
				inputEnded = inputEnded_1
				inputEnded_1 = v7.InputBegan
				AvailableHacks.Basic[4].ToggleFunct(AvailableHacks.Basic[4].IsActive)
				table.insert(AvailableHacks.Basic[4].MovementFuncts,inputEnded_1:connect(inputBegan))
				table.insert(AvailableHacks.Basic[4].MovementFuncts,v7.InputEnded:connect(inputEnded))
				spawn(function()
					while not isCleared and enHacks.Movement=="Jetpack" and workspace:IsAncestorOf(v14) do
						v14.Velocity=(v5.CFrame-v5.Position)*Vector3.new(0,60*enHacks.MovementVerticalSpeed,-60*enHacks.MovementHorizontalSpeed)
						wait()
					end
				end)
			end,
			["FloatScript"]=function()
				local v14 = Instance.new("BodyPosition", char:WaitForChild("Head"))
				v14.MaxForce = Vector3.new(0, 0, 0) v14.Name="JetpackVelocity"
				local height=0
				local baseHeight=0
				local isR6=human.RigType==Enum.HumanoidRigType.R6
				local function update(new,saveHeight)
					local didHit,hitPart=raycast(char.PrimaryPart.Position,char.PrimaryPart.Position-Vector3.new(0,3,0),{"Blacklist",char},
					isR6 and char.PrimaryPart.Size.Y/2+char["Right Leg"].Size.Y/2+3.03 or getHumanoidHeight(char),nil,true)
					if didHit--char.Humanoid.FloorMaterial~=Enum.Material.Air
					then--if height==0 or char.Humanoid.FloorMaterial~=Enum.Material.Air then 
						baseHeight=char.HumanoidRootPart.Position.Y
						if math.abs(height)>0 then
							height=0
						else
							height=math.max(0,new)
						end
					else
						height=new
					end
					v14.Position = Vector3.new(0,baseHeight+height,0)
					if height<.1 and height>-.1 then
						v14.MaxForce = Vector3.new(0,0,0)
					else
						v14.MaxForce = Vector3.new(0, 12000000e9, 0)
						local saveHeight=saveHeight or height
						task.delay(.1,function()
							if saveHeight==height then
								update(height)
							end
						end)
					end
				end
				local function ascend()
					while UIS:IsKeyDown(Enum.KeyCode.F) do
						update(height+2)
						task.wait(.05)
					end
				end
				local function descend()
					while UIS:IsKeyDown(Enum.KeyCode.G) do
						update(height-2)
						task.wait(.05)
					end
				end
				CAS:BindAction("up", ascend, false, Enum.KeyCode.F, Enum.KeyCode.ButtonY)
				CAS:BindAction("down", descend, false, Enum.KeyCode.G, Enum.KeyCode.ButtonX)
				update(0)
			end,
			["DisableMovement"]=function()
				if AvailableHacks.Basic[4].IsActive and AvailableHacks.Basic[4].ToggleFunct then
					AvailableHacks.Basic[4].ToggleFunct() AvailableHacks.Basic[4].ToggleFunct=nil
				end
				for num,funct in pairs(AvailableHacks.Basic[4].MovementFuncts) do
					funct:Disconnect()
				end AvailableHacks.Basic[4].MovementFuncts={}
				AvailableHacks.Basic[4].ToggleFunct=nil
				CAS:UnbindAction("foward")
				CAS:UnbindAction("backward")
				CAS:UnbindAction("left")
				CAS:UnbindAction("right")
				CAS:UnbindAction("up")
				local JetpackGUI=plr.PlayerGui:FindFirstChild("JetpackGUI")
				if JetpackGUI~=nil then JetpackGUI:Destroy() end
				if char:FindFirstChild("Head")~=nil then
					local JetpackVelocity=char.Head:FindFirstChild("JetpackVelocity")
					if JetpackVelocity~=nil then JetpackVelocity:Destroy() end
				end
			end,

			["ActivateFunction"]=function(newValue)
				AvailableHacks.Basic[4].DisableMovement()
				if enHacks.Movement then
					AvailableHacks.Basic[4].IsActive=true
					AvailableHacks.Basic[4][enHacks.Movement.."Script"]()
				end
			end,
			["MyStartUp"]=function(myPlr,myChar)
				AvailableHacks.Basic[4].DisableMovement()
				if enHacks.Movement then
					AvailableHacks.Basic[4].IsActive=true
					AvailableHacks.Basic[4][enHacks.Movement.."Script"]()
				end
			end,
			["MyPlayerAdded"]=function(plr)
				local function onKeyPress(input, gameProcessedEvent)
					if input.KeyCode == Enum.KeyCode.Z 
						and gameProcessedEvent == false and enHacks.Movement then
						if (not human or human:GetState() == Enum.HumanoidStateType.Dead) then
							return;
						end
						AvailableHacks.Basic[4].IsActive=not AvailableHacks.Basic[4].IsActive
						if AvailableHacks.Basic[4].ToggleFunct~=nil then
							AvailableHacks.Basic[4].ToggleFunct(AvailableHacks.Basic[4].IsActive)
						end
					end
				end
				table.insert(functs,UIS.InputBegan:Connect(onKeyPress))
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
				local primPart=char.PrimaryPart if primPart==nil then return end
				local position1=(char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")).Position
				local position2=target+ Vector3.new(0,char:GetExtentsSize().Y/2+1.85,0)
				position2=isCFrame and position2.Position or position2
				local result,hitPart=raycast(position1,
					position2,{"Blacklist",char},(position1-position2).magnitude,1,true)
				if not result then
					result={["Position"]=position2}
				end
				--if not isCFrame then
				local orientation
				if not isCFrame then
					orientation=newOrien~=nil and 
						Vector3.new(newOrien.X,primPart.Orientation.Z,primPart.Orientation.Z) 
						or primPart.Orientation
				else
					orientation=Vector3.new(target:ToOrientation())
				end
				char:SetPrimaryPartCFrame(CFrame.new(result.Position)
					*--Vector3.new(0,char:GetExtentsSize().Y/2+.25,0))*
					CFrame.Angles(math.rad(orientation.X),math.rad(orientation.Y),math.rad(orientation.Z)))
			end,
			["ActivateFunction"]=function(newValue)
				local mouse=plr:GetMouse()
				objectFuncts[mouse]=objectFuncts[mouse] or {}
				for num,funct in pairs(objectFuncts[mouse]) do
					funct:Disconnect()
				end
				if newValue then
					table.insert(objectFuncts[mouse],mouse.KeyDown:connect(function(key)
						if key == "t" then
							--local mouseHit=UIS:GetMouseLocation()
							local inputPosition = mouse.Hit.Position
							-- ViewportPointToRay would probably be more accurate to use here
							--print(ray.Origin,ray.Direction)
							--createTestPart(mouseUnitRay.Origin,3)
							--createTestPart(inputPosition,3)
							AvailableHacks.Basic[12].TeleportFunction(inputPosition)
						end
					end))
				end

			end,
			["MyStartUp"]=function()
				if char.PrimaryPart==nil then
					char.PrimaryPart=char:WaitForChild("HumanoidRootPart")
				end
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
				[true]={
					["Title"]="ACTIVATE",
					["TextColor"]=Color3.fromRGB(255,255,255),
				},
			},
			["BeforeReset"]=function()
				local function Remove(findName,recurseLoop)
					local obj=char:FindFirstChild(findName,recurseLoop)
					if obj~=nil then obj:Destroy() end
				end
				Remove("LocalClubScript",true)
			end,
			["ActivateFunction"]=function(newValue)
				if char~=nil and human~=nil and char.Parent~=nil then
					AvailableHacks.Basic[24].BeforeReset()
					if human.RigType==Enum.HumanoidRigType.R15 then
						char.UpperTorso:Destroy()
					else
						char.Torso:Destroy()
					end
					RunS.RenderStepped:Wait()
					for num,part in pairs(char:GetDescendants()) do
						if part:IsA("BasePart") then part:Destroy() end
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
		[60]={
			["Type"]="ExTextButton",
			["Title"]="Anti AFK",
			["Desc"]="Avoid AFK Kick",
			["Shortcut"]="AntiAFK1",
			["Default"]=true,
			["Funct"]=nil,
			["ActivateFunction"]=function(newValue)
				if AvailableHacks.Basic[60].Funct~=nil then
					AvailableHacks.Basic[60].Funct:Disconnect()
				end
				if newValue then
					AvailableHacks.Basic[60].Funct=plr.Idled:connect(function(timeSec)--runs every sec after 2m, and pulses every second after that
						if enHacks.AntiAFK1 then
							VU:CaptureController()
							VU:ClickButton2(Vector2.new())
						end
					end)
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
					["TextColor"]=Color3.fromRGB(255, 180, 0),
				},
			},
			["ActivateFunction"]=function(newValue)
				clear()
			end,
		},
	},
	["Bot"]={
		[15]={
			["Type"]="ExTextButton",
			["Title"]="Bot Farm Runner",
			["Desc"]="Automatically Bot Farms as Runner",
			["Shortcut"]="BotRunner",
			["Default"]=botModeEnabled,
			["DontStartUp"]=true,
			["CurrentPath"]=nil,
			["CurrentTarget"]=nil,
			["MapData"]={
				["Airport by deadlybones28"]={
					["DefaultVentSize"]=Vector3.new(3, 7, 1.75),
					["Vents"]={
						{["Position"]=Vector3.new(264.5, 5.6, 188)},
						{["Position"]=Vector3.new(264.5, 5.6, 116)},
						{["Position"]=Vector3.new(116.5, 5.6, 113)},
						{["Position"]=Vector3.new(218.5, 5.6, 61)},
						{["Position"]=Vector3.new(117, 18.6, 114.5)},
						{["Position"]=Vector3.new(255.5, 18.6, 212),
							["Size"]=Vector3.new(4.5, 7, 3)},
					},
					["NoWalkThru"]={
						{["Position"]=Vector3.new(267.125, 7.53, 149),
							["Size"]=Vector3.new(4.25, 10.75, 9.5)},
						{["Position"]=Vector3.new(244, 19.6, 140.5),
							["Size"]=Vector3.new(28, 11, 1)},
						{["Position"]=Vector3.new(235.5, 12.242, 235.263),
							["Size"]=Vector3.new(1, 3.25, 14.75),
							["Orientation"]=Vector3.new(-45, 0, 0)},
						{["Position"]=Vector3.new(230.5, 12.242, 235.263),
							["Size"]=Vector3.new(1, 3.25, 14.75),
							["Orientation"]=Vector3.new(-45, 0, 0)},
						{["Position"]=Vector3.new(119.002, 7.628, 12.002),
							["Size"]=Vector3.new(4, 10.945, 14)},
					}
				},
				["Abandoned Prison by AtomixKing and Duck_Ify"]={
					["DefaultVentSize"]=Vector3.new(3, 7, 1.75),
					["Vents"]={
						{["Position"]=Vector3.new(186.25, 6.988, 157.35)},
						{["Position"]=Vector3.new(155.95, 6.988, 224.4),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(109.95, 6.988, 189.5),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(29.45, 6.988, 94.5),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(48.65, 6.988, 17.5),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(132.65, 6.988, 28.45),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(175.5, 6.988, 53.2)},
						{["Position"]=Vector3.new(207.35, 6.988, 104.5),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(283.5, 6.988, 100.3)},
						{["Position"]=Vector3.new(77.65, 6.988, 178.475),
							["Orientation"]=Vector3.new(0, -90, 0)},
					},
					["NoWalkThru"]={
						{["Position"]=Vector3.new(80.875, 7.53, 165.188),
							["Size"]=Vector3.new(6.5, 10.75, 0.125)},
						{["Position"]=Vector3.new(97.027, 7.53, 35.735),
							["Size"]=Vector3.new(12, 10.75, 0.375),
							["Orientation"]=Vector3.new(0,-120,0)},
					}
				},
				["Facility_0 by MrWindy"]={
					["DefaultVentSize"]=Vector3.new(1.75, 7, 3),
					["Vents"]={
						{["Position"]=Vector3.new(86, 5.5, 79.9),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(60, 5.5, 94)},
						{["Position"]=Vector3.new(75.25, 5.5, 184)},
						{["Position"]=Vector3.new(180.25, 5.5, 196)},
						{["Position"]=Vector3.new(130, 5.5, 234)},
						{["Position"]=Vector3.new(154.9, 5.5, 106)},
						{["Position"]=Vector3.new(257.9, 5.5, 104)},
						{["Position"]=Vector3.new(252.1, 5.5, 116)},
						{["Position"]=Vector3.new(56, 5.5, 115.15),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(174, 5.5, 174.9),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(217.9, 5.5, 56)},
						{["Position"]=Vector3.new(214, 5.5, 170.1),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(90.9, 5.5, 44)},
						{["Position"]=Vector3.new(44, 5.5, 215.1),
							["Orientation"]=Vector3.new(0, -90, 0)},
					},
					["NoWalkThru"]={
						{["Position"]=Vector3.new(13, 3.625, 192.6),
							["Size"]=Vector3.new(0.25, 7, 9.5)},
						{["Position"]=Vector3.new(37, 3.625, 192.6),
							["Size"]=Vector3.new(0.25, 7, 9.5)},
						{["Position"]=Vector3.new(37.25, 20.125, 178.35),
							["Size"]=Vector3.new(0.75, 16, 1)},
						{["Position"]=Vector3.new(12.75, 20.125, 178.35),
							["Size"]=Vector3.new(0.75, 16, 1)},
						{["Position"]=Vector3.new(105.717, 7.5, 139.633),
							["Size"]=Vector3.new(1.5, 0.75, 2.25),
							["Orientation"]=Vector3.new(0, -30, 0)},
						{["Position"]=Vector3.new(124.336, 7.5, 150.383),
							["Size"]=Vector3.new(1.5, 0.75, 2.25),
							["Orientation"]=Vector3.new(0, -30, 0)},
					}
				},
				["The Library by Drainhp"]={
					["DefaultVentSize"]=Vector3.new(3, 7, 1.75),
					["Vents"]={
						{["Position"]=Vector3.new(98.5, 33.6, 49)},
						{["Position"]=Vector3.new(66.25, 13.5, 209)},
						{["Position"]=Vector3.new(97.25, 13.5, 126.55)},
						{["Position"]=Vector3.new(27.6, 13.5, 77.75),
							["Orientation"]=Vector3.new(0, 90, 0)},
						{["Position"]=Vector3.new(160.75, 33.5, 193.1)},--stopped here
						{["Position"]=Vector3.new(123.25, 13.5, 20)},
						{["Position"]=Vector3.new(89.25, 33.5, 126.6)},
						{["Position"]=Vector3.new(143.35, 13.5, 197.25),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(165.75, 13.5, 148.55)},
						{["Position"]=Vector3.new(47.15, 33.5, 175.3),
							["Orientation"]=Vector3.new(0, -90, 0)},
						--{["Position"]=Vector3.new(209.45, 32.7, 57.25)},--ELEVATOR EVENT, REMOVED B/C CONFLICTS
					},
					["NoWalkThru"]={
						{["Position"]=Vector3.new(111.9, 35.188, 54.125),
							["Size"]=Vector3.new(26.4, 10.375, 0.125)},
						{["Position"]=Vector3.new(113.837, 17.438, 134.125),
							["Size"]=Vector3.new(2.525, 2.875, 0.375)},
						{["Position"]=Vector3.new(149.462, 17.438, 118.875),
							["Size"]=Vector3.new(2.525, 2.875, 0.375)},
						{["Position"]=Vector3.new(235.712, 19.563, 169.25),
							["Size"]=Vector3.new(9.525, 2.875, 1.5)},
						{["Position"]=Vector3.new(235.712, 18.834, 169.25),
							["Size"]=Vector3.new(9.525, 4.333, 3.5)},
						{["Position"]=Vector3.new(175.775, 13.438, 161.375),
							["Size"]=Vector3.new(8.4, 6.625, 3)},
						{["Position"]=Vector3.new(148.962, 14.938, 121.875),
							["Size"]=Vector3.new(1.525, 0.875, 5.375)},
						{["Position"]=Vector3.new(252.712, 12.084, 171.125),
							["Size"]=Vector3.new(17.525, 4.333, 3.25)},
					}
				},
				["Abandoned Facility Remake by Daniel_H407"]={
					["DefaultVentSize"]=Vector3.new(3, 7, 1.75),
					["Vents"]={
						{["Position"]=Vector3.new(54.2, 6.5, 93.1)},
						{["Position"]=Vector3.new(177.2, 6.5, 72.75)},
					},
					["NoWalkThru"]={
						{["Position"]=Vector3.new(20.887, 10.125, 143.6),
							["Size"]=Vector3.new(5.375, 8.5, 3.75)},
						{["Position"]=Vector3.new(159.2, 9, 191.725),
							["Size"]=Vector3.new(1.375, 12, 12.5)},
						{["Position"]=Vector3.new(142.825, 15.875, 169.85),
							["Size"]=Vector3.new(7.625, 28.25, 10.75)},
						{["Position"]=Vector3.new(152.262, 23.5, 169.85),
							["Size"]=Vector3.new(11.25, 13, 10.75)},
						{["Position"]=Vector3.new(183.2, 9, 237.1),
							["Size"]=Vector3.new(5, 12, 23.5)},
						{["Position"]=Vector3.new(183.2, 9, 266.725),
							["Size"]=Vector3.new(5, 12, 16.75)},
						{["Position"]=Vector3.new(159.2, 9.125, 191.725),
							["Size"]=Vector3.new(1.375, 14.75, 12.5)}
					},
				},
				["Forgotten Facility by Kmart_Corp"]={
					["DefaultVentSize"]=Vector3.new(2.05, 7, 1.75),
					["Vents"]={
						{["Position"]=Vector3.new(243.25, 7.572, 214.75),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(203.25, 7.572, 129.25)},
						{["Position"]=Vector3.new(135.25, 7.572, 291.25),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(161.251, 7.572, 154.5),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(215.75, 7.572, 257.25)},
						{["Position"]=Vector3.new(194.75, 7.572, 289.25),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(161.25, 7.572, 211),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(83.25, 7.572, 62.25),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(48.75, 7.572, 276.75)},
						{["Position"]=Vector3.new(273.75, 7.572, 56.25)},
						{["Position"]=Vector3.new(169.75, 7.572, 303.251)},
						{["Position"]=Vector3.new(40.75, 7.572, 150.25),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(82, 7.572, 129.25)},
					},
					["NoWalkThru"]={
						{["Position"]=Vector3.new(105.553, 6.645, 182.725),
							["Size"]=Vector3.new(0.375, 5.25, 13),
							["Orientation"]=Vector3.new(0, 0, 0)},
						{["Position"]=Vector3.new(116.178, 10.572, 127.975),
							["Size"]=Vector3.new(9.625, 13, 4)},
						{["Position"]=Vector3.new(147.178, 10.77, 55.475),
							["Size"]=Vector3.new(1.125, 13, 42)},
					},
					["CollideSpots"]={
						{["Position"]=Vector3.new(109.303, 11.716, 183.225),
							["Size"]=Vector3.new(0.125, 27.75, 11.5),
							["Orientation"]=Vector3.new(0, 0, 56)}
					}
				},
				["Homestead by MrWindy"]={
					["DefaultVentSize"]=Vector3.new(3, 7, 1.75),
					["DefaultWindowSize"]=Vector3.new(5, 10.5, 2.5),
					["Vents"]={
						{["Position"]=Vector3.new(51, 29.5 - 23, 180),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(20, 29.5 - 23, 246)},
						{["Position"]=Vector3.new(151, 29.5 - 23, 191.5),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(151, 29.5 - 23, 260.5),
							["Orientation"]=Vector3.new(0, -90, 0)},
						{["Position"]=Vector3.new(29.5, 29.5 - 23, 37)},
						{["Position"]=Vector3.new(133.5, 6.5, 153.5),
							["Size"]=Vector3.new(3, 7, 14)}
						--{["Position"]=Vector3.new(190.95, 8.75, 132),
						--["Size"]=Vector3.new(3.5, 5.5, 3)},
					},
					["NoWalkThru"]={
						{["Position"]=Vector3.new(262.5, 6.5, 156.5),
							["Size"]=Vector3.new(33, 3, 3),
							["Orientation"]=Vector3.new(90, 90, 0)},
						{["Position"]=Vector3.new(241.5, 6.5, 143.5),
							["Size"]=Vector3.new(39, 3, 3),
							["Orientation"]=Vector3.new(90, 0, 0)},
						{["Position"]=Vector3.new(250.5, 6.5, 170.5),
							["Size"]=Vector3.new(21, 3, 3),
							["Orientation"]=Vector3.new(90, 0, 0)},
						{["Position"]=Vector3.new(220.5, 6.5, 148.5),
							["Size"]=Vector3.new(17, 3, 3),
							["Orientation"]=Vector3.new(90, 90, 0)},
						{["Position"]=Vector3.new(257, 14.826, 155),
							["Size"]=Vector3.new(6, 9.003, 8)},
						{["Position"]=Vector3.new(135.75, 8.75, 116.25),
							["Size"]=Vector3.new(3.5, 1.5, 3.5)},
						{["Position"]=Vector3.new(41, 6.75, 65),
							["Size"]=Vector3.new(1, 25, 7.5)}
					},
					["Windows"]={
						{["Position"]=Vector3.new(218, 8.25, 192),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(178, 8.25, 192),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(178, 8.25, 260),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(218, 8.25, 260),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(172, 8.25, 168),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(156, 8.25, 119),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(105, 8.25, 77),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(57, 8.25, 77),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(41, 8.25, 19)},
						{["Position"]=Vector3.new(121, 8.25, 33)},
						{["Position"]=Vector3.new(198, 22.75, 260),
							["Size"]=Vector3.new(3, 13.5, 3),
							["Orientation"]=Vector3.new(0,90,0)},
						{["Position"]=Vector3.new(237, 22.75, 226),
							["Size"]=Vector3.new(3, 13.5, 3)},
						{["Position"]=Vector3.new(159, 22.75, 226),
							["Size"]=Vector3.new(3, 13.5, 3)},
					},
					["CollideSpots"]={
						{["Position"]=Vector3.new(150.5, 4.75, 111),
							["Size"]=Vector3.new(5.5, 7, 5),
							["Orientation"]=Vector3.new(0, 90, -90),
							["Shape"]=Enum.PartType.Cylinder}
					}
				}
			},
			["AvoidParts"]={},
			["CurrentNum"]=0,
			["DidAction"]=false,
			--["CanRun"]=nil,
			["ChangedEvent"]=Instance.new("BindableEvent",script),
			["WalkPath"]=function(path,target,checkFunct)
				path:Stop()
				local updatedTarget=typeof(target)=="Instance" and 
					(target:GetAttribute("WalkToPoso") or target.Position) or target
				local event=AvailableHacks.Bot[15].ChangedEvent
				AvailableHacks.Bot[15].DidAction=false
				AvailableHacks.Bot[15].CurrentTarget=target

				local startLoc=char.Torso.Position

				local isWaiting,start,lastTrigger=true,os.clock(),0
				local Torso=char:FindFirstChild("Torso")
				task.spawn(function()
					while true do--for s=3,1,-1 do 
						if not isWaiting or Torso==nil then break end
						local currentPoso=Torso.Position
						if os.clock()-start>3 
							--or (char.Torso.Position-target.Position).magnitude<4
							--or not AvailableHacks.Bot[15].CanRun(false)
							or (checkFunct and not checkFunct())then
							if os.clock()-start>3 and (startLoc-char.Torso.Position).Magnitude<4 then
								for s=1,2 do
									declareError(path, path.ErrorType.AgentStuck)
								end
							end
							event:Fire(false,false) break 
						end
						if os.clock()-lastTrigger>=1.5 then
							--[[if (startLoc-char.Torso.Position).Magnitude<1/2 then
								declareError(path, path.ErrorType.AgentStuck)
							end--]]
							task.spawn(function()
								path:Run(updatedTarget)
							end)
							lastTrigger=os.clock()
							startLoc=char.Torso.Position
						end
						wait(.15)
					end--]]
				end)
				local result,canRun=event.Event:Wait()
				--local results=event.Event:Wait() 
				--if results then
				--	
				--end
				--isWaiting=false
				--return results--]]
				isWaiting=false

				if not canRun and char.Parent then
					human:MoveTo(char.PrimaryPart.Position)
					return false
				elseif result then
					path:Stop() task.wait()
					--human:MoveTo(updatedTarget)
					AvailableHacks.Bot[20].Funct(path,updatedTarget)
				end
				return result or ((updatedTarget-char.PrimaryPart.Position)/Vector3.new(1,4,1)).magnitude<2
			end,
			["UnlockDoor"]=function(shouldWait)
				if isActionProgress then return false end
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local ActionSign 
				--if not skipWait and ActionSign==nil then --print("searching") 
				for s=60,1,-1 do

					--for num,part in pairs(char.Torso:GetTouchingParts()) do
					ActionSign=TSM.ActionEvent.Value~=nil 
						and string.find(TSM.ActionEvent.Value.Parent.Parent.Name,"Door")~=nil
						and TSM.ActionEvent.Value.Parent:FindFirstChild("ActionSign")--part:FindFirstChild("ActionSign")
					--if ActionSign~=nil then break end
					--end
					--local hit=char.Torso.Touched:Wait() task.wait()
					--ActionSign=hit:FindFirstChild("ActionSign")
					--print("touch set!")
					if ActionSign or not shouldWait then break end
					task.wait() --print("reset")
				end
				--end
				if ActionSign then
					local Trigger=ActionSign.Parent
					if true then
						isActionProgress=true AvailableHacks.Bot[15].DidAction=true
						if TSM.ActionEvent.Value~=nil and (ActionSign.Value==10 or ActionSign.Value==12) then
							VU:SetKeyDown("e") wait()  
							VU:SetKeyUp("e") TSM.ActionProgress.Changed:Wait()
						end --print("opening!",shouldWait)
						while TSM.ActionProgress.Value%1~=0 and 
							TSM.ActionProgress.Value~=1 do
							TSM.ActionProgress.Changed:Wait()
						end
						task.spawn(function()
							if ActionSign.Value%1==0 then
								ActionSign.Changed:Wait()
							end
							local Event=Trigger:FindFirstChild("Event")
							for s=3,1,-1 do--tries a few times, otherwise exits
								if Event~=nil and Event==TSM.ActionEvent.Value then
									VU:SetKeyDown("e") wait()  
									VU:SetKeyUp("e")
								end
								task.wait()
							end
						end)
						isActionProgress=false
						return true
					end
				end 
				return false
			end,
			["CrawlVent"]=function(shouldWait)
				local Torso=char:WaitForChild("Torso")
				for TimesLeft=30,1,-1 do
					for num,part in pairs(Torso:GetTouchingParts()) do
						if part.Name=="VentPartWalkThru" then
							AvailableHacks.Blatant[2].Crawl(true)
							task.wait(.4)
							local startCrawlTime=os.clock()
							while --((part.Position-Torso.Position)/Vector3.new(0,math.huge,0)).magnitude<.5
								table.find(Torso:GetTouchingParts(),part)~=nil
								and os.clock()-startCrawlTime < 2 do
								task.wait()
							end
							AvailableHacks.Blatant[2].Crawl(false)
							return true
						end
					end
					if not shouldWait then return false end
					task.wait()
				end
				return false
			end,
			["noComputeStuck"]=function()
				human:MoveTo(char.Torso.CFrame*(5*Random.new():NextUnitVector()))
				wait(1/3)
			end,
			["ActivateFunction"]=function(newValue)
				human:SetAttribute("OverrideSpeed",nil)
				local currentPath=AvailableHacks.Bot[15].CurrentPath
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				if currentPath==nil then error("no path found!") return end
				if not newValue then
					human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
					currentPath:Stop()
					AvailableHacks.Bot[15].ChangedEvent:Fire(false,false) 
					return 
				end
				AvailableHacks.Bot[15].CurrentNum+=1
				local savedValue=AvailableHacks.Bot[15].CurrentNum
				local function canRun(fullLoop)
					--print(({isInLobby(char)})[2])
					return enHacks.BotRunner and char~=nil and human~=nil and human.Health>0
						and camera.CameraSubject==human
						and savedValue==AvailableHacks.Bot[15].CurrentNum and not TSM.Escaped.Value
						and (fullLoop or ({isInLobby(char)})[2]=="Runner") 
						and not isCleared
				end
				AvailableHacks.Bot[15].CanRun=canRun
				local function getGoodTriggers(pc)
					local screen=pc:FindFirstChild("Screen")
					if screen.Color.G*255<128 and screen.Color.G*255>126 then--check if its green, meaning no hack hecked pcs!
						return {}
					end
					local list={}
					for num,triggerName in pairs({"ComputerTrigger1","ComputerTrigger2","ComputerTrigger3"}) do
						local trigger=pc:FindFirstChild(triggerName)

						if trigger~=nil and trigger.Parent~=nil and Map~=nil and
							workspace:IsAncestorOf(trigger) and screen~=nil 
							and trigger:FindFirstChild("ActionSign")~=nil
							and trigger.ActionSign.Value==20
							and not trigger:GetAttribute("Unreachable"..saveIndex) then
							--print(screen.BrickColor.Name,pc:GetFullName())
							--createTestPart(screen.Position,10)
							table.insert(list,trigger)
						end
					end
					return list
				end

				local function getComputerTriggers()
					local triggers={}
					for num,pc in pairs(CS:GetTagged("Computer")) do
						for num,goodTrigger in pairs(getGoodTriggers(pc)) do
							table.insert(triggers,goodTrigger)
						end
					end 
					if #triggers==0 and RS.IsGameActive.Value then AvailableHacks.Bot[15].noComputeStuck() end
					return triggers
				end
				local function getExitDoors()
					local exitAreas={}
					for num,exit in pairs(CS:GetTagged("Exit")) do
						local exitArea=exit:FindFirstChild("ExitArea")
						if exitArea~=nil and not exitArea:GetAttribute("Unreachable"..saveIndex) then
							table.insert(exitAreas,exitArea)
						end
					end 
					if #exitAreas==0 and RS.IsGameActive.Value then AvailableHacks.Bot[15].noComputeStuck() end
					return exitAreas
				end
				AvailableHacks.Blatant[2].Crawl(UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.ButtonL2))
				while canRun(true) do
					human:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
					while #CS:GetTagged("Computer")==0 do
						human:Move(Vector3.new())
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
					if RS.ComputersLeft.Value>0
						or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15")--string.sub(RS.GameStatus.Value,1,2)=="15")
					then--hack time :D
						local closestTrigger,dist=findClosestObj(getComputerTriggers(),char.PrimaryPart.Position,3000,6)
						while canRun() and closestTrigger~=nil and (RS.ComputersLeft.Value>0
							or (#CS:GetTagged("Computer")>0 and string.sub(RS.GameStatus.Value,1,2)=="15")) do --print("found trigger")
							local ActionSign=closestTrigger:FindFirstChild("ActionSign")
							local didReach=TSM.CurrentAnimation.Value=="Typing" or 
								AvailableHacks.Bot[15].WalkPath(currentPath,
									closestTrigger, function()
										return ActionSign~=nil and ActionSign.Value==20 and canRun()
									end)
							local distance=(closestTrigger.Position-char.Torso.Position).magnitude
							human:SetAttribute("OverrideSpeed",distance<13 and 35 or nil)
							if didReach
								or (closestTrigger.Position-char.Torso.Position).magnitude<2
								or (TSM.ActionEvent.Value~=nil 
									and closestTrigger:IsAncestorOf(TSM.ActionEvent.Value))
								and ActionSign~=nil and ActionSign.Value==20 then--and table.find(closestTrigger:GetTouchingParts(),char.PrimaryPart) ~=nil then
								--print(TSM.ActionEvent.Value,TSM.CurrentAnimation.Value)
								--effective way of making the server wait!
								task.wait(.45)
								if TSM.CurrentAnimation.Value~="Typing" and 
									(TSM.ActionEvent.Value==nil or 
										plr.PlayerGui:WaitForChild("ScreenGui")
										:WaitForChild("ActionBox").Text~="Hack")
										and closestTrigger.ActionSign.Value==20 then
									--AvailableHacks.Basic[12].TeleportFunction(CFrame.new(closestTrigger.Position-Vector3.new(0,human.HipHeight+char.Torso.Size.Y/2,0),closestTrigger.Parent.PrimaryPart.Position))
									human:MoveTo(closestTrigger.Position)--:lerp(closestTrigger.Parent.Screen.Position,0))
									human:ChangeState(Enum.HumanoidStateType.Jumping)
									task.wait(.6)
								end
								local screen=closestTrigger.Parent:FindFirstChild("Screen")
								while canRun() and TSM.ActionEvent.Value~=nil and closestTrigger.ActionSign.Value==20
									and TSM.CurrentAnimation.Value~="Typing" and not (screen.Color.G*255<128 and screen.Color.G*255>126) do
									local distTraveled=(lastHackedPosition-closestTrigger.Position).Magnitude
									local timeElapsed=os.clock()-computerHackStartTime
									local minHackTimeBetweenPCs=0.15+
										math.max(distTraveled/minSpeedBetweenPCs,absMinTimeBetweenPCs)
									if lastHackedPC~=closestTrigger.Parent
										and timeElapsed<minHackTimeBetweenPCs then
										timeElapsed+=task.wait(minHackTimeBetweenPCs-timeElapsed) 
									else
										print("Attempting to hack",closestTrigger.Parent.Name .."/"..closestTrigger.Parent.Parent.Name,
											"\nTime Elapsed:",
											math.round(timeElapsed*100)/100,"s".."\nDistance Traveled:",math.round(distTraveled*100)/100 ..
												"\nAvg Velocity:",math.round((distTraveled/timeElapsed)*100)/100)
										VU:SetKeyDown("e") --print("force 'e'")
										RunS.RenderStepped:Wait()
										VU:SetKeyUp("e")
										task.wait(1/3)
									end
								end --print("hacking ", closestTrigger.Parent:GetFullName())
								--if TSM.CurrentAnimation.Value=="Typing" then
								while canRun() and
									TSM.CurrentAnimation.Value=="Typing" do
									task.wait(1/3) computerHackStartTime=os.clock() 
									lastHackedPC,lastHackedPosition=closestTrigger.Parent,closestTrigger.Position
								end
							end
							if char.PrimaryPart~=nil then
								closestTrigger,dist=findClosestObj(getGoodTriggers(closestTrigger.Parent),char.PrimaryPart.Position,3000,1)
							end
							task.wait()
						end
						--print(AvailableHacks.Bot[15].WalkPath(currentPath,
						--	char.PrimaryPart.CFrame*Vector3.new(0,0,-15)))
					else--escape time :D
						local closestExitArea,dist=findClosestObj(getExitDoors(),char.PrimaryPart.Position,3000,1)
						while canRun() and closestExitArea~=nil and not closestExitArea:GetAttribute("Unreachable"..saveIndex) 
							and not TSM.Escaped.Value do
							local didReach=AvailableHacks.Bot[15].WalkPath(currentPath,
								closestExitArea,canRun)
							while table.find(workspace:GetPartsInPart(char.HumanoidRootPart),closestExitArea)
								--didReach and ((closestExitArea.Position-char.Torso.Position)/Vector3.new(1,100,1)).magnitude<2
								and not TSM.Escaped.Value do--jump to escape!!
								if human.FloorMaterial~=Enum.Material.Air then
									human:ChangeState(Enum.HumanoidStateType.Jumping)
								end
								task.wait(1/6)
							end
							wait()
						end
					end
					wait()
				end
				human:SetAttribute("OverrideSpeed",nil)
				human:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
			end,
			["MyStartUp"]=function(myPlr,myChar)
				isActionProgress=false
				local Torso=char:WaitForChild("Torso")
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local Errors=0
				local newPath = Path.new(myChar,{
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
					}
				})
				newPath.Visualize = true
				table.insert(functs,newPath.Reached:Connect(function(agent,lastWayPoint)
					--print("reached!")
					if lastWayPoint.Position~=nil then
						human:MoveTo(lastWayPoint.Position)
					end
					Errors=0--math.max(0,Errors-.2)
					AvailableHacks.Bot[15].ChangedEvent:Fire(true,true)
				end))
				table.insert(functs,newPath.Blocked:Connect(function(myChar,wayPoint)
					if RS.IsGameActive.Value then
						AvailableHacks.Bot[15].noComputeStuck()
					end
				end))
				local function waypointReached(agent,lastWayPoint,nextWayPoint)
					Errors=math.max(0,Errors-.2)
					if isActionProgress then return false end
					local from,to=Torso.Position,nextWayPoint.Position+Vector3.new(0,getHumanoidHeight(char),0) --Vector3.new(0,Torso.Size.Y/2+char["Right Leg"].Size.Y/2,0)
					local didHit,instance=raycast(from,
						to,{"Whitelist",table.unpack(CS:GetTagged("Door"))},5,0.001,true)
					local didHit2,instance2=raycast(from,
						to,{"Whitelist",Map},5,0.001,true)
					--print(nextWayPoint.Label,instance2)
					--print(to.Y-1.5,(char.PrimaryPart.Position.Y-getHumanoidHeight(char)))
					if nextWayPoint.Label=="DoorPath" or (didHit and (--(instance.Name=="WalkThru" 
						--or instance.Name=="DoorTrigger" or instance.Name=="ExitDoorTrigger"

						CS:HasTag(instance.Parent,"Door") or CS:HasTag(instance.Parent.Parent,"Door")
							or CS:HasTag(instance.Parent.Parent.Parent,"Door"))) then
						--print("doorpath!")
						--createTestPart(didHit.Position,3)
						return AvailableHacks.Bot[15].UnlockDoor(true)
					elseif nextWayPoint.Label=="Vent" or (didHit2 and instance2.Name~="VentPartWalkThru") then
						--print("imposter sos!")
						return AvailableHacks.Bot[15].CrawlVent(true)
					elseif (to.Y>char.PrimaryPart.Position.Y and human.FloorMaterial~=Enum.Material.Air--(to.Y-1.5)-(char.PrimaryPart.Position.Y-getHumanoidHeight(char))>2
						and not AvailableHacks.Blatant[2].IsCrawling and not isActionProgress) 
						or nextWayPoint.Label=="Window" or (instance2~=nil and instance2.Name=="WindowWalkThru") then --if nextWayPoint.Action==Enum.PathWaypointAction.Jump then
						--print("yeah jump!")
						human:ChangeState(Enum.HumanoidStateType.Jumping)
						return true
					end
					return false
					--newPath:Run(AvailableHacks.Bot[15].CurrentTarget)
				end
				newPath.WaypointReached:Connect(waypointReached)
				table.insert(functs,TSM.ActionEvent.Changed:Connect(function(event)
					local path=AvailableHacks.Bot[15].CurrentPath
					if not isActionProgress and path~=nil and path._status==Path.StatusType.Active
						and event~=nil and string.find(event.Parent.Name,"DoorTrigger")~=nil
						and AvailableHacks.Bot[15].CurrentTarget~=nil then
						task.wait(3/5)--3/5s compromise APUSH letsgo
						waypointReached(char,
							path._waypoints[1<path._currentWaypoint-1 
								and path._currentWaypoint-1 or 1],
							path._waypoints[#path._waypoints>=path._currentWaypoint 
								and path._currentWaypoint or 1])
					end
				end))
				newPath.Error:Connect(function(errorType)
					if errorType == Path.ErrorType.ComputationError then
						--newPath:Run(AvailableHacks.Bot[15].CurrentTarget
						AvailableHacks.Bot[15].ChangedEvent:Fire(false,true)
						local failedTarget=AvailableHacks.Bot[15].CurrentTarget
						local current=failedTarget:GetAttribute("Unreachable"..saveIndex)
						failedTarget:SetAttribute("Unreachable"..saveIndex,current~=nil and current+1 or 1)
						--print("set ",failedTarget:GetFullName(), "unreachable!")
						delay(4,function()
							if not workspace:IsAncestorOf(failedTarget) then return end
							current=failedTarget:GetAttribute("Unreachable"..saveIndex)
							if current~=nil then
								failedTarget:SetAttribute("Unreachable"..saveIndex,current>1 and current-1 or nil)
							end
							--print("down ",failedTarget:GetFullName(), "to",tostring(current>1 and current-1 or nil))
						end)
					elseif errorType == Path.ErrorType.AgentStuck then
						--and #newPath._waypoints>=newPath._currentWaypoint+1 then
						--[[local wayPoint=newPath._waypoints[newPath._currentWaypoint+1]
						local newPart=Instance.new("Part")
						newPart.Size=Vector3.new(2,2,2)
						newPart.Transparency=.6
						newPart.Anchored=true
						newPart.CanCollide=false
						newPart.Position=wayPoint.Position
						newPart.Parent=workspace
						createModifer(newPart,"NoWalkThru",false)--]]
						Errors+=1
						if Errors==3 then
							print("LEFT / err bruh",Errors)
							human:MoveTo(char.PrimaryPart.CFrame*Vector3.new(-4,0,0))
						elseif Errors>=10 then
							print("RESET / err bruh",Errors)
							AvailableHacks.Basic[24].ActivateFunction()
						else
							print("err bruh",Errors)
						end
					end
				end)
				table.insert(functs,Torso.Touched:Connect(function(hit)
					if hit.Name=="WindowWalkThru" and Path~=nil 
						and AvailableHacks.Bot[15].CurrentTarget~=nil
						and human~=nil and human.Health>0 
						and human.FloorMaterial~=Enum.Material.Air then
						human:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end))
				AvailableHacks.Bot[15].CurrentPath=newPath
				AvailableHacks.Bot[15].ActivateFunction(enHacks.BotRunner)
			end,
			["MyPlayerAdded"]=function()
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				table.insert(functs,TSM.Escaped.Changed:Connect(function()
					if not TSM.Escaped.Value and enHacks.BotRunner then
						AvailableHacks.Bot[15].ActivateFunction(true)
					end
				end))
				table.insert(functs,TSM.Health.Changed:Connect(function()
					if TSM.Health.Value>0 
						and not TSM.Escaped.Value and enHacks.BotRunner then
						AvailableHacks.Bot[15].ActivateFunction(true)
					end
				end))
			end,
			["DoorAdded"]=function(door)
				local doorTrigger=door.Name~="ExitDoor" and door:WaitForChild("DoorTrigger")
					or door:WaitForChild("ExitDoorTrigger",1e5) if not doorTrigger then return end
				local ActionSign=door.Name=="ExitDoor" and doorTrigger:FindFirstChild("ActionSign")
					or doorTrigger:WaitForChild("ActionSign",1e5) if not ActionSign then return end
				local exitArea=door.Name=="ExitDoor" and door:WaitForChild("ExitArea")
				local walkThruPart=doorTrigger:Clone() 
				walkThruPart:ClearAllChildren()
				removeAllTags(walkThruPart)
				walkThruPart.Name="WalkThru"
				walkThruPart.Parent=door
				walkThruPart.Transparency=hitBoxesEnabled and .6 or 1
				walkThruPart.Size=door.Name=="ExitDoor" and Vector3.new(6,7,8.6)
					or Vector3.new(3,7,2.25)--walkThruPart.Size+=Vector3.new(-.5,4,0)
				CS:AddTag(walkThruPart,"WalkThruDoor")
				local currentPoso=walkThruPart.Position
				if door.Name=="ExitDoor" then
					local setPoso=doorTrigger.Position:lerp(exitArea.Position,.4)
					walkThruPart.Position=Vector3.new(setPoso.X,doorTrigger.Position.Y,setPoso.Z)
					walkThruPart.Size=Vector3.new(6,7,(doorTrigger.Position-exitArea.Position).magnitude/2+5.5)
					exitArea:SetAttribute("Unreachable"..saveIndex,nil)
				end

				--if Map.Name=="Homestead by MrWindy" and door.Name=="ExitDoor" then
				--print("set homestead exit!")
				--walkThruPart.Position=walkThruPart.Position:lerp(Vector3.new(door.ExitArea.Position.X,currentPoso.Y,currentPoso.Z),1/5)
				--end

				--print(doorTrigger.Orientation.Y,math.fmod(math.abs(doorTrigger.Orientation.Y),180))
				if  math.fmod(math.abs(doorTrigger.Orientation.Y),180)==0 then
					walkThruPart.CFrame=CFrame.new(
						walkThruPart.Position+Vector3.new(0,2,0))*CFrame.Angles(0,math.rad(90),0) --]]
				else
					walkThruPart.CFrame=CFrame.new(
						walkThruPart.Position+Vector3.new(0,2,0))
				end
				if door.Name=="ExitDoor" then
					if Map.Name=="Abandoned Prison by AtomixKing and Duck_Ify" then
						walkThruPart.CFrame*=CFrame.Angles(0,math.rad(90),0)
					elseif Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda" then
						walkThruPart.Size=Vector3.new(3,5,walkThruPart.Size.Z)
					elseif Map.Name=="Airport by deadlybones28" then
						walkThruPart.Size=Vector3.new(3,7,walkThruPart.Size.Z)
					end
				else
					if Map.Name=="Abandoned Prison by AtomixKing and Duck_Ify" then
						walkThruPart.CFrame*=CFrame.Angles(0,math.rad(90),0)
					elseif Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda" then
						walkThruPart.Size=Vector3.new(3,5,1.5)
					end
				end
				--walkThruPart.Size=Vector3.new(4,7,6)


				CS:AddTag(walkThruPart,"RemoveOnDestroy")
				createModifer(walkThruPart,(ActionSign~=nil and (ActionSign.Value==10 or ActionSign.Value==12)) and "DoorPath" or "DoorOpened",true)
			end,
			["OthersBeastAdded"]=function(theirPlr,theirChar)
				local theirTorso=theirChar:WaitForChild("Torso",3)
				if theirTorso==nil or not workspace:IsAncestorOf(theirTorso) then return end
				for num,part in pairs(AvailableHacks.Bot[15].AvoidParts) do
					part:Destroy()
				end AvailableHacks.Bot[15].AvoidParts={}
				local avoidPart=Instance.new("Part",theirChar)
				avoidPart.Shape=Enum.PartType.Ball
				avoidPart.Anchored=true
				avoidPart.Size=Vector3.new(20,20,20)
				avoidPart.Position=theirTorso.Position
				avoidPart.Transparency=hitBoxesEnabled and .7 or 1
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
				for num,part in pairs(AvailableHacks.Bot[15].AvoidParts) do
					part:Destroy()
				end AvailableHacks.Bot[15].AvoidParts={}
			end,
			["MapAdded"]=function()
				task.wait(4/3)
				local function createBoxPart(DataTbl,DefaultSize,PartName,LabelName,PartColor,Collide)
					for num,ventData in pairs(DataTbl or {}) do
						local newPart=Instance.new("Part")
						newPart.Transparency=hitBoxesEnabled and .6 or 1
						newPart.Color=PartColor or newPart.Color
						newPart.CanCollide=false
						newPart.Anchored=true
						newPart.Size=DefaultSize or newPart.Size
						newPart.Parent=Map
						newPart.Name=PartName
						CS:AddTag(newPart,"RemoveOnDestroy")
						CS:AddTag(newPart,PartName)
						for property,setTo in pairs(ventData) do
							--print(property,setTo)
							newPart[property]=setTo
						end

						createModifer(newPart,LabelName,Collide)
					end
				end
				local function createSolidPart(cframe,size,shape,partName,place)
					local newPart=Instance.new(shape=="WedgePart" and shape or "Part")
					newPart.Transparency=hitBoxesEnabled and .6 or 1
					newPart.Anchored=true
					newPart.Color=Color3.fromRGB(255,255)
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
					createBoxPart(Data.Vents,Data.DefaultVentSize,"VentPartWalkThru","Vent",Color3.fromRGB(165, 0, 2),true)
					createBoxPart(Data.Windows,Data.DefaultWindowSize,"WindowWalkThru","Window",Color3.fromRGB(0,255,255),true)
					createBoxPart(Data.NoWalkThru,nil,"NoWalkThruPart","NoWalkThru",Color3.fromRGB(255, 0, 191),true)
					for num,data in pairs(Data.CollideSpots or {}) do
						local orientation=data.Orientation or Vector3.new()
						createSolidPart(CFrame.new(data.Position)*CFrame.Angles(math.rad(orientation.X),math.rad(orientation.Y),math.rad(orientation.Z)),
							data.Size,data.Shape,"SolidCollidable",Map)
					end
				else
					warn(Map.Name,"not found!")
				end
				if Map.Name=="Airport by deadlybones28" then
					for num,box in pairs(Map:WaitForChild("Boxes"):GetChildren()) do
						local cframe,size=box:GetBoundingBox()
						createSolidPart(cframe,size,nil,"SolidCollidable",box)
					end
				elseif Map.Name=="Forgotten Facility by Kmart_Corp"
					or Map.Name=="Abandoned Facility Remake by Daniel_H407"
					or Map.Name=="Facility_0 by MrWindy" then
					for num,windowModel in pairs(Map:GetChildren()) do
						if windowModel.Name=="Window" then
							local Barrier=windowModel:FindFirstChild("Barrier")
							if Barrier~=nil then Barrier.Parent=Map end--don't delete it or get noclip kick or stuck!
							local cframe,size=windowModel:GetBoundingBox()
							createBoxPart({{["CFrame"]=cframe-Vector3.new(0,1.75,0)}},
							Vector3.new(3, 9.5, 2.5),"WindowWalkThru","Window",Color3.fromRGB(0,255,255),true)
						end

					end
					for num,box in pairs(Map:GetChildren()) do
						if box:IsA("Model") and string.find(box.Name,"Crate")~=nil then
							local cframe,size=box:GetBoundingBox()
							createSolidPart(cframe,size,nil,"SolidCollidable",box)
						end
					end
				elseif Map.Name=="The Library by Drainhp" then
					for num,windowModel in pairs(Map:WaitForChild("Misc"):WaitForChild("Windows"):GetChildren()) do
						local cframe,size=windowModel:GetBoundingBox()
						createBoxPart({{["CFrame"]=cframe-Vector3.new(0,0,0)}},
						Vector3.new(1.9, 18, 2.5),"WindowWalkThru","Window",Color3.fromRGB(0,255,255),true)
					end
				end
			end,
		},
		[20]={
			["Type"]="ExTextButton",
			["Title"]="Bot Transportation",
			["Desc"]="Means of transportation",
			["Shortcut"]="BotTransport",
			["Options"]={
				["Walk"]={
					["Title"]="WALK",
					["TextColor"]=Color3.fromRGB(0,255)
				},
				["Teleport"]={
					["Title"]="TELEPORT",
					["TextColor"]=Color3.fromRGB(255,255)
				}
			},
			["Default"]="Walk",
			["TeleportDelay"]=0, ["LastTeleport"]=0,
			["Funct"]=nil,
			["WalkFunct"]=function(currentPath,nextPoso,expireTime)
				human:MoveTo(nextPoso)
			end,
			["ActivateFunction"]=function(newValue)
				local teleportOffset=Vector3.new(0,2,0)
				if newValue=="Walk" then
					AvailableHacks.Bot[20].Funct=AvailableHacks.Bot[20].WalkFunct
				elseif newValue=="Teleport" then
					AvailableHacks.Bot[20].Funct=function(currentPath,nextPoso)
						task.spawn(function()
							if os.clock()<AvailableHacks.Bot[20].TeleportDelay then
								return AvailableHacks.Bot[20].WalkFunct(nextPoso)
							end
							local hrp=char:WaitForChild("HumanoidRootPart")
							local startPoso=char:GetPivot().Position+teleportOffset
							local result,hitPart=raycast(startPoso,nextPoso,{Map},nil,nil,true)
							local dist=result and result.Distance or ((nextPoso-startPoso)/Vector3.new(1,5,1)).Magnitude
							if dist>.3 then
								local endPoint=result and CFrame.new(startPoso,result.Position)*Vector3.new(0,0,-(dist-1.5)) or nextPoso
								local x,y,z=char:GetPivot():ToOrientation()
								hrp:PivotTo(CFrame.new(endPoint+teleportOffset)*
									CFrame.Angles(x,y,z))
								--char.Torso.Anchored=true
								--wait()--print("Response;",RS.DefaultChatSystemChatEvents.MutePlayerRequest:InvokeServer())--we wait for a response--task.wait(1/4)
								--char.Torso.Anchored=false
								if (startPoso-hrp:GetPivot().Position).Magnitude+2<(endPoint-hrp:GetPivot().Position).Magnitude then
									AvailableHacks.Bot[20].TeleportDelay=os.clock()+3
									print("Detected Cheating!")
									return
								end
								AvailableHacks.Bot[20].TeleportDelay=0
								if not AvailableHacks.Bot[15].IsRunning or not currentPath then return end
								dist=((char:GetPivot().Position-nextPoso)/Vector3.new(1,5,1)).Magnitude

								if dist<4 and AvailableHacks.Bot[15].IsRunning then
									return moveToFinished(currentPath,true)
								else
									return --AvailableHacks.Bot[20].WalkFunct(nextPoso)
								end
							else
								return AvailableHacks.Bot[20].WalkFunct(nextPoso)
							end
						end)
					end
				end
			end,
		},
		[23]={
			["Type"]="ExTextButton",
			["Title"]="Auto Vote For Known Maps",
			["Desc"]="",
			["Shortcut"]="AutoVote/Known",
			["Default"]=botModeEnabled,
			["CurrentNum"]=0,
			["DontStartUp"]=true,
			["CurrentPath"]=nil,
			["IsRunning"]=false,
			["CleanUp"]=function()
				AvailableHacks.Bot[23].CurrentNum+=1
				AvailableHacks.Bot[23].IsRunning=false
			end,
			["ActivateFunction"]=function()
				AvailableHacks.Bot[23].CurrentNum+=1
				local SaveNum=AvailableHacks.Bot[23].CurrentNum
				local newPath=AvailableHacks.Bot[23].CurrentPath
				if newPath==nil or SaveNum~=AvailableHacks.Bot[23].CurrentNum then return end
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
							table.insert(votableMaps,{["Name"]=SurfaceGui.TitleLabel.Text,
								["Board"]=board,["Pad"]=pad})
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
				local mapTarget=#mapsToVoteFor>=1 
					and mapsToVoteFor[Random.new():NextInteger(1,#mapsToVoteFor)] or nil
				local function canRun()
					return char~=nil and workspace:IsAncestorOf(char) 
						and human~=nil and human.Health>0 and enHacks["AutoVote/Known"]
						and mapTarget and mapTarget.Board.SurfaceGui.Enabled
						and not ({isInLobby(char)})[1] 
						and SaveNum==AvailableHacks.Bot[23].CurrentNum
						and not isCleared
				end

				while canRun() do
					local didReach=
						AvailableHacks.Bot[15].WalkPath(newPath,mapTarget.Pad,canRun)
					task.wait()
				end
				if SaveNum==AvailableHacks.Bot[23].CurrentNum then
					AvailableHacks.Bot[23].IsRunning=false
				end
			end,
			["MyStartUp"]=function()
				task.wait()
				local Torso=char:WaitForChild("Torso")
				local TSM=plr:WaitForChild("TempPlayerStatsModule")
				local newPath = Path.new(char,{
					AgentCanJump=true,
					Costs = {
						NoWalkThru = math.huge
					}
				})
				newPath.Visualize=true
				AvailableHacks.Bot[23].CurrentPath=newPath
				AvailableHacks.Bot[23].ActivateFunction(enHacks["AutoVote/Known"])
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
				setChangedAttribute(RS.GameStatus,
					"Value",function()
						if not AvailableHacks.Bot[23].IsRunning 
							and not ({isInLobby(char)})[1] then
							AvailableHacks.Bot[23].ActivateFunction() 
						else
							--print(AvailableHacks.Bot[23].IsRunning)
						end
					end)
			end,
		},
		[30]={
			["Type"]="ExTextButton",
			["Title"]="Reset After "..botBeastBreakMin.."m or exit open (BEAST ONLY)",
			["Desc"]="",
			["Shortcut"]="Bot/AutoReset",
			["Default"]=botModeEnabled,
			["CurrentNum"]=0,
			["ShouldBreak"]=function()
				if RS.GameTimer.Value<=60 * botBeastBreakMin then return true end
				if RS:WaitForChild("GameStatus").Value=="FIND AN EXIT" then
					local canBreak = true
					for num,theirPlr in pairs(PS:GetPlayers()) do
						local theirTSM=theirPlr:FindFirstChild("TempPlayerStatsModule")
						if theirTSM then
							if theirTSM.CurrentAnimation.Value=="Typing" then canBreak=false break end
						end
					end
					if canBreak then return true end
				end
				return false
			end,
			["ActivateFunction"]=function(en)
				AvailableHacks.Bot[30].CurrentNum+=1
				local saveNum=AvailableHacks.Bot[30].CurrentNum
				task.delay(3/2,function()
					while enHacks["Bot/AutoReset"] and Map and Beast==char and human and human.Health>0
						and saveNum==AvailableHacks.Bot[30].CurrentNum and not isCleared do
						if AvailableHacks.Bot[30].ShouldBreak() then
							AvailableHacks.Basic[24].ActivateFunction(true)
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
	}

}

--Multi Script Check:
local getID="HackGUI1"
local plr=game:GetService("Players").LocalPlayer
local RStorage=game:GetService("ReplicatedStorage")
saveIndex=(plr:GetAttribute(getID) or 0)+1
--if plr:GetAttribute("Cleared"..getID) then plr:SetAttribute("Cleared"..getID,false) end
local previousCopy=plr:GetAttribute(getID)~=nil
plr:SetAttribute(getID,saveIndex) wait()
table.insert(functs,plr:GetAttributeChangedSignal(getID):Connect(function()
	if clear==nil then isCleared=true script:Destroy() return end
	if plr:GetAttribute(getID)~=saveIndex then
		clear()
	end
end))
if script==nil then return end
--DELETION--
clear=function()
	isCleared=true
	if HackGUI then HackGUI.Enabled=false end
	if DraggableMain then DraggableMain:Disable() end
	--plr:SetAttribute(getID,nil)
	if AvailableHacks.Bot[15].CurrentPath~=nil then
		AvailableHacks.Bot[15].CurrentPath:Stop()
	end
	for obj,objectEventsList in pairs(objectFuncts or {}) do
		for value,funct in pairs(objectEventsList or {}) do
			if funct~=nil then
				funct:Disconnect() funct=nil
			end
		end
	end
	for num,obj in pairs(CS:GetTagged("RemoveOnDestroy")) do
		if obj~=nil then
			obj:Destroy()
		end
	end
	for num, tag in pairs(CS:GetTagged("HackDisplays")) do
		if tag~=nil then
			tag:Destroy()
		end
	end
	for userID,functList in pairs(playerEvents) do
		for num,funct in pairs(functList or {}) do
			funct:Disconnect() funct=nil
		end
	end
	--[[for hackName,enabled in pairs(enHacks) do
		enHacks[hackName]=nil--disables all running hacks to stop them!
	end--]]
	enHacks={}--effectively disables all hacks!
	for num,tagName in pairs({"WalkThruDoor","Computer","Trigger","Capsule","Door"}) do
		for num,tagPart in pairs(CS:GetTagged(tagName)) do
			CS:RemoveTag(tagPart,tagName)
		end
	end
	for num,funct in pairs(functs) do
		funct:Disconnect() funct=nil
	end hackChanged:Fire() hackChanged:Destroy()
	CAS:UnbindAction("Crawl2")
	CAS:UnbindAction("CloseMenu")
	plr:SetAttribute("Cleared"..getID,true)
	DS:AddItem(HackGUI,1)
	DS:AddItem(script,1)
end

--Anti Main Check:
local function iterPageItems(pages)return coroutine.wrap(function()local pagenum = 1 while true do for _, item in ipairs(pages:GetCurrentPage()) do coroutine.yield(item, pagenum)end if pages.IsFinished then break end pages:AdvanceToNextPageAsync()pagenum = pagenum + 1 end end)
end
if previousCopy then
	local changedEvent=Instance.new("BindableEvent")
	local startTime=os.clock()
	local maxWaitTime=5
	task.delay(maxWaitTime,function()
		if not changedEvent then return end
		changedEvent:Fire()
	end)
	local clearedConnection=plr:GetAttributeChangedSignal("Cleared"..getID):Connect(function()
		changedEvent:Fire()
	end)
	while not plr:GetAttribute("Cleared"..getID) do
		changedEvent.Event:Wait()
		if isCleared then script:Destroy() return end
		if os.clock()-startTime>=maxWaitTime then
			warn("Maximum Wait Time Reached ("..maxWaitTime.."s), Starting Script...")
			break
		end
	end
	changedEvent:Destroy() clearedConnection:Disconnect() clearedConnection=nil
end
if isCleared then script:Destroy() return end

local numOfFriends=0
local success, err=pcall(function()
	for item, pageNo in iterPageItems(PS:GetFriendsAsync(plr.UserId)) do
		numOfFriends+=1
	end
end)
if not success then wait("Error getting friends!",err) end
if success and numOfFriends>=10 and not isStudio then plr:Kick("Anti Main Hack: Main Account Detected!") end
--while #CS:GetTagged("RemoveOnDestroy")>0 do
--	CS.TagRemoved:Wait()
--end wait(1)

-- GUI CREATION / Instances:
local ExTextButton = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Desc = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local ExTextBox = Instance.new("Frame")
local Title_2 = Instance.new("TextLabel")
local Desc_2 = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local MainListEx = Instance.new("TextButton")
HackGUI = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local List = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Properties = Instance.new("Frame")
local PropertiesEx = Instance.new("ScrollingFrame")
local UIListLayout_2 = Instance.new("UIListLayout")
NameTagEx = Instance.new("BillboardGui")
local Username = Instance.new("TextLabel")
local Distance = Instance.new("TextLabel")
local ExpandingBar = Instance.new("Frame")
local AmtFinished = Instance.new("Frame")
ToggleTag = Instance.new("BillboardGui")
local ToggleButton = Instance.new("TextButton")
TestPart = Instance.new("Part",script)
local XPGained = Instance.new("TextLabel")
local CreditsGained = Instance.new("TextLabel")
local ServerXPGained = Instance.new("TextLabel")
local ServerCreditsGained = Instance.new("TextLabel")

--GUI CREATION / Instances Properties:

HackGUI.DisplayOrder = 1e7

ExTextButton.Name = "ExTextButton"
ExTextButton.Parent = script
ExTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExTextButton.BackgroundTransparency = 1.000
ExTextButton.Size = UDim2.new(1, -6, 0, 40)

Title.Name = "Title"
Title.Parent = ExTextButton
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(0.556971073, 0, 0.680000007, 0)
Title.ZIndex = 3
Title.Font = Enum.Font.Fondamento
--Title.Text = "ESP Players"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextStrokeTransparency = 0.000
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left

Desc.Name = "Desc"
Desc.Parent = ExTextButton
Desc.AnchorPoint = Vector2.new(0, 1)
Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Desc.BackgroundTransparency = 1.000
Desc.Position = UDim2.new(0, 0, 1, 0)
Desc.Size = UDim2.new(0.556999981, 0, 0.47, 0)
Desc.ZIndex = 3
Desc.Font = Enum.Font.Fondamento
--Desc.Text = " See players through walls"
Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
Desc.TextScaled = true
Desc.TextSize = 14.000
Desc.TextStrokeTransparency = 0.000
Desc.TextWrapped = true
Desc.TextXAlignment = Enum.TextXAlignment.Left

Toggle.Name = "Toggle"
Toggle.Parent = ExTextButton
Toggle.AnchorPoint = Vector2.new(1, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle.BackgroundTransparency = 1.000
Toggle.Position = UDim2.new(1.00000012, 0, 0, 0)
Toggle.Size = UDim2.new(0.443029076, 0, 1, 0)
Toggle.Font = Enum.Font.SourceSans
--Toggle.Text = "ENABLED"
Toggle.TextColor3 = Color3.fromRGB(0, 255, 0)
Toggle.TextScaled = true
Toggle.TextSize = 14.000
Toggle.TextStrokeTransparency = 0.000
Toggle.TextWrapped = true

ExTextBox.Name = "ExTextBox"
ExTextBox.Parent = script
ExTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExTextBox.BackgroundTransparency = 1.000
ExTextBox.Size = UDim2.new(1, 0, 0, 40)

Title_2.Name = "Title"
Title_2.Parent = ExTextBox
Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_2.BackgroundTransparency = 1.000
Title_2.Size = UDim2.new(0.556971073, 0, 0.680000007, 0)
Title_2.ZIndex = 3
Title_2.Font = Enum.Font.Fondamento
--Title_2.Text = "Walkspeed"
Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_2.TextScaled = true
Title_2.TextSize = 14.000
Title_2.TextStrokeTransparency = 0.000
Title_2.TextWrapped = true
Title_2.TextXAlignment = Enum.TextXAlignment.Left

Desc_2.Name = "Desc"
Desc_2.Parent = ExTextBox
Desc_2.AnchorPoint = Vector2.new(0, 1)
Desc_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Desc_2.BackgroundTransparency = 1.000
Desc_2.Position = UDim2.new(0, 0, 1, 0)
Desc_2.Size = UDim2.new(0.556999981, 0, 0.47, 0)
Desc_2.ZIndex = 3
Desc_2.Font = Enum.Font.Fondamento
Desc_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Desc_2.TextScaled = true
Desc_2.TextSize = 14.000
Desc_2.TextStrokeTransparency = 0.000
Desc_2.TextWrapped = true
Desc_2.TextXAlignment = Enum.TextXAlignment.Left

TextBox.Parent = ExTextBox
TextBox.AnchorPoint = Vector2.new(1, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.Position = UDim2.new(1, 0, 0, 0)
TextBox.Size = UDim2.new(0.442999989, 0, 1, 0)
TextBox.Font = Enum.Font.SourceSans
--TextBox.Text = "0"
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextStrokeTransparency = 0.000
TextBox.TextWrapped = true
TextBox.ClearTextOnFocus = false

MainListEx.Name = "MainListEx"
MainListEx.Parent = script
MainListEx.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainListEx.BackgroundTransparency = 1.000
MainListEx.Size = UDim2.new(1, 0, 0, 25)
MainListEx.Font = Enum.Font.SourceSans
--MainListEx.Text = "Render"
MainListEx.TextColor3 = Color3.fromRGB(255, 255, 255)
MainListEx.TextScaled = true
MainListEx.TextSize = 14.000
MainListEx.TextWrapped = true

HackGUI.Name = "HackGUI"
HackGUI.ResetOnSpawn = false
HackGUI.Parent = isStudio and plr:WaitForChild("PlayerGui") 
	or game:GetService("CoreGui")
HackGUI.DisplayOrder=-100
HackGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = HackGUI
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
Main.Position = UDim2.new(0.25, 0, 0.75, 0)
Main.Size = UDim2.new(0.26, 0, 0.225, 0)

List.Name = "List"
List.Parent = Main
List.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
List.BackgroundTransparency = 1.000
List.AutomaticCanvasSize = Enum.AutomaticSize.Y
List.Size = UDim2.new(0.245000005, 0, 1, 0)
List.CanvasSize = UDim2.new(0, 0, 0, 0)

UIListLayout.Parent = List
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 20)

Properties.Name = "Properties"
Properties.Parent = Main
Properties.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Properties.BackgroundTransparency = 1.000
Properties.Size = UDim2.new(1, 0, 1, 0)

PropertiesEx.Name = "PropertiesEx"
PropertiesEx.Parent = script
PropertiesEx.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
PropertiesEx.AutomaticCanvasSize = Enum.AutomaticSize.Y
PropertiesEx.BackgroundTransparency = 1.000
PropertiesEx.Position = UDim2.new(0.290841579, 0, 0, 0)
PropertiesEx.Size = UDim2.new(0.709158421, 0, 1, 0)
PropertiesEx.CanvasSize = UDim2.new(0, 0, 0, 0)
PropertiesEx.ScrollBarThickness=6

UIListLayout_2.Parent = PropertiesEx
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 20)

--

NameTagEx.Name = "NameTagEx"
NameTagEx.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NameTagEx.AlwaysOnTop = true
NameTagEx.LightInfluence = 1.000
NameTagEx.Size = UDim2.new(3, 40,0.7, 10)
NameTagEx.ExtentsOffsetWorldSpace = Vector3.new(0, 3, 0)

Username.Name = "Username"
Username.Parent = NameTagEx
Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Username.BackgroundTransparency = 1.000
Username.Size = UDim2.new(1, 0, 1, 0)
Username.ZIndex = 2
Username.Font = Enum.Font.Roboto
Username.TextColor3 = Color3.fromRGB(0, 0, 255)
Username.TextScaled = true
Username.TextStrokeTransparency = 0
Username.TextWrapped = true

Distance.Name = "Distance"
Distance.Parent = NameTagEx
Distance.AnchorPoint = Vector2.new(0.5, 0)
Distance.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Distance.BackgroundTransparency = 1.000
Distance.Position = UDim2.new(0.5, 0, -0.899999976, 0)
Distance.Size = UDim2.new(0.275000006, 0, 1, 0)
Distance.ZIndex = 2
Distance.Font = Enum.Font.Roboto
Distance.TextColor3 = Color3.fromRGB(255, 255, 255)
Distance.TextScaled = true
Distance.TextSize = 14
Distance.TextStrokeTransparency = 0
Distance.TextWrapped = true

ExpandingBar.Name = "ExpandingBar"
ExpandingBar.Parent = NameTagEx
ExpandingBar.AnchorPoint = Vector2.new(0, 1)
ExpandingBar.BackgroundColor3 = Color3.fromRGB(32,32,32)
ExpandingBar.BackgroundTransparency = 0.2
ExpandingBar.Position = UDim2.new(0, 0, 1.49, 0)
ExpandingBar.Size = UDim2.new(1, 0, 0.5, 0)
ExpandingBar.Visible = false

AmtFinished.Name = "AmtFinished"
AmtFinished.Parent = ExpandingBar
AmtFinished.BackgroundColor3 = Color3.fromRGB(255,255,255)
AmtFinished.BackgroundTransparency=.1
AmtFinished.Size = UDim2.new(0, 0, 1, 0)

ToggleTag.Name = "ToggleTag"
ToggleTag.Parent = script
ToggleTag.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleTag.Active = true
ToggleTag.AlwaysOnTop = true
ToggleTag.LightInfluence = 1.000
ToggleTag.Size = UDim2.new(1, 30, 0.75, 10)
ToggleTag.ExtentsOffsetWorldSpace = Vector3.new(0, 4, 0)

ToggleButton.Name = "Toggle"
ToggleButton.Parent = ToggleTag
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "Close"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextScaled = true
ToggleButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
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
XPGained.ZIndex = 3
XPGained.Font = Enum.Font.Fondamento
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
CreditsGained.ZIndex = 3
CreditsGained.Font = Enum.Font.Fondamento
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
ServerXPGained.Font = Enum.Font.Fondamento
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
ServerCreditsGained.ZIndex = 3
ServerCreditsGained.Font = Enum.Font.Fondamento
ServerCreditsGained.Text = " "
ServerCreditsGained.TextColor3 = Color3.new(1, 0.8, 0)
ServerCreditsGained.TextScaled = true
ServerCreditsGained.TextStrokeTransparency = 0
ServerCreditsGained.TextWrapped = true
ServerCreditsGained.TextXAlignment = Enum.TextXAlignment.Left

--GUI CODING
DraggableMain=DraggableObject.new(Main)
DraggableMain:Enable()

local refreshTypes={
	ExTextButton=function(hackFrame,hackInfo)
		local Selected=hackInfo.Options[enHacks[hackInfo.Shortcut]]
		hackFrame.Toggle.Text=Selected.Title
		hackFrame.Toggle.TextColor3=Selected.TextColor
		if hackInfo.ActivateFunction then
			if not hackInfo.DontActivate and not hackInfo.DontStartUp then
				hackInfo.ActivateFunction(enHacks[hackInfo.Shortcut])
			else 
				hackInfo.DontActivate=false
			end
		end
		hackChanged:Fire()
	end,
	ExTextBox=function(hackFrame,hackInfo)
		hackFrame.TextBox.Text=enHacks[hackInfo.Shortcut]
		if hackInfo.ActivateFunction then
			if not hackInfo.DontActivate then
				hackInfo.ActivateFunction(enHacks[hackInfo.Shortcut])
			else 
				hackInfo.DontActivate=false
			end
		end	
		hackChanged:Fire()
	end,
}
local initilizationTypes={
	ExTextButton=function(hackFrame,hackInfo)
		local function cycle(delta)
			local totalNum,shortCutNum=0,0
			for Type,Vals in pairs(hackInfo.Options) do
				totalNum+=1
				if Type==enHacks[hackInfo.Shortcut] then
					shortCutNum=totalNum
				end
			end
			if delta>0 then
				shortCutNum=shortCutNum+delta<=totalNum and shortCutNum+delta or 1
			elseif delta<0 then
				shortCutNum=shortCutNum+delta>0 and shortCutNum+delta or totalNum
			end
			totalNum=0
			for Type,Vals in pairs(hackInfo.Options) do
				totalNum+=1
				if totalNum==shortCutNum then
					enHacks[hackInfo.Shortcut]=Type
					break
				end
			end
			refreshTypes.ExTextButton(hackFrame,hackInfo)
		end
		table.insert(functs,hackFrame.Toggle.MouseButton1Up:Connect(function()
			cycle(1)
		end))
		if getDictLength(hackInfo.Options)>2 then
			table.insert(functs,hackFrame.Toggle.MouseButton2Up:Connect(function()
				cycle(-1)
			end))
		end
	end,
	ExTextBox=function(hackFrame,hackInfo)
		table.insert(functs,hackFrame.TextBox.FocusLost:Connect(function()
			local toNumber=tonumber(hackFrame.TextBox.Text)
			if toNumber~=nil then
				enHacks[hackInfo.Shortcut]=math.clamp(toNumber,hackInfo.MinBound,hackInfo.MaxBound)
			else
				enHacks[hackInfo.Shortcut]=hackInfo.Default
			end
			refreshTypes.ExTextBox(hackFrame,hackInfo)
		end))
	end,
}

local function defaultFunction(functName,args)
	for hackType,hackList in pairs(AvailableHacks) do
		for num,hackInfo in pairs(hackList) do
			if hackInfo[functName] then 
				--(functName~="MyStartUp" or not hackInfo.DontStartUp) then
				spawn(function()
					hackInfo[functName](table.unpack(args))
				end)
			end
		end
	end
end

for name, differentHacks in pairs(AvailableHacks) do
	local newButton = MainListEx:Clone()
	newButton.Text=name
	newButton.Name=name
	newButton.Parent=List

	local newProperty = PropertiesEx:Clone()
	newProperty.Parent=Properties
	newProperty.Name=name
	newProperty.Visible=false
	newButton.MouseButton1Up:Connect(function()
		for num,prop in pairs(Properties:GetChildren()) do
			if prop.ClassName=="ScrollingFrame" then
				prop.Visible=prop==newProperty
			end
		end
		for num,button in pairs(List:GetChildren()) do
			if button.ClassName=="TextButton" then
				button.Font=button==newButton and Enum.Font.SourceSansBold or Enum.Font.SourceSans
			end
		end
	end)
	for num,hack in pairs(differentHacks) do
		if isCleared then return end
		enHacks[hack.Shortcut]=hack.Default
		hack.Options=hack.Options or {
			[true]={
				["Title"]="ENABLED",
				["TextColor"]=Color3.fromRGB(0,255)
			},
			[false]={
				["Title"]="DISABLED",
				["TextColor"]=Color3.fromRGB(255)
			},
		}
		local miniHackFrame=script[hack.Type]:Clone()
		miniHackFrame.Parent=newProperty
		miniHackFrame.Name=hack.Title
		miniHackFrame.Title.Text=hack.Title
		miniHackFrame.Desc.Text=hack.Desc
		miniHackFrame.LayoutOrder=num
		spawn(function()
			refreshTypes[hack.Type](miniHackFrame,hack)
		end)
		initilizationTypes[hack.Type](miniHackFrame,hack)
		--if hack.ChildAdded~=nil then
		--	table.insert(functs,workspace.DescendantAdded:Connect(hack.ChildAdded))
		--	for num,obj in pairs(workspace:GetDescendants()) do
		--		hack.ChildAdded(obj)
		--	end
		--end
	end
end
--HACK CONTROL
local function CharacterAdded(theirChar)
	if isCleared then return end
	task.wait()
	local theirPlr=PS:GetPlayerFromCharacter(theirChar)
	local theirHumanoid=theirChar:WaitForChild("Humanoid")
	local hrp=theirChar:WaitForChild("HumanoidRootPart",1) or theirChar.PrimaryPart
	local isMyChar=theirPlr==plr
	if isMyChar then --print("set char + human ", theirChar:GetFullName(), human:GetFullName())
		char=theirChar
		human=theirHumanoid
	end

	defaultFunction(isMyChar and "MyStartUp" or "OthersStartUp",{theirPlr,theirChar})
	--[[for hackType,hackList in pairs(AvailableHacks) do
		for num,hackInfo in pairs(hackList) do
			if isMyChar and hackInfo.MyStartUp then
				spawn(function()
					hackInfo.MyStartUp(theirPlr,theirChar)
				end)
			elseif not isMyChar and hackInfo.OthersStartUp then
				spawn(function()
					hackInfo.OthersStartUp(theirPlr,theirChar)
				end)
			end
		end
	end--]]
end
local function CharacterRemoving(theirPlr,theirChar)
	if isCleared then return end
	local isMyChar=theirPlr==plr
	--[[for hackType,hackList in pairs(AvailableHacks) do
		for num,hackInfo in pairs(hackList) do
			if isMyChar and hackInfo.MyShutDown then
				hackInfo.MyShutDown(theirPlr,theirChar)
			elseif not isMyChar and hackInfo.OthersShutDown then
				hackInfo.OthersShutDown(theirPlr,theirChar)
			end
		end
	end--]]
	defaultFunction(isMyChar and "MyShutDown" or "OthersShutDown",{theirPlr,theirChar})
end
local function PlayerAdded(theirPlr)
	local isMe=plr==theirPlr
	playerEvents[theirPlr.UserId]={}
	if theirPlr.Character~=nil then
		CharacterAdded(theirPlr.Character)
	end
	--[[for hackType,hackList in pairs(AvailableHacks) do
		for num,hackInfo in pairs(hackList) do
			if isMe and hackInfo.MyPlayerAdded then
				spawn(function()
					hackInfo.MyPlayerAdded(plr)
				end)
			elseif not isMe and hackInfo.OthersPlayerAdded then
				spawn(function()
					hackInfo.OthersPlayerAdded(theirPlr)
				end)
			end
		end
	end--]]
	defaultFunction(isMe and "MyPlayerAdded" or "OthersPlayerAdded",{theirPlr})
	table.insert(playerEvents[theirPlr.UserId],theirPlr.CharacterAdded:Connect(CharacterAdded))
	table.insert(playerEvents[theirPlr.UserId],theirPlr.CharacterRemoving:Connect(function(removingChar)
		CharacterRemoving(theirPlr,removingChar)
	end))
end
table.insert(functs,PS.PlayerAdded:Connect(PlayerAdded))
table.insert(functs,PS.PlayerRemoving:Connect(function(theirPlr)
	if plr==theirPlr then return end--we don't care bc there's no need to cleanup after we leave!
	for num,funct in pairs(playerEvents[theirPlr.UserId] or {}) do
		funct:Disconnect()
	end playerEvents[theirPlr.UserId]=nil
end))
for num,theirPlr in pairs(PS:GetPlayers()) do
	PlayerAdded(theirPlr)
end
local function DescendantRemoving(child)
	if child==Map then
		Map=nil
		--[[for num,hackType in pairs(AvailableHacks) do
			for num,hackInfo in pairs(hackType) do
				if hackInfo.CleanUp then
					hackInfo.CleanUp(child)
				end
			end
		end--]]
		defaultFunction("CleanUp",{child})
	elseif string.sub(child.Name,1,13)=="ComputerTable" then
		--[[for num,hackType in pairs(AvailableHacks) do
			for num,hackInfo in pairs(hackType) do
				if hackInfo.ComputerRemoved then
					hackInfo.ComputerRemoved(child)
				end
			end
		end--]]
		defaultFunction("ComputerRemoved",{child})
	elseif string.sub(child.Name,1,9)=="FreezePod" then
		--[[for num,hackType in pairs(AvailableHacks) do
			for num,hackInfo in pairs(hackType) do
				if hackInfo.CapsuleRemoved then
					hackInfo.CapsuleRemoved(child)
				end
			end
		end--]]
		CS:RemoveTag(child,"Capsule")
		defaultFunction("CapsuleRemoved",{child})
	elseif child.Name=="Hammer" then
		local theirChar=child.Parent
		local theirPlr=PS:GetPlayerFromCharacter(theirChar)
		Beast=nil
		defaultFunction(theirPlr==plr and "MyBeastRemoved" or "OthersBeastRemoved",{theirPlr,theirChar})
	elseif child.Name=="SingleDoor" or child.Name=="DoubleDoor" or child.Name=="ExitDoor" then
		CS:RemoveTag(child,"Door")
		defaultFunction("DoorRemoved",{child,child.Name})
	end
end
local function DescendantAdded(child,shouldntWait)
	if not shouldntWait then
		wait()
	end
	if string.match(child.Name," by ")~=nil and child.Parent==workspace then--must be a direct instance of WORKSPACE
		Map=child
		defaultFunction("MapAdded",{child})
	elseif string.sub(child.Name,1,13)=="ComputerTable" then
		while child.PrimaryPart==nil do
			child:GetPropertyChangedSignal("PrimaryPart"):Wait() wait(.25)
		end
		local Screen=child:WaitForChild("Screen")
		--[[for num,hackType in pairs(AvailableHacks) do
			for num,hackInfo in pairs(hackType) do
				if hackInfo.ComputerAdded~=nil then
					spawn(function()
						hackInfo.ComputerAdded(child)
					end)
				end
			end
		end--]]
		CS:AddTag(child,"Computer")
		for num,triggerName in pairs({"ComputerTrigger1","ComputerTrigger2","ComputerTrigger3"}) do
			local trigger=child:WaitForChild(triggerName)
			CS:AddTag(trigger,"Trigger")
			trigger.Transparency=hitBoxesEnabled and .6 or 1
			if Map.Name=="Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda" then
				trigger:SetAttribute("WalkToPoso",Vector3.new(Screen.Position.X,trigger.Position.Y,
					Screen.Position.Z):lerp(trigger.Position,1.17))
				--trigger.Position=
			end
		end
		child.Name="ComputerTable/"..(table.find(CS:GetTagged("Computer"),child))
		--tonumber(table.find(CS:GetTagged("Computer"),Computer))
		defaultFunction("ComputerAdded",{child})
	elseif string.sub(child.Name,1,9)=="FreezePod" then
		--[[for num,hackType in pairs(AvailableHacks) do
			for num,hackInfo in pairs(hackType) do
				if hackInfo.CapsuleAdded~=nil then
					spawn(function()
						hackInfo.CapsuleAdded(child)
					end)
				end
			end
		end--]]
		local PodTrigger=child:WaitForChild("PodTrigger",3)
		CS:AddTag(child,"Capsule")
		if PodTrigger==nil then
			CS:AddTag(PodTrigger,"Trigger")
		end
		defaultFunction("CapsuleAdded",{child})
		table.insert(functs,child.AncestryChanged:Connect(DescendantRemoving))
	elseif child.Name=="Hammer" then
		local theirChar=child.Parent
		local theirPlr=PS:GetPlayerFromCharacter(theirChar)
		if theirPlr~=nil then
			Beast=theirChar
			defaultFunction(theirPlr==plr and "MyBeastAdded" or "OthersBeastAdded",{theirPlr,theirChar})
		end
	elseif child.Parent~=workspace and 
		(child.Name=="SingleDoor" or child.Name=="DoubleDoor" or child.Name=="ExitDoor") then
		local doorTrigger=child.Name~="ExitDoor" and child:WaitForChild("DoorTrigger")
			or child:WaitForChild("ExitDoorTrigger",16*60)
		CS:AddTag(child,"Door")
		CS:AddTag(doorTrigger,"Trigger")
		if child.Name=="ExitDoor" then
			CS:AddTag(child,"Exit")
		else
			CS:AddTag(doorTrigger,"DoorTrigger")
		end
		defaultFunction("DoorAdded",{child,child.Name})
	else
		return
	end
	table.insert(functs,child.AncestryChanged:Connect(function(newParent)
		DescendantRemoving(child)
	end))
end
table.insert(functs,workspace.DescendantAdded:Connect(DescendantAdded))
table.insert(functs,workspace.DescendantRemoving:Connect(DescendantRemoving))
for num,obj in pairs(workspace:GetDescendants()) do
	if isCleared then return end
	task.spawn(function()
		DescendantAdded(obj,true)
	end)
	if num%900==0 then
		task.wait()
	end
end


--MENU FUNCTS
if gameName=="FleeMain" then
	local LevelingXpCurve=require(RS:WaitForChild("LevelingXpCurve"))
	local totalXPEarned,totalCreditsEarned=0,0
	local totCreditsOffset,totXPOffset=PS:GetAttribute("TotalServerCreditsOffset") or 0,
		PS:GetAttribute("TotalServerXPOffset") or 0
	local function calculateCredits(theirPlr)
		local currentXP,currentCredits,currentLvl
		local creditsEarned,xpEarned=0,0
		local startXP,startCredits

		local function getTotalXP()
			local totalXP=0
			for level=1,currentLvl.Value,1 do
				totalXP+=LevelingXpCurve[level] or 4000
			end
			totalXP+=currentXP.Value
			return totalXP
		end
		local function updateXPStats()
			if theirPlr.Parent~=PS then return end
			local deltaXP=getTotalXP()-startXP
			startXP=getTotalXP() xpEarned+=deltaXP
			totalXPEarned+=deltaXP
			--print(theirPlr,"deltaXP:",deltaXP,"newtotal:",totalXPEarned+totXPOffset)
			ServerXPGained.Text="Server XP Earned: "..comma_value(totalXPEarned+totXPOffset).." "
			if theirPlr==plr then
				XPGained.Text="XP Earned: "..comma_value(xpEarned).." "
			end
		end
		local function updateCreditStats()
			if theirPlr.Parent~=PS then return end
			local deltaCredits=currentCredits.Value-startCredits
			startCredits=currentCredits.Value creditsEarned+=deltaCredits
			totalCreditsEarned+=deltaCredits
			--print(theirPlr,"deltaCred:",deltaCredits,"newtotal:",totalCreditsEarned+totCreditsOffset)
			ServerCreditsGained.Text=" Server Credits Earned: "..comma_value(totalCreditsEarned+totCreditsOffset)
			if theirPlr==plr then
				CreditsGained.Text=" Credits Earned: "..comma_value(creditsEarned)
			end
		end
		table.insert(functs,theirPlr.AncestryChanged:Connect(function()
			PS:SetAttribute("TotalServerXPOffset",(currentXP and currentXP.Value or xpEarned)
				+(PS:SetAttribute("TotalServerXPOffset") or 0))
			PS:SetAttribute("TotalServerCreditsOffset",(currentCredits and currentCredits.Value or creditsEarned)
				+(PS:SetAttribute("TotalServerCreditsOffset") or 0))
		end))
		task.spawn(function()
			local theirSSM=theirPlr:WaitForChild("SavedPlayerStatsModule")
			currentLvl=theirSSM:WaitForChild("Level",1e5) if not currentLvl then return end
			currentXP,currentCredits=theirSSM:WaitForChild("Xp"),theirSSM:WaitForChild("Credits")
			startXP=theirPlr:GetAttribute("StartXP") or getTotalXP()
			startCredits=theirPlr:GetAttribute("StartCredits") or currentCredits.Value
			theirPlr:SetAttribute("StartXP",startXP)
			theirPlr:SetAttribute("StartCredits",startCredits)
			setChangedAttribute(currentXP,"Value",updateXPStats)
			setChangedAttribute(currentCredits,"Value",updateCreditStats)
			updateXPStats() updateCreditStats()
		end)
	end
	PS.PlayerAdded:Connect(calculateCredits)
	for num,theirPlr in pairs(PS:GetPlayers()) do
		calculateCredits(theirPlr)
	end
end

local function CloseMenu(actionName, inputState, inputObject)
	if inputState==Enum.UserInputState.Begin then
		Main.Visible=not Main.Visible
		if Main.Visible then
			DraggableMain:Enable()
		else
			DraggableMain:Disable()
		end
	end
end
CAS:BindActionAtPriority("CloseMenu",CloseMenu,true,100,Enum.KeyCode.V)
--GARBAGE COMPILER
