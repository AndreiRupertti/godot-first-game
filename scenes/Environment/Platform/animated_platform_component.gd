extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var platform_node: AnimatableBody2D
@export var start_position: Vector2
@export var end_position: Vector2
@export var duration: float

@export_range(0.0, 1.0) var progress: float = 0.0

func _ready() -> void:
	animation_player.speed_scale = 1/duration

func _physics_process(delta):
	platform_node.global_position = start_position.lerp(end_position, progress)
