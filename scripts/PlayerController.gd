extends Node


@export var physics_body: Node2D
@export var collision_shape: CollisionShape2D
@export var run_speed: float

var speed_vertical = 0

func _physics_process(delta):
	speed_vertical -= 1 * delta
	
	var pos_offset_this_frame = Vector2.ZERO
	
	pos_offset_this_frame.y += speed_vertical * delta
	
	if Input.is_action_pressed("ui_right"):
		pos_offset_this_frame.x += run_speed * delta
	if Input.is_action_pressed("ui_left"):
		pos_offset_this_frame.x -= run_speed * delta
		
	physics_body.position += pos_offset_this_frame	
