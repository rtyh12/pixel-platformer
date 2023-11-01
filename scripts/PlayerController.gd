extends Node


@export var physics_body: Node2D
@export var speed: float

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		physics_body.position.x += speed
	if Input.is_action_pressed("ui_left"):
		physics_body.position.x -= speed
