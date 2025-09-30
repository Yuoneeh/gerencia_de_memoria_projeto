extends PanelContainer
class_name reformed_slot
 
@onready var timer_time = $Timer
@onready var texture_rect = $TextureRect
@export var self_instance : PackedScene
@export_enum("NONE:0","TINY:1","SMALL:2","MEDIUM:3", "LARGE:4", "GIGANTIC:5") var slot_type : int
 
var filled : bool = false
var slot_position
 

func _get_drag_data(at_position):
	
	set_drag_preview(get_preview())
 
	return texture_rect
 
func _can_drop_data(_pos, data):
	return data is TextureRect
 
func _drop_data(_pos, data):
	var temp = texture_rect.property
	texture_rect.property = data.property
	data.property = temp
	timer_time.start()
	print ("Sent_it")
	$audio_leave.play()
func get_preview():
	var preview_texture = TextureRect.new()
	$audio_click.play()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
	return preview

func get_SIZE():
	return texture_rect.SIZE

func set_property(data):
	$audio_click.play()
	texture_rect.property = data
 
	if data["TEXTURE"] == null:
		filled = false
	else:
		filled = true

func slot_data_erase():
	#slot_position = self.position
	#var instance_of_self = self_instance.instantiate()
	
	#add_child(instance_of_self)
	#instance_of_self.position = slot_position
	get_parent().calculate()
	self.queue_free()
	
	
	#texture_rect.property["TEXTURE"] = null
	#filled = false
func _on_timer_timeout() -> void:
	print("Timer_out")
	#texture_rect.property["TEXTURE"] = null
	#data["TEXTURE"] = null
	slot_data_erase()
	
	
