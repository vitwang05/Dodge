extends Node

@export var _player:RigidBody2D;
@export var obstancle_pool: NodePath;
var pool:ObstanclePool;

var _positionSpawn:Vector2 = Vector2(0,0);
var _positionPlayer:Vector2 = Vector2(0,0);

var _isSpawn: bool = false;
var spawn_interval := 3.0
var time: = 0.0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pool = get_node(obstancle_pool)
	_isSpawn = true;
	pass # Replace with function body.

func _Straight(obstacle, _positionPlayer: Vector2, _positionSpawn: Vector2):
	
	obstacle.position = _positionSpawn
	obstacle.look_at(_positionPlayer)
	obstacle.direction = Vector2.RIGHT.rotated(obstacle.rotation)
	
func _getPositionPlayer():
	_positionPlayer = _player.global_position
	pass

func _randomPositionObstacle():
	_positionSpawn = Vector2(randi() % 800, randi() % 400)
	pass
func _spawnRandomObstacle():
	var types = ["straight"]
	var type = types[randi() % types.size()]
	var obstacle = pool.get_obstacle(type)
	_getPositionPlayer()
	_randomPositionObstacle()
	if(type == "straight"):
		_Straight(obstacle,_positionPlayer, _positionSpawn)
	pass
	

func _process(delta):
	if _isSpawn:
		time += delta
		if time >= spawn_interval:
			time = 0.0
			_spawnRandomObstacle()
	pass
