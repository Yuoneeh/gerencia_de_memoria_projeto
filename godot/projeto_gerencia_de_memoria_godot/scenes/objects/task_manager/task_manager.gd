extends Control


func _on_minimizar_pressed() -> void:
	self.queue_free()


func _on_fechar_pressed() -> void:
	self.queue_free()
