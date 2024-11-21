extends Node



var PlayerSelect = null
var money : int = 0
var total_money : int = 0
var food : int = 0
var reward_counter : int = 0
var max_stamina : int = 10
var player_mushroom_collection : Array = []
var current_level : int = 1

var walk_scene : String = ""




var character_scenes = [
	preload("res://scenes/enoki_mushroom.tscn"),
	preload("res://scenes/red_mushroom.tscn")
]

func level_up():
	print("current level %d " % Global.current_level)
	print("required to level %d" % Global.get_level_up_cost())
	current_level += 1
	max_stamina += 1

func get_level_up_cost() -> int:
	return int(5 * pow(1.5, Global.current_level))
#var selected_character : PackedScene = null

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
