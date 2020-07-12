extends Node2D

export var enemy_count = 20

onready var enemies = $Enemies
onready var spawn_points = $SpawnPoints
onready var ui = $UI

# Preload Enemies
var enemy = preload("res://Entities/Enemy.tscn")


func _ready():
	var potential_spawns = spawn_points.get_children()
	potential_spawns.shuffle()
	
	for _i in range(enemy_count):
		var enemy_instance = enemy.instance()
		var next_spawn = potential_spawns.pop_front()
		enemy_instance.position = next_spawn.position
		enemies.add_child(enemy_instance)

	ui.starting_enemies = enemy_count
