extends Node

var task_data := {}
var task_grid_data := {}
@onready var task_data_path = "res://Data/task_data.json"

func _ready() -> void:
	load_data(task_data_path)
	set_grid_data()
	
func load_data(a_path) -> void:
	if not FileAccess.file_exists(a_path):
		print("Task data file not found")
	var task_data_file = FileAccess.open(a_path, FileAccess.READ)
	task_data = JSON.parse_string(task_data_file.get_as_text())
	task_data_file.close()
	print(task_data)
	
func set_grid_data():
	for task in task_data.keys():
		var temp_grid_array := []
		for point in task_data[task]["Grid"].split("/"):
			temp_grid_array.push_back(point.split(","))
		task_grid_data[task] = temp_grid_array
	print(task_grid_data)
		
	
