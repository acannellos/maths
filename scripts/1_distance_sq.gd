@tool
extends Node3D

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

@export_range(0.5,10.0) var radius: float = 1.5
@export var color_in: Color = Color(1,1,1,1)
@export var color_out: Color = Color(1,1,1,1)

func _process(delta: float) -> void:
	
	for child in debug.get_children():
		child.queue_free()
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	DebugDraw.line(debug, a, b)
	
	#var dist := a.distance_to(b)
	var distSq: float = a.distance_squared_to(b)
	var color_selected: Color
	#if dist > radius:
	if distSq > radius * radius:
		color_selected = color_out
	else:
		color_selected = color_in
	
	DebugDraw.point(debug, a, radius, color_selected)
