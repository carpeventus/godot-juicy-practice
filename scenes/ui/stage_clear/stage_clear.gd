extends Control

signal next()

@onready var time: Label = %Time
@onready var early_bumps: Label = %EarlyBumps
@onready var late_bumps: Label = %LateBumps
@onready var perfect_bumps: Label = %PerfectBumps
@onready var bounces: Label = %Bounces
@onready var score: Label = %Score

@onready var final_score = %FinalScore


var bump_earlylate_multiplicator: int = 500
var bump_perfect_multiplicator: int = 2000
var bounce_multiplicator: int = 10
var final_score_value: int = 0

func _ready() -> void:
	#region for testing only
	#Globals.stats["time"] = 1000
	#Globals.stats["bumps_early"] = 25
	#Globals.stats["bumps_late"] = 12
	#Globals.stats["bumps_perfect"] = 4
	#Globals.stats["ball_bounces"] = 32
	#Globals.stats["score"] = 5200
	#endregion
	
	pivot_offset = size / 2
	
	# $VBoxContainer/NextBtn.grab_focus()
	update_stats()
	# animated_stats()

func update_stats() -> void:
	var ms = Globals.stats["time"] * 1000
	var seconds: int = int(ms / 1000 )% 60
	var minutes: int = int(ms / 1000 / 60)
	time.text = str(minutes) + ":" + str(seconds)
	early_bumps.text = str(Globals.stats["bumps_early"])
	late_bumps.text = str(Globals.stats["bumps_late"])
	perfect_bumps.text = str(Globals.stats["bumps_perfect"])
	bounces.text = str(Globals.stats["ball_bounces"])
	score.text = str(Globals.stats["score"])
	final_score_value = (Globals.stats["bumps_early"]*bump_earlylate_multiplicator) + \
		(Globals.stats["bumps_late"]*bump_earlylate_multiplicator)+ \
		(Globals.stats["bumps_perfect"]*bump_perfect_multiplicator)+ \
		(Globals.stats["ball_bounces"]*bounce_multiplicator) + \
		Globals.stats["score"]
	final_score.text = str(final_score_value)


func hide_status() -> void:
	for child in %TagVBoxContainer.get_children():
		child.self_modulate.a = 0.0
	for child in %ValueBoxContainer.get_children():
		child.self_modulate.a = 0.0
	final_score.self_modulate.a = 0.0
	%FinalScoreLabel.self_modulate.a = 0.0
	$VBoxContainer.modulate.a = 0.0
	
func animated_stats() -> void:
	hide_status()
	
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	# labels
	for child in %TagVBoxContainer.get_children():
		tween.tween_property(child, "position:x", 0.0, 0.2).from(-get_viewport_rect().size.x)
		tween.parallel().tween_property(child, "self_modulate:a", 1.0, 0.2).from(0.0)
	
	# values
	for i in range(%ValueBoxContainer.get_child_count()):
		var child = %ValueBoxContainer.get_child(i)
		var key = Globals.stats.keys()[i]
		var value = Globals.stats[key]
		tween.tween_property(child, "position:x", 0.0, 0.2).from(-get_viewport_rect().size.x)
		tween.parallel().tween_property(child, "self_modulate:a", 1.0, 0.2).from(0.0)

		tween.tween_method(set_label_text.bind(child), 0, value, 0.5)
		tween.parallel().tween_property(child, "self_modulate:a", 1.0, 0.05).from(0.0)
		tween.parallel().tween_callback(screen_shake.bind(1.0, 30.0, 25.0))
		tween.parallel().tween_callback($Shaker.start.bind(0.25))
		tween.tween_interval(0.25)
		
	tween.tween_interval(0.25)
	# final score label appear
	tween.tween_property(%FinalScoreLabel, "position:x", 0.0, 0.3).from(-get_viewport_rect().size.x)
	tween.parallel().tween_property(%FinalScoreLabel, "self_modulate:a", 1.0, 0.2).from(0.0)
	# final score value count up
	tween.tween_method(set_label_text.bind(final_score), 0, final_score_value, 1.0)
	tween.parallel().tween_property(final_score, "self_modulate:a", 1.0, 0.05).from(0.0)
	tween.parallel().tween_callback(screen_shake.bind(1.0, 30.0, 25.0))
	tween.parallel().tween_callback($Shaker.start.bind(1.0))
	# NEXT button
	tween.tween_interval(1.0)
	tween.tween_property($VBoxContainer, "position:y", 904, 0.3).from(get_viewport_rect().size.y)
	tween.parallel().tween_property($VBoxContainer, "modulate:a", 1.0, 0.1).from(0.0)
	tween.tween_callback($VBoxContainer/NextBtn.grab_focus)
	
# tween_method默认选择方法的第一个参数来插值，如果要绑定参数
func set_label_text(number: int, label: Label) -> void:
	label.text = str(number)

func screen_shake(duration: float, frequency: float, amplitude: float) -> void:
	Globals.camera.shake(duration, frequency, amplitude)

func _on_NextBtn_pressed() -> void:
	emit_signal("next")
	queue_free()
