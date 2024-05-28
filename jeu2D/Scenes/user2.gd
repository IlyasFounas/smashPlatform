extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var compteurJump = 0
var compteurMunition = 0
@onready var MUNITION = preload("res://Scenes/munition.tscn")
@onready var SHIELD = preload("res://Scenes/shield.tscn")
var userLeft = false
var compteurLife = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _on_ready():
	get_child(1).play("walk_right")
	get_child(2).play("stop")

func _physics_process(delta):
	# Add the gravity.

	if not is_on_floor():
		velocity.y += gravity * delta
		if Input.is_action_just_pressed('ui_left'):
			userLeft = true
			get_child(1).play("stop")
			get_child(2).play("mouvement_up_left")
		if Input.is_action_just_pressed('ui_right'):
			userLeft = false
			get_child(1).play("stop")
			get_child(2).play("mouvement_up_right")
	if compteurJump < 3:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
			if not Input.is_action_just_pressed('ui_right') && not Input.is_action_just_pressed('ui_left'):
				get_child(2).play("mouvement_up_right")
			compteurJump = compteurJump + 1
	if is_on_floor():
		compteurJump = 0
		get_child(2).play("stop")
		if Input.is_action_just_pressed('ui_left'):
			userLeft = true
			get_child(1).play("walk_left")
		if Input.is_action_just_pressed('ui_right'):
			userLeft = false
			get_child(1).play("walk_right")
		if Input.is_action_just_pressed('ui_down'):
			get_child(1).play("mouvement_right")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _input(event):	
	if event is InputEventKey:
		match event.keycode:
			77: 
				if event.pressed == true:
					if compteurMunition < 6:
						var munition = MUNITION.instantiate()
						if userLeft :
							munition.position = position
							munition.position.x = munition.position.x - 50
							munition.initialVelocity = Vector2(-1,0)
							get_parent().add_child(munition)
							compteurMunition = compteurMunition + 1
						else :
							munition.position = position
							munition.position.x = munition.position.x + 50
							munition.initialVelocity = Vector2(1,0)
							get_parent().add_child(munition)
							compteurMunition = compteurMunition + 1
