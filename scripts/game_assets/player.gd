extends CharacterBody2D


const SPEED = 50000.0

func _physics_process(delta: float) -> void:
	var dir = 0
	if Input.is_action_pressed("player_moveLeft"): dir = -1
	if Input.is_action_pressed("player_moveRight"): dir = 1
	
	velocity.x = dir * SPEED * delta

	move_and_slide()
