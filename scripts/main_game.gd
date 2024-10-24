extends Control
#
#var character_scenes = [
	#preload("res://scenes/enoki_mushroom.tscn"),
	#preload("res://scenes/red_mushroom.tscn")
#]
#
## Method to set the selected character
#func set_selected_character(character_scene: PackedScene):
	#print("Global character:", Global.selected_character)
	## Instance the character scene
	#var character_instance = character_scene.instantiate()
	#print(character_instance)
	#
	## Get the CharacterHolder node
	#var character_holder = $CharacterHolder
	#
	#
	## Remove the existing child node if it exists
	#if character_holder.get_child_count() > 0:
		#print(character_instance)
		#character_holder.get_child(0).queue_free()
	#
	## Add the new character instance to CharacterHolder
	#character_holder.add_child(character_instance)
	#print(character_holder.get_child_count())
	#
	## Ensure the new character instance fills the CharacterHolder
	#if character_instance is Control:
		#print("Show me")
		#print("Type of character_instance: %s" % typeof(character_instance))
		#
		#character_instance.anchor_left = 0.0
		#character_instance.anchor_right = 1.0
		#character_instance.anchor_top = 0.0
		#character_instance.anchor_bottom = 1.0
		#character_instance.offset_left = 0.0
		#character_instance.offset_right = 0.0
		#character_instance.offset_top = 0.0
		#character_instance.offset_bottom = 0.0
		#
		#print("Anchors set: left=%f, right=%f, top=%f, bottom=%f" % [character_instance.anchor_left, character_instance.anchor_right, character_instance.anchor_top, character_instance.anchor_bottom])
		#print("Offsets set: left=%f, right=%f, top=%f, bottom=%f" % [character_instance.offset_left, character_instance.offset_right, character_instance.offset_top, character_instance.offset_bottom])
		#
		## Ensure the node is added to the scene tree and is visible
		#if character_instance.get_parent() and not character_instance.get_parent().visible:
			#print("Parent node is not visible. Making it visible now.")
			#character_instance.get_parent().visible = true
		#print("Z-index of character_instance: %d" % character_instance.z_index)
		#if not character_instance.visible:
			#print("character_instance is not visible.")
		## Check the size
		#size = character_instance.get_minimum_size()
		#print("Size of character_instance: %s" % str(size))
			#
	#else:
		#print("character_instance is not a Control node.")
	##if character_instance is Control:
		##character_instance.set_anchors_and_margins_preset(Control.PRESET_FULL_RECT)
	##else:
		##character_instance.set_position(Vector2.ZERO)
		##character_instance.set_size(character_holder.get_size())
# AnotherScript.gd


func _ready():
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
