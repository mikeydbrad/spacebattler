extends Node

export (PackedScene) var EnemyScout
export (PackedScene) var EnemyCruiser
export (PackedScene) var Player

var score

func _ready():
	spawn_player()

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
	$EnemySpawnTimer.stop()
	$MainMenu.visible = true
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()
	var lasers = get_tree().get_nodes_in_group("lasers")
	for laser in lasers:
		laser.queue_free()
	spawn_player()

func start_game():
	$EnemySpawnTimer.start()
	print("start game")
	score = 0
	# choose new starting position for players ship

func spawn_player():
	var player = Player.instance()
	player.position = $PlayerStartPos.position
	player.rotation_degrees = -90
	add_child(player)
