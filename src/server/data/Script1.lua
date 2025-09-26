local DataStoreService = game:GetService("DataStoreService")
local TradeHistoryStore = DataStoreService:GetDataStore("TradeHistoryBytrV1")
local HttpService = game:GetService("HttpService")

--[[-- Function to save trade history
local function SaveTradeHistory(playerId, tradeData)
	-- Generate a unique key using timestamp
	local tradeId = tostring(os.time()) .. "-" .. playerId

	-- Convert trade data to JSON
	local tradeDataJSON = HttpService:JSONEncode(tradeData)

	-- Save to DataStore
	local success, error = pcall(function()
		TradeHistoryStore:SetAsync(tradeId, tradeDataJSON)
	end)

	if not success then
		warn("Error saving trade history:", error)
	end
end]]

-- Function to save trade history 
local function SaveTradeHistory(playerId, tradeData) -- Generate a unique key using timestamp 
	local tradeId = tostring(os.time()) .. "-" .. playerId

	-- Convert trade data to JSON
	local tradeDataJSON = HttpService:JSONEncode(tradeData)

	-- Save to DataStore
	local success, error = pcall(function()
		TradeHistoryStore:SetAsync(tradeId, tradeDataJSON)

		-- Save tradeId to the list of trade keys
		local existingKeys = TradeHistoryStore:GetAsync("TradeHistoryPages") or {}
		table.insert(existingKeys, tradeId)
		TradeHistoryStore:SetAsync("TradeHistoryPages", existingKeys)
	end)

	if not success then
		warn("Error saving trade history:", error)
	end
end

-- Event listener for saving trade history
game.ReplicatedStorage.SaveDATA.Event:Connect(function(player, targetPlayerId, assetPrice, assetPriceme, towersGiven, towersReceived)
	-- Prepare trade data
	local tradeData = {
		playerId = player.UserId,
		targetPlayerId = targetPlayerId,
		assetPrice = assetPrice or 0,
		assetPriceme = assetPriceme or 0,
		towersGiven = towersGiven,
		towersReceived = towersReceived,
		date = os.date("%Y-%m-%d %H:%M:%S")
	}
	
	local tradeData2 = {
		playerId = targetPlayerId,
		targetPlayerId = player.UserId,
		assetPrice = assetPriceme or 0,
		assetPriceme = assetPrice or 0,
		towersGiven = towersReceived,
		towersReceived = towersGiven,
		date = os.date("%Y-%m-%d %H:%M:%S")
	}
	
	print("Data Saved for player:", player.UserId, "Target:", targetPlayerId, "date:", tradeData.date)
	print("Data Saved for player2:",targetPlayerId, "Target:",  player.UserId, "date:", tradeData.date)

	-- Save the trade data
	SaveTradeHistory(player.UserId, tradeData)
	wait()
	SaveTradeHistory(targetPlayerId, tradeData2)

end)
