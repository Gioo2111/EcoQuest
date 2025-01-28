extends Area2D

@onready var water = $water as AnimatedSprite2D
@onready var collision = $collision as CollisionShape2D

func _on_body_entered(body):
	if body.name == "player" && body.has_method("take_damage"):
		body.take_damage(Vector2(0, - 250))
