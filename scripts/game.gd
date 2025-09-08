extends Node2D

@export var stack_scene: PackedScene
@export var stack_size: int = 8
@export var stack_spacing: float = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(stack_size):
		var stack = stack_scene.instantiate()
		stack.scale = Vector2(40,40)
		stack.position = Vector2(-i * stack_spacing * stack.scale.x, 0)
		stack.position.x += 450
		add_child(stack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
