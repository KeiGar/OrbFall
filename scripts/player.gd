extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var dir = 0
	if Input.is_action_pressed("player_moveLeft"): dir = -1
	if Input.is_action_pressed("player_moveRight"): dir = 1
	
	velocity.x = dir * SPEED
	

	move_and_slide()
