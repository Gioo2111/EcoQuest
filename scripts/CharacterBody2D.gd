extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var is_hurted := false
var direction = Input.get_axis("ui_left", "ui_right")
var knockback_vector := Vector2.ZERO
var knockback_power := 20
var minimum_height = 450
var active_sign : Area2D = null

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D
@onready var jump_sfx = $Jump_sfx as AudioStreamPlayer
@onready var interaction = $interaction

signal player_has_died()

func _ready():
	pass

func _physics_process(delta):
	if global_position.y > minimum_height:
		emit_signal("player_has_died")
		queue_free()
		
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jump_sfx.play()
	elif is_on_floor():
		is_jumping = false

	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
		
	_set_state()
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
			
func _process(delta):
	if Input.is_action_just_pressed("Interact"):
		var signs_in_range = interaction.get_overlapping_areas()
		for area in signs_in_range:
			if area.is_in_group("Signs"):
				if active_sign != area:
					if active_sign:
						active_sign._on_hide_message()
					active_sign = area
					area._on_player_interaction()
					
func _unhandled_input(event):
	if event.is_action_pressed("Interact") and active_sign != null:
		active_sign._on_advance_message()
	
func _on_hurbox_body_entered(body: Node2D) -> void:
	var knockback = Vector2((global_position.x - body.global_position.x) * knockback_power, -200)
	take_damage(knockback)
	
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	if Globals.player_life > 0:
		Globals.player_life -= 1
	else:
		queue_free()
		emit_signal("player_has_died")
		
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
	if get_tree():
		var knockback_tween := get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.self_modulate = Color(1, 0, 0, 1)
		knockback_tween.tween_property(animation, "self_modulate", Color(1, 1, 1, 1), duration)
	
	is_hurted = true
	await get_tree().create_timer(.3).timeout
	is_hurted = false
	
func _set_state():
	var state = "default"
	
	if !is_on_floor():
		state = "Jump"
	elif direction != 0:
		state = "Run"

	if is_hurted:
		state = "hurt"
		
	if animation.name != state:
		animation.play(state)
