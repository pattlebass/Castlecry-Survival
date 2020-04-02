extends Node2D

var damage = 20
var damage_dropoff = 5

var bullet_scene = preload("res://assets/weapons/bullet.tscn")

func _process(delta):
	look_at(get_global_mouse_position())
