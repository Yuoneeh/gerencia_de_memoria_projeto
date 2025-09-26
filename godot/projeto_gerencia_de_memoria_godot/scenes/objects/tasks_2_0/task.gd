extends Node2D

@onready var IconRect_path = $Icon

var task_ID : int
var task_grids := []
var selected = false
var grid_anchor = null

func _ready() -> void:
	pass


func _process(delta) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	
func load_task(a_taskID : int)-> void:
	var Icon_path = "res://scenes/objects/tasks_2_0/" + DataHandler.task_data[str(a_taskID)]["Name"] + ".png"
	IconRect_path.texture = load(Icon_path)
	for grid in DataHandler.task_grid_data[str(a_taskID)]:
		var converter_array := []
		for i in grid :
			converter_array.push_back(int(i))
		task_grids.push_back(converter_array)


func rotate_task():
	for grid in task_grids:
		var temp_y = grid[0]
		grid[0] = -grid[1]
		grid[1] = temp_y
	rotation_degrees += 90
	if rotation_degrees >= 360:
		rotation_degrees = 0

func _snap_to(destination):
	var tween = get_tree().create_tween()
	#separate cases to avoid snapping errors
	if int(rotation_degrees) % 180 == 0:
		destination += IconRect_path.size/2
	else:
		var temp_xy_switch = Vector2(IconRect_path.size.y,IconRect_path.size.x)
		destination += temp_xy_switch/2
	tween.tween_property(self, "global_position", destination, 0.15).set_trans(Tween.TRANS_SINE)
	selected = false
