class_name Player extends CharacterBody2D

# Player movement
@export var ACCELERATION = 75
@export var FRICTION = 50
@export var SPEED = 200

@onready var timer = $RefreshTimer

# Bullet preload
var bullet = preload("res://Entities/Bullet.tscn")

# End game preload
var endgame = preload("res://UI/PlayAgain.tscn")


func _ready():
	add_to_group("enemy_killed")


func _physics_process(_delta):
	var input_vector = Vector2.ZERO

	# Face player towards mouse
	look_at(get_global_mouse_position())

	# Gather movement key input into new input_vector
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

	set_velocity(velocity)
	move_and_slide()

	# Handle weapon firing
	if Input.is_action_just_pressed("mouse_left"):
		fire()


func death():
	load_endgame("Lost")


func enemy_killed():
	var enemies_remaining = get_parent().get_node("Enemies").get_child_count()
	if enemies_remaining == 0:
		load_endgame("Won")


func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.initialize(get_global_position(), rotation_degrees)
	get_parent().add_child(bullet_instance)


func load_endgame(status):
	var endgame_instance = endgame.instantiate()
	endgame_instance.initialize(status)

	get_tree().root.add_child(endgame_instance)
	get_parent().queue_free()


func _on_HitBox_body_entered(_body):
	if _body is Enemy:
		death()


# Force a refresh on a set interval to catch slow or missed updates (Only seen on the web)
func _on_RefreshTimer_timeout():
	enemy_killed()
