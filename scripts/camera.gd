extends Camera2D

var player

func start_following(player_node):
	player = player_node
	set_process(true)

func _process(delta):
	if player:
		global_position = player.global_position
