class_name Lightbulb
extends Node3D

@onready var collision: CollisionShape3D = $Area3D/CollisionShape3D
@onready var lightbulb: Node3D = $Lightbulb
@onready var lightbulb_off: Node3D = $LightbulbOff


func interaction(player : CharacterBody3D):
	player.call("pickup", self)
	switchBulbMesh()


func setPosition(pos : Vector3):
	position = pos


func switchBulbMesh():
	match lightbulb.visible:
		true:
			lightbulb.visible = false
			lightbulb_off.visible = true
		false:
			lightbulb.visible = true
			lightbulb_off.visible = false
