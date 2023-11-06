extends Node


var settings: ConfigFile

func create_default_settings():
	settings = ConfigFile.new()

func load_from_file():
	var new_settings = ConfigFile.new()
	var err = new_settings.load("user://settings.ini")
	if err != OK:
		create_default_settings()
	settings = new_settings

#	var player_name = settings.get_value("section1", "prop1")

func _ready():
	load_from_file()
