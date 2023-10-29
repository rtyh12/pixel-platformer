extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	var level = load("res://scenes/levels/level1.tscn")
	add_child(level.instantiate())
