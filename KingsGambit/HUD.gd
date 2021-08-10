extends CanvasLayer

var score

func init():
	score = 0
	$ScoreLabel.show()


func set_center_label(label_text):
	$CenterLabel.text = label_text

func increment_score():
	if score == null:
		score = 1

	score += 1
	$ScoreLabel.text = str(score)

func increase_score(num):
	score += num
	$ScoreLabel.text = str(score)

func show_center_label():
	$Mask.show()
	$CenterLabel.show()

func hide_center_label():
	$Mask.hide()
	$CenterLabel.hide()

func _on_StartTimer_timeout():
	hide_center_label()
	init()

func _on_Player_hit():
	# TODO: screen flash
	pass
