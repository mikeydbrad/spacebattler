extends KinematicBody2D

export (PackedScene) var LaserBeamE

const MOVE_SPEED = 120
var velocity = Vector2(-1, 0)

func _ready():
	if (.has_node("CruiserFireTimer")):
		# Enemy might be EnemyCruiser or EnemyScout
		# only one of them has a cruiserfiretimer
		# QUESTION: better way to do this?
		randomize()
		var time = randf() + 0.5
		# generates a random float from 0.0-1.0, then adds 0.5 so it will be
		# atleast > 0.5s fire speed
		$CruiserFireTimer.wait_time = time # change timer's time
		$CruiserFireTimer.start() # start the timer

func hit():
	queue_free()

func _physics_process(delta):
	velocity = velocity.normalized() * MOVE_SPEED
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit"):
			# if the enemyship collides with something that has a hit() method,
			# trigger it!
			collision.collider.hit()
		else:
			# hits the left or right wall
			var collider = collision.normal
			position.y += 30
			velocity = collider

func _on_CruiserFireTimer_timeout():
	shoot()

func shoot():
	var laser = LaserBeamE.instance()
	laser.start($Barrel.global_position, rotation + PI / 2)
	
	get_parent().add_child(laser)
