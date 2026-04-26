extends State
class_name RunState

const SPEED = 130.0
@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	animated_sprite.play(animation)

func physics_update(delta: float):
	var direction := Input.get_axis("move_left", "move_right")

	# Handle movement
	if direction != 0:
		_flip_sprite(direction)
		_move_player(direction)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	
	# Apply gravity when airborne
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	
	# Transition checks (after physics resolution)
	if not player.is_on_floor():
		if player.velocity.y > 0:
			Transitioned.emit(self, "falling")
	else:
		if Input.is_action_just_pressed("jump"):
			Transitioned.emit(self, "jump")
		elif direction == 0:
			Transitioned.emit(self, "idle")
	player.move_and_slide()


func _flip_sprite(direction: float):
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
func _move_player(direction: float):
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
