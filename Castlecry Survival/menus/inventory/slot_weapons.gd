extends "res://menus/inventory/slot.gd"


func _ready():
	inventory = get_parent().get_parent().get_parent().get_parent().get_parent()
