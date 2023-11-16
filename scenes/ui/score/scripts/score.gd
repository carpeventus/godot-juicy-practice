extends Control

@onready var score = $Score


func set_score(new_score: int) -> void:
	score.text = str(new_score)
