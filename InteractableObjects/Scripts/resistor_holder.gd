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
		#heldResistor.setPosition(resistor_marker.position)


func _process(delta: float) -> void:
	if heldResistor != null:
		heldResistor.global_position = lerp(heldResistor.global_position, resistor_marker.global_position, 5 * delta)
		heldResistor.rotation_degrees = lerp(heldResistor.rotation_degrees, Vector3(0, 0, -90), 5 * delta)
