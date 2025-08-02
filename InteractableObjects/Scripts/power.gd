extends RigidBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var handle: MeshInstance3D = $Handle

@onready var shimmer : ShaderMaterial = preload("res://shaders/shimmerMat.tres")


func interaction(_player : CharacterBody3D):
	animation_player.play("Cube_005Action")
	disable()


func disable():
	set_collision_layer_value(2, false)


func enableShimmer():
	handle.material_overlay = shimmer


func disableShimmer():
	handle.material_overlay = null
