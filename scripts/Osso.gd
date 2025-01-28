extends CharacterBody2D


const JUMP_VELOCITY = -400.0

@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer
@onready var enemy_score := 1000

var is_hurted := false
var direction := -1
var health := 6

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()
	
func _on_anim_animation_finished(anim_name):
	if anim_name == "dead":
			Globals.score += enemy_score
			queue_free()
			
func take_damage(amount: int) -> void:
	health -= amount
	if health > 0:
		anim.play("hurt")
		await get_tree().create_timer(.6).timeout
		anim.play("Idle")
	else:
		anim.play("die") 

func _on_hitbox_body_entered(body):
	if body.is_in_group("player_attack"):
		take_damage(1)
