extends Node2D


enum Facing { LEFT, RIGHT }

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
		
func set_facing(facing: Facing):
	for sprite in sprites:
		if facing == Facing.LEFT:
			sprite.flip_h = true
		if facing == Facing.RIGHT:
			sprite.flip_h = false
