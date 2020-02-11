extends KinematicBody2D

export (PackedScene) var LaserBeamP

const MOVE_SPEED = 100
var velocity = Vector2()
var lastShot = "left" # will start shooting from the right barrel

var livesLeft = 3

func get_input():
	velocity = Vector2()
	var modifier = 0
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("accelerate"):
			modifier = 50
		move(1)
	elif Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("accelerate"):
			modifier = 50
		move(-1)
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
	velocity = velocity.normalized() * (MOVE_SPEED + modifier)

func move(direction):
	# direction = 1 // right
	# direction = 2 // left
	velocity.x = direction

func shoot():
	var laser = LaserBeamP.instance()
	if lastShot == "right":
		laser.start($LeftBarrel.global_position, rotation)
		lastShot = "left"
	elif lastShot == "left":
		laser.start($RightBarrel.global_position, rotation)
		lastShot = "right"
	
	get_parent().add_child(laser)

func hit():
	if (livesLeft > 0):
		livesLeft -= 1
		print("lost a life!")
	else:
		# trigger a game over
		# player ship destroyed
		# does the ship explode? or does a message appear?
		queue_free()
		get_parent().game_over()

func _physics_process(delta):
	get_input()
	var _collision = move_and_collide(velocity * delta)

