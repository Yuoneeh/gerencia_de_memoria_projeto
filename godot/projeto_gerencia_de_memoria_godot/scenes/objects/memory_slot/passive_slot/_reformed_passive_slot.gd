extends reformed_slot


func _ready() -> void:
	pass

func _can_drop_data(_pos, data):
	return data is TextureRect and data.slot_type == slot_type
