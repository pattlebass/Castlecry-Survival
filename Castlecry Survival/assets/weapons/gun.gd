extends Node2D

var can_shoot = true
var bullet_scene = preload("res://assets/weapons/bullet.tscn")

var properties = {
	"name":"",
	"texture":"",
	"weapon":true,
	"scene":"",
	"primary":false,
	"secondary":false,
	"damage":0,
	"damage_dropoff":0,
	"delay":0,
	"automatic":false
}

func _process(delta):
	look_at(get_global_mouse_position())
	if can_shoot && not global.paused:
		if properties["automatic"]:
			if Input.is_action_pressed("shoot"):
				shoot()
		else:
			if Input.is_action_just_pressed("shoot"):
				shoot()

func shoot():
	can_shoot = false
	var bullet = bullet_scene.instance()
	bullet.global_position = $Position2D.global_position
	bullet.rotation = rotation
	global.game.add_child(bullet)
	yield(get_tree().create_timer(properties["delay"]), "timeout")
	can_shoot = true
