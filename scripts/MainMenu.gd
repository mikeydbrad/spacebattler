extends MarginContainer

func _process(_delta):
	if visible && Input.is_action_just_pressed("ui_accept"):
		get_parent().start_game()
		visible = false
		$MenuMusic.stop()
