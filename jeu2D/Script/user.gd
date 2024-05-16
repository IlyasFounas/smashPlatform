extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var MARIO_JUMP = preload("res://Ressources/marioJump.png")
@onready var MUNITION = preload("res://Scenes/munition.tscn")
@onready var SHIELD = preload("res://Scenes/shield.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var compteurJump = 0
var compteurMunition = 0

func _physics_process(delta):
	#the user can jump 3 time in row if he want
	if compteurJump < 2:
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			compteurJump = compteurJump + 1
		if Input.is_action_just_pressed("ui_z"):
			velocity.y = JUMP_VELOCITY
			compteurJump = compteurJump + 1
			
	#when the user is on a surface/background/enemie he gain 3 jumpd 
	if is_on_floor(): 
		compteurJump = 0
		
	#the user go down if he press s
	if Input.is_action_just_pressed('ui_s'):
		velocity.y += gravity * 1.2
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_q", "ui_d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.pressed == true:
			if compteurMunition < 6:
				var munition = MUNITION.instantiate()
				munition.position = position
				get_parent().add_child(munition)
				compteurMunition = compteurMunition + 1
				
	elif event is InputEventKey:
		match event.keycode:
			70:
				# F
				if event.is_pressed():
					var shield = SHIELD.instantiate()
					shield.position = position
					get_parent().add_child(shield)
			

