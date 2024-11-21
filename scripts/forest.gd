extends Node2D

# Array to track visited grid positions
var visited_squares = []


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.walk_scene = "forest"
	# Reference to the character instance
	if Global.PlayerSelect == null:
		Global.PlayerSelect = 0
	
	# Access the current value of Global.PlayerSelect
	var current_selection = Global.PlayerSelect
	print("Current PlayerSelect value: ", current_selection)
	
	# Modify the Global.PlayerSelect value
	Global.PlayerSelect = (current_selection) % Global.character_scenes.size()
	print("New PlayerSelect value: ", Global.PlayerSelect)
	
	# Optionally, you can perform actions based on the new value
	update_character_scene()
	
	# Connect to the character's moved signal
	var character = $CharacterHolder.get_child(0)
	if character:
		character.connect("moved", Callable(self, "_on_character_moved"))

	else:
		print("Error: CharacterHolder node not found.")
	




func update_character_scene():
	# Get the current character scene based on the Global.PlayerSelect value
	var current_index = Global.PlayerSelect
	var character_scene = Global.character_scenes[current_index]
	var character_instance = character_scene.instantiate()
	
	# Add the character instance to the desired node
	var character_holder = $CharacterHolder
	character_holder.add_child(character_instance)
	
	# Ensure the new character instance fills the CharacterHolder
	if character_instance is Control:
		character_instance.anchor_left = 0.0
		character_instance.anchor_right = 1.0
		character_instance.anchor_top = 0.0
		character_instance.anchor_bottom = 1.0
		character_instance.offset_left = 0.0
		character_instance.offset_right = 0.0
		character_instance.offset_top = 0.0
		character_instance.offset_bottom = 0.0
	

func _on_character_moved(new_position: Vector2):
	# Convert new position to grid coordinates
	var grid_size = Vector2(80, 80)  # Adjust based on your grid size
	var character_holder_position = $CharacterHolder.position
	var local_position = new_position - character_holder_position
	var grid_position = (local_position / grid_size).floor()

	# Debugging output
	print("Character moved to new position: ", new_position)
	print("CharacterHolder position: ", character_holder_position)
	print("Converted local position: ", local_position)
	print("Converted grid position: ", grid_position)

	# Add to visited squares if not already present
	if grid_position not in visited_squares:
		visited_squares.append(grid_position)
		mark_visited_square(new_position)
	
	
		
func mark_visited_square(character_position: Vector2):
	# Create a new ColorRect to mark the visited square
	var visited_marker = ColorRect.new()
	visited_marker.color = Color(0, 1, 0, 0.3)  # Red with transparency
	visited_marker.set_size(Vector2(80, 80))  # Size of the ColorRect
	visited_marker.position = character_position - Vector2(40, 40)  # Center the ColorRect on the character
	visited_marker.z_index = 1  # Bring to front

	# Debugging output
	print("Adding ColorRect at position: ", visited_marker.position, " with size: ", visited_marker.size)

	# Ensure the ColorRect is added to the correct parent node
	$CharacterHolder.add_child(visited_marker)
	



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/room.tscn")
