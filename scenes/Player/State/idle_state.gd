extends State
class_name IdleState

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	player.velocity.x = 0
	animated_sprite.play(animation)

func physics_update(delta: float):
	# Idle state: Stop horizontal movement, apply gravity if airborne
	player.velocity.x = 0
	
	# Apply gravity when airborne
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	# Resolve physics
	player.move_and_slide()
	
	# Transition checks
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "jump")
	else:
		var direction := Input.get_axis("move_left", "move_right")
		if direction != 0:
			Transitioned.emit(self, "run")
