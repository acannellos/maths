@tool
extends Node3D

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b
@onready var ray: RayCast3D = %ray

@export var speed: float = 2.0

func _process(delta: float) -> void:
	
	for child in debug.get_children():
		child.queue_free()
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	var look_dir: Vector3 = marker_a.transform.basis.x
	
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	ray.force_raycast_update()
	if ray.is_colliding():
		var hit: Vector3 = ray.get_collision_point()
		var up: Vector3 = ray.get_collision_normal()
		var right: Vector3 = look_dir.cross(up).normalized()
		var forward: Vector3 = up.cross(right)
		var bounce: Vector3 = look_dir.bounce(up)
		var reflect: Vector3 = look_dir.reflect(up)
		
		DebugDraw.point(debug, hit, 0.03)
		DebugDraw.line(debug, hit, hit + up, Color.GREEN_YELLOW)
		DebugDraw.line(debug, hit, hit + right, Color.CORNFLOWER_BLUE)
		DebugDraw.line(debug, hit, hit + forward, Color.CRIMSON)
		DebugDraw.line(debug, hit, hit + bounce)
		DebugDraw.line(debug, hit, hit + reflect, Color.MAGENTA)
