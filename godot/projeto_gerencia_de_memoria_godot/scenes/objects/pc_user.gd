extends Sprite2D

@onready var anim = $AnimationPlayer

func _ready() -> void:
	anim.play("RESET")


func _on_button_spawner_task_created() -> void:
	print("recebi o sinal")
	anim.play("alert")
