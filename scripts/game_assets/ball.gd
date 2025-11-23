extends CharacterBody2D

@export var speed = 600.0

signal ball_collision(collider: Node)
const MAX_BOUNCES_PER_FRAME := 1
const REMAINDER_EPS := 0.001
var dir: Vector2 = Vector2(0.25, -1).normalized()
var rng:= RandomNumberGenerator.new()

func _ready() -> void:
	rng.seed = Time.get_ticks_usec()

# Called every frame. 'dt' is the elapsed time since the previous frame.
func _physics_process(dt: float) -> void:
	velocity = dir * speed
	var remainder := velocity * dt
	
	# Process multiple impacts in one frame, up to the max impact limit
	var bounces := 0
	while bounces < MAX_BOUNCES_PER_FRAME and remainder.length() > REMAINDER_EPS:
		var hit := move_and_collide(remainder, true, true, true)
		if hit:
			var travel := hit.get_travel()
			if travel.length() > 0.0:
				move_and_collide(travel, false, true, true)
			var collider_obj := hit.get_collider()
			var collider: Node = collider_obj if collider_obj is Node else null
			if collider.is_in_group("player"):
				remainder = collideWithPlayer(hit)
			else:
				remainder = collideWithBody(hit)
			ball_collision.emit(collider)
			bounces += 1
		else:
			move_and_collide(remainder, false, true, true)
			remainder = Vector2.ZERO
			
func copysign(a: float, b: float) -> float:
	if b >= 0:
		return a
	else:
		return -a
		
func collideWithBody(hit: KinematicCollision2D) -> Vector2:
	var n := hit.get_normal()
	dir = dir.bounce(n).normalized()
	var rem := hit.get_remainder()
	velocity = dir * speed
	return rem
	
func collideWithPlayer(hit: KinematicCollision2D) -> Vector2:
	var collider = hit.get_collider()
	var player: Node2D = collider if collider is Node2D else null
	var hit_pos = position.x
	var player_center = player.position.x
	var half_w = player.paddle_width / 2
	var offset = (hit_pos - player_center) / half_w
	var max_angle = deg_to_rad(60)
	var bounce_angle = offset * max_angle
	
	dir = Vector2(sin(bounce_angle), -cos(bounce_angle)).normalized()
	
	var rem := hit.get_remainder()
	return rem
