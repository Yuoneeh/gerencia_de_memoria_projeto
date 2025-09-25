extends Node2D

@onready var IconRect_path = $Icon

var task_ID : int
var task_grids := []
var selected = false
var grid_anchor = null

func _process(delta) -> void:
	pass
	
func load_task(a_taskID : int)-> void:
	var Icon_path = "res://scenes/objects/tasks_2_0/" + DataHandler.task_data[str(a_taskID)]["Name"] + ".png"
	IconRect_path.texture = load(Icon_path)
	for grid in DataHandler.task_grid_data[str(a_taskID)]:
		var converter_array := []
		for i in grid:
			converter_array.push_back(int(i))
