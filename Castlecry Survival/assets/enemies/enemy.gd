extends KinematicBody2D

var health = 50

func _physics_process(delta):
	look_at(global.player.position)
	if health <= 0:
		queue_free()
