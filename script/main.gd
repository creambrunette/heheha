extends Node

var giampihealth: int = 3
var isincar:bool = false

func _physics_process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
