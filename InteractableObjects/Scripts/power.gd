extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision: CollisionShape3D = $Area3D/CollisionShape3D


func interaction(_player : CharacterBody3D):
	animation_player.play("Cube_005Action")
	disable()


func disable():
	collision.disabled = true
