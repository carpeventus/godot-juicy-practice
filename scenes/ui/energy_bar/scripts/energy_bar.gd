extends Control

@export var max_particles: int =  300
@onready var progress: ProgressBar = $EnergyBar
@onready var shaker: Shaker = $Shaker
@onready var particles: GPUParticles2D = $EnergyBar/GPUParticles2D

func _ready() -> void:
	particles.amount = 1
	progress.value = 0.0
	progress.rotation = 0.0

func set_energy(new_value: int) -> void:
	
	if new_value > 90.0 and new_value > progress.value:
		shaker.start()
	elif new_value <= 90.0:
		shaker.stop()
		
	particles.amount = clamp(new_value/100.0 * max_particles, 1, max_particles)
	progress.value = new_value
