extends Sprite2D


@export var target_manual: Node2D
var target: Node2D
var pos_offset: Vector2i
var rot_offset: float

var target_pos_prev: Vector2
var target_pos_now: Vector2

var target_rot_prev: float
var target_rot_now: float

func _ready():
	if target_manual == null:
		target = get_node("../RigidBody2D")
		pos_offset = position - target.position
		rot_offset = rotation - target.rotation
	else:
		target = target_manual
	
func _physics_process(delta):
	target_pos_prev = target_pos_now
	target_pos_now = target.position
	
	target_rot_prev = target_rot_now
	target_rot_now = target.rotation

func _process(delta):
	var pif = Engine.get_physics_interpolation_fraction()
	var interp = (1 - pif) * target_pos_prev + \
		pif * target.position
	position = Vector2i(interp.round()) + pos_offset
