extends Area2D

@export var radius: float = 25.0
@export var damage: int = 50
@export var delay_before_explode: float = 3.0
@export var lifetime: float = 0.8
@export var sound_volume_db: float = -3.0

@onready var particles = $CPUParticles2D
@onready var anim = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = true
	if particles:
		particles.emitting = false
	var t = create_tween()
	t.tween_interval(delay_before_explode)
	t.tween_callback(Callable(self, "explode"))

func explode():
	$CollisionShape2D.disabled = false	
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		shape.radius = radius
		pass
		
	if particles:
		particles.one_shot = true
		
	pass # Replace with function body.
	apply_damage()
	
	var t = create_tween()
	t.tween_interval(lifetime)
	t.tween_callback(Callable(self, "queue_free"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func apply_damage():
	var bodies = get_overlapping_bodies()
	for b in bodies:
		if b.has_method("take_damage"):
			b.take_dame(damage)
		elif b.has_meta("health"):
			var h = b.get_meta("health")
			b.set_meta("health", h - damage)
	pass
func _process(delta):
	pass
