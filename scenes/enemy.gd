extends CharacterBody2D


const SPEED: int = 70

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var attackArea = $attackArea

var health: int

func _ready():
	health= 3

func _physics_process(_delta):
	move_and_slide()

func _on_attack_area_body_entered(body):
	if body.name == "giampi":
		Main.giampihealth -= 1

func _on_player_detection_body_entered(body):
	if body.name == "giampi":
		var playerDirection = self.position.x - body.position.x 
		if playerDirection > 0:
			playerDirection = -1
			$attackArea.scale.x = -1
		elif playerDirection < 0:
			playerDirection = 1
			$attackArea.scale.x = 1
		if playerDirection:
			velocity.x = playerDirection * SPEED

func takeDamage(a: int):
	health -= 1
	if health <= 0:
		self.queue_free()

func _on_player_detection_body_exited(body):
	if body.name == "giampi":
		velocity.x = 0
