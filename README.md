# DataHandler Module

Effortless Data Management, Infinite Possibilities

by @knopka_01 :D

## Overview

The DataHandler module helps you easily manage player data in Roblox. It allows you to save, load, and delete player data using the DataStore service. It also lets you create leader stats for players with different types of values.

## Features

- **Save Player Data**: Save data to the DataStore for each player.
- **Load Player Data**: Load saved data from the DataStore.
- **Delete Player Data**: Remove data from the DataStore.
- **Get Player Data**: Retrieve all data for a player.
- **Create Leader Stats**: Automatically create leader stats for players with specified types.

## Configuration

You can set up the module with the following configuration:

```lua
DataHandler.Config = {
    DataStoreName = "PlayerDataStore", -- Name of the DataStore for player data
    Keys = {"stats"}, -- Keys to load for a player
    LeaderStats = {} -- Table for leader stats
}
