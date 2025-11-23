extends Area2D

signal killzone_hit

func _on_area_entered(area: Area2D) -> void:
	killzone_hit.emit()
