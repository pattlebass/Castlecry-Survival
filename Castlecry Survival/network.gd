extends Node

signal server_created                          # when server is successfully created
signal join_success                            # When the peer successfully joins a server
signal join_fail                               # Failed to join a server
signal player_list_changed                     # List of players has been changed

var players = {}

var server_info = {
	name = "Server",      # Holds the name of the server
	max_players = 0,      # Maximum allowed connections
	used_port = 5656         # Listening port
}


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

	emit_signal("server_created")
	
	# Register the server's player in the local player list
	register_player(Gamestate.player_info)

func create_client(_ip, _port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(_ip, _port)
	get_tree().network_peer = peer
	
	get_tree().change_scene("res://game.tscn")

remote func register_player(_player_info):
	if (get_tree().is_network_server()):
		# We are on the server, so distribute the player list information throughout the connected players
		for id in players:
			# Send currently iterated player info to the new player
			rpc_id(_player_info.net_id, "register_player", players[id])
			# Send new player info to currently iterated player, skipping the server (which will get the info shortly)
			if (id != 1):
				rpc_id(id, "register_player", _player_info)
	
	# Now to code that will be executed regardless of being on client or server
	print("Registering player ", _player_info.name, " (", _player_info.net_id, ") to internal player table")
	players[_player_info.net_id] = _player_info          # Create the player entry in the dictionary
	emit_signal("player_list_changed")     # And notify that the player list has been changed

func _on_player_connected(id):
	print("Player connected: " + str(id))


# Everyone gets notified whenever someone disconnects from the server
func _on_player_disconnected(id):
	print("Player disconnected: " + str(id))


# Peer trying to connect to server is notified on success
func _on_connected_to_server():
	emit_signal("join_success")
	# Update the player_info dictionary with the obtained unique network ID
	Gamestate.player_info.net_id = get_tree().get_network_unique_id()
	# Request the server to register this new player across all connected players
	rpc_id(1, "register_player", Gamestate.player_info)
	# And register itself on the local list
	register_player(Gamestate.player_info)


# Peer trying to connect to server is notified on failure
func _on_connection_failed():
	emit_signal("join_fail")
	get_tree().set_network_peer(null)


# Peer is notified when disconnected from server
func _on_disconnected_from_server():
	print("Disconnected from server")
