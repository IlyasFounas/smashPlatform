extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(float(get_parent().get_child(14).get_child(3).get_child(0).text)) > 50:
		print(get_parent().get_child(14).get_child(3).get_child(0).push_color(Color(1,1,0,0))
	
