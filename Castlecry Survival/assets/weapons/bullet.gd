extends KinematicBody2D

var speed = 1000
var damage = 0

func _physics_process(delta):
	
	if move_and_collide(Vector2.RIGHT.rotated(rotation) * speed * delta):
		var collider = move_and_collide(Vector2.RIGHT.rotated(rotation) * speed * delta).collider
		if collider.is_in_group("enemies"):
			collider.health -= damage
			queue_free()
	if global.player.global_position.distance_to(global_position) > 1500:
		queue_free()
