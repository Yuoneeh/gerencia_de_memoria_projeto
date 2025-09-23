extends Control

@onready var Size = %Sum_of_ram

func calculate():
	var sum = 0 
	
	for i in get_children():
		sum += i.get_SIZE()
	
	Size.text = str(sum)
