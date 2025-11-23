extends CharacterBody2D
@onready var paddle_shape: Polygon2D = $PaddleShape

@export var paddle_width: float = 200
@export var paddle_height: float = 50

const SPEED = 50000.0

func _ready() -> void:
	var hw = paddle_width / 2
	var hh = paddle_height / 2
	if paddle_shape.polygon.size() == 4:
		paddle_shape.polygon[0] = Vector2(-hw, -hh)
		paddle_shape.polygon[1] = Vector2(hw, -hh)
		paddle_shape.polygon[2] = Vector2(hw, hh)
		paddle_shape.polygon[3] = Vector2(-hw, hh)

func _physics_process(delta: float) -> void:
	var dir = 0
	if Input.is_action_pressed("player_moveLeft"): dir = -1
	if Input.is_action_pressed("player_moveRight"): dir = 1
	
	velocity.x = dir * SPEED * delta

	move_and_slide()
