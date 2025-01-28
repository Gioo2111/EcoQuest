extends Node2D

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://scenes/player.tscn")
@onready var camera := $camera as Camera2D

func _ready():
	#GlobalAudioStreamPlayer.play_music_level()
	Globals.player = player
	Globals.player.player_has_died.connect(reload_game)
	Globals.player.follow_camera(camera)
	Globals.player_life = 3

func reload_game():
	var player_new = player_scene.instantiate()
	add_child(player_new)
	Globals.player = player_new
	Globals.player.player_has_died.connect(reload_game)
	Globals.player.follow_camera(camera)
	Globals.player_life = 3
	Globals.respawn_player()
