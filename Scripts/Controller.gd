extends RigidBody2D

var _Gravity = 0;
@export var _speed:float = 500.0;
# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = _Gravity;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	# Chuẩn hóa hướng để tốc độ không vượt mức khi đi chéo
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	position += direction * _speed * delta;
