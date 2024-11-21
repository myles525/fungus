extends Node2D

var counter : int
@onready var counter_label = $Label

@onready var start_button = $VBoxContainer/StartButton
@onready var initial_timer = $InitialTimer
@onready var game_timer = $GameTimer
@onready var initial_timer_label = $InitialTimerLabel
@onready var game_timer_label = $GameTimerLabel

func _ready():
	# Configure timers
	initial_timer.wait_time = 3  # Set initial timer duration
	initial_timer.one_shot = true
	game_timer.wait_time = 10    # Set game timer duration
	game_timer.one_shot = true

	# Connect signals
	start_button.connect("pressed", Callable(self, "_on_start_button_pressed"))
	initial_timer.connect("timeout", Callable(self, "_on_initial_timer_timeout"))
	game_timer.connect("timeout", Callable(self, "_on_game_timer_timeout"))

	# Initialize labels
	initial_timer_label.text = "Initial Timer: %d" % int(initial_timer.wait_time)
	game_timer_label.text = "Game Timer: %d" % int(game_timer.wait_time)

func _on_start_button_pressed():
	# Start the initial timer
	initial_timer.start()

func _on_initial_timer_timeout():
	# When the initial timer finishes, start the game timer and update its label
	game_timer.start()
	_update_game_timer_label()

func _on_game_timer_timeout():
	# Handle the end of the game timer
	print("Game Timer has finished!")
	game_timer_label.text = "Game Timer: 0"

func _process(delta):
	# Update labels during countdowns
	if initial_timer.is_stopped() == false:
		_update_initial_timer_label()
	elif game_timer.is_stopped() == false:
		_update_game_timer_label()

func _update_initial_timer_label():
	# Update the initial timer label
	initial_timer_label.text = "Initial Timer: %d" % int(initial_timer.time_left)

func _update_game_timer_label():
	# Update the game timer label
	game_timer_label.text = "Game Timer: %d" % int(game_timer.time_left)

func _on_confirm_pressed():
	Global.money = counter
	print(Global.money)
	Global.total_money += counter
	#get_tree().change_scene_to_file("res://scenes/room.tscn")
	get_tree().change_scene_to_file("res://scenes/terrarium.tscn")

func _on_counter_pressed():
	if counter_label and counter_label is Label:
		if game_timer.time_left > 0:
			counter_label.text = "Counter : %d" % [counter + 1]
			counter += 1
			


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/room.tscn")
