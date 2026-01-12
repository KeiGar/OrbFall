extends Node2D
@onready var brick_tiles: TileMapLayer = $BrickTiles
@onready var ball: CharacterBody2D = $Ball
signal game_over
signal increment_points(incr: int)

const points_increment = 10

func _on_ball_ball_collision(collider: Node) -> void:
	if collider.has_method("on_ball_hit"):
		collider.on_ball_hit()
		increment_points.emit(points_increment)

func _on_killzone_body_entered(body: Node2D) -> void:
	game_over.emit()
	
func get_ball_position() -> Vector2:
	return ball.position
