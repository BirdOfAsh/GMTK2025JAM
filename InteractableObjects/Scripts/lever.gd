extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision: CollisionShape3D = $Area3D/CollisionShape3D


func interaction(_player : CharacterBody3D):
	animation_player.play("Part Studio 2 - Part 1Action")
	disable()


func disable():
	collision.disabled = true
