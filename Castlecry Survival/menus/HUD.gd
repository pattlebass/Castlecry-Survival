extends CanvasLayer

onready var player = get_parent().get_node("player")

func _process(delta):
	$Panel/HealthBar.value = player.health #Set bar to player health

func _input(event):
	if Input.is_action_just_pressed("inventory"):
		$inventory.visible = !$inventory.visible
		global.paused = !global.paused
