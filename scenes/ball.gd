extends AnimatableBody2D

const SPEED = 500
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = Vector2(0,-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + (direction * SPEED * delta)
		
