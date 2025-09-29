extends Node
 
var ram_used : int
var content : Dictionary
 
func _ready():
	var file = FileAccess.open("res://autoload/database.json",FileAccess.READ)
 
	content = JSON.parse_string(file.get_as_text())
 
	file.close()
 
func get_texture(ID = "0"):
	return content[ID]["texture"]
 
func get_SIZE(ID = "0"):
	return content[ID]["SIZE"]
 
func get_slot_type(ID = "0"):
	return content[ID]["slot_type"]
