extends Node


@export var cb: CharacterBody2D
@export var collision_shape: CollisionShape2D
@export var run_speed: float

var can_jump = false
var still_holding_jump_after_jump = false

var speed_vertical = 0
var floaty_jump_time = 0.7

# Don't forget to add new stopwatches to update_stopwatches()
var t_since_jump = 0

func _physics_process(delta):
	# Bookkeeping
	update_stopwatches(delta)
	can_jump = cb.is_on_floor()
	cb.velocity = Vector2.ZERO
	
	# Collisions
	if cb.is_on_floor() or cb.is_on_ceiling():
		speed_vertical = 0
	
	# Gravity
	if cb.is_on_floor():
		speed_vertical += 5
	else:
		if t_since_jump < floaty_jump_time and still_holding_jump_after_jump:
			speed_vertical += 5
		else:
			speed_vertical += 12
		
	# Input
	if Input.is_action_pressed("ui_right"):
		cb.velocity.x += run_speed
	if Input.is_action_pressed("ui_left"):
		cb.velocity.x -= run_speed
	if Input.is_action_pressed("jump"):
		if can_jump:
			t_since_jump = 0
			still_holding_jump_after_jump = true
			speed_vertical += -270
	if !Input.is_action_pressed("jump"):
		still_holding_jump_after_jump = false
		
	# Apply results
	cb.velocity.y = speed_vertical
	cb.move_and_slide()

func update_stopwatches(delta):
	# TODO there HAS to be a better way ;_;
	t_since_jump += delta
