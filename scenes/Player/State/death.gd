extends State
class_name DeathState

@onready var timer: Timer = $"../../Timer"
@export var animated_sprite: AnimatedSprite2D
#@onready var death_fall: AudioStreamPlayer2D = %death_fall
@onready var bonebreak: AudioStreamPlayer2D = %bonebreak
@onready var harsh_fall: AudioStreamPlayer2D = %harsh_fall

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	animated_sprite.modulate = Color(1, 0, 0)
	animated_sprite.play(animation)
	harsh_fall.play()
	bonebreak.play(0.25)
	print("You died!")
	#Engine.time_scale = 0.5
	
	timer.start()


func _on_timer_timeout() -> void:
	#Engine.time_scale = 1.0
	print("time run out")
	get_tree().reload_current_scene()
