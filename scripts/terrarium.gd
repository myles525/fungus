extends Node2D

@onready var money_label = $itemsPanel/MoneyLabel
@onready var food_label = $itemsPanel/FoodLabel
@onready var fungus_label = $fungusPanel/FungusLabel
@onready var level_label = $fungusPanel/VBoxContainer/LevelLabel
@onready var stamina_label = $fungusPanel/VBoxContainer/StaminaLabel
@onready var levelup_label = $fungusPanel/VBoxContainer/LevelUp

# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()
	update_label_with_array(Global.player_mushroom_collection)


# Update the labels with the current values
func update_labels():
	money_label.text = "Mushies: %d" % int(Global.total_money)
	food_label.text = "Food: %d" % int(Global.food)
	level_label.text = "Current Level: %d" % int(Global.current_level)
	stamina_label.text = "Max Stamina: %d" % int(Global.max_stamina)
	levelup_label.text = "Food to Level: %d" %int(Global.get_level_up_cost())
	#fungus_label.text = "Current Mushroom %s" % (Global.PlayerSelect)


func update_label_with_array(array: Array):
	# Create a new array to hold unique elements
	var unique_array = []
	for item in array:
		if item not in unique_array:
			unique_array.append(item)
	
	# Create a string representation of the unique array
	var array_string = ""
	for i in range(unique_array.size()):
		array_string += str(unique_array[i])
		if i < unique_array.size() - 1:
			array_string += ", "
	
	# Update the label with the unique array elements
	fungus_label.text = "Fungus: %s" % array_string




# This function will run every frame
func _process(delta):
	update_labels()  # Continuously update the labels
	update_label_with_array(Global.player_mushroom_collection)
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/room.tscn")


func _on_buy_food_pressed():
	if Global.total_money < 0:
		Global.total_money = 0
	if Global.total_money >= 20:
		Global.total_money -= 20
		Global.food += 1


#func _on_level_up_pressed():
	#if Global.food >= 1:
		#Global.food -= 5
		#Global.level_up()
		#print(Global.current_level)
		#print(Global.max_stamina)

func _on_level_up_pressed():
	# Check if the player has enough food to level up.
	if Global.food >= Global.get_level_up_cost():
		# Deduct food based on the level-up cost.
		Global.food -= Global.get_level_up_cost()
		
		
		# Call level up function and print updated stats.
		Global.level_up()
		print("Level:", Global.current_level)
		print("Max Stamina:", Global.max_stamina)
		print("Food:", Global.food)
	else:
		print("Not enough food to level up!")

# Function to calculate stamina increase based on level
#func calculate_stamina_increase(level: int) -> int:
	#return level * 2 + 10

# Function to calculate food cost for leveling up, e.g., scaling with level.


# Function to calculate experience required for the next level.
#func calculate_exp_requirement(level: int) -> int:
	#return level * 100
	#print(level)


func _on_fungus_select_pressed():
	get_tree().change_scene_to_file("res://scenes/fungus_selection.tscn")
