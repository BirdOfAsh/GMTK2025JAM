class_name Lightbulb
extends RigidBody3D

@onready var lightbulb: Node3D = $Lightbulb
@onready var lightbulb_off: Node3D = $LightbulbOff


func interaction(player : CharacterBody3D):
	player.call("pickup", self)
	switchBulbMesh()


func setPosition(pos : Vector3):
	position = pos


func disable():
	set_collision_layer_value(2, false)


func switchBulbMesh():
	match lightbulb.visible:
		true:
			lightbulb.visible = false
			lightbulb_off.visible = true
		false:
			lightbulb.visible = true
			lightbulb_off.visible = false
