extends CharacterBody2D

const SPEED = 600

func _ready():
	get_node("Girl").play("Idle")

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * SPEED
	if velocity:
		get_node("Girl").play("Run")
	else:
		get_node("Girl").play("Idle")
	move_and_slide()
