extends Area2D

const SPEED = 250
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = Vector2(0,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + (direction * SPEED * delta)
		
func _on_body_entered(body: Node2D) -> void:
	print("Ball collided with player!")
	direction = -direction
