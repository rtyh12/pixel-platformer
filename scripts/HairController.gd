extends Node


func _ready():
	var sprite = Sprite2D.new()
	sprite.texture = load("res://textures/100px diameter circle.png")
	add_child(sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
