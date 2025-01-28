extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer
@onready var ground_detector = $ground_detector
@export var limit := 30
@onready var enemy_score := 500
@onready var mosquito_sfx = $mosquito_sfx

var initial_position: Vector2
var vertical_direction := -1
var upper_limit: float
var lower_limit: float

func _ready() -> void:
	initial_position = position
	upper_limit = initial_position.y - limit / 2
	lower_limit = initial_position.y + limit / 2
	ground_detector.enabled = true
	mosquito_sfx.play()

func _physics_process(delta: float) -> void:
	velocity.y += vertical_direction * SPEED * delta
	if position.y <= upper_limit:
		vertical_direction = 1
	elif position.y >= lower_limit:
		vertical_direction = -1
	if ground_detector.is_colliding() and vertical_direction == 1:
		vertical_direction = -1
		
	move_and_slide()

func _on_anim_animation_finished(anim_name):
	if anim_name == "Hurt":
		mosquito_sfx.stop()
		Globals.score += enemy_score
		queue_free()

