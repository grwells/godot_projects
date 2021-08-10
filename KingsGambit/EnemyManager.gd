extends Node

var num_enemies = 6

func freeze_all():
	get_tree().paused = true
	pause_mode = Node.PAUSE_MODE_PROCESS

func decrement_enemies():
	num_enemies -= 1

	if num_enemies <= 0:
		get_node("/root/Main").end_game()