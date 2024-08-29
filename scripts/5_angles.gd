@tool
extends Node

## demo the basics of rotation in radians and degrees
@export_range(0.0, 1.0) var desired_turn: float = 0.0
@export_range(0.0, 360.0) var desired_deg: float = 0.0

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

func _process(delta: float) -> void:
	
	marker_a.global_rotation.z = desired_turn * TAU ## rotation part of the transformation in radians
	marker_b.global_rotation_degrees.z = desired_deg ## rotation part of the transformation in degrees
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	var a_right: Vector3 = marker_a.transform.basis.x
	var b_right: Vector3 = marker_b.transform.basis.x
	
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	DebugDraw.line(debug, a, a + a_right, Color.CRIMSON)
	DebugDraw.line(debug, b, b + b_right, Color.CRIMSON)
