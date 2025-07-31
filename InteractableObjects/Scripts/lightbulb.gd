class_name Lightbulb
extends Node3D

@onready var collision: CollisionShape3D = $Area3D/CollisionShape3D


func interaction(player : CharacterBody3D):
	player.call("pickup", self)


func setPosition(pos : Vector3):
	position = pos


func disable():
	collision.disabled = true
