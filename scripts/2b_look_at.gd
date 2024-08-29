@tool
extends Node

## demo the node3D look_at function

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

func _process(delta: float) -> void:
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	var backward: Vector3 = marker_a.transform.basis.z ## godot uses -z forward so this will point backward
	var pointer: Vector3 = a.direction_to(b)
		
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	DebugDraw.line(debug, a, a + pointer * 2)
	DebugDraw.line(debug, a, a + backward, Color.CORNFLOWER_BLUE)
	
	marker_a.look_at(b) ## rotates the node so that the local forward axis points toward the target position
