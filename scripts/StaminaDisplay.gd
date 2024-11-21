extends CanvasLayer


@onready var stamina_label = $Label  # Adjust the path if needed

func update_stamina(current_stamina: int, max_stamina: int):
	if stamina_label and stamina_label is Label:
		stamina_label.text = "Stamina: %d/%d" % [current_stamina, max_stamina]
	else:
		print("Error: stamina_label is not correctly assigned or not a Label node.")
