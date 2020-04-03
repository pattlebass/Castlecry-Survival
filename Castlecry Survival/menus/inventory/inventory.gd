extends Control

var slots = {}

var item_selected = null

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
			var start_pos = $HBoxContainer/VBoxContainer/Panel/VBoxContainer/position.get_global_transform_with_canvas().get_origin()
			slot.position = start_pos + Vector2(v, h) * 50
			
			add_child(slot)
