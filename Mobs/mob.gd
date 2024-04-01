extends CharacterBody2D

var speed = 1200
var health = 150
var direction_after_change
var is_eating = false
var speed_multiplier = randi_range(2,5)
@onready var base = get_node("/root/World/Base")
@onready var player = get_node("/root/World/Player")
@onready var zombie = get_node("Zombie")

func _ready():
	zombie.play("Walk")
	print(speed_multiplier)

func _physics_process(delta):
	velocity.x = speed * delta * speed_multiplier
	move_and_slide()
	
	if velocity.x <= 1:
		velocity.x = 0
		is_eating = true;
		zombie.play("Idle")

func _change_movement_to_player():
	speed = 100
	zombie.play("Walk")
	is_eating = false
	direction_after_change = global_position.direction_to(player.global_position)
	velocity = direction_after_change * speed
	move_and_slide()
	
func take_damage():
	health -= 50
	get_node("AnimationPlayer").play("hurt")
	if health <= 0:
		queue_free()
