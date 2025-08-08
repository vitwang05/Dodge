extends RigidBody2D

var _Gravity = 0;
@export var _speed:float = 500.0;

@export var _dashSpeed:float = 800.0;
@export var _dashDuration := 0.2;
@export var _dashCooldown := 0.5;
# Called when the node enters the scene tree for the first time.

var is_dashing := false
var dash_time_left := 0.0
var dash_cooldown_left := 0.0
var dash_direction := Vector2.ZERO


func _ready():
	gravity_scale = _Gravity;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.ZERO
	if(!is_dashing):
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_down"):
			direction.y += 1
		if Input.is_action_pressed("move_up"):
			direction.y -= 1
	
	if dash_cooldown_left > 0:
		dash_cooldown_left -= delta
	if is_dashing:
		dash_time_left -= delta
		position += dash_direction * _dashSpeed * delta
		if dash_time_left <= 0:
			is_dashing = false
			dash_cooldown_left = _dashCooldown
			
	if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_left <= 0:
		is_dashing = true
		dash_direction = direction if direction != Vector2.ZERO else Vector2.RIGHT
		dash_time_left = _dashDuration
	# Chuẩn hóa hướng để tốc độ không vượt mức khi đi chéo
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	position += direction * _speed * delta;
