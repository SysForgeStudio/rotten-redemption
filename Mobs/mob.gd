extends CharacterBody2D

const SPEED = 900
var speed_multiplier = 6
@onready var base = get_node("/root/World/Base")

func _physics_process(delta):
	velocity.x = SPEED * delta * speed_multiplier
	move_and_slide()
