local CP = game:GetService("ContentProvider")

local OldRemoteEvent

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
	end

	return OldRemoteEvent(event,...)
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
