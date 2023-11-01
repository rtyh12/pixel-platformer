extends StaticBody2D


func create_tail_attached_to(prev_attach_point, scales):
	for i in range(len(scales)):
		var tail_segment = Node2D.new()
		add_child(tail_segment)
		
		var rb = RigidBody2D.new()
		rb.linear_damp = 20
		rb.mass = 0.1
		# Disable collision with other tail segments
		rb.collision_layer = 1 << 1
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
		sprite.target_manual = rb
		tail_segment.add_child(sprite)
		
		var spring = DampedSpringJoint2D.new()
		spring.length = 0
		spring.rest_length = 1.4
		spring.stiffness = 1000
		spring.damping = 1
		
		spring.node_a = prev_attach_point.get_path()
		spring.node_b = rb.get_path()
		prev_attach_point = rb
		
		tail_segment.add_child(spring)

func _ready():
	var diameters = [8, 7, 6, 5, 5, 4, 2, 2, 1]
	
	create_tail_attached_to(self, diameters)
