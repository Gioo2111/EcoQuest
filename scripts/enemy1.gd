extends CharacterBody2D

const SPEED = 1300.0
const JUMP_VELOCITY = -400.0

@onready var wall_detector := $wall_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim = $anim as AnimationPlayer
@onready var enemy_score := 250

var direction := -1
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
		
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
			
	velocity.x = direction * SPEED * delta
	move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Hurt":
		Globals.score += enemy_score
		queue_free()
