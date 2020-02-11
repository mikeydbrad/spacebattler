extends KinematicBody2D

export (PackedScene) var LaserBeamE

const MOVE_SPEED = 90
var velocity = Vector2(-1, 0)

func _ready():
	if ($CruiserFireTimer):
		$CruiserFireTimer.start()

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
