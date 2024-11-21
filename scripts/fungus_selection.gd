extends Control
#
## List of character scenes
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
			Global.player_mushroom_collection.append("Enoki")
		1:
			get_node("FungusSelect").play("red_mushroom")
			Global.player_mushroom_collection.append("Amanita")
			
	
	
	
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
	if Global.PlayerSelect == 0:
		Global.PlayerSelect = 1
	else:
		Global.PlayerSelect = 0



func _on_next_pressed():
	Global.PlayerSelect += 1
	if Global.PlayerSelect >= MAX_INDEX:
		Global.PlayerSelect = MIN_INDEX

		

