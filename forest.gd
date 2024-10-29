extends Node2D


# Called when the node enters the scene tree for the first time.
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
	update_character_scene()
	
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
