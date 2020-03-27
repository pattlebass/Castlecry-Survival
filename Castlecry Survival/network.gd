extends Node


func _ready():
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_on_disconnected_from_server")

func create_server(_port, _max_players):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(_port, _max_players)
	get_tree().network_peer = peer
	
	get_tree().change_scene("res://game.tscn")

func create_client(_ip, _port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(_ip, _port)
	get_tree().network_peer = peer
	
	get_tree().change_scene("res://game.tscn")


func _on_player_connected(id):
	print("Player connected: " + str(id))


# Everyone gets notified whenever someone disconnects from the server
func _on_player_disconnected(id):
	print("Player disconnected: " + str(id))


# Peer trying to connect to server is notified on success
func _on_connected_to_server():
	print("Connected to server")


# Peer trying to connect to server is notified on failure
func _on_connection_failed():
	print("Connection to server failed")


# Peer is notified when disconnected from server
func _on_disconnected_from_server():
	print("Disconnected from server")
