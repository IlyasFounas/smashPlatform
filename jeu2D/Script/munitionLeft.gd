extends RigidBody2D

func _physics_process(delta):
	translate(Vector2(-1,0)*15)

func _on_timer_timeout():
	queue_free()
