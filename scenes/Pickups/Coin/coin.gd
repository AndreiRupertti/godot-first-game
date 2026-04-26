extends Area2D

@onready var coin_pickup_animation: AnimationPlayer = %CoinPickupAnimation

func _on_body_entered(body: Node2D) -> void:
	GameManager.add_point()
	coin_pickup_animation.play("pickup")
