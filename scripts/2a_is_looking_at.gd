@tool
extends Node

## check if a is looking at b using vector3 basis and dot product
@export_range(0.0, 1.0) var thresh: float = 0.8 # where 1.0 requires more precision

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

var color_in_view: Color = Color(0.8, 0.94, 0.79, 1.0)
var color_out_of_view: Color = Color(0.94, 0.79, 0.83, 1.0)
var color_selected: Color

func _process(delta: float) -> void:
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	
	## we can access the vectors representing a nodes axis using transform.basis.x/y/z
	var look_dir: Vector3 = marker_a.transform.basis.x.normalized() # lets pretend x is player forward
	var actual_dir: Vector3 = a.direction_to(b)
	
	var dot: float = look_dir.dot(actual_dir) ## when both vectors are normalized dot ranges -1 < 0 < 1
	
	if dot > thresh: ## 1 when looking directly at, -1 when looking directly away, 0 to sides
		color_selected = color_in_view
	else:
		color_selected = color_out_of_view
		
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	DebugDraw.line(debug, a, b, color_selected)
	DebugDraw.line(debug, a, a + look_dir, Color.CORAL)
	
	## extra credit: check if b is to the right or left of a
	var right: Vector3 = marker_a.transform.basis.z.normalized() # lets pretend z is player right
	var dot_right: float = right.dot(actual_dir)
	
	if dot_right > 0:
		DebugDraw.line(debug, a, a + right, Color.CORNFLOWER_BLUE)
	else:
		DebugDraw.line(debug, a, a - right, Color.CORNFLOWER_BLUE)
	
	#print("dot: " + str(dot))
	#print("dot_right: " + str(dot_right))
