extends Node

@export var Browser = PackedScene
@export var Email = PackedScene
@export var MSN = PackedScene
@export var server = PackedScene
@onready var spawn_position = $"../Marker2D"
signal task_created




func spawn_random_program():
	var program_pool = [Browser, Email, MSN, server]
	var picked_program = program_pool.pick_random()
	
	var new_program = picked_program.instantiate()

	add_child(new_program)
	new_program.global_position = spawn_position.position
	

func _on_timer_timeout() -> void:
	task_created.emit()
	print("Program Spawn")
	spawn_random_program()
