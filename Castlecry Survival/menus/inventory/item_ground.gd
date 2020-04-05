extends StaticBody2D

var properties = {"name":"Pistol", "texture":"res://menus/inventory/item icons/pistol.png", "primary":false, "secondary":true, "scene":"res://assets/weapons/pistol/pistol.tscn", "weapon":true}

func _ready():
	$Sprite.texture = load(properties["texture"])
