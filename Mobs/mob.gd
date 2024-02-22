extends CharacterBody2D

const SPEED = 10
@onready var base = get_node("/root/World/Base")

func _physics_process(delta):
	velocity.x += SPEED * delta
	move_and_slide()
