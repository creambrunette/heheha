extends CharacterBody2D

var canenter: bool = false
var playerload = preload("res://giampi.tscn")
@onready var player = $"../giampi"

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and canenter and !Main.isincar:
		Main.isincar = true
		player.queue_free()
		print(Main.isincar)
	
	if Main.isincar and Input.is_action_just_pressed("exitCar"):
		var playerinstance = playerload.instantiate()
		playerinstance.position.x = self.positon.x + 20
		add_child(playerinstance)
		Main.isincar = false
		print(Main.isincar)
		

func _on_interaction_zone_body_entered(body):
	if body.name == "giampi":
		canenter = true
		await get_tree().create_timer(0.5).timeout

func _on_interaction_zone_body_exited(body):
	if body.name == "giampi":
		canenter = false
