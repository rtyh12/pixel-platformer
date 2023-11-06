extends Sprite2D


@export var target: Node2D
var pos_offset: Vector2i
var rot_offset: float

var target_pos_prev: Vector2
var target_pos_now: Vector2

var target_rot_prev: float
var target_rot_now: float

func _ready():
	pos_offset = position - target.position
	rot_offset = rotation - target.rotation
		
func setup(target_: Node2D):
	target = target_
	_ready()
	set_process(true)
	set_physics_process(true)
	
func _physics_process(_delta):
	target_pos_prev = target_pos_now
	target_pos_now = target.position
	
	target_rot_prev = target_rot_now
	target_rot_now = target.rotation

func _process(_delta):
	var pif = Engine.get_physics_interpolation_fraction()
	var interp = (1 - pif) * target_pos_prev + \
		pif * target.position
	position = Vector2i(interp.round()) + pos_offset
