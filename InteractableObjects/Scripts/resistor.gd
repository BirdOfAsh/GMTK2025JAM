class_name Resistor
extends RigidBody3D

@onready var collision: CollisionShape3D = $CollisionShape3D

@onready var shimmer : ShaderMaterial = preload("res://shaders/shimmerMat.tres")
@onready var resistor: MeshInstance3D = $ResistorModel/Cylinder


func interaction(player : CharacterBody3D):
	if player.heldObject == null:
		disable()
		
	player.call("pickup", self)



func setPosition(pos : Vector3):
	position = pos


func disable():
	set_collision_layer_value(2, false)

func enableShimmer():
	resistor.material_overlay = shimmer


func disableShimmer():
	resistor.material_overlay = null
