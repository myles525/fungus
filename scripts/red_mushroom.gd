extends Control

# Grid size in pixels
@export var grid_size: int = 80
@onready var stamina_display = $StaminaDisplay
signal moved
# Target position for snapping
var target_position: Vector2

# RayCast2D nodes for collision detection
@onready var raycast_up = $RayCast2D_Up
@onready var raycast_down = $RayCast2D_Down
@onready var raycast_left = $RayCast2D_Left
@onready var raycast_right = $RayCast2D_Right
@onready var confirmation_dialog = $ConfirmationDialog
# Flag to track if the character is moving
var is_moving: bool = false

# Stamina variables
@export var max_stamina: int = Global.max_stamina
@export var stamina_cost_per_move: int = 1
var current_stamina: int

# TileMap node for marking visited tiles
@onready var visited_tiles = $VisitedTiles

# Function to initialize the stamina display reference
func init_stamina_display(stamina_label):
	stamina_display = stamina_label

func _ready():
	Global.reward_counter = 0
	# Initialize the target position to the current position
	target_position = position
	
	# Enable RayCast2D nodes
	raycast_up.enabled = true
	raycast_down.enabled = true
	raycast_left.enabled = true
	raycast_right.enabled = true

	# Initialize stamina
	current_stamina = max_stamina    
	
	# Mark the initial position as visited
	if visited_tiles:
		mark_visited_tile(position)
	else:
		print("Error: VisitedTiles TileMap node not found")

	# Update the stamina display initially
	update_stamina_display()

func _process(delta):
	# Move towards the target position
	if position != target_position:
		is_moving = true
		var direction = (target_position - position).normalized()
		var distance = (target_position - position).length()
		var move_amount = min(grid_size * delta, distance)
		position += direction * move_amount
		
		# Snap to target position if close enough
		if position.distance_to(target_position) < 1:
			position = target_position
			is_moving = false
			mark_visited_tile(position)
	else:
		is_moving = false

func _unhandled_input(event):
	# Handle movement input when character is not moving and has enough stamina
	if event is InputEventKey and event.pressed and not is_moving and current_stamina > 0:
		match event.keycode:
			Key.KEY_UP:
				raycast_up.force_raycast_update()
				if not raycast_up.is_colliding():
					target_position.y -= grid_size
					move_character()
			Key.KEY_DOWN:
				raycast_down.force_raycast_update()
				if not raycast_down.is_colliding():
					target_position.y += grid_size
					move_character()
			Key.KEY_LEFT:
				raycast_left.force_raycast_update()
				if not raycast_left.is_colliding():
					target_position.x -= grid_size
					move_character()
			Key.KEY_RIGHT:
				raycast_right.force_raycast_update()
				if not raycast_right.is_colliding():
					target_position.x += grid_size
					move_character()

func move_character():
	# Move the character and emit the moved signal
	is_moving = true
	current_stamina -= stamina_cost_per_move
	update_stamina_display()
	emit_signal("moved", target_position)
	if current_stamina == 0:
		confirmation_dialog.popup()
	

func mark_visited_tile(world_position: Vector2):
	# Mark the tile at world_position as visited
	if visited_tiles:
		var local_position = visited_tiles.to_local(world_position)
		var cell_position = visited_tiles.local_to_map(local_position)
		visited_tiles.set_cell(0, cell_position, 1)  # Set the cell as "visited" on the specified layer and tile ID
	else:
		print("Error: VisitedTiles TileMap node not found")

func update_stamina_display():
	print(current_stamina)
	
	print("in update_stamina_display")
	stamina_display.update_stamina(current_stamina, max_stamina)

func on_stamina_depleted_confirmed():
	if current_stamina == 0:
		print("User confirmed the action.")
	
	




func _on_confirmation_dialog_confirmed():
	var i = 0
	while i < Global.reward_counter:
		i+=1
		var multiplier = int(randf_range(2.0, 5.0))
		var reward = multiplier * Global.reward_counter
		Global.food += reward
	get_tree().change_scene_to_file("res://scenes/terrarium.tscn")


func _on_confirmation_dialog_canceled():
	if (Global.walk_scene == "cave"):
		get_tree().change_scene_to_file("res://scenes/cave.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/forest.tscn")
