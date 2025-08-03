extends Node3D

@onready var resistor_marker: Marker3D = $ResistorMarker
@onready var particle: GPUParticles3D = $GPUParticles3D2
@onready var particle1: GPUParticles3D = $GPUParticles3D
var heldResistor : Resistor
@export var startEmission: bool = true

func _ready() -> void:
	particle.set_emitting(startEmission)
	particle1.set_emitting(startEmission)

func interaction(player : CharacterBody3D):
	if player.call("getHeldObject") is Resistor:
		heldResistor = player.call("getHeldObject")
		player.call("place", self)
		particle.set_emitting(false)
		particle1.set_emitting(false)
		
		SignalBussin.emit_signal("increaseCompletedPuzzle")


func _process(delta: float) -> void:
	if heldResistor != null:
		heldResistor.global_position = lerp(heldResistor.global_position, resistor_marker.global_position, 5 * delta)
		heldResistor.rotation_degrees = lerp(heldResistor.rotation_degrees, Vector3(0, 0, -90), 5 * delta)
