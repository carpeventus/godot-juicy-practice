extends Control

signal retry
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pivot_offset = size / 2
	$VBoxContainer/RetryBtn.grab_focus()

func _on_RetryBtn_pressed() -> void:
	retry.emit()
	queue_free()

func _on_QuitBtn_pressed() -> void:
	get_tree().quit()

func screen_shake(duration: float, frequency: float, amplitude: float) -> void:
	Globals.camera.shake(duration, frequency, amplitude)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "appear":
		animation_player.play("wiggle")
