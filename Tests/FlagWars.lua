local CP = game:GetService("ContentProvider")
local PS = game:GetService("Players")

local plr = PS.LocalPlayer

local OldRemoteEvent

local function getClosest()
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
end

OldRemoteEvent = hookfunction(Instance.new("RemoteEvent").FireServer,function(event,...)
	local arguments = {...}



	if tostring(getcallingscript()) == "BAC_" then
		
		local arg1 = (...)[1]
		if typeof(arg1)=="table" then
			for num, val in pairs(arg1) do
				print("Key/Val",num,val)
			end
		end
		if tostring(event) == "NewMessage" and (arguments[1] == "B-1" or arguments[1] == "A-1" or typeof(arg1)=="table") then
			print("Prevented BAC_ with",event.Name,...)
			return error("Nope")
		else
			print("Passed BAC_ with",event.Name,...)
		end
	elseif not checkcaller() and tostring(event) == "WeaponHit" then
		local Closest = getClosest()
		arguments[2]["part"] = Closest.Character.Head
		arguments[2]["h"] = Closest.Character.Head
	end

	return OldRemoteEvent(event,unpack(arguments))
end)

local OldPreloadAsync
local Print2 = true

OldPreloadAsync = hookfunction(CP.PreloadAsync,function(CP_2,assets,callerFunction)

	if tostring(getcallingscript()) == "BAC_" then
		if Print2 then
			Print2 = false
			print("PreloadAsync Instance: "..assets[1]:GetFullName())
		else
			print("Blocked BAC_ from calling",#assets)
		end
		return
	end

	return OldPreloadAsync(CP_2,assets,callerFunction)
end)
