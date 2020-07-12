extends Particles2D


func _physics_process(_delta):
	if not emitting:
		get_tree().call_group("enemy_killed", "enemy_killed")
		queue_free()
