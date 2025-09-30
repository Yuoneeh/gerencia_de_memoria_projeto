extends Node
var ram_being_used = ItemData.ram_used


func _process(delta: float) -> void:
	ram_being_used = ItemData.ram_used
	gameover()


func gameover():
	if ItemData.hp_count <= 0:
		get_tree().change_scene_to_file("res://scenes/game/main/game_over.tscn")


func _on_timer_timeout() -> void:
	print(ItemData.hp_count)
	if (ram_being_used >= 2000):
		ItemData.hp_count -= 1
		print(ItemData.hp_count)
	else:
		ItemData.points += 100
		$"../point_sound".play()
