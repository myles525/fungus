extends Control

# Grid size in pixels
@export var grid_size: int = 32

# Grid color
@export var grid_color: Color = Color(1, 1, 1, 0.5)  # White with 50% opacity

func _ready():
	# Request to redraw the grid
	queue_redraw()

func _draw():
	# Get the size of the control
	var size = get_size()
	
	# Draw vertical lines
	for x in range(0, size.x, grid_size):
		draw_line(Vector2(x, 0), Vector2(x, size.y), grid_color)
	
	# Draw horizontal lines
	for y in range(0, size.y, grid_size):
		draw_line(Vector2(0, y), Vector2(size.x, y), grid_color)



func _on_resized():
	queue_redraw()
