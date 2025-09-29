extends Control

@onready var slot_scene = preload("res://System_task_manager/slot.tscn")
@onready var grid_container = $Background/MarginContainer/VBoxContainer/ScrollContainer/GridContainer
@onready var task_scene = preload("res://System_task_manager/task.tscn")
@onready var scroll_container = $Background/MarginContainer/VBoxContainer/ScrollContainer
@onready var col_count = grid_container.columns #save column number
@onready var pointer_1 = $Spawn_1

var previous_mouse_position:Vector2 = Vector2(150,-20)
var button_pressed : bool = false

var grid_array := []
var task_held = null
var current_slot = null
var can_place := false
var icon_anchor : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(2):
		create_slot()
	spawn_process_alone()
	place_task_alone()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if button_pressed:
		var current_mouse_position = get_viewport().get_mouse_position()
		var mouse_delta = current_mouse_position-previous_mouse_position
		global_position = lerp(global_position, mouse_delta, 25 * delta)
	if task_held:
		if Input.is_action_just_pressed("mouse_rightclick"):
			rotate_task()
		
		if Input.is_action_just_pressed("mouse_leftclick"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				place_task()
	else:
		if Input.is_action_just_pressed("mouse_leftclick"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				pick_task()
	
	
func create_slot(): 
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	grid_container.add_child(new_slot)
	grid_array.push_back(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered)
	new_slot.slot_exited.connect(_on_slot_mouse_exited)
	pass


func _on_slot_mouse_entered(a_Slot):
	icon_anchor = Vector2(10000,100000)
	current_slot = a_Slot
	if task_held:
		check_slot_availability(current_slot)
		set_grids.call_deferred(current_slot)
	
func _on_slot_mouse_exited(a_Slot):
	clear_grid()
	
	if not grid_container.get_global_rect().has_point(get_global_mouse_position()):
		current_slot = null

func _on_button_spawn_pressed():
	var new_task = task_scene.instantiate()
	add_child(new_task)
	new_task.load_task(randi_range(1,4))    #randomize this for different tasks to spawn
	new_task.selected = true
	task_held = new_task
	
	
func check_slot_availability(a_Slot):
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
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			continue
		#make sure the check don't wrap around boarders
		var line_switch_check = a_Slot.slot_ID % col_count + grid[0]
		if line_switch_check <0 or line_switch_check >= col_count:
			continue
		
		if can_place:
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.FREE)
			#save anchor for snapping
			if grid[1] < icon_anchor.x: icon_anchor.x = grid[1]
			if grid[0] < icon_anchor.y: icon_anchor.y = grid[0]
				
		else:
			print("can't place")
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.TAKEN)

func clear_grid():
	for grid in grid_array:
		grid.set_color(grid.States.DEFAULT)

func rotate_task():
	task_held.rotate_task()
	clear_grid()
	if current_slot:
		_on_slot_mouse_entered(current_slot)

func place_task():
	if not can_place or not current_slot: 
		return #put indication of placement failed, sound or visual here
		
	#for changing scene tree
	task_held.get_parent().remove_child(task_held)
	grid_container.add_child(task_held)
	task_held.global_position = get_global_mouse_position()
	####
	var calculated_grid_id = current_slot.slot_ID + icon_anchor.x * col_count + icon_anchor.y
	task_held._snap_to(grid_array[calculated_grid_id].global_position)
	print(calculated_grid_id)
	task_held.grid_anchor = current_slot
	for grid in task_held.task_grids:
		var grid_to_check = current_slot.slot_ID + grid[0] + grid[1] * col_count
		grid_array[grid_to_check].state = grid_array[grid_to_check].States.TAKEN 
		grid_array[grid_to_check].task_stored = task_held
	
	#put task into a data storage here
	
	task_held = null
	clear_grid()
	
func pick_task():
	if not current_slot or not current_slot.task_stored: 
		return
	task_held = current_slot.task_stored
	task_held.selected = true
	#move node in the scene tree
	task_held.get_parent().remove_child(task_held)
	add_child(task_held)
	task_held.global_position = get_global_mouse_position()
	####
	
	for grid in task_held.task_grids:
		var grid_to_check = task_held.grid_anchor.slot_ID + grid[0] + grid[1] * col_count # use grid anchor instead of current slot to prevent bug
		grid_array[grid_to_check].state = grid_array[grid_to_check].States.FREE 
		grid_array[grid_to_check].task_stored = null
	
	check_slot_availability(current_slot)
	set_grids.call_deferred(current_slot)
	
	


func _on_add_slot_pressed():
	create_slot()


func _on_button_button_down() -> void:
	print("Pressionado")
	button_pressed = true


func _on_button_button_up() -> void:
	print("Pressionado")
	button_pressed = false


func _on_minimizar_pressed() -> void:
	self.visible = false

func spawn_process():
	var new_task = task_scene.instantiate()
	add_child(new_task)
	new_task.load_task(randi_range(1,4))    #randomize this for different tasks to spawn
	new_task.selected = true
	task_held = new_task

func place_task_alone():
	if not can_place or not current_slot: 
		return #put indication of placement failed, sound or visual here
		
	#for changing scene tree
	task_held.get_parent().remove_child(task_held)
	grid_container.add_child(task_held)
	task_held.global_position = pointer_1.global_position
	####
	var calculated_grid_id = current_slot.slot_ID + icon_anchor.x * col_count + icon_anchor.y
	task_held._snap_to(grid_array[calculated_grid_id].global_position)
	print(calculated_grid_id)
	task_held.grid_anchor = current_slot
	for grid in task_held.task_grids:
		var grid_to_check = current_slot.slot_ID + grid[0] + grid[1] * col_count
		grid_array[grid_to_check].state = grid_array[grid_to_check].States.TAKEN 
		grid_array[grid_to_check].task_stored = task_held
	
	#put task into a data storage here
	
	task_held = null
	clear_grid()
	
func spawn_process_alone():
	var new_task = task_scene.instantiate()
	add_child(new_task)
	new_task.load_task(randi_range(1,4))    #randomize this for different tasks to spawn
	new_task.selected = true
	task_held = new_task
