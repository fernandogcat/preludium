extends Node

const CONFIG_RESOURCE_PATH = "res://Components/GameConfiguration/GameConfiguration.tres"

var config: GameConfiguration
var settings: SettingsManager

func setup():
	config = preload(CONFIG_RESOURCE_PATH)
	config.setup()
	settings = SettingsManager.new()
	settings.setup()
