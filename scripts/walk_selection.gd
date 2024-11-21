extends Node2D



func _ready():
	if Global.PlayerSelect == null:
		Global.PlayerSelect = 0
	
		match Global.PlayerSelect:
			0:
				get_node("FungusSelect").play("enoki")
			1:
				get_node("FungusSelect").play("red_mushroom")
			
	# Access the current value of Global.PlayerSelect
	var current_selection = Global.PlayerSelect
	print("Current PlayerSelect value: ", current_selection)
	
	# Modify the Global.PlayerSelect value
	Global.PlayerSelect = (current_selection) % Global.character_scenes.size()
	print("New PlayerSelect value: ", Global.PlayerSelect)
	
	# Optionally, you can perform actions based on the new value






func _on_forest_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Area2D clicked!")
			get_tree().change_scene_to_file("res://scenes/forest.tscn")


func _on_cave_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Area2D clicked!")
			get_tree().change_scene_to_file("res://scenes/cave.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/room.tscn")
