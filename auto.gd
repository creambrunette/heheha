extends CharacterBody2D

var canenter: bool = false
@onready var player = $"../giampi"

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and canenter and !Main.isincar:
		Main.isincar = true
		$Camera2D.enabled = true
		print(Main.isincar)
	if Main.isincar and Input.is_action_just_pressed("exitCar"):
		Main.isincar = false
		$Camera2D.enabled = false
		print(Main.isincar)
		

func _on_interaction_zone_body_entered(body):
	if body.name == "giampi":
		canenter = true
		await get_tree().create_timer(0.5).timeout

func _on_interaction_zone_body_exited(body):
	if body.name == "giampi":
		canenter = false
