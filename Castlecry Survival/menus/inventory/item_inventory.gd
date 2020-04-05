extends Node2D

var properties = {"name":"dummy", "texture":"res://menus/inventory/item icons/icon.png"}

var is_selected = false
onready var inventory = get_parent()

func _ready():
	print(properties)
	$TextureButton.texture_normal = load(properties["texture"])

func _process(delta):
	if is_selected:
		#set position of item to mouse pos
		position = get_global_mouse_position() - $TextureButton.rect_size / 2

func _on_TextureButton_pressed():
	select_item()
func select_item():
	if not inventory.item_selected: #check if there is a held item
		is_selected = true
		#$TextureButton.disabled = true #disable item button
		inventory.item_selected = self #set held item to self
