extends Node2D
@onready var OBSTACLE = preload("res://Scenes/obstacles.tscn")
var compteur = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#put the screen on full mode
	get_viewport().get_window().mode = get_viewport().get_window().MODE_EXCLUSIVE_FULLSCREEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if compteur < 20:
	#	var obstacle = OBSTACLE.instantiate()
	#	obstacle.position = Vector2(rng.randf_range(0, get_viewport_rect().size.x),rng.randf_range(0, get_viewport_rect().size.y))
	#	add_child(obstacle)
	#compteur = compteur + 1
