extends Node2D

var is_selected = false
onready var inventory = get_parent()

func _process(delta):
	if is_selected:
		position = get_global_mouse_position() - $TextureButton.rect_size / 2

func _on_TextureButton_pressed():
	is_selected = true
	#$TextureButton.disabled = true
	inventory.item_selected = self
