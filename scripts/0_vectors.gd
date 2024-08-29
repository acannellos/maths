@tool
extends Node

## demo the basics of vectors
@export_range(0.5, 8.0) var speed: float = 2.0

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

func _process(delta: float) -> void:
	
	## we can get a vector in space, in this case global space
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	
	var avg: Vector3 = (a + b) / 2			## we can do math on vectors
	var dir: Vector3 = a.direction_to(b)	## equivalent to (b - a).normalized()
	var bullet: Vector3 = a + dir * speed	## unit vectors can help apply a specific distance
	
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	DebugDraw.point(debug, avg, 0.04, Color.AQUA)
	DebugDraw.point(debug, bullet)
	
	DebugDraw.line(debug, a, a + dir, Color.CORAL)
