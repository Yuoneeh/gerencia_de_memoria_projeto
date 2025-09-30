extends Node2D



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/main/main.tscn")


func _on_button_2_pressed() -> void:
	OS.shell_open("https://yuoneeh.itch.io/") 
