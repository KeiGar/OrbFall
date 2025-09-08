extends Node2D

@export var brick_scene: PackedScene
@export var stack_count: int = 8
@export var stack_spacing: float = 50.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(stack_count):
		var brick = brick_scene.instantiate()
		brick.position = Vector2(0, (-i * stack_spacing) / scale.y)
		add_child(brick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
