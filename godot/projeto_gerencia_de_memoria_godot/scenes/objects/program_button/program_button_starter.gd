extends Button
@onready var scene_to_instantiate =  preload("res://scenes/objects/task_manager/task_manager.tscn")
@export var scene_to_instantiate_2 : PackedScene 
@export var spawn_pointer : Marker2D
@onready var texture_button = $TextureRect
@export var button_texture : Texture
@onready var root = $".."


func _on_pressed() -> void:
	var new_scene = scene_to_instantiate_2.instantiate()

	root.add_child(new_scene)
	#new_scene.global_position = spawn_pointer.position
	queue_free()

func _ready() -> void:
	texture_button.texture = button_texture
	
