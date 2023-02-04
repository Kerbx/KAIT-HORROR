extends KinematicBody


export var ROTATION = 0.01
export var GRAVITY = -20
export var SPEED = 300
export var RUN_SPEED = 2.5
export var JUMP_SPEED = 7

var velocity = Vector3()

var rotationX = 0
var rotationY = 0

var flashlight

var animation


func _ready():
	animation = $floppa.get_child(2)
	flashlight = $Spatial/Camera/flashlight
	flashlight.set("light_energy", 0)


func _physics_process(delta):
	var direction = Vector3()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("lightOnOff"):
		if flashlight.get("light_energy"):
			flashlight.set("light_energy", 0)
		else:
			flashlight.set("light_energy", 2)
		
	
	# bruh, idk why this run animation called like this. seems in blender all's ok.
	if Input.is_action_pressed("move_forward"):
		direction.z = -1
		if is_on_floor():
			animation.play("Размещённое действие]")
	if Input.is_action_pressed("move_backward"):
		direction.z = 1
		if is_on_floor():
			animation.play("Размещённое действие]")
	if Input.is_action_pressed("move_left"):
		direction.x = -1
		if is_on_floor():
			animation.play("Размещённое действие]")
	if Input.is_action_pressed("move_right"):
		direction.x = 1
		if is_on_floor():
			animation.play("Размещённое действие]")
	
	if Input.is_action_pressed("run"):
		direction *= RUN_SPEED
		if is_on_floor():
			animation.play("Размещённое действие]", -1, 2.0)
		
	if direction:
		direction *= SPEED * delta
		direction = direction.rotated(Vector3.UP, rotation.y)
		
	velocity.x = direction.x
	velocity.z = direction.z
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			animation.play("jump")
			velocity.y = JUMP_SPEED
			
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))


func _input(e):
	# dont fucking say it.
	if e is InputEventMouseMotion:
		rotationX -= e.relative.y * ROTATION
		rotationY -= e.relative.x * ROTATION
		
		if rotationX < -1.5:
			rotationX = -1.5
		elif rotationX > 1.5:
			rotationX = 1.5
			
		transform.basis = Basis(Vector3.UP, rotationY)
		$Spatial/Camera.transform.basis = Basis(Vector3.RIGHT, rotationX)
		
