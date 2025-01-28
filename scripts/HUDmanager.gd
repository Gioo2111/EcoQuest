extends Control

@onready var trashcount = $container/trashcount/trashcount as Label
@onready var scorecount = $container/scorecount/scorecount as Label
@onready var lifecount = $container/lifecount/lifecount as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	trashcount.text = str("%04d" % Globals.trash)
	scorecount.text = str("%06d" % Globals.score)
	lifecount.text = str("%02d" % Globals.player_life)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	trashcount.text = str("%04d" % Globals.trash)
	scorecount.text = str("%06d" % Globals.score)
	lifecount.text = str("%02d" % Globals.player_life)
