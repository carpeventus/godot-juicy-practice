extends Node2D

@export var ghost_scene : PackedScene = preload("res://scenes/paddle/ghost.tscn")
@export var sprite : Sprite2D
@export var color : Color
@export var timer_interval = 0.04

var timer: float = 0.0
var timer_started = false

func spawn() -> void:
	var ghost = ghost_scene.instantiate() as Node2D;
	get_tree().current_scene.add_child(ghost)
	ghost.global_position = sprite.global_position
	ghost.rotation = sprite.rotation
	ghost.texture = sprite.texture
	ghost.self_modulate = color
	ghost.scale = sprite.scale
	ghost.z_index = 0

func start_spawn() -> void:
	timer_started = true
	
func stop_spawn() -> void:
	timer = 0.0
	timer_started = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not timer_started:
		return
	timer += delta
	if timer > timer_interval:
		timer = 0.0
		spawn()
