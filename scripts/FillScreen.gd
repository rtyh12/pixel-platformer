extends SubViewportContainer


var game_resolution = Vector2i(320, 180)


func _ready():
	pivot_offset = 0.5 * game_resolution
	print(pivot_offset)
	
	get_tree().root.connect("size_changed", _on_viewport_size_changed)
	_on_viewport_size_changed()

func _on_viewport_size_changed():
	var window_size = DisplayServer.window_get_size()
	var scale_dim = min(
		float(window_size.x) / game_resolution.x,
		float(window_size.y) / game_resolution.y,
	)
	scale = Vector2(scale_dim, scale_dim)
