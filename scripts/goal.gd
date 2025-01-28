extends Area2D

@export var next_level : String = ""
@onready var trans_sfx = $trans_sfx

func change_scene(path):
	assert(get_tree().change_scene_to_file(path) == OK)
	
func _on_body_entered(body):
	if body.name == "player" and !next_level == "":
		change_scene(next_level)
		trans_sfx.play()
	else:
		print("No scene")
