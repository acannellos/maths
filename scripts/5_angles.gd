@tool
extends Node3D

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

@export_range(0.0,1.0) var desired_turn: float = 0.0
@export_range(0.0,360) var desired_deg: float = 0.0

func _process(delta: float) -> void:
	
	for child in debug.get_children():
		child.queue_free()
	
	var a: Vector3 = marker_a.global_position
	var a_right: Vector3 = marker_a.transform.basis.x
	
	var b: Vector3 = marker_b.global_position
	var b_right: Vector3 = marker_b.transform.basis.x
	
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	DebugDraw.line(debug, a, a + a_right, Color.CRIMSON)
	DebugDraw.line(debug, b, b + b_right, Color.CRIMSON)
	
	marker_a.global_rotation.z = desired_turn * TAU
	marker_b.global_rotation_degrees.z = desired_deg
