extends CharacterBody3D

@onready var camera : Camera3D = $Camera3D
@onready var interactionArea : Area3D = $Camera3D/Area3D
@onready var holdingMarker: Marker3D = $HoldingMarker


######## CAMERA ########
var speed : int = 300
var direction : Vector3
var inputDirection : Vector2i
var mouseSensitivity = 2
######## INTERACTION ########
var objectLookingAt: Node
######## INTERACTION ########
var heldObject : Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	lerpToMarker(delta)


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
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
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

		print("picked up object")
		print(object)


func getHeldObject() -> Node3D:
	return heldObject


func place(placementNode : Node3D) -> void:
	heldObject.reparent(placementNode)
	heldObject = null
	

func lerpToMarker(delta : float):
	if heldObject != null:
		heldObject.global_position = lerp(heldObject.global_position, holdingMarker.global_position, 5 * delta)
		heldObject.rotation_degrees = lerp(heldObject.rotation_degrees, Vector3.ZERO, 5 * delta)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("enableShimmer"):
		body.get_parent().enableShimmer()
	objectLookingAt = body.find_child("Interactable")
	print(body)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.has_method("disableShimmer"):
		body.disableShimmer()
	objectLookingAt = null
