extends Node
@export var player: RigidBody2D

var type_map: String = "topdown";
func _ready():
	change_map(type_map)

func _process(delta):
	if(Input.is_action_just_pressed("toggle_map")):
		if type_map == "topdown":
			type_map = "sidescroll"
			change_map(type_map)
		else:
			type_map = "topdown"
			change_map(type_map)

func change_map(map_type: String):
	match map_type:
		"topdown":
			player.config_resource = load("res://Resource/player_config_topdown.tres")
			player.set_controller("res://Scripts/Player/player_topdown.gd")
		"sidescroll":
			player.config_resource = load("res://Resource/player_config_sidescroll.tres")
			player.set_controller("res://Scripts/Player/player_sidescroll.gd")

