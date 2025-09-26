--Made By EmoStudio 

--[[


-- // Useful functions

function getMultiplier(Player, multiplierName)
	-- put "Multipler1" or "Multiplier2" for the multiplierName parameter
	local Multi = 0
	for i,v in pairs(Player.Pets:GetChildren()) do
		if v.Equipped.Value == true then
			Multi = Multi + v[multiplierName].Value
		end
	end
	return Multi
end

function getLevel(totalXP)
	local Increment = 0
	local RequiredXP = 100
	for i = 0, game.ReplicatedStorage.Pets.Settings.MaxPetLevel.Value do
		RequiredXP = 100 + (25*i)
		if totalXP >= (100*i) + Increment then
			if i ~= RS.Pets.Settings.MaxPetLevel.Value then
				if totalXP < ((100*i) + Increment) + RequiredXP then
					return i
				end
			else
				return i
			end
		end
		Increment = Increment+(i*25)
	end
end

function GetFolderFromPetID(Player, PetID)
	for i,v in pairs(Player.Pets:GetChildren()) do
		if v.PetID.Value == PetID then
			return v
		end
	end
	return nil
end

--]]