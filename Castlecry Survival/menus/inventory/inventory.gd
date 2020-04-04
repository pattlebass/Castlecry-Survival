extends Control

var slots = {}

var item_selected = null

onready var GroundList = $HBoxContainer/VBoxContainer2/PanelGround/VBoxContainer2/ItemList
var items_on_ground = []

func _ready():
	var slot_scene = preload("res://menus/inventory/slot.tscn")
	for v in 9:
		for h in 5:
			#naming
			var slot = slot_scene.instance()
			slot.name = "slot_v%sh%s" % [v, h]
			slot.get_node("Label").text = "v%sh%s" % [v, h]
			
			#adds it to the dictionary
			slots[slot.name] = slot
			
			#position
			var start_pos = $HBoxContainer/VBoxContainer/PanelInventory/VBoxContainer/position.get_global_transform_with_canvas().get_origin()
			slot.position = start_pos + Vector2(v, h) * 50
			
			add_child(slot)

#items on ground
func _on_body_entered(body):
	if body.is_in_group("ground_items"):
		GroundList.add_item(body.properties.name, load(body.properties.texture))
		items_on_ground.append(body)
func _on_body_exited(body):
	if body.is_in_group("ground_items"):
		GroundList.remove_item(items_on_ground.find(body))
		items_on_ground.remove(items_on_ground.find(body))
func _on_ItemList_item_selected(index):
	if not item_selected:
		var ground_properties = items_on_ground[index].properties
		items_on_ground[index].queue_free()
		
		var item_inventory = load("res://menus/inventory/item_inventory.tscn").instance()
		add_child(item_inventory)
		move_child(item_inventory, 0)
		item_inventory.select_item()
		
func throw_item(_item):
	var _item_ground = load("res://menus/inventory/item_ground.tscn").instance()
	_item_ground.global_position = global.player.position
	_item_ground.properties = _item.properties
	global.game.add_child(_item_ground)
	
