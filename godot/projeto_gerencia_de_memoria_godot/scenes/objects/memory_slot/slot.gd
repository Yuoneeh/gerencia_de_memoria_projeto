extends PanelContainer

@onready var texture_rect = $TextureRect

@export_enum("NONE:0", "SMALL:1","MEDIUM:2","BIG:3","MASSIVE:4") 
var slot_type : int


func _get_drag_data(at_position: Vector2) -> Variant:
	
	set_drag_preview(get_preview())
	
	return texture_rect
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is TextureRect
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
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
