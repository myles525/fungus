extends Control
#
## List of character scenes
#var character_scenes = [
	#preload("res://scenes/enoki_mushroom.tscn"),
	#preload("res://scenes/red_mushroom.tscn")
#]
#
#var current_index = 0
#
## Called when the scene is initialized
#func _ready():
	## Set the initial character scene
	#update_character_scene()
#
## Function to update the CharacterHolder with the current character scene
#func update_character_scene():
	## Instance the new character scene
	#var new_character_instance = character_scenes[current_index].instantiate()
	#
	## Get the CharacterHolder node
	#var character_holder = $HBoxContainer/CharacterHolder
	#
	## Remove the existing child node if it exists
	#if character_holder.get_child_count() > 0:
		#character_holder.get_child(0).queue_free()
	#
	## Add the new character instance to CharacterHolder
	#character_holder.add_child(new_character_instance)
	#
	## Ensure the new character instance fills the CharacterHolder
	#if new_character_instance is Control:
		#new_character_instance.anchor_left = 0.0
		#new_character_instance.anchor_right = 1.0
		#new_character_instance.anchor_top = 0.0
		#new_character_instance.anchor_bottom = 1.0
		#new_character_instance.offset_left = 0.0
		#new_character_instance.offset_right = 0.0
		#new_character_instance.offset_top = 0.0
		#new_character_instance.offset_bottom = 0.0
#
#func _on_left_pressed():
	#current_index -= 1
	#if current_index < 0:
		#current_index = character_scenes.size() - 1
	#update_character_scene()
#
#func _on_right_pressed():
	#current_index += 1
	#if current_index >= character_scenes.size():
		#current_index = 0
	#update_character_scene()
#
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
#
func _on_confirm_pressed():
	if Global.PlayerSelect == null:
		Global.PlayerSelect = 0
		
	match Global.PlayerSelect:
		0:
			get_node("FungusSelect").play("enoki")
		1:
			get_node("FungusSelect").play("red_mushroom")
			
	
	
	
	# Load the main game scene
	var main_game_scene = ResourceLoader.load("res://scenes/room.tscn") as PackedScene  # Cast to PackedScene
	
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
		
		
const MIN_INDEX = 0
const MAX_INDEX = 2


func _process(delta):
	if Global.PlayerSelect == null:
		Global.PlayerSelect = 0
		
	match Global.PlayerSelect:
		0:
			get_node("FungusSelect").play("enoki")
		1:
			get_node("FungusSelect").play("red_mushroom")


func _on_previous_pressed():
	Global.PlayerSelect -= 1
	if Global.PlayerSelect < MIN_INDEX:
		Global.PlayerSelect = MAX_INDEX



func _on_next_pressed():
	Global.PlayerSelect += 1
	if Global.PlayerSelect > MAX_INDEX:
		Global.PlayerSelect = MIN_INDEX

		

