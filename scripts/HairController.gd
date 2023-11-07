class_name HairController extends StaticBody2D


@export var snap_sprite: Resource
@export var attachment_point: PhysicsBody2D
var _attachment_point_init_pos = Vector2(0, 3)

func create_tail_attached_to(prev_attach_point, parent, scales):
	for i in range(len(scales)):
		var tail_segment = Node2D.new()
		add_child(tail_segment)
		
		var rb = RigidBody2D.new()
		rb.position = prev_attach_point.position
		rb.linear_damp = 20
		rb.mass = 0.1
		# Disable collision with other tail segments
		# and the character body
		rb.collision_layer = 2**2
		rb.collision_mask = 2**0
		tail_segment.add_child(rb)
		
		var collider = CollisionShape2D.new()
		collider.shape = CircleShape2D.new()
		collider.shape.radius = max(scales[i] / 2, 1)
		rb.add_child(collider)

		var sprite = Sprite2D.new()
		sprite.texture = load("res://textures/100px diameter circle.png")
		sprite.scale = Vector2.ONE * scales[i] / 100
		sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		sprite.set_script(load("res://scripts/SnapSprite.gd"))
		sprite.target = rb
		sprite.modulate = Color("b6cbcf")
		tail_segment.add_child(sprite)
		
		var spring = DampedSpringJoint2D.new()
		spring.length = 0
		spring.rest_length = 1
		spring.stiffness = 1000
		spring.damping = 1
		
		spring.node_a = prev_attach_point.get_path()
		spring.node_b = rb.get_path()
		prev_attach_point = rb
		
		tail_segment.add_child(spring)

func _ready():
	var diameters = [4, 4, 4, 4, 4, 4, 2, 2]
	
	create_tail_attached_to(attachment_point, attachment_point, diameters)
	attachment_point.position = _attachment_point_init_pos
		
func set_facing(facing: Values.Facing):
	if facing == Values.Facing.LEFT:
		attachment_point.position.x = -_attachment_point_init_pos.x
	if facing == Values.Facing.RIGHT:
		attachment_point.position.x = _attachment_point_init_pos.x
		
func _physics_process(delta):
	print(attachment_point.position.x)
