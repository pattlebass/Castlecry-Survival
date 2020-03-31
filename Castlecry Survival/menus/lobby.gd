extends CanvasLayer

func _ready():
	Network.connect("server_created", self, "_on_ready_to_play")
	Network.connect("join_success", self, "_on_ready_to_play")
	Network.connect("join_fail", self, "_on_join_fail")
	
func _on_host_pressed():
	Network.server_info.used_port = int($Panel_server/LineEdit_port_host.text)
	Network.server_info.max_players = int($Panel_server/SpinBox_max_players.value)
	
	Network.create_server(Network.server_info.used_port, Network.server_info.max_players)
	
func _on_join_pressed():
	Network.create_client($Panel_join/LineEdit_IP.text, int($Panel_join/LineEdit_Port_join.text))

func _on_ready_to_play():
	get_tree().change_scene("res://game.tscn")

func _on_join_fail():
	print("Failed to join server")
