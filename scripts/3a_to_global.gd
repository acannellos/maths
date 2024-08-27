@tool
extends Node3D

@onready var debug: Node3D = %debug
@onready var node: Marker3D = %NODE

@export var local_point: Vector3 = Vector3.ZERO

func _process(delta: float) -> void:
	
	for child in debug.get_children():
		child.queue_free()
	
	var node_pos = node.global_position
	var right: Vector3 = node.transform.basis.x
	var up: Vector3 = node.transform.basis.y
	
	var offset: Vector3 = node.to_global(local_point)
	#var offset: Vector3 = get_world_offset(local_point, right, up, node_pos)
	
	DebugDraw.point(debug, local_point)
	DebugDraw.point(debug, offset, 0.05, Color.AQUA)
	
	DebugDraw.line(debug, node_pos, node_pos + right, Color.FIREBRICK)
	DebugDraw.line(debug, node_pos, node_pos + up, Color.GREEN_YELLOW)

func get_world_offset(local_point: Vector3, right: Vector3, up: Vector3, node_pos: Vector3) -> Vector3:
	var world_offset: Vector3 = right * local_point.x + up * local_point.y
	return world_offset + node_pos
