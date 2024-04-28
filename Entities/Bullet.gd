class_name Bullet extends RigidBody2D

# Bullet parameters
@export var SPEED = 500

@onready var animation = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D

var despawning = false

func initialize(new_position, new_rotation):
	position = new_position
	rotation_degrees = new_rotation


func _ready():
	apply_impulse(Vector2(SPEED,0).rotated(rotation), Vector2())


func _on_Bullet_body_entered(_body):
	if not despawning:
		despawning = true
		
		animation.play("FadeOut")
		await animation.animation_finished

		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
