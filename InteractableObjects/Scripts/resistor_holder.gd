extends Node3D

@onready var resistor_marker: Marker3D = $ResistorMarker


var heldResistor : Resistor

func interaction(player : CharacterBody3D):
	if player.call("getHeldObject") is Resistor:
		heldResistor = player.call("getHeldObject")
		player.call("place", self)
		
		heldResistor.disable()
		heldResistor.setPosition(resistor_marker.position)
