extends Node3D

@onready var resistor_marker: Marker3D = $ResistorMarker
@onready var particle: GPUParticles3D = $GPUParticles3D2
@onready var particle1: GPUParticles3D = $GPUParticles3D
var heldResistor : Resistor

func interaction(player : CharacterBody3D):
	if player.call("getHeldObject") is Resistor:
		heldResistor = player.call("getHeldObject")
		player.call("place", self)
		particle.set_emitting(true)
		particle1.set_emitting(true)
		heldResistor.disable()
		heldResistor.setPosition(resistor_marker.position)
