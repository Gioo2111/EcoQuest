extends Area2D

var trash := 1
@onready var coin_sfx = $coin_sfx as AudioStreamPlayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	$anim.play("collect")
	coin_sfx.play()
	await $CollisionShape2D.call_deferred("queue_free")
	Globals.trash += trash

func _on_anim_animation_finished() -> void:
	queue_free()
