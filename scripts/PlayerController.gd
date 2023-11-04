extends Node


@export var physics_body: CharacterBody2D
@export var collision_shape: CollisionShape2D
@export var run_speed: float

var speed_vertical = 0

func _physics_process(delta):
	# Gravity
	speed_vertical -= -1 * delta
	
	var frame_mov = Vector2.ZERO
	
	frame_mov.y += speed_vertical * delta
	
	# Collisions
	print(physics_body.is_on_floor())
	
	# Input
	if Input.is_action_pressed("ui_right"):
		frame_mov.x += run_speed * delta
	if Input.is_action_pressed("ui_left"):
		frame_mov.x -= run_speed * delta
		
	physics_body.position += frame_mov	
