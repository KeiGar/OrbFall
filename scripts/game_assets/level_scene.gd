extends Node2D
signal game_over
signal increment_points(incr: int)

const points_increment = 10

func _on_ball_ball_collision(collider: Node) -> void:
	if collider.has_method("on_ball_hit"):
		collider.on_ball_hit()
		increment_points.emit(points_increment)

func _on_killzone_body_entered(body: Node2D) -> void:
	game_over.emit()
