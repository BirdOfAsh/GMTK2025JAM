extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var staticBody: StaticBody3D = $StaticBody3D

@onready var handle: MeshInstance3D = $Handle

@onready var shimmer : ShaderMaterial = preload("res://shaders/shimmerMat.tres")


func interaction(_player : CharacterBody3D):
	animation_player.play("Cube_005Action")
	disable()


func disable():
	staticBody.set_collision_layer_value(2, false)


func enableShimmer():
	handle.material_overlay = shimmer


func disableShimmer():
	handle.material_overlay = null
