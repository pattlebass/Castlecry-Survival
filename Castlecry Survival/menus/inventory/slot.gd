extends Node2D

var item
onready var inventory = get_parent()

func _ready():
	$Label.text = name

func _on_TextureButton_pressed():
	if Input.is_action_pressed("left_click"):
		if inventory.item_selected && not item: #check if there is a held item and if slot is empty
			if name == "Primary" or name == "Secondary":
				if not inventory.item_selected.properties["weapon"]:
					return
				if inventory.item_selected.properties[name.to_lower()]:
					var weapon_scene = load(inventory.item_selected.properties["scene"])
					global.player.get_node("weapons").add_child(weapon_scene.instance())
					store_item()
			else:
				store_item()
		elif not inventory.item_selected and item: #check of there is no item selected and if there is an item in the slot
			if name == "Primary" or name == "Secondary":
				remove_weapon()
				remove_item()
			else:
				remove_item()
	elif Input.is_action_pressed("right_click"):
		if item:
			if name == "Primary" or name == "Secondary":
				remove_weapon()
				throw_item()
			else:
				throw_item()
func store_item():
	inventory.item_selected.is_selected = false #set item's "selected" variable to false
	inventory.item_selected.position = global_position #set position of the item to the slot
	item = inventory.item_selected #set slot held item
	inventory.item_selected = null #set held item to null

func remove_item():
	inventory.item_selected = item #set item held to item in the slot
	item.is_selected = true #set item to is selected
	item = null #set slot item to null

func throw_item():
	inventory.throw_item(item)
	item.queue_free()
	item = null
	
func remove_weapon():
	for i in global.player.get_node("weapons").get_children():
		if i.properties[name.to_lower()]:
			i.queue_free()
