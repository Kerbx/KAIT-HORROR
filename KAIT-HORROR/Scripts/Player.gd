extends KinematicBody


const ROTATION = 0.01
const GRAVITY = -20
const SPEED = 300
const RUN_SPEED = 2.5
const JUMP_SPEED = 7

var velocity = Vector3()

var rotationX = 0
var rotationY = 0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	var direction = Vector3()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_pressed("move_forward"):
		direction.z = -1
	if Input.is_action_pressed("move_backward"):
		direction.z = 1
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	
	if Input.is_action_pressed("run"):
		direction *= RUN_SPEED
		
	if direction:
		direction *= SPEED * delta
		
		direction = direction.rotated(Vector3.UP, rotation.y)
		
	velocity.x = direction.x
	velocity.z = direction.z
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_SPEED
			
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))


func _input(e):
	if e is InputEventMouseMotion:
		rotationX -= e.relative.y * ROTATION
		rotationY -= e.relative.x * ROTATION
		
		if rotationX < -1.5:
			rotationX = -1.5
		elif rotationX > 1.5:
			rotationX = 1.5
			
		transform.basis = Basis(Vector3.UP, rotationY)
		$Spatial/Camera.transform.basis = Basis(Vector3.RIGHT, rotationX)
		
