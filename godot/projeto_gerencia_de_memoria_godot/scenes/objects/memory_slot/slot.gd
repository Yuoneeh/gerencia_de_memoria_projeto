extends PanelContainer
class_name Slot
 
@onready var texture_rect = $TextureRect
 
@export_enum("NONE:0","TINY:1","SMALL:2","MEDIUM:3", "LARGE:4", "GIGANTIC:5") var slot_type : int
 
var filled : bool = false
 
func _get_drag_data(at_position):
 
	set_drag_preview(get_preview())
 
	return texture_rect
 
func _can_drop_data(_pos, data):
	return data is TextureRect
 
func _drop_data(_pos, data):
	var temp = texture_rect.property
	texture_rect.property = data.property
	data.property = temp
 
func get_preview():
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	return preview

func get_SIZE():
	return texture_rect.SIZE
