extends Area2D

var target: RigidBody2D;
var _speed: float = 250.0;
var _time_life: float = 5.0;
var _isChase: bool = false;
var _damage: int = 10;
var pool: ObstanclePool
@export var type:String = "rocket"
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	if target:
		_isChase = false
	
	pass # Replace with function body.

func fire(new_pool: ObstanclePool,new_target: RigidBody2D):
	target = new_target
	pool = new_pool
	_isChase = true
	var t = create_tween()
	t.tween_interval(_time_life)
	t.tween_callback(Callable(self, "_return_to_pool"))

func _return_to_pool():
	if pool:
		pool.return_obstacle(type, self)
	_isChase = false
	target = null
	
func chase(delta):
	var desired_angle = (target.global_position - global_position).angle()
	rotation = lerp_angle(rotation, desired_angle, 3.0 * delta) # 5.0 là tốc độ xoay

	# Tiến về phía trước theo hướng hiện tại
	position += Vector2.RIGHT.rotated(rotation) * _speed * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_body_entered(body: Node):
	if(body.name == "player"):
		if(body.has_method("take_damage")):
			body.take_damage(10)
			_return_to_pool()


func _process(delta):
	if _isChase:
		chase(delta)
	pass
