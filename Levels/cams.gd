extends Node3D

@onready var cam1 : Camera3D = $Cam1
@onready var cam2 : Camera3D = $Cam2
@onready var cam3 : Camera3D = $Cam3
@onready var cam4 : Camera3D = $Cam4




func _ready() -> void:
	SignalBussin.connect("switchCam", switchCam)


func switchCam(camName : String):
	cam1.current = false
	cam2.current = true



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		cam1.current = true
		cam2.current = false
		cam3.current = false
		cam4.current = false


func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		cam1.current = false
		cam2.current = true


func _on_area_3d_3_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		cam1.current = false
		cam2.current = false
		cam3.current = true
		cam4.current = false


func _on_area_3d_4_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		cam1.current = false
		cam2.current = false
		cam3.current = false
		cam4.current = true
