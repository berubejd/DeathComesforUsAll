class_name Enemy extends CharacterBody2D

# Enemy movement
@export var acceleration = 30
@export var speed = 100

@onready var player: CharacterBody2D = null
@onready var navigation_agent = $NavigationAgent2D as NavigationAgent2D
@onready var path_timer = $PathingTimer as Timer

var explosion = preload("res://Entities/Explosion.tscn")


func _ready():
	player = get_tree().get_root().find_child("Player", true, false)
	path_timer.start(randf())


func _physics_process(delta):
	var path = navigation_agent.get_next_path_position()
	look_at(path)
	
	#var direction = to_local(path.normalized())
	var direction = (path - global_position).normalized()
	velocity = velocity.lerp(direction * speed, acceleration * delta)

	move_and_slide()

func _on_HitBox_body_entered(body):
	if body is Bullet:
		var explosion_instance = explosion.instantiate()
		explosion_instance.position = global_position
		explosion_instance.emitting = true
		get_tree().get_root().find_child("Effects", true, false).add_child(explosion_instance)
		queue_free()

func _on_PathingTimer_timeout():
	path_timer.start(randf() / 2)
	make_path()


func make_path():
	if player:
		navigation_agent.set_target_position(player.global_position)
