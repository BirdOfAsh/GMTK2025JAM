extends Node
var Music: AudioStreamPlayer
var CharacterTalk1: AudioStreamPlayer
var Char1Played: bool = false
var CharacterTalk2: AudioStreamPlayer
var Char2Played: bool = false
@export var TimerLabel: Label3D

func _ready() -> void:
	Music = self.get_child(0)
	Music.set_autoplay(true)
	CharacterTalk1 = self.get_child(1)
	CharacterTalk2 = self.get_child(2)

func _process(_delta: float) -> void:
	if Music.playing == false:
		#Start music from begining
		Music.play(0.0)
	
	if TimerLabel.get_time() <= 60 && Char1Played == false:
		CharacterTalk1.play(0.0) 
		Char1Played = true
	
	if TimerLabel.get_time() <= 30 && Char2Played == false:
		CharacterTalk2.play(0.0) 
		Char2Played = true
