extends Control

func _on_new_game_pressed():
	get_tree().change_scene_to_file("insertfile")


func _on_load_game_pressed():
	get_tree().change_scene_to_file("insertfileoptions")


func _on_exit_game_pressed():
	get_tree().quit()
