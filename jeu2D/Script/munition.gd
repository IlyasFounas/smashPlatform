extends RigidBody2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#translate(Vector2(1,0)*15)
func _physics_process(delta):
	translate(Vector2(1,0)*15)

func _on_timer_timeout():
	queue_free()
