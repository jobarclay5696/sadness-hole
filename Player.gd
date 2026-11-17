extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var neck: Node3D = $Neck

@onready var shop: Control = $CanvasLayer/shop

@onready var camera: Camera3D = $Neck/Camera3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var flashlight: SpotLight3D = $Neck/Camera3D/SpotLight3D

var health = 20

var damage = 5

var is_alive = true

var sprint = false
var crouch = false
var crawl = false

func _ready():
	print(global_position.y)
	

func _input(event):
	if event.is_action_pressed("attack"):
		print("attack")
		
		#shop.visible = !shop.visible
		
		
	if event.is_action_pressed("use"):
		print("use")
		
	if event.is_action_pressed("sprint")and crawl == false and crouch == false:
		sprint = true
		SPEED = 10.0
	if event.is_action_released("sprint"):
		sprint = false
		SPEED = 5.0
	
	if event.is_action_pressed("crouch") and crawl == false and sprint == false:
		crouch = true
		SPEED = 3
		var crouched = CapsuleShape3D.new()
		crouched.radius = 0.25
		crouched.height = 1.0
		collision_shape_3d.set_deferred("shape", crouched)
	if event.is_action_released("crouch"):
		crouch = false
		SPEED = 5
		var stand = CapsuleShape3D.new()
		stand.radius = 0.5
		stand.height = 2.0
		collision_shape_3d.set_deferred("shape", stand)
		
	if event.is_action_pressed("crawl") and crouch == false and sprint == false:
		crawl = true
		SPEED = 1.5
		var target_rotation = Vector3(0, 0, deg_to_rad(90))
		var crouched = CapsuleShape3D.new()
		crouched.radius = 0.2
		crouched.height = 0.5
		collision_shape_3d.set_deferred("shape", crouched)
		collision_shape_3d.set_deferred("rotation", target_rotation)
		
	if event.is_action_released("crawl") and is_on_floor() and crawl == false and crouch == false:
		crawl = false
		SPEED = 5
		var rotated = Vector3(0, 0, deg_to_rad(0))
		var stand = CapsuleShape3D.new()
		global_position.y += 0.2
		stand.radius = 0.5
		stand.height = 2.0
		collision_shape_3d.set_deferred("shape", stand)
		collision_shape_3d.set_deferred("rotation", rotated)
		
	if event.is_action_pressed("normal"):
		#Vector3(0, 0, 0)
		camera.rotation.x = 0
		camera.rotation.y = 0
		camera.rotation.y = 0
		camera.rotation.z = 0
		print("let me guess, it didnt work")
		
	if event.is_action_pressed("flashlight"):
		if flashlight.light_energy == 8.0:
			flashlight.light_energy = 0
		else:
			flashlight.light_energy = 8.0
		
		
	#if event.is_action_pressed("attack"):
		#shop.visible = false
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			
			if camera.rotation.x <= 1 and camera.rotation.x >= -1: #and -150 < event.relative.x and event.relative.x < 150 and -150 < event.relative.y and event.relative.y < 150:
				#print(event.relative.y)
				#print(event.relative.x)
				rotate_y(-event.relative.x * 0.002)
				
				camera.rotate_x(event.relative.y * 0.002)
				camera.rotation.x = clamp(camera.rotation.x, -1, 1)
			camera.rotation.z = 0
			

		
			
			
func _physics_process(delta: float) -> void:
	if global_position.y < -30 :
		print("you fell")
		global_position.x = 0
		global_position.y = 1.0
		global_position.z = 0
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity()*1 )* delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	var input_dir := Input.get_vector("right", "left", "back", "forward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if direction:
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
