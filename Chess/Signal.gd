extends Node2D

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func on_Timer_timeout():
	$Sprite.visible = !$Sprite.visible 

# Declare your own signal!
# This code will not run and does nothing, should throw error
signal my_signal(value, other_value)

func _ready():
	emit_signal("my_signal", true, 42)
