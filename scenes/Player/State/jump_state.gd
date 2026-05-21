extends State

class_name JumpState

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
@export var jump_height: int
const AIR_SPEED = 130


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	animated_sprite.play(animation)
	var direction := Input.get_axis("move_left", "move_right")
	jump()
	move_x(direction)


func physics_update(delta: float):
	# Apply gravity (always, since we're airborne)
	player.velocity += player.get_gravity() * delta

	# Jump state: Handle air movement, apply gravity
	var direction := Input.get_axis("move_left", "move_right")
	_flip_sprite(direction)
	move_x(direction)

	# Transition checks (after physics resolution)
	if player.velocity.y > 0:
		state_transition.emit(self, "falling")
	elif player.is_on_floor():
		state_transition.emit(self, "idle")

	player.move_and_slide()


func _flip_sprite(direction: float):
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true


func move_x(direction: float):
	if direction:
		player.velocity.x = direction * AIR_SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, AIR_SPEED)


func jump():
	player.velocity.y = -(jump_height)
