extends Sprite2D


var rb: RigidBody2D
var target_offset: Vector2i

var rb_position_last_frame: Vector2
var rb_position_this_frame: Vector2

func _ready():
	rb = get_node("../RigidBody2D")
	target_offset = position - rb.position
	
func _physics_process(delta):
	rb_position_last_frame = rb_position_this_frame
	rb_position_this_frame = rb.position

func _process(delta):
	var pif = Engine.get_physics_interpolation_fraction()
	var interp = (1 - pif) * rb_position_last_frame + pif * rb.position
	position = Vector2i(interp.round()) + target_offset
