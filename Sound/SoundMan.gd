extends Node
var Music: AudioStreamPlayer
var CharacterTalk1: AudioStreamPlayer
var Char1Played: bool = false
var CharacterTalk2: AudioStreamPlayer
var Char2Played: bool = false
@export var TimerLabel: Label3D
var speakerMan: Node3D
var speaker1anim: AnimationPlayer
var speaker2anim: AnimationPlayer
var speaker3anim: AnimationPlayer
var speaker4anim: AnimationPlayer

func _ready() -> void:
	Music = self.get_child(0)
	Music.set_autoplay(true)
	CharacterTalk1 = self.get_child(1)
	CharacterTalk2 = self.get_child(2)
	speakerMan = self.get_parent().find_child("SpeakerMan", true)
	speaker1anim = speakerMan.find_child("Speakers").find_child("AnimationPlayer")
	speaker2anim = speakerMan.find_child("Speakers2").find_child("AnimationPlayer")
	speaker3anim = speakerMan.find_child("Speakers3").find_child("AnimationPlayer")
	speaker4anim = speakerMan.find_child("Speakers4").find_child("AnimationPlayer")

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
	
	if CharacterTalk1.playing || CharacterTalk2.playing:
		if not speaker1anim.is_playing():
			speaker1anim.play("playingSpeaker")
			speaker2anim.play("playingSpeaker")
			speaker3anim.play("playingSpeaker")
			speaker4anim.play("playingSpeaker")
