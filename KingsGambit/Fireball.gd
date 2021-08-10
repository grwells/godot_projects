extends Area2D

class_name Fireball, "res://art/KingsGambit_tiles/fireball_1-2.png"

export var speed = 300
export var damage = 10
export var target = Vector2(0, 0)
export var tracking = false

var direction
var hud 

func _ready():
	hud = get_node("/root/Main/HUD")

func _physics_process(delta):
	if direction == null:
		direction = self.position.direction_to(target).normalized()

	position += direction * speed * delta


func _on_Fireball_body_entered(body):
	#print("[body] fireball hit by " + body.name)
	if body.name != "Player":
		hud.increment_score()
	death()

func _on_Fireball_area_entered(area):
	#print("[area] fireball hit by " + area.name)
	if area.name != "Player":
		hud.increment_score()
	death()


func _on_VisibilityNotifier2D_screen_exited():
	hud.increment_score()
	queue_free()

func death():
	self.queue_free()
