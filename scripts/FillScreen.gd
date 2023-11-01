extends SubViewportContainer


@onready var windowController: Node = get_node("/root/main/WindowController")
var game_resolution = Vector2i(320, 180)
var scale_int: int = 3

func _scale_window():
	scale = Vector2i(scale_int, scale_int)
	get_window().size = scale_int * game_resolution
	
func _ready():
	pivot_offset = 0.5 * game_resolution
	_scale_window()
	
	
	windowController.full_screen_toggled.connect(rescale_to_window_size)
#	get_tree().root.connect(full_screen_toggled, rescale_to_window_size)

func rescale_to_window_size():
	var window_size = DisplayServer.window_get_size()
	var window_size_float = Vector2(window_size)
	scale_int = round(min(
		window_size_float.x / game_resolution.x,
		window_size_float.y / game_resolution.y,
	))
	scale = Vector2i(scale_int, scale_int)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_EQUAL:
			scale_int += 1
			_scale_window()
		if event.pressed and event.keycode == KEY_MINUS:
			scale_int -= 1
			scale_int = max(1, scale_int)
			_scale_window()
