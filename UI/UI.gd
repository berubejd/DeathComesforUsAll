extends CanvasLayer

onready var control = $Control
onready var count_label = $Control/CenterContainer/HBoxContainer/CountLabel

var starting_enemies


func _ready():
	add_to_group("enemy_killed")


func enemy_killed():
	var enemies_remaining = get_parent().get_node("Enemies").get_child_count()
	count_label.text = str(enemies_remaining) + " / " + str(starting_enemies)
	
	if not control.visible:
		control.visible = true
