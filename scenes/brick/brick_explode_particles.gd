extends GPUParticles2D

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	emitting = true
	$GPUParticles2D.emitting = true
	timer.start(lifetime)


func _on_timer_timeout() -> void:
	queue_free()
