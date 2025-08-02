class_name Lightbulb
extends RigidBody3D

@onready var lightbulb: Node3D = $Lightbulb
@onready var lightbulb_off: Node3D = $LightbulbOff
@export var lightbulbActivatedReverse: bool = false

func _ready() -> void:
	## True is off
	## False is on
	switchBulbMesh(lightbulbActivatedReverse)

func interaction(player : CharacterBody3D):
	player.call("pickup", self)
	switchBulbMesh(true)


func disable():
	set_collision_layer_value(2, false)


func setPosition(pos : Vector3):
	position = pos


func switchBulbMesh(lightonoff):
	match lightonoff:
		true:
			lightbulb.visible = false
			lightbulb_off.visible = true
		false:
			lightbulb.visible = true
			lightbulb_off.visible = false
