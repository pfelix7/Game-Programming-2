extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# yellow
	var v1 = Vector3(1.0,0.0,0.0)
	#r red
	var v2 = Vector3(-1.0,0.0,1.0)
	# orange
	var v3 = Vector3(-1.0,0.0,-1.0)
	#green
	var v4 = Vector3(0.0,2.0,0.0)
	
	var edge_red = (v2 - v4)
	var edge_dark_green = (v1 - v2)
	
	var f1_normal = edge_red.cross(edge_dark_green).normalized()
	print(f1_normal)

	var edge_blue = (v4 - v3)
	var edge_green = (v1 - v2)
	var edge_yellow = (v1 -v3)
	var edge_orange = (v2 - v3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
