extends AudioStreamPlayer2D

func _ready():
	var audio_stream = preload("res://Novo/mosquito_sfx.wav") as AudioStream
	self.stream = audio_stream
	self.connect("finished", Callable(self, "_on_audio_finished"))
	self.play()

func _on_audio_finished():
	self.play()
