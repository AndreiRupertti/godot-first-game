extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const STRONG_FALL_DISTANCE = 40

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var harsh_fall: AudioStreamPlayer2D = $harsh_fall

var fall_strength = 0

func physics_process(delta: float) -> void:
	pass
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#move_and_slide()
	#var direction = move_player()
	#
	## Play animation
	#var is_falling = not is_on_floor() and velocity.y > 0
	#var be_prone = fall_strength > STRONG_FALL_DISTANCE
	#
	#if is_on_floor():
		#if be_prone:
			#if animated_sprite.animation != 'prone':
				#harsh_fall.play()
			#animated_sprite.play("prone")
#
		#if not be_prone and direction == 0:
			#animated_sprite.play("idle")
		#elif direction != 0:
			#fall_strength = 0
			#animated_sprite.play("run")
		#
	#elif is_falling:
		#fall_strength += 1
		#animated_sprite.play("falling")
	#else:
		#animated_sprite.play("jump")
	#
	## Apply movement
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#
	#
	#move_and_slide()
	#
#func move_player() -> int:
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Gets input direction: -1, 0, 1
	#var direction := Input.get_axis("move_left", "move_right")
	#
	## Flip the sprite
	#if direction > 0:
		#animated_sprite.flip_h = false
	#elif direction < 0:
		#animated_sprite.flip_h = true
#
	#return direction
