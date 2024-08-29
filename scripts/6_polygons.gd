@tool
extends Node

## demo using radians and TAU to create 2d polygons
@export_range(3,32) var count: int = 3
@export var has_lines: bool = false
@export_enum("origin", "og", "nearest", "skip") var line_type = "origin"
@export_range(1,16) var density: int = 2

@onready var debug: Node3D = %debug

func _process(delta: float) -> void:
	
	var points: Array[Vector3]
	for i in count:
		var t: float = i / float(count) ## turns equal to 0 < 1
		var rad: float = t * TAU
		
		#var x: float = cos(rad)
		#var y: float = sin(rad)
		#var point: Vector3 = Vector3(x, y, 0)
		var point: Vector3 = rad_to_dir_2d(rad)
		
		points.append(point)
	
	var i: int = 0
	for point in points:
		DebugDraw.point(debug, point)
		#
		if has_lines:
			match line_type:
				"origin":
					DebugDraw.line(debug, Vector3.ZERO, point)
				"og":
					DebugDraw.line(debug, -debug.global_position, point)
				"nearest":
					var size: int = points.size()
					var t = (i + 1) % size
					DebugDraw.line(debug, points[i], points[t])
				"skip":
					var size: int = points.size()
					var t = (i + density) % size
					DebugDraw.line(debug, points[i], points[t])
		i += 1

func rad_to_dir_2d(rad: float) -> Vector3:
	return Vector3(cos(rad), sin(rad), 0)

func dir_to_rad_2d(dir: Vector3) -> float:
	return atan2(dir.y, dir.x) 
