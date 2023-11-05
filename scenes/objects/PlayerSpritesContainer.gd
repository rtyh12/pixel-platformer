extends Node2D


@export var snap_sprite: Resource
@export var character_body: CharacterBody2D
var sprites

func _ready():
	sprites = get_children()
	for sprite in sprites:
		sprite.set_script(snap_sprite)
		assert(character_body)
		sprite.target_manual = character_body
