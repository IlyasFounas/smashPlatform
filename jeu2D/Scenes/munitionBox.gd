extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	pass


func _on_area_2d_body_entered(body):
	
	if body.get_name() == "user":
		queue_free()
		if body.get_parent().compteurMunitionBox > 0:
			body.get_parent().compteurMunitionBox = body.get_parent().compteurMunitionBox - 1
		body.compteurMunition = 0
		
	
