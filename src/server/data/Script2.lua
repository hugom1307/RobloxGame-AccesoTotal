local DataStoreService = game:GetService("DataStoreService")
local TradeHistoryStore = DataStoreService:GetDataStore("TradeHistoryBytrV1")
local HttpService = game:GetService("HttpService")

-- Function to load trade history
local function LoadTradeHistory(player)
	local historyData = {}
	local pageNumber = 1

	local function LoadPage()
		local success, error = pcall(function()
			local pageData = TradeHistoryStore:GetAsync("TradeHistoryPages") or {}
			local pageKeys = {}

			for _, key in ipairs(pageData) do
				if string.match(key, tostring(pageNumber)) then
					local playerTradeId = string.match(key, "^(.*)-" .. tostring(player.UserId))
					if playerTradeId then
						table.insert(pageKeys, key)
					end
				end
			end

			if #pageKeys > 0 then
				for _, key in ipairs(pageKeys) do
					local tradeData = TradeHistoryStore:GetAsync(key)
					if tradeData then
						table.insert(historyData, HttpService:JSONDecode(tradeData))
					end
				end
			end
		end)

		if not success then
			warn("Failed to load trade history:", error)
		end
	end


--[[	local function LoadPage()
		local success, error = pcall(function()
			local pageData = TradeHistoryStore:GetAsync("TradeHistoryPages") or {}
			local pageKeys = {}

			for _, key in ipairs(pageData) do
				if string.match(key, tostring(pageNumber)) then
					table.insert(pageKeys, key)
				end
			end

			if #pageKeys > 0 then
				for _, key in ipairs(pageKeys) do
					local tradeData = TradeHistoryStore:GetAsync(key)
					if tradeData then
						table.insert(historyData, HttpService:JSONDecode(tradeData))
					end
				end
			end
		end)

		if not success then
			warn("Failed to load trade history:", error)
		end
	end]]

	while true do
		LoadPage()
		pageNumber = pageNumber + 1

		if #historyData > 0 then
			break
		else 
			warn("No trade history found for player:", player.Name)
		end
	end

	return historyData
end

-- Event listener for loading trade history
game.ReplicatedStorage.RemoteEvents.LoadTradeHistory.OnServerEvent:Connect(function(player)
	local historyData = LoadTradeHistory(player)
	if historyData then
		game.ReplicatedStorage.RemoteEvents.LoadTradeHistory:FireClient(player, historyData)
	end
end)