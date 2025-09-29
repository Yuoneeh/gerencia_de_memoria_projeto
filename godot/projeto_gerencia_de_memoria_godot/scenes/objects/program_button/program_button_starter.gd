extends Button
@onready var scene_to_instantiate =  preload("res://scenes/objects/task_manager/task_manager.tscn")
@export var scene_to_instantiate_2 : PackedScene 
@onready var texture_button = $TextureRect
@export var button_texture : Texture

func _on_pressed() -> void:
	var new_scene = scene_to_instantiate_2.instantiate()
	add_child(new_scene)

func _ready() -> void:
	texture_button.texture = button_texture
	
