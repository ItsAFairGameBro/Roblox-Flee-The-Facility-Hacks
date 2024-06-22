local RS = game:GetService("ReplicatedStorage")
local PS = game:GetService("Players")

local plr = PS.LocalPlayer
return function(C,_SETTINGS)
	function C.isInGame(theirChar)
		if theirChar and theirChar.Name == "InviClone" then
			theirChar = C.char
		end
		local player=PS:GetPlayerFromCharacter(theirChar)
		if not player then
			return false, "Neutral"--No player, no team!
		end
		if not theirChar.PrimayPart or theirChar.PrimaryPart < -260 then
			return false, player.Team -- Player, but in lobby!
		end

		return true, player.Team -- Player exists!
	end
	function C.getClosest()
		local myHRP = C.char and C.char.PrimaryPart
		if not C.human or C.human.Health <= 0 or not myHRP then return end


		local closest = nil;
		local distance = math.huge;


		for i, v in pairs(PS.GetPlayers(PS)) do
			if v == plr then continue end
			local theirChar = v.Character
			if not theirChar then continue end
			local isInGame,team = C.isInGame(theirChar)
			if not isInGame then continue end
			if team == plr.Team then continue end
			local theirHumanoid = theirChar.FindFirstChildOfClass(theirChar,"Humanoid")
			if not theirHumanoid or theirHumanoid.Health <= 0 then continue end
			local theirHead = theirChar.FindFirstChild(theirChar,"Head")
			if not theirHead then continue end

			local d = (theirHead.Position - myHRP.Position).Magnitude

			if d < distance then
				distance = d
				closest = theirHead
			end
		end

		return closest, distance
	end
	print("Loaded C.getclosest()")
	getgenv().isInGame = C.isInGame
	if C.gameUniverse=="NavalWarefare" then
		C.RemoteEvent = RS:WaitForChild("Event") -- image naming something "Event"
	end
end
