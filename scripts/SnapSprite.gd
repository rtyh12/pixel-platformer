extends Sprite2D


@export var target_manual: Node2D
var target: Node2D
var target_offset: Vector2i

var target_position_last_frame: Vector2
var target_position_this_frame: Vector2

func _ready():
	if target_manual == null:
		target = get_node("../RigidBody2D")
		target_offset = position - target.position
	else:
		target = target_manual
	
func _physics_process(delta):
	target_position_last_frame = target_position_this_frame
	target_position_this_frame = target.position

func _process(delta):
	var pif = Engine.get_physics_interpolation_fraction()
	var interp = (1 - pif) * target_position_last_frame + \
		pif * target.position
	position = Vector2i(interp.round()) + target_offset
