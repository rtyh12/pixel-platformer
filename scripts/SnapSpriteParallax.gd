extends Control


var parent

func _ready() -> void:
	parent = get_parent()


func _process(_delta) -> void:
	global_position = Vector2i(parent.global_position)
	print(global_position)
