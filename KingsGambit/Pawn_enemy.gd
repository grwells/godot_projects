extends Area2D

signal killed

export (PackedScene) var Projectile

export var min_step = 400
export var max_step = 600 
export var speed = 200
var screen_size

var frozen = false
var moving = false
var dest = Vector2()

var rng = RandomNumberGenerator.new()

func _ready():
	screen_size = get_viewport_rect().size 
	self.connect("killed", get_node("/root/Main/HUD"), "increment_score")
	rng.randomize()
	$MoveTimer.start()
	dest = self.position

# Enemy is capable of 3 types of movement 
# 1) Wait (stay in spot for some amount of time)
# 2) Dodge (away from player or projectile)
# 3) Move to spot (towards player or not)
func start_new_action():
	var next_action = rng.randi_range(1, 2)

	moving = true
	if next_action == 0:
		stay()
	elif next_action == 1:
		advance()
	elif next_action == 2:
		attack()

func stay():
	print("stayed\n")
	dest = position

func advance():
	var rand_x = rng.randi_range(0, 7)
	var rand_y = rng.randi_range(0, 5)
	var step_length = 128
	var new_x = 192 + (rand_x * step_length)
	var new_y = 192 + (rand_y * step_length)
	dest = Vector2(new_x, new_y)

func attack():
	#print("shooting fireball\n")
	# shoot fireball at player
	var player = self.get_parent().get_parent().get_node("Player")
	# the distance from pawn to instance the fireball
	var offset = 100 				 	

	# add fireball to scene
	var fireball = Projectile.instance()
	fireball.target = player.position 		# location of player at this instant

	# add as child of pawn
	# spawn fireball under enemy manager so that it is not affected by pawn movement
	self.get_parent().add_child(fireball) 
	# place fireball at pawn's position and in the direction of the player * offset distance
	fireball.position = self.position + (self.position.direction_to(fireball.target) * offset) 

	# point fireball at player
	fireball.rotation = fireball.position.angle_to_point(fireball.target) + (PI / 2)



func set_freeze(val):
	frozen = val

func get_freeze():
	return frozen 

func _process(delta):
	if moving && !frozen:
		if position.distance_to(dest) > 20: 
			position = position.move_toward(dest, delta*speed)
		else:
			position = dest
			moving = false 

#func _on_AttackTimer_timeout():
#	self.attack()

func _on_MoveTimer_timeout():
	if !moving: 
		start_new_action()


# if colliding with player, damage player 
# if colliding with projectile, kill
func _on_Pawn_enemy_body_entered(body):
	# check body type
	print("Pawn_enemy hit by " + body.name)
	if body.is_in_group("Player_Projectile"): 
		emit_signal("killed")
		death()

func death():
	get_node("/root/Main/HUD").increase_score(2)
	get_parent().decrement_enemies()
	queue_free()

func _on_Pawn_enemy_area_entered(area):
	# check body type
	print("Pawn_enemy hit by " + area.name)
	if area.is_in_group("Player_Projectile"): 
		emit_signal("killed")
		death()
