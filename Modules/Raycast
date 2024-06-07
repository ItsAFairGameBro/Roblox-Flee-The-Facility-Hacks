return function(C,_SETTINGS)
	--PRINT ENVIRONMENT START
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

	function C.raycast(from, target, filter, distance, passThroughTransparency,passThroughCanCollide,breakFunct)
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
			if breakFunct and breakFunct(result) then
				
			elseif raycastParams.FilterType==Enum.RaycastFilterType.Include or (result==nil or result.Instance==nil) or ((not passThroughTransparency or result.Instance.Transparency<(passThroughTransparency or 1) or result.Instance.Parent:IsA("Accessory")) 
				and (not passThroughCanCollide or result.Instance.CanCollide or result.Instance:GetAttribute(C.OriginalCollideName))) then
				break;
			elseif result~=nil and lastInstance==result.Instance then
				break;
			end
			
			if result then
				from = result.Position:lerp(target,.01);
				lastInstance = result.Instance;
				table.insert(filter, lastInstance);
				raycastParams.FilterDescendantsInstances = filter;
			else
				break
			end
		end
		if result~=nil and result.Instance~=nil and result.Instance.Parent~=nil then
			return result,result.Instance;
		else
			return false;
		end;
	end;

end


