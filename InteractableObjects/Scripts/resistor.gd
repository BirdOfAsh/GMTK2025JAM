class_name Resistor
extends RigidBody3D

@onready var collision: CollisionShape3D = $Area3D/CollisionShape3D


func interaction(player : CharacterBody3D):
	player.call("pickup", self)


func setPosition(pos : Vector3):
	position = pos


func disable():
	set_collision_layer_value(2, false)
