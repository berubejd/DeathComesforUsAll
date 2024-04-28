extends Control


func initialize(status):
	var label = $VBoxContainer/Label
	var button = $VBoxContainer/Button

	if status == "Won":
		label.text = "Victory is yours.  Today."
	else:
		label.text = "Death comes for us all."
		
	button.text = "Play Again?"


func _ready():
	# Since this can be manually swapped, ensure that we are setting the current_scene appropriately when we enter
	get_tree().current_scene = self


func _on_Button_pressed():
	var _return = get_tree().change_scene_to_file("res://World.tscn")
