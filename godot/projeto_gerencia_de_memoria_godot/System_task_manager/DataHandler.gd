extends Node

var task_data := {}
var task_grid_data := {}
@onready var task_data_path = "res://Data/Task_data.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data(task_data_path)
	set_grid_data()

#load the data file
func load_data(path : String) -> void:
	if not FileAccess.file_exists(path):
		print("Item Data file not found")
	var task_data_file = FileAccess.open(path, FileAccess.READ)
	task_data = JSON.parse_string(task_data_file.get_as_text())
	task_data_file.close()
	#print(task_data)	#check value
	
#process the json and put the grid information into accessable array format for iterating
func set_grid_data() -> void:
	for task in task_data.keys():
		var temp_grid_array := []
		for point in task_data[task]["Grid"].split("/"):
			temp_grid_array.push_back(point.split(","))
		task_grid_data[task] = temp_grid_array
	#print(task_grid_data)	#check values
	
