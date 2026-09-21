extends CharacterBody3D

@export var parent_character: CharacterBody3D
@export_range(0.001, 0.1) var mouse_sensitivity: float = 0.005
@export var tilt_limit = deg_to_rad(75)
var is_camera_captured


const SPEED = 10.0
const JUMP_VELOCITY = 5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	is_camera_captured = true

func _physics_process(delta: float) -> void:
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		move_toward(velocity.z, 0, SPEED)

	animate()
	move_and_slide()


func animate() -> void:
	$AnimationTree["parameters/conditions/is_idle"] = (
		abs(velocity.x) < 0.05 and abs(velocity.z) < 0.05
	)

	$AnimationTree["parameters/conditions/is_running"] = (
		abs(velocity.x) > 0.05 or abs(velocity.z) > 0.05
	)

	$AnimationTree["parameters/conditions/is_not_grouded"] = not is_on_floor()

	$AnimationTree["parameters/conditions/is_jumping"] = (
		is_on_floor() and Input.is_action_just_pressed("ui_accept")
	)

	$AnimationTree["parameters/conditions/is_grounded"] = is_on_floor()
