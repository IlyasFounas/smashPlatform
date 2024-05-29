extends Node2D
@onready var OBSTACLE = preload("res://Scenes/obstacles.tscn")
@onready var MUNITION_BOX = preload("res://Scenes/munitionBox.tscn")
var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene

var compteur = 0
var rng = RandomNumberGenerator.new()
var compteurMunitionBox = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#put the screen on full mode
	#get_viewport().get_window().mode = get_viewport().get_window().MODE_EXCLUSIVE_FULLSCREEN
	pass

# Called every frame. 'delta' is the elapsed time sincd e the previous frame.
func _process(delta):
	pass
	#if compteur < 20:
	#	var obstacle = OBSTACLE.instantiate()
	#	obstacle.position = Vector2(rng.randf_range(0, get_viewport_rect().size.x),rng.randf_range(0, get_viewport_rect().size.y))
	#	add_child(obstacle)
	#compteur = compteur + 1


func _on_timer_timeout():
	if compteurMunitionBox < 6:
		var muntion_box = MUNITION_BOX.instantiate()
		muntion_box.position = Vector2(rng.randf_range(400, 800),rng.randf_range(0, get_viewport_rect().size.y))
		add_child(muntion_box)
		compteurMunitionBox = compteurMunitionBox +1


func _on_host_pressed():
	peer.create_server(1027)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player()
	$CanvasLayer.hide()

func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)


func _on_join_pressed():
	peer.create_client("127.0.0.1",1027)
	multiplayer.multiplayer_peer = peer
	$CanvasLayer.hide()
	
func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)
	
	
func del_player(id):
	rpc("_del_player",id)
	
@rpc("any_peer","call_local")
func _del_player(id):
	get_node(str(id)).queue_free()
