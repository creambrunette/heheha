extends CharacterBody2D

const SPEED = 500
var canenter: bool = false
@onready var player = $"../giampi"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and canenter and !Main.isincar:
		Main.isincar = true
		$Camera2D.enabled = true
		print(Main.isincar)
	if Main.isincar and Input.is_action_just_pressed("exitCar"):
		Main.isincar = false
		player.position.x = self.position.x - 80
		player.position.y = self.position.y
		$Camera2D.enabled = false
		print(Main.isincar)
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("left", "right")
	if direction and Main.isincar:
		velocity.x = direction * SPEED
		if direction == 1:
			$AutoPng.flip_h = false
		else:
			$AutoPng.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _on_interaction_zone_body_entered(body):
	if body.name == "giampi":
		canenter = true
		await get_tree().create_timer(0.5).timeout

func _on_interaction_zone_body_exited(body):
	if body.name == "giampi":
		canenter = false
