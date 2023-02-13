extends Spatial

onready var timer = $Timer
onready var lights = []


func _ready():
	for i in $lights.get_children():
		lights.append(i)
		
		
func _on_Timer_timeout():
	var energy = 0
	
	for i in lights:
		i.set("light_energy", rand_range(1, 10))
		i.set("light_color", Color8(rand_range(90, 210), 9, 249))
