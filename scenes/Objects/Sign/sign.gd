extends Area2D

@onready var timer: Timer = $Timer
@export var text_content: String = ""
@onready var sign_text_label: Label = $SignText
@onready var read_prompt_button_sprite: Sprite2D = $ReadPromptButtonSprite
var is_colliding = false

func _ready() -> void:
	sign_text_label.text = text_content
	hide_prompt()
	hide_text()

func _on_body_entered(body: Node2D) -> void:
	show_prompt()
	is_colliding = true

func _on_body_exited(body: Node2D) -> void:
	is_colliding = false
	hide_prompt()
	hide_text()

func _input(event):
	# TODO: this is terrible, every sign will be reading inputs every time
	if (is_colliding &&
		Input.is_action_just_pressed("read") &&
		!sign_text_label.visible
	):
		hide_prompt()
		show_text()

func show_prompt() -> void: read_prompt_button_sprite.visible = true
func hide_prompt() -> void: read_prompt_button_sprite.visible = false

func show_text() -> void:
	sign_text_label.visible = true
	sign_text_label.visible_characters = 0
	timer.start()
	
func hide_text() -> void:
	sign_text_label.visible = false
	sign_text_label.visible_characters = 0
	
func _on_timer_timeout() -> void:
	print("timeout")

	if sign_text_label.visible_characters < text_content.length():
		sign_text_label.visible_characters += 1
	else:
		timer.stop()
