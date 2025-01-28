extends Area2D

var is_active = false
@onready var anim = $anim
@onready var marker_2d = $Marker2D
@onready var cp_sfx = $cp_sfx
	
func _on_body_entered(body):
	if body.name != "player" or is_active:
		return
	activate_checkpoint()

func activate_checkpoint():
	Globals.current_checkpoint = marker_2d
	cp_sfx.play()
	anim.play("check")
	is_active = true

func _on_anim_animation_finished():
	if anim.animation == "check":
		anim.play("finish")
