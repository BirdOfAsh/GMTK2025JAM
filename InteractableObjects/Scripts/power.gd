extends RigidBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var handle: MeshInstance3D = $Handle

@onready var shimmer : ShaderMaterial = preload("res://shaders/shimmerMat.tres")

var part1: GPUParticles3D
var part2: GPUParticles3D

var powerManager: Node

func _ready() -> void:
	part1 = self.find_child("GPUParticles3D")
	part2 = self.find_child("GPUParticles3D2")
	powerManager = self.get_parent().find_child("PowerManager")

func interaction(_player : CharacterBody3D):
	if powerManager != null:
		animation_player.play("Cube_005Action")
		part1.emitting = false
		part2.emitting = false
		powerManager.leverFlicked()
		disable()


func disable():
	set_collision_layer_value(2, false)


func enableShimmer():
	if powerManager != null:
		handle.material_overlay = shimmer


func disableShimmer():
	handle.material_overlay = null
