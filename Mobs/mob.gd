extends CharacterBody2D

const SPEED = 10
@onready var base = get_node("/root/World/Base")

func _physics_process(delta):
	#var direction = global_position.direction_to(base.global_position)
	velocity.x += SPEED * delta
	move_and_slide()
