extends TextureRect

@export var slot_type: int = 0

@export var SIZE = 0:
	set(value):
		SIZE = value
		%debug.text = str(SIZE)

		if get_parent() is PassiveSlot:
			get_parent().get_parent().calculate()
		
		
@onready var property: Dictionary = {"TEXTURE": texture,
									 "SIZE": SIZE,
									 "SLOT_TYPE": slot_type}:
	set(value):
		property = value
 
		texture = property["TEXTURE"]
		SIZE = property["SIZE"]
		slot_type = property["SLOT_TYPE"]
