@tool
extends Node3D

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b

@export var speed: float = 2.0

func _process(delta: float) -> void:
	
	for child in debug.get_children():
		child.queue_free()
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	var dir: Vector3 = a.direction_to(b)
	DebugDraw.line(debug, a, a + dir, Color.CORAL)
	
	var avg: Vector3 = (a + b) / 2
	DebugDraw.point(debug, avg, 0.04, Color.AQUA)
	
	var bullet: Vector3 = a + dir * speed
	DebugDraw.point(debug, bullet)
	
