extends Node

signal full_screen_toggled


func toggle_fullscreen():
	if get_window().mode == Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_WINDOWED
	else:
		get_window().mode = Window.MODE_FULLSCREEN
	emit_signal("full_screen_toggled")

func _input(event):
	if event.is_action_pressed("full_screen"):
		toggle_fullscreen()
	if event.is_action_pressed("debug_quit"):
		get_tree().quit()

#func _ready():
#	toggle_fullscreen()
