extends Area2D

@export var _sprite: Sprite2D;
@export var _speed: float = 0.0;
@export var _rotationSpeed:float = 0.0;
@export var type:String = "straight"
var pool: ObstanclePool
var direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2.RIGHT
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node):
	if(body.name == "player"):
		var dist = global_position.distance_to(body.global_position)
		if dist < 120:
			if(body.has_method("take_damage")):
				body.take_damage(10)


func _return_to_pool():
	if pool:
		pool.return_obstacle(type, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_sprite.rotation += _rotationSpeed * delta;
	global_position += direction * _speed * delta;
	pass
