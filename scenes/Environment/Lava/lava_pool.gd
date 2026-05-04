extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_killzone_death_start() -> void:
	#Engine.time_scale = 0.3
	GameEvents.player_burn.emit()
	

func _on_killzone_death_end() -> void:
	#Engine.time_scale = 1
	print("Killzione signal end")
	GameEvents.player_died.emit()
