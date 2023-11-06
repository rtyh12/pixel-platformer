extends Node


@export var cb: CharacterBody2D
@export var collision_shape: CollisionShape2D
@export var sprite_container: Node2D
@export var hair_controller: HairController
@export var run_speed: float

enum Facing { LEFT, RIGHT }
@onready var hair_controller_pos = hair_controller.position

var can_jump = false
var can_coyote = false
var still_holding_jump_after_jump = false
var jump_buffered = false

var speed_vertical = 0
var floaty_jump_time = 0.4
var coyote_time = 0.1
var jump_buffer_time = 0.1

var was_on_floor_last_frame = false

# Stopwatches
var t_since_jump = 0
var t_since_jump_input = 0
var t_since_left_ground = 0
# Don't forget to add new stopwatches to update_stopwatches()

func _physics_process(delta):
	# Collisions
	if cb.is_on_floor() or cb.is_on_ceiling():
		speed_vertical = 0

	# Bookkeeping
	update_stopwatches(delta)
	can_jump = cb.is_on_floor() or can_coyote
	if _just_left_ground():
		t_since_left_ground = 0
	if _just_landed_on_ground():
		if jump_buffered and t_since_jump_input < jump_buffer_time:
			_jump()
		can_coyote = true
		jump_buffered = false
	if !cb.is_on_floor() and t_since_left_ground >= coyote_time:
		can_coyote = false
	cb.velocity = Vector2.ZERO
	
	# Gravity
	if cb.is_on_floor():
		speed_vertical += 5
	else:
		if t_since_jump < floaty_jump_time and still_holding_jump_after_jump:
			speed_vertical += 4
		else:
			speed_vertical += 7

	# Input
	if Input.is_action_pressed("ui_right"):
		cb.velocity.x += run_speed
		_set_facing(Facing.RIGHT)
	if Input.is_action_pressed("ui_left"):
		cb.velocity.x -= run_speed
		_set_facing(Facing.LEFT)
	if Input.is_action_just_pressed("jump"):
		t_since_jump_input = 0
		if can_jump:
			_jump()
		if !cb.is_on_floor():
			jump_buffered = true
	if !Input.is_action_pressed("jump"):
		still_holding_jump_after_jump = false

	# Apply results
	cb.velocity.y = speed_vertical
	was_on_floor_last_frame = cb.is_on_floor()
	cb.move_and_slide()
	
func _jump():
	t_since_jump = 0
	still_holding_jump_after_jump = true
	speed_vertical = -270
	can_coyote = false
	
func _set_facing(facing: Facing):
	if facing == Facing.LEFT:
		sprite_container.set_facing(Facing.LEFT)
		hair_controller.position.x = -hair_controller_pos.x
	else:
		sprite_container.set_facing(Facing.RIGHT)
		hair_controller.position.x = hair_controller_pos.x

func update_stopwatches(delta):
	# TODO there HAS to be a better way ;_;
	t_since_jump += delta
	t_since_left_ground += delta
	t_since_jump_input += delta
	
func _just_left_ground() -> bool:
	return was_on_floor_last_frame and !cb.is_on_floor()
	
func _just_landed_on_ground() -> bool:
	return !was_on_floor_last_frame and cb.is_on_floor()
