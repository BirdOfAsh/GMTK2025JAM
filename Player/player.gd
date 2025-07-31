extends CharacterBody3D

@onready var camera : Camera3D = $Camera3D
@onready var marker3d: Marker3D = $Marker3D


var speed : int = 300
var direction : Vector3
var inputDirection : Vector2i
var mouseSensitivity : int = 3

var cameraRotation : Vector2

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
	
	
	rotateCamera()
	
	velocity = direction * speed * delta
	move_and_slide()


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		
		cameraRotation.y = event.relative.x * -0.005 * mouseSensitivity
		cameraRotation.x = event.relative.y * -0.005 * mouseSensitivity

func rotateCamera() -> void:
	rotate_y(cameraRotation.y)
	marker3d.rotate_x(cameraRotation.x)
	
	marker3d.rotation_degrees.x = clampf(marker3d.rotation_degrees.x, -90, 90)
	
	camera.global_transform = marker3d.get_global_transform_interpolated()
	
	cameraRotation = cameraRotation.lerp(Vector2.ZERO, 1)
