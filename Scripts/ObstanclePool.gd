extends Node


class_name ObstanclePool

const OBSTACLE_TYPES = {
	"straight": preload("res://Scenes/Straight.tscn"),
	"rocket": preload("res://Scenes/rocket.tscn")
}

var pools: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for name in OBSTACLE_TYPES:
		pools[name] = [];
		_prepopulate(name, 10)
	pass # Replace with function body.

func _prepopulate(obstacle_type: String, amount: int):
	var scene = OBSTACLE_TYPES[obstacle_type]
	for i in range(amount):
		var instance = scene.instantiate();
		instance.visible = false
		instance.set_physics_process(false)
		pools[obstacle_type].append(instance)
		add_child(instance)

func get_obstacle(obstacle_type: String) -> Node2D:
	var pool = pools[obstacle_type]
	if pool.size() > 0:
		var obj = pool.pop_back()
		obj.visible = true
		obj.set_physics_process(true)
		return obj
	else:
		var obj = OBSTACLE_TYPES[obstacle_type].instantiate()
		add_child(obj)
		return obj

func return_obstacle(obstacle_type: String, obj: Node2D):
	obj.visible = false
	obj.set_physics_process(false)
	pools[obstacle_type].append(obj)
