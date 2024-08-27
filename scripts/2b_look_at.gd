@tool
extends Node3D

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

@export_range(0.0,1.0) var thresh: float = 0.0
@export var color_in_view: Color = Color(1,1,1,1)
@export var color_out_of_view: Color = Color(1,1,1,1)

func _process(delta: float) -> void:
	
	for child in debug.get_children():
		child.queue_free()
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
		
	var look_dir: Vector3 = marker_a.transform.basis.z
	var actual_dir: Vector3 = a.direction_to(b)
	
	var d: float = look_dir.dot(actual_dir)
	
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	DebugDraw.line(debug, a, a + actual_dir * 2)
	DebugDraw.line(debug, a, a + look_dir, Color.CORNFLOWER_BLUE)
	
	marker_a.look_at(b)
