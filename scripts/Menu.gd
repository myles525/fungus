extends Control
@export var save_file_path := "user://save_game.json"
func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/fungus_selection.tscn")


func _on_load_game_pressed():
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()  # Get the raw JSON data as a string
		file.close()  # Close the file after reading
		
		var json = JSON.new()
		var parse_result = json.parse(json_data)
		
		# Check if parsing was successful
		if parse_result == OK:
			var save_data = json.data  # Access the parsed data from JSON instance
			Global.total_money = save_data.get("total_money", 0)
			Global.food = save_data.get("food", 0)
			Global.max_stamina = save_data.get("stamina", 10)
			Global.current_level = save_data.get("current_level", 1)
			#Global.PlayerSelect = save_data.get("current_mushroom", null)
			print("Game loaded successfully!")
			print(Global.PlayerSelect)
			get_tree().change_scene_to_file("res://scenes/fungus_selection.tscn")
		else:
			print("Error parsing save file:", parse_result)
	else:
		print("No save file found.")
	



func _on_exit_game_pressed():
	get_tree().quit()
