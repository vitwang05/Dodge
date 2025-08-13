extends  Resource
class_name PlayerStats

@export var max_health: int = 100
var current_health: int = max_health

@export var speed: float = 200.0
@export var damage: int = 10

func take_damage(amount: int):
	current_health = max(current_health - amount, 0)

func heal(amount: int):
	current_health = min(current_health + amount, max_health)

func is_dead() -> bool:
	return current_health <= 0
