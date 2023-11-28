extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	scale = Vector2.ZERO
	$Shaker.start(1.5)
	var tween = create_tween()
	tween.tween_property(self, "scale",Vector2.ONE, 0.7).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.6).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(queue_free)


