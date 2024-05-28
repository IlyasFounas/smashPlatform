extends RigidBody2D

var initialVelocity = Vector2.ZERO

func _physics_process(delta):
	linear_velocity = initialVelocity*1000

func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.get_name().contains("user"):
		body.compteurLife = body.compteurLife + 10
	queue_free()	
