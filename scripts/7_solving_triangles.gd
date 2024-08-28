@tool
extends Node3D

@onready var debug: Node3D = %debug
@onready var camera: Camera3D = %camera
@onready var points: Node3D = %points

@export var fov_buffer: float = 0.0

func _process(delta: float) -> void:
	
	for child in debug.get_children():
		child.queue_free()
	
	var c: Vector3 = camera.global_position
	var look_dir: Vector3 = -camera.transform.basis.z
	
	var padding: Vector3 = Vector3(0,0,-0.5)
	DebugDraw.line(debug, c + padding, c + padding + look_dir * 2)
	
	var lowest: float = 2.0
	var outermost: Node3D
	for point: Node3D in points.get_children():
		#DebugDraw.line(debug, c, point.global_position, Color.WEB_GRAY)
		var dir = (c + look_dir).direction_to(point.global_position)
		var dot = look_dir.dot(dir)
		if dot < lowest:
			lowest = dot
			outermost = point
	
	DebugDraw.line(debug, c, outermost.global_position, Color.MAGENTA)
	
	var acos = clamp(acos(lowest) * 100 * 2, 2, 178)
	camera.fov = acos
