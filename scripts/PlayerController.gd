extends Node


@export var cb: CharacterBody2D
@export var collision_shape: CollisionShape2D
@export var run_speed: float


var speed_vertical = 0

func _physics_process(delta):
	cb.velocity = Vector2.ZERO
	
	# Gravity
	cb.velocity.y += 20
	
	# Collisions
	
	# Input
	if Input.is_action_pressed("ui_right"):
		cb.velocity.x += run_speed
	if Input.is_action_pressed("ui_left"):
		cb.velocity.x -= run_speed
		
	print(cb.move_and_slide())
	print(cb.is_on_floor())
