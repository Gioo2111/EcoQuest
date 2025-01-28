extends CharacterBody2D


const SPEED = 1300.0
const JUMP_VELOCITY = -400.0

@onready var wall_detector := $wall_detector as RayCast2D
@onready var ground_detector := $ground_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer

@onready var enemy_score := 350

var direction := -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
		update_raycasts()
		
		
	if !ground_detector.is_colliding():
		direction *= -1
		update_raycasts()
		
		
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
			
	velocity.x = direction * SPEED * delta

	move_and_slide()
	
func update_raycasts():
	wall_detector.position.x = direction * abs(wall_detector.position.x)
	ground_detector.position.x = direction * abs(ground_detector.position.x)

func _on_anim_animation_finished(anim_name):
	if anim_name == "Hurt":
		Globals.score += enemy_score
		queue_free()
