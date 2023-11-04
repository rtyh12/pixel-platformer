extends Node


@export var cb: CharacterBody2D
@export var collision_shape: CollisionShape2D
@export var run_speed: float


var speed_vertical = 0

func _physics_process(delta):
	cb.velocity = Vector2.ZERO
	
	# Gravity
#	speed_vertical -= -1 * delta
	
	cb.velocity.y += speed_vertical
	
	# Collisions
#	print(cb.is_on_floor())
	
	# Input
	if Input.is_action_pressed("ui_right"):
		cb.velocity.x += run_speed
	if Input.is_action_pressed("ui_left"):
		cb.velocity.x -= run_speed
		
	print(cb.velocity)
	cb.move_and_slide()	
