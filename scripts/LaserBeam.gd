extends KinematicBody2D

const LASER_SPEED = 300
var velocity

func _ready():
	# change SFX play to when the instance is spawned
	$SFX.play()

func start(pos, dir):
	# choose where the laser starts
	position = pos
	rotation = dir
	velocity = Vector2(LASER_SPEED, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit"):
			# if the laser collides with something that has a hit() method,
			# trigger it!
			collision.collider.hit()
		# also trigger the laser's hit method
		hit()

func hit():
	# might be redundant, but is here for future expansion of the laser being hit
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	# if the laser goes off-screen, delete it
	queue_free()
