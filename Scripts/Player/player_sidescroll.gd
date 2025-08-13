extends Node

var player: RigidBody2D
var config
var is_dashing := false
var dash_time_left := 0.0
var dash_cooldown_left := 0.0
var dash_direction := Vector2.ZERO
var last_facing_dir := Vector2.RIGHT

@onready var anim: AnimatedSprite2D = player.get_node("AnimatedSprite2D")

func _ready():
	player.gravity_scale = 1

func _physics_process(delta):
	var direction = Vector2.ZERO
	

