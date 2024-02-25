extends CharacterBody2D

var speed = 900
var speed_multiplier = 6
var direction_after_change

@onready var base = get_node("/root/World/Base")
@onready var player = get_node("/root/World/Player")

func _physics_process(delta):
	velocity.x = speed * delta * speed_multiplier
	move_and_slide()

func _change_movement_to_player():
	speed = 100
	direction_after_change = global_position.direction_to(player.global_position)
	velocity = direction_after_change * speed
	move_and_slide()
