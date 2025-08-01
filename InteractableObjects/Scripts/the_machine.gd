extends Node3D

@onready var bulbMarker: Marker3D = $bulbMarker


var heldBulb : Lightbulb

func interaction(player : CharacterBody3D):
	if player.call("getHeldObject") is Lightbulb:
		heldBulb = player.call("getHeldObject")
		player.call("place", self)
		
		heldBulb.disable()


func _process(delta: float) -> void:
	if heldBulb != null:
		heldBulb.global_position = lerp(heldBulb.global_position, bulbMarker.global_position, 5 * delta)
		heldBulb.rotation_degrees = lerp(heldBulb.rotation_degrees, Vector3(-90, 0, 0), 5 * delta)
