extends Node2D


signal did_sword_attack

@export var animatedSprite: AnimatedSprite2D
@export var characterBody: Node2D
@export var playerController: Node

var can_attack = true
var cooldown = 0.5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_attack()

func _attack() -> void:
	if not can_attack:
		return
	can_attack = false

	did_sword_attack.emit()

	var clickPosition = get_global_mouse_position()
	var facingLeft = clickPosition.x < characterBody.global_position.x
	animatedSprite.flip_h = facingLeft
	animatedSprite.play()
	# TODO refactor facing to bools everywhere
	playerController._set_facing(Values.Facing.LEFT if facingLeft else Values.Facing.RIGHT)

	await get_tree().create_timer(cooldown).timeout
	can_attack = true