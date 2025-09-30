extends Control
var button_pressed : bool = false
var previous_mouse_position:Vector2 = Vector2(150,-20)
@onready var timer_generic = %timer_generic
 

func _on_minimizar_pressed() -> void:
	self.visible = false


func _on_fechar_pressed() -> void:
	$close.play()
	self.queue_free()

func _process(delta: float) -> void:
	if button_pressed:
		var current_mouse_position = get_viewport().get_mouse_position()
		var mouse_delta = current_mouse_position-previous_mouse_position
		global_position = lerp(global_position, mouse_delta, 25 * delta)
	#lerp(global_position, get_global_mouse_position(), 25 * delta)

func _on_button_button_down() -> void:
	print("Pressionado")
	button_pressed = true
	$drag.play()


func _on_button_button_up() -> void:
	print("Deselecionado")
	button_pressed = false
