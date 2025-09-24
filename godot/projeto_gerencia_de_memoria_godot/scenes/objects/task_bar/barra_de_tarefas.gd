extends Control

@export var task_manager : PackedScene


func _on_task_manager_pressed() -> void:
	
	var task_manager_spawn = task_manager.instantiate() as Control
	get_parent().add_child(task_manager_spawn)
	task_manager_spawn.position.x = 27.0
	task_manager_spawn.position.y = 106.0
