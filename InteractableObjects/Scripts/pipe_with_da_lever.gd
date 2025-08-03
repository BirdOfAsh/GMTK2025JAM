extends RigidBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var lever : MeshInstance3D = $Lever
@onready var shimmer : ShaderMaterial = preload("res://shaders/shimmerMat.tres")
@onready var particle : GPUParticles3D = $GPUParticles3D


@export var canUse : bool = false



func _ready() -> void:
	if canUse:
		particle.emitting = true


func interaction(_player : CharacterBody3D):
	if canUse:
		animation_player.play("LeverAction")
		disable()
		
		particle.emitting = false
		
		SignalBussin.emit_signal("increaseCompletedPuzzle")


func disable():
	set_collision_layer_value(2, false)


func enableShimmer():
	if canUse:
		lever.material_overlay = shimmer


func disableShimmer():
	if canUse:
		lever.material_overlay = null
