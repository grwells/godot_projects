extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("original position = %d" % self.position.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# called when input event is generated
func _input(event):
	print(event.as_text())

	var amount = 5
	if Input.is_key_pressed(KEY_W):
		self.position += Vector2(0, -amount)

	if Input.is_key_pressed(KEY_S):
		self.position += Vector2(0, amount)

	if Input.is_key_pressed(KEY_A):
		self.position += Vector2(-amount, 0)

	if Input.is_key_pressed(KEY_D):
		self.position += Vector2(amount, 0)

