extends Node2D


@export var snap_sprite: Script
@export var character_body: CharacterBody2D
var sprites: Array[Node]

func _ready():
	assert(character_body)
	sprites = get_children()
	for sprite in sprites:
		var a = load("res://scripts/SnapSprite.gd")
		sprite.set_script(a)
		sprite.setup(character_body)
		
func set_facing(facing: Values.Facing):
	for sprite in sprites:
		if facing == Values.Facing.LEFT:
			sprite.flip_h = true
		if facing == Values.Facing.RIGHT:
			sprite.flip_h = false
