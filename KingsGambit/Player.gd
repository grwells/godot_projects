extends Area2D

signal death
signal hit

export var health = 100
export var speed = 400
export var dash_speed = 1000

export var shield_duration = 0.5
export var shield_recharge = 1.0
var screen_size
var GameManager # reference to Main.gd
var shield_ready = true
var store_speed
var last_velocity = Vector2()

func _ready():
	$ShieldArea2D.ready()
	self.set_name("Player")
	screen_size = get_viewport_rect().size
	GameManager = $Main
	store_speed = speed
	
	# Move player to coordinates passed to this function
func set_position(pos):
	position = pos


func _process(delta):
	var velocity = Vector2()

	if Input.is_key_pressed(KEY_W):
		velocity.y -= 1

	if Input.is_key_pressed(KEY_S):
		velocity.y += 1

	if Input.is_key_pressed(KEY_A):
		velocity.x -= 1

	if Input.is_key_pressed(KEY_D):
		velocity.x += 1


	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		last_velocity = velocity

	position += velocity * delta # increment player position with spped * time
	# make sure player does not travel outside screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			if shield_ready: 
				$CollisionShape2D.disabled = true # player invulnerable while dashing
				$ShieldArea2D.activate()
				$ShieldArea2D/DurationTimer.start(shield_duration)
				speed = dash_speed
				$ShieldArea2D.set_process(true)
				shield_ready = false
				
func _on_RechargeTimer_timeout():
	shield_ready = true


func _on_DurationTimer_timeout():
	$CollisionShape2D.disabled = false # player vulnerable again
	$ShieldArea2D.deactivate()
	$ShieldArea2D/RechargeTimer.start(shield_recharge)
	$ShieldArea2D.set_process(false)
	speed = store_speed

func _on_Player_body_entered(body):
	if body.is_in_group("Enemy"):
		print("player hit by enemy")
		damage(20)

func damage(amount):
	emit_signal("hit")
	health -= amount
	print("hit, health = " + str(health))

	if health <= 0:
		print("you are dead!")
		death()

func death():
	emit_signal("death")
	# play death sound
	queue_free()


func _on_Player_area_entered(area):
	if area.is_in_group("Enemy_Projectile"):
		print("player hit by projectile")
		damage(5)
