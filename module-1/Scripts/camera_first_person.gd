extends Camera3D

@export var mouse_sensitivity = 0.01
@export var parent_character: CharacterBody3D
var is_camera_captured

var min_fov = 25
var max_fov = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	is_camera_captured = true
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_camera_captured:
		#print(event)
		if event.relative.x !=0:
			parent_character.rotate_y(-event.relative.x * mouse_sensitivity)
		
		if event.relative.y !=0:
			rotate_x(-event.relative.y * mouse_sensitivity)
			print(rotation.x)
			rotation.x = clamp(rotation.x, -PI/2, PI/2)
	
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		is_camera_captured = false
	
	if event is InputEventMouseButton:
		if event.button_index == 1 and not is_camera_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			is_camera_captured = true
			
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				fov = clamp(fov + 1, min_fov, max_fov)
			MOUSE_BUTTON_WHEEL_DOWN:
				fov = clamp(fov - 1, min_fov, max_fov)
