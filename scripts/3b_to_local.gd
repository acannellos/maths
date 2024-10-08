@tool
extends Node

## convert a desired world point into local coordinates
@export var world_point: Vector3 = Vector3.ZERO

@onready var debug: Node3D = %debug
@onready var node: Marker3D = %node
@onready var object: Marker3D = %object

func _process(delta: float) -> void:
	
	object.position = node.to_local(world_point) ## transforms global_point from world space to node's local space
	
	## the manual way
	var node_pos = node.global_position
	var right: Vector3 = node.transform.basis.x
	var up: Vector3 = node.transform.basis.y
	
	#object.position = get_local_offset_2d(world_point, right, up, node_pos)
	
	DebugDraw.point(debug, world_point)
	
	DebugDraw.line(debug, node_pos, node_pos + right, Color.FIREBRICK)
	DebugDraw.line(debug, node_pos, node_pos + up, Color.GREEN_YELLOW)

func get_local_offset_2d(world_point: Vector3, right: Vector3, up: Vector3, node_pos: Vector3) -> Vector3:
	var rel_point: Vector3 = world_point - node_pos
	var x: float = rel_point.dot(right)
	var y: float = rel_point.dot(up)
	return Vector3(x, y, 0)
