extends CharacterBody3D

@onready var camera : Camera3D = $Camera3D


var speed : int = 300
var direction : Vector3
var inputDirection : Vector2i
var mouseSensitivity = 5


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
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(event.relative.x * -0.005 * mouseSensitivity)
		camera.rotate_x(event.relative.y * -0.005 * mouseSensitivity)
		
		camera.rotation_degrees.x = clampf(camera.rotation_degrees.x, -90, 90)
