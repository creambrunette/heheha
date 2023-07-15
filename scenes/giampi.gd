extends CharacterBody2D

const SPEED = 300
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Main.giampihealth = 3

func _physics_process(delta):
	
	if Main.isincar:
		self.visible = false
		$CollisionShape2D.disabled = true
		$Camera2D.enabled = false
	else:
		self.visible = true
		$CollisionShape2D.disabled = false
		$Camera2D.enabled = true
	
	if Main.giampihealth <= 0:
		death()
	
	if not is_on_floor() and !Main.isincar:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("up") and is_on_floor() and !Main.isincar:
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction and !Main.isincar:
		velocity.x = direction * SPEED
		if direction == 1:
			$AnimatedSprite2D.flip_h = true
			$attackarea.scale.x = -1
		else:
			$AnimatedSprite2D.flip_h = false
			$attackarea.scale.x = 1
	else:	
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func death():
	Main.giampihealth = 3
	get_tree().reload_current_scene()

func _on_attackarea_body_entered(body):
	if body.is_in_group("hittable") and !Main.isincar:
		body.takeDamage(1)
