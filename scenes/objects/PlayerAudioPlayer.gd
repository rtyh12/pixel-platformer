extends Node


@export var streams: Array[AudioStream]

var asr = AudioStreamRandomizer.new()

func _ready() -> void:
	for stream in streams:
		asr.add_stream(-1, stream)
	var r = asr.instantiate_playback()

# func play_sword():
# 	asr.play
