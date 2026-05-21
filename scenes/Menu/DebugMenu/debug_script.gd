extends Control

@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player, 'No player set')
		
var spawnMap: Dictionary = {
	0: Vector2(0, 0),
	1: Vector2(-30, -214),
	2: Vector2(-30, -314)
	
}

func _on_option_button_item_selected(index: int) -> void:
	var spawn_cords = spawnMap[index];
	
