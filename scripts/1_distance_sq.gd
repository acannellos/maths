@tool
extends Node

## check if something is within some radius using vector3 distance_squared_to
@export_range(0.5, 10.0) var radius: float = 1.5

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

var color_in: Color = Color(0.8, 0.94, 0.79, 0.2)
var color_out: Color = Color(0.94, 0.79, 0.83, 0.2)
var color_selected: Color

func _process(delta: float) -> void:
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	
	 ## first, get distance from a to b
	
	# the regular version
	# where the length call needs pathagoras and use sqrt
	#var dist := a.distance_to(b) # equivelent to (a - b).length()
	
	var dist_sq: float = a.distance_squared_to(b) # the faster version, skips the cost of sqrt
	
	## second, check if distance is within some threshold
	
	#if dist > radius:
	if dist_sq > radius * radius: # faster version needs to square the radius, but only one time
		color_selected = color_out
	else:
		color_selected = color_in
	
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	DebugDraw.point(debug, a, radius, color_selected)
	
	DebugDraw.line(debug, a, b)
