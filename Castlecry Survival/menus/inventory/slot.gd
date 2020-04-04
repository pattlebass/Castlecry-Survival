extends Node2D

var item
onready var inventory = get_parent()

func _on_TextureButton_pressed():
	if Input.is_action_pressed("left_click"):
		if inventory.item_selected && not item: #check if if there is a held item and if slot is empty
			inventory.item_selected.is_selected = false #set item's "selected" variable to false
			inventory.item_selected.position = position #set position of the item to the slot
			item = inventory.item_selected #set slot held item
			inventory.item_selected = null #set held item to null
		elif not inventory.item_selected and item: #check of there is no item selected and if there is an item in the slot
			inventory.item_selected = item #set item held to item in the slot
			item.is_selected = true #set item to is selected
			item = null #set slot item to null
	elif Input.is_action_pressed("right_click"):
		inventory.throw_item(item)
		item.queue_free()
		item = null
	
