extends Node3D

@onready var resistor_marker: Marker3D = $ResistorMarker


var heldResistor : Resistor

func interaction(player : CharacterBody3D):
	if player.call("getHeldObject") is Resistor:
		heldResistor = player.call("getHeldObject")
		player.call("place", self)
		
		heldResistor.disable()
		#heldResistor.setPosition(resistor_marker.position)


func _process(delta: float) -> void:
	if heldResistor != null:
		heldResistor.global_position = lerp(heldResistor.global_position, resistor_marker.global_position, 5 * delta)
		heldResistor.rotation_degrees = lerp(heldResistor.rotation_degrees, Vector3(0, 0, -90), 5 * delta)
