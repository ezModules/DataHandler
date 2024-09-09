--[[
              // DataHandler Module \\
// Effortless Data Management, Infinite Possibilities \\
  
by @knopka_01 :D
]]


local DataHandler = {}
DataHandler.__index = DataHandler

DataHandler.Config = {
	DataStoreName = "PlayerDataStore",
	Keys = {"stats"},
	LeaderStats = {} 
}

local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore(DataHandler.Config.DataStoreName)

function DataHandler:SaveData(player, key, value)
	local userId = player.UserId
	local success, errorMessage = pcall(function()
		playerDataStore:SetAsync(userId .. "_" .. key, value)
	end)
	if not success then
		warn("Failed to save data for UserId " .. userId .. ": " .. errorMessage)
	end
end

function DataHandler:LoadData(userId, key)
	local success, result = pcall(function()
		return playerDataStore:GetAsync(userId .. "_" .. key)
	end)
	if success then
		return result
	else
		warn("Failed to load data for UserId " .. userId)
		return nil
	end
end

function DataHandler:DeleteData(userId, key)
	local success, errorMessage = pcall(function()
		playerDataStore:RemoveAsync(userId .. "_" .. key)
	end)
	if not success then
		warn("Failed to delete data for UserId " .. userId .. ": " .. errorMessage)
	end
end

function DataHandler:GetPlayerData(userId)
	local data = {}
	for _, key in ipairs(DataHandler.Config.Keys) do
		data[key] = self:LoadData(userId, key)
	end
	return data
end

function DataHandler:CreateLeaderStats(player, statsTable)
	if type(statsTable) ~= "table" then
		error("statsTable must be a table with leader stat names and types")
	end

	local existingStats = player:FindFirstChild("leaderstats")

	local leaderstats = existingStats or Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	for statName, statType in pairs(statsTable) do
		local stat
		if statType == "IntValue" then
			stat = Instance.new("IntValue")
			stat.Name = statName
			stat.Value = 0
		elseif statType == "NumberValue" then
			stat = Instance.new("NumberValue")
			stat.Name = statName
			stat.Value = 0
		elseif statType == "StringValue" then
			stat = Instance.new("StringValue")
			stat.Name = statName
			stat.Value = ""
		else
			warn("Unknown stat type for " .. statName .. ": " .. tostring(statType))
			continue
		end
		stat.Parent = leaderstats
	end
end

return DataHandler
