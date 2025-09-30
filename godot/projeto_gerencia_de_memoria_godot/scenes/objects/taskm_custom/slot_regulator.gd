extends Control

func _process(delta: float) -> void:
	var children_amount = get_children()
	if  children_amount.size() < 0:
		print("Sujo")

func calculate():
	var sum = 0 
	
	for i in get_children():
		sum += i.get_SIZE()
	
	ItemData.ram_used = sum
