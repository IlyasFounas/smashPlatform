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
var userLeft = false
var life = 3
var compteurLife = 0

func _on_ready():
	get_child(1).visible = false
	get_child(2).visible = false
	get_child(3).visible = false
	get_child(4).visible = false
	get_child(5).visible = false

func _physics_process(delta):
	get_parent().get_child(15).get_child(3).get_child(0).text = str(compteurLife)
	if life > 0:
		if position.x > 1920:
			life = life -1 
			position = Vector2(300,300)
		if position.y > 1080:
			life = life -1
			position = Vector2(300,300)
		if position.y < 0 :
			life = life - 1
			position = Vector2(300,300)
			
	if life == 0:
		get_parent().get_child(14).get_child(3).get_child(0).text = "Death"
	#the user can jump 3 time in row if he want
	if compteurJump < 2:
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept"):
			if !Input.is_action_just_pressed("ui_q"):
				if userLeft :
					get_child(1).visible = false
					get_child(2).visible = false
					get_child(3).visible = true
					get_child(4).visible = false
					get_child(5).visible = false
				else : 
					get_child(1).visible = false
					get_child(2).visible = true
					get_child(3).visible = false
					get_child(4).visible = false
					get_child(5).visible = false
			elif !Input.is_action_just_pressed("ui_d"):
				if userLeft :
					get_child(1).visible = false
					get_child(2).visible = false
					get_child(3).visible = true
					get_child(4).visible = false
					get_child(5).visible = false
				else : 
					get_child(1).visible = false
					get_child(2).visible = true
					get_child(3).visible = false
					get_child(4).visible = false
					get_child(5).visible = false
			velocity.y = JUMP_VELOCITY
			compteurJump = compteurJump + 1
		if Input.is_action_just_pressed("ui_z"):
			if !Input.is_action_just_pressed("ui_q"):
				get_child(1).visible = false
				get_child(2).visible = false
				get_child(3).visible = true
				get_child(4).visible = false
				get_child(5).visible = false
			elif !Input.is_action_just_pressed("ui_d"):
				get_child(1).visible = false
				get_child(2).visible = false
				get_child(3).visible = true
				get_child(4).visible = false
				get_child(5).visible = false
			velocity.y = JUMP_VELOCITY
			compteurJump = compteurJump + 1

			
	#when the user is on a surface/background/enemie he gain 3 jumpd 
	if is_on_floor(): 
		compteurJump = 0

	#the user go down if he press s
	if Input.is_action_just_pressed('ui_s'):
		velocity.y += gravity * 1.2
		get_child(1).visible = false
		get_child(2).visible = false
		get_child(3).visible = false
		get_child(4).visible = false
		get_child(5).visible = true
		if is_on_floor():
			get_child(1).visible = false
			get_child(2).visible = false
			get_child(3).visible = true
			get_child(4).visible = false
			get_child(5).visible = false
		
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
	
	if Input.is_action_just_pressed('ui_q'):
		userLeft = true
		if is_on_floor():
			get_child(1).visible = false
			get_child(2).visible = false
			get_child(3).visible = false
			get_child(4).visible = true
			get_child(5).visible = false
		if !is_on_floor(): 
			get_child(1).visible = false
			get_child(2).visible = false
			get_child(3).visible = true
			get_child(4).visible = false
			get_child(5).visible = false
	
	if Input.is_action_just_pressed('ui_d'):
		userLeft = false
		if is_on_floor():
			get_child(1).visible = true
			get_child(2).visible = false
			get_child(3).visible = false
			get_child(4).visible = false
			get_child(5).visible = false
		if !is_on_floor(): 
			get_child(1).visible = false
			get_child(2).visible = true
			get_child(3).visible = false
			get_child(4).visible = false
			get_child(5).visible = false
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.pressed == true:
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
				
	elif event is InputEventKey:
		match event.keycode:
			70:
				# F
				if event.is_pressed():
					var shield = SHIELD.instantiate()
					shield.position = position
					get_parent().add_child(shield)
			

