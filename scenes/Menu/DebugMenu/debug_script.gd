extends Control

@export var player: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player, 'No player set')
	visible = false

var spawn_map: Dictionary = {
	0: Vector2(0, 0),
	1: Vector2(-396, 1101),
	2: Vector2(-468, 2382),
}

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F2:
			toggle_visibility()

func toggle_visibility():
	self.visible = !visible

func _on_option_button_item_selected(index: int) -> void:
	var spawn_cords = spawn_map[index]
	player.position = spawn_cords
