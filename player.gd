extends KinematicBody2D

var velocity = Vector2.ZERO #Used in every method
var speed = 400 #Used in every method
var target_position : Vector2 #Only used in mouse click movement
var gravity = 2000 #Only used in platformer movement
var jump_force = 750 #Only used in platformer movement
var friction = 0.1 #Only used in advanced platformer movement
var acceleration = 0.25 #Only used in advanced platformer movement
onready var animation = $AnimationPlayer
onready var sprite = $Sprite

func _physics_process(delta: float) -> void:
	#Choose your movement method here. Be sure to include delta in the parentheses.
	advanced_platformer_movement(delta)

func eight_way_movement(delta: float):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x += -1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y += -1
	
	velocity = velocity.normalized() * speed
	#Godot's built in way to move things	
	velocity = move_and_slide(velocity)
func eight_way_movement_look(delta: float)-> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x += -1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y += -1
	
	velocity = velocity.normalized() * speed
	#Godot's built in way to move things	
	velocity = move_and_slide(velocity)
	look_at(position + velocity)
func mouse_click_movement(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		target_position = get_global_mouse_position()
	velocity = position.direction_to(target_position) * speed
	velocity = velocity.normalized()*speed
	if position.distance_to(target_position)>5: #The greater than 5 here prevents a strange error where the character flickers back and forth
		velocity = move_and_slide(velocity)
func mouse_click_movement_look(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		target_position = get_global_mouse_position()
	velocity = position.direction_to(target_position) * speed
	velocity = velocity.normalized()*speed
	if position.distance_to(target_position)>5: #The greater than 5 here prevents a strange error where the character flickers back and forth
		velocity = move_and_slide(velocity)
	look_at(target_position)
func platformer_movement(delta:float) -> void:
	#Direction is -1 if moving left, 1 if moving right
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	#Allow the player to jump with up if they are on the floor (feel free to change to space, but make sure you add the input under Project -> Project Settings -> Input Map
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = -jump_force #Jump force is negative here because the negative y direction is upward
	velocity.x = direction*speed #Feel free to change speed at the top
	velocity.y += gravity*delta #Effect the player by gravity - feel free to change the value at the top
	velocity = move_and_slide(velocity, Vector2.UP) #Move the player by the calculated velocity
#This includes acceleration and friction, which are more difficult to deal with but allow for more precise and controlled movement.
#Coyote time could also be included here, and jump buffering
func advanced_platformer_movement(delta:float) -> void:
	#Direction is -1 if moving left, 1 if moving right
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	#Allow the player to jump with up if they are on the floor (feel free to change to space, but make sure you add the input under Project -> Project Settings -> Input Map
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = -jump_force #Jump force is negative here because the negative y direction is upward
	
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration) #Speed up linearly with acceleration
	else:
		velocity.x = lerp(velocity.x, 0, friction) #Slow down linearly with friction
	
	velocity.y += gravity*delta #Effect the player by gravity - feel free to change the value at the top
	velocity = move_and_slide(velocity, Vector2.UP) #Move the player by the calculated velocity

func _process(delta):
	if Input.is_action_pressed("left"):
		animation.play("running")
		sprite.flip_h = true
	elif Input.is_action_pressed("right"):
		animation.play("running")
		sprite.flip_h = false
	else: 
		animation.play("New Anim")
