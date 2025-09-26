local DataService = require(game.ServerScriptService.data.DataService)


-- EVENTS -




game.ReplicatedStorage.SaveDATA.Event:Connect(function(Player, Target, AssetPrice,AssetPriceme,Towers1,Towers2)
	local currentDate = os.date("%Y-%m-%d %H:%M:%S")

	print(currentDate.." Trade")
	print(Player.UserId.." Trade")

	if AssetPrice == nil or AssetPrice == "" then
		AssetPrice = 0
	end

	if AssetPriceme == nil or AssetPriceme == "" then
		AssetPriceme = 0
	end

	local byt =  DataService:SaveTradeHistory(Player.UserId, Target, AssetPrice,AssetPriceme,Towers1,Towers2,currentDate)

	if byt then
		return
	end	
end) 

game.ReplicatedStorage.RemoteEvents.LoadTradeHistory.OnServerEvent:Connect(function(Player)
	return DataService:LoadTradeHistory(Player.UserId)	
end) 
