extends Area2D
var red_outline_path = "res://art/KingsGambit_tiles/shield_notready.png"
var shield_tile_path = "res://art/KingsGambit_tiles/shield.png"

onready var shield = load(shield_tile_path)
onready var shield_outline_red = load(red_outline_path)
onready var offset = self.position.length()

func _process(delta):
	var angle = self.position.angle_to(self.get_parent().last_velocity)
	self.position = self.position.rotated(angle)
	self.rotation = self.position.angle() + (PI / 2)


func activate():
	# show shield, detect collisions
	$Sprite.set_texture(shield)
	$Sprite.visible = true 
	get_node("CollisionShape2D").set_deferred("disabled", false)
	if $CollisionShape2D.is_disabled():
		print("[activate] Shield is disabled")
	else:
		print("[activate] Shield is enabled")


func deactivate():
	# hide shield, stop detecting collisions
	$Sprite.visible = false
	get_node("CollisionShape2D").set_deferred("disabled", true)
	if $CollisionShape2D.is_disabled():
		print("[deactivate] Shield is disabled")
	else:
		print("[deactivate] Shield is enabled")


func ready():
	# show symbol to indicate the shield is ready
	$Sprite.set_texture(shield_outline_red)
	$Sprite.visible = true


func _on_RechargeTimer_timeout():
	ready()
