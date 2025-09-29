extends Node
var ram_being_used = ItemData.ram_used


func _process(delta: float) -> void:
	ram_being_used = ItemData.ram_used
	gameover()


func gameover():
	
	if (ram_being_used >= 2000):
		get_tree().quit()
