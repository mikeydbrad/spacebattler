extends AnimatedSprite

func _ready():
	pass

func _on_Visiblity_screen_exited():
	queue_free()
