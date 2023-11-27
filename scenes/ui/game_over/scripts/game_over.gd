extends Control

signal retry()

func _ready() -> void:
	pivot_offset = size / 2
	$VBoxContainer/RetryBtn.grab_focus()

func _on_RetryBtn_pressed() -> void:
	emit_signal("retry")
	queue_free()

func _on_QuitBtn_pressed() -> void:
	get_tree().quit()

func screen_shake(duration: float, frequency: float, amplitude: float) -> void:
	Globals.camera.shake(duration, frequency, amplitude)
