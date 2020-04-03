extends Node2D

var item
onready var inventory = get_parent()

func _on_TextureButton_pressed():
	if inventory.item_selected && !item:
		inventory.item_selected.is_selected = false
		inventory.item_selected.position = position
		item = inventory.item_selected
