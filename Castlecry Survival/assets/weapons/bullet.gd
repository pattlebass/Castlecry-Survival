extends KinematicBody2D

var speed = 1000

func _physics_process(delta):
	move_and_slide(Vector2.RIGHT.rotated(rotation) * speed)
	if global.player.global_position.distance_to(global_position) > 1500:
		queue_free()
