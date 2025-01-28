extends Node2D

@onready var texture = $texture
@onready var area_sign = $area_sign

const lines : Array[String] = [
	"Olá, aventureiro!",
	"O meio ambiente está ameaçado e precisa de alguém consciente e destemido para salvá-lo.",
	"Use as teclas direcionais para andar pelo mapa e espaço para pular.",
	"Faça sua parte coletando o lixo espalhado e eliminando os inimigos poluentes.",
	"Boa jornada!",
]

func _unhandled_input(R):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if R.is_action_pressed("Interact") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, lines)
	else:
		texture.hide()
		if DialogManager.is_message_active && R.is_action_pressed("advance_message"):
			DialogManager._unhandled_input(R)  # Encaminha o evento para o DialogManager
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
