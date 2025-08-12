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
	if("pool" in obstacle):
		obstacle.pool = pool
	
func _Rocket(obstacle, _positionPlayer: Vector2, _positionSpawn: Vector2):
	obstacle.position = _positionSpawn
	obstacle.look_at(_positionPlayer)
func _getPositionPlayer():
	_positionPlayer = _player.global_position
	pass

func _randomPositionObstacle():
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 50  # khoảng cách spawn ngoài màn hình
	
	var side = randi() % 4  # 0: trái, 1: phải, 2: trên, 3: dưới
	match side:
		0: # trái
			_positionSpawn = Vector2(-margin, randf() * screen_size.y)
		1: # phải
			_positionSpawn = Vector2(screen_size.x + margin, randf() * screen_size.y)
		2: # trên
			_positionSpawn = Vector2(randf() * screen_size.x, -margin)
		3: # dưới
			_positionSpawn = Vector2(randf() * screen_size.x, screen_size.y + margin)

func _spawnRandomObstacle():
	var types = ["straight","rocket"]
	var type = types[randi() % types.size()]
	var obstacle = pool.get_obstacle(type)
	_getPositionPlayer()
	_randomPositionObstacle()
	if(type == "straight"):
		_Straight(obstacle,_positionPlayer, _positionSpawn)
	if(type == "rocket"):
		if(obstacle.has_method("fire")):
			obstacle.fire(pool,_player)
	pass
	


func _process(delta):
	if _isSpawn:
		time += delta
		if time >= spawn_interval:
			time = 0.0
			_spawnRandomObstacle()
	pass
