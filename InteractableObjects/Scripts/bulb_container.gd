extends Node3D

@onready var bulbMarker: Marker3D = $BulbMarker
@onready var electricParts: GPUParticles3D = $GPUParticles3D
var heldBulb : Lightbulb

func _ready() -> void:
	electricParts.emitting = true

func interaction(player : CharacterBody3D):
	if player.call("getHeldObject") is Lightbulb:
		heldBulb = player.call("getHeldObject")
		player.call("place", self)
		heldBulb.switchBulbMesh(false)
		electricParts.emitting = false
		SignalBussin.emit_signal("increaseCompletedPuzzle")


func _process(delta: float) -> void:
	if heldBulb != null:
		heldBulb.global_position = lerp(heldBulb.global_position, bulbMarker.global_position, 5 * delta)
		heldBulb.rotation_degrees = lerp(heldBulb.rotation_degrees, Vector3(0, 0, 0), 5 * delta)
