extends Control

@onready var slot_scene = preload("res://scenes/objects/slot_2_0/slot_2_0.tscn")
@onready var grid_container = $ColorRect/MarginContainer/VBoxContainer/ScrollContainer/GridContainer
@onready var task_scene = preload("res://scenes/objects/tasks_2_0/task.tscn")
@onready var scroll_container = $ColorRect/MarginContainer/VBoxContainer/ScrollContainer
@onready var col_count = grid_container.columns

var grid_array := []
var task_held = null	
var current_slot = null
var can_place := false
var icon_anchor : Vector2

func _ready() -> void:
	for i in range(16):
		create_slot()
		
		
func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	grid_array.push_back(new_slot)
	grid_container.add_child(new_slot)
	grid_array.push_back(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered)
	new_slot.slot_exited.connect(_on_slot_mouse_exited)

func _process(delta: float) -> void:
	if task_held:
		if Input.is_action_just_pressed("mouse_rightclick"):
			rotate_task()

func _on_slot_mouse_entered(a_Slot):
	icon_anchor = Vector2(10000,10000)
	current_slot = a_Slot
	if task_held:
		check_slot_availability(current_slot)
		set_grids.call_deferred(current_slot)
	
func _on_slot_mouse_exited(a_Slot):
	clear_grid()


func _on_button_spawn_pressed() -> void:
	var new_task = task_scene.instantiate()
	add_child(new_task)
	new_task.load_task(6)
	new_task.selected = true
	task_held = new_task


func check_slot_availability(a_Slot) -> void:
	for grid in task_held.task_grids:
		var grid_to_check = a_Slot.slot_ID + grid[0] + grid[1] * col_count
		var line_switch_check = a_Slot.slot_ID % col_count + grid[0]
		if line_switch_check < 0 or line_switch_check >= col_count:
			can_place = false
			return
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			can_place = false
			return
		if grid_array[grid_to_check].state == grid_array[grid_to_check].States.TAKEN:
			can_place = false
			return
	can_place = true
	
func set_grids(a_Slot):
	for grid in task_held.task_grids:
		var grid_to_check = a_Slot.slot_ID + grid[0] + grid[1] * col_count
		var line_switch_check = a_Slot.slot_ID % col_count + grid[0]
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			continue
		if line_switch_check < 0 or line_switch_check >= col_count:
			continue
			
		if can_place:
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.FREE)
			
			if grid[1] < icon_anchor.x: icon_anchor.x = grid[1]
			if grid[0] < icon_anchor.y: icon_anchor.y = grid[0]
		else:
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.FREE)

func clear_grid():
	for grid in grid_array:
		grid.set_color(grid.States.DEFAULT)

func rotate_task():
	task_held.rotate_task()
	clear_grid()
	if current_slot:
		_on_slot_mouse_entered(current_slot)
	
