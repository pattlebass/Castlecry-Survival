extends StaticBody2D

export var properties = {"name":"Pistol", "texture":"", "scene":"", "weapon":false}

func _ready():
	if properties["scene"]:
		properties = load(properties["scene"]).instance().properties
	$Sprite.texture = load(properties["texture"])
