extends GridContainer
var ID_string

func _ready() -> void:
	pass

func add_item(ID = "0"):
	var item_texture = load("res://scenes/objects/processes/all_assets/" + ItemData.get_texture(ID))
	var item_slot_type = ItemData.get_slot_type(ID)
	var item_SIZE = ItemData.get_SIZE(ID)
 
	var item_data = {"TEXTURE": item_texture,
					 "SIZE": item_SIZE,
					 "SLOT_TYPE": item_slot_type}
 
	var index = 0
	for i in get_children():
		if i.filled == false:
			index = i.get_index()
			break
	get_child(index).set_property(item_data)

func randomizador():
	var ID_task = randf_range(1,4)
	
	if ID_task == 1:
		ID_string = "1"
	elif ID_task == 2:
		ID_string = "2"
	elif ID_task == 3:
		ID_string = "3"
