extends Area2D

signal death_start
signal death_end

@onready var timer: Timer = $Timer

@export var collision_shape: CollisionShape2D
@export var death_delay: float = 0.0:
	set(value):
		death_delay = value
		if timer:
			timer.wait_time = death_delay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = death_delay
	if collision_shape:
		add_child(collision_shape)

func _on_body_entered(body: Node2D) -> void:
	timer.start()
	death_start.emit()


func _on_timer_timeout() -> void:
	death_end.emit()
