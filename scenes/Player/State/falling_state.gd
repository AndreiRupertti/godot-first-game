extends State

class_name FallingState

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

const STRONG_FALL_DISTANCE = 110
const DEATH_FALL_DISTANCE = 260
const AIR_SPEED = 130
var origin_fall_pos = 0


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	animated_sprite.play(animation)
	origin_fall_pos = abs(player.position.y)


func physics_update(delta: float):
	# Falling state: Handle air movement, apply gravity
	var direction := Input.get_axis("move_left", "move_right")
	_flip_sprite(direction)
	move_x(direction)

	# Apply gravity (always, since we're airborne)
	player.velocity += player.get_gravity() * delta

	# Resolve physics after velocity is set
	player.move_and_slide()

	# Transition check (after physics resolution)
	if player.is_on_floor():
		var jump_distance = abs(player.position.y) - abs(origin_fall_pos)
		var is_safe = is_safe_floor()

		if jump_distance > DEATH_FALL_DISTANCE and not is_safe:
			state_transition.emit(self, "death")
		elif jump_distance > STRONG_FALL_DISTANCE and not is_safe:
			state_transition.emit(self, "prone")
		else:
			state_transition.emit(self, "idle")


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


func is_safe_floor() -> bool:
	for i in player.get_slide_collision_count():
		var collision = player.get_slide_collision(i)

		if collision.get_collider() is TileMapLayer:
			var tilemap = collision.get_collider()

			var position = collision.get_position()
			var cell = tilemap.local_to_map(position)

			var tile_data = tilemap.get_cell_tile_data(cell)

			if tile_data:
				return tile_data.get_custom_data("is_safe_fall")

	return false
