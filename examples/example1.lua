local DataHandler = require(108002867325509)

-- Update the configuration with the desired values
DataHandler.Config.DataStoreName = "PlayerData_v1"
DataHandler.Config.Keys = {"stats"}

game.Players.PlayerAdded:Connect(function(player)
	-- Create leader stats for the player
	DataHandler:CreateLeaderStats(player, {
		["Cash"] = "NumberValue",
		["Level"] = "NumberValue"
	})

	-- Load player data from DataStore
	local playerData = DataHandler:LoadData(player.UserId, "stats")
	if playerData then
		-- Apply loaded values to leader stats
		if playerData.Cash then
			player.leaderstats.Cash.Value = playerData.Cash
		end
		if playerData.Level then
			player.leaderstats.Level.Value = playerData.Level
		end
	else
		-- If no data is found, set default values
		player.leaderstats.Cash.Value = 0
		player.leaderstats.Level.Value = 0
	end

	-- Every second, player will get +1 on both stats
	while wait(1) do
		player.leaderstats.Cash.Value += 1
		player.leaderstats.Level.Value += 1
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	-- Save data when player leaves
	DataHandler:SaveData(player, "stats", {
		Cash = player.leaderstats.Cash.Value,
		Level = player.leaderstats.Level.Value
	})
end)
