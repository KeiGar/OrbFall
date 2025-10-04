extends Area2D

@export var SPEED = 600
var direction
@onready var boundary_left: ShapeCast2D = $"../BoundaryLeft"
@onready var boundary_right: ShapeCast2D = $"../BoundaryRight"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var randX = randf_range(-1,1)
	var randY = randf_range(-1,1)
	direction = Vector2(randX,randY).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + (direction * SPEED * delta)
	if boundary_left.is_colliding():
		direction = Vector2(1, direction.y).normalized()
	if boundary_right.is_colliding():
		direction = Vector2(-1, direction.y).normalized()

func _on_body_entered(body: Node2D) -> void:
	direction = Vector2(direction.x, -1).normalized()

func _on_area_entered(area: Area2D) -> void:
	var ydir = 0
	var xDir = randf_range(-1,1)
	if area.position.y >= position.y:
		ydir = randf_range(-1,-.5)
	else:
		ydir = randf_range(.5,1)
	direction = Vector2(xDir, ydir).normalized()
