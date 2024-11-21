extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the _input_event signal to the _on_Area2D_input_event function
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_door_mouse_entered():
	pass
	

@export var save_file_path := "user://save_game.json"

func _on_door_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Area2D clicked!")
			
	# Load the main game scene
		var main_game_scene = ResourceLoader.load("res://scenes/walk_selection.tscn") as PackedScene  # Cast to PackedScene
	
		if main_game_scene:
			print("Root node type: ", main_game_scene.get_class())
			print("Scene loaded")
			var game_instance = main_game_scene.instantiate()  # Create an instance of the scene
			if game_instance:
				print("Instance created successfully")
				get_tree().change_scene_to_packed(main_game_scene)
			else:
				print("Error: Could not instance the scene")
		else:
			print("Error: Could not load main_game.tscn")


func _on_minigame_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Area2D clicked!")
			get_tree().change_scene_to_file("res://scenes/minigame.tscn")


func _on_terrarium_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Area2D clicked!")
			get_tree().change_scene_to_file("res://scenes/terrarium.tscn")


func _on_save_game_pressed():

	var save_data = {
		"total_money": Global.total_money,
		"food": Global.food,
		"stamina": Global.max_stamina,
		"current_level": Global.current_level
		#"current_mushroom": Global.PlayerSelect
	}

	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("Game saved successfully!")
	else:
		print("Failed to save the game.")
