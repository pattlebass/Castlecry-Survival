extends "res://assets/weapons/gun.gd"

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		var bullet = bullet_scene.instance()
		bullet.global_position = $Position2D.global_position
		bullet.rotation = rotation
		#global.game.add_child(bullet)
		get_parent().get_parent().add_child(bullet)
