extends AnimatedSprite2D

func _process(delta: float) -> void:
	sprite_definition()


func sprite_definition():
	if ItemData.hp_count == 3:
		self.animation = ("3_life")
	elif ItemData.hp_count == 2:
		self.animation = ("2_life")
	elif ItemData.hp_count == 1:
		self.animation = ("1_life")
