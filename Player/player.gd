extends CharacterBody2D

const SPEED = 600
var shooting = false

@onready var anim = get_node("AnimationPlayer")

func _ready():
	if shooting == false:
		get_node("Girl").play("Idle")

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("shoot") and shooting == false:
		shoot_gun()
	
	if velocity:
		if shooting == false:
			anim.play("Run")
	else:
		if !shooting:
			anim.play("Idle")
	move_and_slide()

func _on_timer_timeout():
	shooting = false
	anim.play("Idle")
	get_node("Timer").wait_time = 0.4

func shoot_gun():
	const BULLET = preload("res://Player/bullet.tscn")
	var newBullet = BULLET.instantiate()
	get_node("ShootingPoint").add_child(newBullet)
	newBullet.global_position = get_node("ShootingPoint").global_position
	shooting = true
	anim.play("Shoot")
	newBullet.shoot()
	get_node("Timer").start()
