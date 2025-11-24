extends StaticBody2D

@export var max_health: int = 1
@export var particle_lifetime: float = 1.6
@onready var brick_destruction_particles: GPUParticles2D = $BrickDestructionParticles
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var polygon: Polygon2D = $Polygon2D
var current_health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brick_destruction_particles.lifetime = particle_lifetime
	brick_destruction_particles.emitting = false
	current_health = max_health

func on_ball_hit() -> void:
	current_health -= 1
	if current_health <= 0:
		brick_destruction_particles.emitting = true
		polygon.visible = false
		collision_shape.disabled = true
		await get_tree().create_timer(particle_lifetime).timeout
		queue_free()	
