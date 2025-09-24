extends Control


func _on_minimizar_pressed() -> void:
	self.visible = false


func _on_fechar_pressed() -> void:
	self.queue_free()
