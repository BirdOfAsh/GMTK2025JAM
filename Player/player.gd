extends CharacterBody3D

@onready var camera : Camera3D = $Camera3D
@onready var interactionArea : Area3D = $Area3D
@onready var holdingMarker: Marker3D = $HoldingMarker
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D


######## CAMERA ########
var speed : int = 300
var direction : Vector3
var inputDirection : Vector2i
var mouseSensitivity = 2
######## INTERACTION ########
var objectLookingAt: Node
######## INTERACTION ########
var heldObject : Node3D

var intro : bool = true
var GOOOOO : bool = false


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	SignalBussin.connect("weLoveTransitioning", huh)
	#pass


func _process(delta: float) -> void:
	lerpToMarker(delta)
	if intro and mesh_instance_3d.mesh.material.albedo_color.a > 0.01:
		transitionIn(delta)
	if GOOOOO:
		transitionOut(delta)


func _physics_process(delta: float) -> void:
	inputDirection = Vector2i.ZERO
	direction = Vector3.ZERO
	
	if Input.is_action_pressed("Forward"):
		inputDirection.y = -1
	if Input.is_action_pressed("Backward"):
		inputDirection.y = 1
	if Input.is_action_pressed("Right"):
		inputDirection.x = 1
	if Input.is_action_pressed("Left"):
		inputDirection.x = -1
	
	if Input.is_action_just_pressed("Esc"):
		get_tree().quit()
	
	if inputDirection != Vector2i.ZERO:
		direction = transform.basis * Vector3(inputDirection.x, 0 , inputDirection.y).normalized()
	
	velocity = direction * speed * delta
	move_and_slide()


func _input(event: InputEvent) -> void:
	keyEPressed(event)
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * -0.005 * mouseSensitivity)
		camera.rotate_x(event.relative.y * -0.005 * mouseSensitivity)
		
		camera.rotation_degrees.x = clampf(camera.rotation_degrees.x, -90, 90)

func keyEPressed(event: InputEvent):
	if event.is_action_pressed("Interact") && objectLookingAt != null:
		objectLookingAt.call("interact", self)


func pickup(object : Node3D) -> void:
	if heldObject == null:
		object.reparent(holdingMarker)
		heldObject = object

		object.disableShimmer()


func getHeldObject() -> Node3D:
	return heldObject


func place(placementNode : Node3D) -> void:
	heldObject.reparent(placementNode)
	heldObject = null
	objectLookingAt = null
	

func lerpToMarker(delta : float):
	if heldObject != null:
		heldObject.global_position = lerp(heldObject.global_position, holdingMarker.global_position, 5 * delta)
		heldObject.rotation_degrees = lerp(heldObject.rotation_degrees, Vector3.ZERO, 5 * delta)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("enableShimmer") && heldObject != body:
		body.enableShimmer()
	objectLookingAt = body.find_child("Interactable")
	print(objectLookingAt.get_parent())


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.has_method("disableShimmer"):
		body.disableShimmer()
		objectLookingAt = null
		print("make null look at ")


func transitionOut(delta : float):
	print("why")
	mesh_instance_3d.mesh.material.albedo_color.a = lerp(mesh_instance_3d.mesh.material.albedo_color.a, 1.0, 3 * delta)
	if mesh_instance_3d.mesh.material.albedo_color.a > 0.99:
		SignalBussin.emit_signal("NEXTSCENEAHHHHHH")


func transitionIn(delta : float):
	mesh_instance_3d.mesh.material.albedo_color.a = lerp(mesh_instance_3d.mesh.material.albedo_color.a, 0.0, 3 * delta)
	if mesh_instance_3d.mesh.material.albedo_color.a < 0.01:
		intro = false
		print("yeet the child")

func huh():
	GOOOOO = true
