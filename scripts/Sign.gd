extends Area2D

@export var messages : Array[String] = []

@onready var panel = $panel
@onready var messagelabel = $panel/messagelabel

@onready var current_message_index := 0

func _ready():
	panel.visible = true
	messagelabel.visible = true
	if messages.size() > 0:
		messagelabel.text = messages[current_message_index]
	else:
		print("No messages to display!")

func _on_player_interaction():
	if messages.size() == 0:
		return # Não faz nada se não houver mensagens
	panel.visible = true
	messagelabel.visible = true
	messagelabel.text = messages[current_message_index]

func _on_advance_message():
	if messages.size() == 0:
		return # Não faz nada se não houver mensagens
	if current_message_index < messages.size() - 1:
		current_message_index += 1
	else:
		_on_hide_message()
	messagelabel.text = messages[current_message_index]

func _on_hide_message():
	panel.visible = false
	messagelabel.visible = false
	current_message_index = 0
	if messages.size() > 0:
		messagelabel.text = messages[current_message_index]
