extends CharacterBody3D

@onready var camera : Camera3D = $Camera3D
@onready var interactionArea : Area3D = $Camera3D/Area3D

######## CAMERA ########
var speed : int = 300
var direction : Vector3
var inputDirection : Vector2i
var mouseSensitivity = 2
######## CAMERA ########
######## INTERACTION ########
var objectLookingAt: Node
######## INTERACTION ########

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


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
		objectLookingAt.call("interact")

func _on_area_3d_area_entered(area: Area3D) -> void:
	objectLookingAt = area.get_parent().find_child("Interactable")


func _on_area_3d_area_exited(area: Area3D) -> void:
	objectLookingAt = null
