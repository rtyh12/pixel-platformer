extends Node


func toggle_fullscreen():
	var is_full_screen = get_window().mode == Window.MODE_FULLSCREEN
	if get_window().mode == Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_WINDOWED
	else:
		get_window().mode = Window.MODE_FULLSCREEN

func _input(event):
	if event.is_action_pressed("full_screen"):
		toggle_fullscreen()
	if event.is_action_pressed("debug_quit"):
		get_tree().quit()

