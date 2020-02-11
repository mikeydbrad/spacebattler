extends Node

export (PackedScene) var EnemyScout
export (PackedScene) var EnemyCruiser

var score

func _ready():
	pass

func _on_EnemySpawner_timeout():
	# on timer timeout, spawn enemy
	randomize()
	var enemy
	var r = (randi() % 5)
	if (r == 4):
		enemy = EnemyCruiser.instance()
	else:
		enemy = EnemyScout.instance()
	# make their spawn location the far right edge
	enemy.position = Vector2(224, 10)
	add_child(enemy)

func game_over():
	# reopen the main menu, but there will be a "you lost! score: ####"
	# new_game()
	pass

func new_game():
	score = 0
	# choose new starting position for players ship
	pass
