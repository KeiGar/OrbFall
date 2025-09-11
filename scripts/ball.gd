extends Area2D

const SPEED = 250
var direction

@onready var ray_top_left: RayCast2D = $RayTopLeft
@onready var ray_bottom_left: RayCast2D = $RayBottomLeft


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var randX = randf_range(-1,1)
	var randY = randf_range(-1,1)
	direction = Vector2(randX,randY)
	direction = direction.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir
	if ray_bottom_left.is_colliding():
		dir = -1
		direction = Vector2(randf_range(-1,1), dir).normalized()
	if ray_top_left.is_colliding():
		dir = 1
		direction = Vector2(randf_range(-1,1), dir).normalized()
		
	position = position + (direction * SPEED * delta)
		
