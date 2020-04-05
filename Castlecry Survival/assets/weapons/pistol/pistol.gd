extends "res://assets/weapons/gun.gd"

var properties = {"name":"Pistol", "texture":"res://menus/inventory/item icons/pistol.png", "primary":false, "secondary":true, "scene":"res://assets/weapons/pistol/pistol.tscn", "weapon":true}

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		var bullet = bullet_scene.instance()
		bullet.global_position = $Position2D.global_position
		print($Position2D.global_position)
		bullet.rotation = rotation
		global.game.add_child(bullet)
