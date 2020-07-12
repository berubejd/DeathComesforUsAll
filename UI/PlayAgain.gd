extends Control

func initialize(status):
	if status == "Won":
		$VBoxContainer/Label.text = "Victory is yours.  Today."
	else:
		$VBoxContainer/Label.text = "Death comes for us all."


func _on_Button_pressed():
	var _return = get_tree().change_scene("res://World.tscn")
	queue_free()
