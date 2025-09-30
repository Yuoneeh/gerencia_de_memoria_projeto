extends "res://scenes/objects/task_manager/task_grid.gd"

func _ready() -> void:
	add_item("1")
	add_item("2")
	add_item("3")
	add_item("1")

func calculate():
	var sum = 0 
	
	for i in get_children():
		sum += i.get_SIZE()
	
