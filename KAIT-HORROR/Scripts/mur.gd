extends StaticBody


func _process(delta):
	var x = Global.pos.x
	var z = Global.pos.z
	
	look_at(Vector3(x, 0, z), Vector3.UP)
	rotate_y(deg2rad(180))
