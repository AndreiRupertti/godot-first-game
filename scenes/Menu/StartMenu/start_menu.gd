extends Control

@export var end_y: float = 0.0
@export var duration: float = 0.0
@export var player: CharacterBody2D
@export var camera: Camera2D

var start_y: float
var elapsed_time := 0.0
var play_anim = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(end_y >= 0, 'end_y not set')
	assert(duration, 'duration not set')
	assert(player, 'player not set')
	assert(camera, 'camera not set')

	start_y = camera.position.y

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	#play_anim = true
	start_game()


func should_play_anim():
	return play_anim


func end_anim():
	play_anim = false
	elapsed_time = 0


func bind_camera_to_player():
	camera.reparent(player)


func play_start_animation() -> Signal:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(camera, 'position', Vector2(camera.position.x, end_y), duration)
	return tween.finished


func start_game():
	await play_start_animation()
	bind_camera_to_player()
	GameEvents.game_start.emit()
