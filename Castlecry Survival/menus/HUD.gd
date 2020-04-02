extends CanvasLayer

onready var player = get_parent().get_node("player")

func _process(delta):
	$Panel/HealthBar.value = player.health #Set bar to player health
