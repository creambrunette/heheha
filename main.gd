extends Node2D

var giampi: bool = false

func _ready():
	$ParallaxBackground.visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("giampimode"):
		if giampi:
			giampi = false
			$ParallaxBackground.visible = false
		else:
			giampi = true
			$ParallaxBackground.visible = true

func _on_quit_pressed():
	get_tree().quit()

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://giampihouse.tscn")
