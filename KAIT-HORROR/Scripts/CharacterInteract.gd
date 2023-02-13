extends CollisionShape


func _ready():
	pass


func action():
	var dialog = Dialogic.start('startGame')
	add_child(dialog)
