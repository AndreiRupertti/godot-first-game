extends Node

class_name State

signal state_transition

@export var animation: String


## Called when entering this state. Override to initialize state-specific logic.
func enter() -> void:
	pass


## Called when exiting this state. Override to cleanup state-specific logic.
func exit() -> void:
	pass


func update(_delta: float):
	pass


func physics_update(_delta: float):
	pass
