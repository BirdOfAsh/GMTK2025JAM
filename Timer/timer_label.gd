extends Label3D

@export_range(1.0, 60.0, 1.0) var waitTime : float

@onready var timer : Timer = $Timer


func _ready() -> void:
	timer.wait_time = waitTime
	timer.start()


func _process(_delta: float) -> void:
	text = str(float(int(timer.time_left * 10)) / 10)

func get_time() -> float:
	return timer.time_left

func _on_timer_timeout() -> void:
	SignalBussin.emit_signal("resetLoop")
