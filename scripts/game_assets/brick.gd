extends StaticBody2D

@export var max_health: int = 1
var current_health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health

func on_ball_hit() -> void:
	current_health -= 1
	if current_health <= 0:
		queue_free()	
