extends CollisionShape


var character = true

export var characterName = ''


func _ready():
	pass


func action():
	if self.characterName == 'mur':
		var dialog = Dialogic.start('startGame')
		dialog.connect("dialogic_signal", self, "exit")
		add_child(dialog)


func exit(string):
	match string:
		"exit":
			Global.inDialog = false
