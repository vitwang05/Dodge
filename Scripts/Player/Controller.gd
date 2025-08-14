extends RigidBody2D

@export var stats:PlayerStats;
@export var default_controller: String = "res://Scripts/Player/player_topdown.gd"
@export var config_resource: Resource

var controller: Node
# Called when the node enters the scene tree for the first time.

func _ready():
	set_controller(default_controller)
	pass # Replace with function body.

func take_damage(damage: int):
	stats.take_damage(damage)
	print(stats.current_health)
	if stats.is_dead():
		print("game over")

func set_controller(controller_script_path: String):
	var old_pos = position
	var old_vel = linear_velocity
	
	# Xóa controller cũ
	if controller and controller.get_parent() == self:
		remove_child(controller)
		controller.queue_free()

	# Load script mới
	var new_controller = load(controller_script_path).new()
	new_controller.player = self
	new_controller.config = config_resource
	add_child(new_controller)
	controller = new_controller
	
	# Khôi phục vị trí và velocity
	position = old_pos
	linear_velocity = old_vel



