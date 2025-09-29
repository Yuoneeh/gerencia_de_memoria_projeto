extends Control

func calculate():
	var sum = 0 
	
	for i in get_children():
		sum += i.get_SIZE()
	
	ItemData.ram_used = sum
