extends Control

const MAX_PLAYERS = 5
const PORT = 5555


func _on_host_pressed():
	Network.create_server(PORT, MAX_PLAYERS)


func _on_join_pressed():
	Network.create_client('127.0.0.1', PORT)
