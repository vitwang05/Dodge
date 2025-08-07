extends Node2D

@export var _sprite: Sprite2D;
@export var _speed: float = 0.0;
@export var _rotationSpeed:float = 0.0;
@export var type:String = "sraight"
var direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2.RIGHT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(global_rotation_degrees)
	#print(_sprite.global_rotation_degrees)
	_sprite.rotation += _rotationSpeed * delta;
	global_position += direction * _speed * delta;
	pass
