extends CharacterBody2D

const SPEED = 600

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * SPEED
	print(global_position)
	move_and_slide()
