extends Node

var player_scene = preload("res://scenes/player.tscn")
var camera
var trash := 0
var score := 0
var player_life := 3
var player = null
var current_checkpoint = null

#func _ready():
	#connect("player_has_died", Callable(self, "_on_player_has_died"))
	
func respawn_player():
	#if player:
		#player.queue_free() 
		#
	#player = player_scene.instantiate()
	#
	if current_checkpoint != null:
		player.global_position = current_checkpoint.global_position
	#else:
		#player.global_position = Vector2(0, 0)
		#
	#get_tree().root.add_child(player)
	##player.connect("player_has_died", Callable(self, "_on_player_has_died"))
	##player._reset_state()
	#if camera:
		#camera.start_following(player)
		#
	#print("Player respawned.")
	#
#func _on_player_has_died():
	#print("Player has died signal received.")
	#respawn_player()
	#
##func _on_player_respawned():
	##print("Player has respawned.")
#func set_current_checkpoint(checkpoint):
	#current_checkpoint = checkpoint
