extends Node2D

@export var color_too_far: Color
@export var color_early: Color
@export var color_perfect: Color
@export var color_late: Color

var bump_to_str = {
	Globals.BUMP.TOO_FAR: "TOO FAR",
	Globals.BUMP.EARLY: "EARLY",
	Globals.BUMP.LATE: "LATE",
	Globals.BUMP.PERFECT: "PERFECT"
}

var type = Globals.BUMP.EARLY

@onready var label: Label = $Label



func _ready() -> void:
	var bump_colors = {
	Globals.BUMP.TOO_FAR: color_too_far,
	Globals.BUMP.EARLY: color_early,
	Globals.BUMP.LATE: color_late,
	Globals.BUMP.PERFECT: color_perfect
	}
	
	label.text = bump_to_str[type]
	label.self_modulate = bump_colors[type]
	appear()
	
func appear() -> void:
	visible = true
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(label, "rotation", randf_range(-0.05, 0.05), 1.2)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(label, "position", Vector2(), 1) \
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(label, "scale", Vector2.ONE,0.7)\
	.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.chain().tween_property(label, "scale", Vector2.ZERO,0.45)\
	.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_callback(disappear)
	
func disappear() -> void:
	visible = false

func _process(delta) -> void:
	pass

