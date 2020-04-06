extends "res://assets/weapons/gun.gd"

func _ready():
	properties = {
		"name":"Pistol",
		"texture":"res://menus/inventory/item icons/pistol.png",
		"weapon":true,
		"scene":"res://assets/weapons/pistol/pistol.tscn",
		"primary":false,
		"secondary":true,
		"damage":20,
		"damage_dropoff":5,
		"delay":0.3,
		"automatic":true
	}
