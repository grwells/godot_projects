extends Node2D
export var player_position = Vector2(600, 600)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func new_game():
	$Board/Player.set_position(player_position)
	get_node("HUD/StartTimer").start()
	$HUD.set_center_label("Get Ready!")
	$HUD.show_center_label()

func _on_Player_death():
	# display death stuff on HUD 
	$HUD.set_center_label("GAME OVER")
	$HUD.show_center_label()

	$Board/EnemyManager.freeze_all()


func end_game():
	$HUD.set_center_label("TOTAL DOMINATION")
	$HUD.show_center_label()

	$Board/EnemyManager.freeze_all()
	get_tree().paused = true
