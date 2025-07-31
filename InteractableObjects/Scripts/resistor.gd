extends Node3D


func interaction(player : CharacterBody3D):
	position = Vector3.ZERO
	player.call("pickup", self)
