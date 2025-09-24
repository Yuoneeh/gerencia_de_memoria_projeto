extends Node2D

@onready var root = $"../.."

var selected = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("Help")
	if Input.is_action_just_pressed("click"):
		print("selected")
		selected = true

func _physics_process(delta: float) -> void:
	
	if selected == true:
		print("AAAAAA")
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)


func _on_area_2d_mouse_entered() -> void:
	print("Help")
	if Input.is_action_just_pressed("click"):
		print("selected")
		selected = true
