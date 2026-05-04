extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.player_died.connect(_on_death_received)
	GameEvents.player_burn.connect(_on_burn_received)

	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transitioned(state: State, new_state_name: String):

	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state

func _on_death_received():
	print("Player - Death recieved")
	on_child_transitioned(current_state, "Death")
	
func _on_burn_received():
	print("Player - Burn recieved")
	# TODO: add  burn state
	on_child_transitioned(current_state, "Prone")
