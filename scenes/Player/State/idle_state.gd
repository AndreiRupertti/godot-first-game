extends State

class_name IdleState

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.

# Called when the node enters the scene tree for the first time.
var can_move = false


func _ready() -> void:
	GameEvents.game_start.connect(_on_game_start)


func _on_game_start() -> void:
	can_move = true


func enter() -> void:
	player.velocity.x = 0
	animated_sprite.play(animation)


func physics_update(delta: float):
	if not can_move:
		return

	# Idle state: Stop horizontal movement, apply gravity if airborne
	player.velocity.x = 0

	# Apply gravity when airborne
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	# Resolve physics
	player.move_and_slide()

	# Transition checks
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_transition.emit(self, "jump")
	else:
		var direction := Input.get_axis("move_left", "move_right")
		if direction != 0:
			state_transition.emit(self, "run")
