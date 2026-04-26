extends State
class_name ProneState

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
@onready var harsh_fall: AudioStreamPlayer2D = %harsh_fall

var prone_timer: float = 0.0
const PRONE_DURATION: float = 1.0  # 1 second

func enter() -> void:
	animated_sprite.play(animation)
	player.velocity.x = 0
	player.velocity.y = 0
	harsh_fall.play()
	prone_timer = PRONE_DURATION  # Start the timer

func physics_update(delta: float):
	# Countdown the timer
	prone_timer -= delta
	
	# Apply gravity while prone (to handle edge cases)
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	# Resolve physics
	player.move_and_slide()
	
	# Only allow transitions after timer expires
	if prone_timer <= 0.0:
		var direction := Input.get_axis("move_left", "move_right")
		if direction != 0: 
			Transitioned.emit(self, "run")
