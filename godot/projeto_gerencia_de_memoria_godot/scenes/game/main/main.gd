extends Node2D
@onready var Sum_label = %Sum_of_ram
@export var Browser = PackedScene
@export var Email = PackedScene
@export var MSN = PackedScene
@export var server = PackedScene
@onready var spawn_position = $Marker2D
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var gameover_timer = $gameover_condition/Timer
@onready var points = %pontos

func spawn_random_program():
	var program_pool = [Browser, Email, MSN, server]
	var picked_program = program_pool.pick_random()
	
	var new_program = picked_program.instantiate()

	add_child(new_program)
	new_program.global_position = spawn_position.position

func _ready() -> void:
	$ost.play()
	progress_bar.max_value = gameover_timer.wait_time

func _process(delta: float) -> void:
	Sum_label.text = "Ram em uso: " + str(ItemData.ram_used)
	
	progress_bar.value = gameover_timer.time_left
	
	points.text = ("Pontos: " + str(ItemData.points))

func _on_timer_timeout() -> void:
	print("Program Spawn")
	spawn_random_program()
