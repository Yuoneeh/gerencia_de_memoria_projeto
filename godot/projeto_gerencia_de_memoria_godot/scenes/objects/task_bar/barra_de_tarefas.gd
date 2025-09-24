extends Control

@export var task_manager : PackedScene


func _on_task_manager_pressed() -> void:
	task_manager.self.visible = true
