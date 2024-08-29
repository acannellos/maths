@tool
extends Node

 ## demo creating a basis from three vector3 and applying it to another transform

@onready var debug: Node3D = %debug
@onready var marker_a: Marker3D = %marker_a
@onready var marker_b: Marker3D = %marker_b
@onready var ray: RayCast3D = %ray

func _process(delta: float) -> void:
	
	var a: Vector3 = marker_a.global_position
	var b: Vector3 = marker_b.global_position
	var look_dir: Vector3 = marker_a.transform.basis.x
	
	DebugDraw.point(debug, a, 0.05, Color.CRIMSON)
	DebugDraw.point(debug, b, 0.05, Color.GREEN_YELLOW)
	
	ray.force_raycast_update()
	if ray.is_colliding():
		var hit: Vector3 = ray.get_collision_point()
		var up: Vector3 = ray.get_collision_normal()
		var forward: Vector3 = look_dir.cross(up).normalized()
		var right: Vector3 = up.cross(forward)
				
		var base = Basis(right, up, forward) ## creating the basis to be passed into square function
		
		DebugDraw.point(debug, hit, 0.03)
		DebugDraw.line(debug, hit, hit + up, Color.GREEN_YELLOW)
		DebugDraw.line(debug, hit, hit + forward, Color.CORNFLOWER_BLUE)
		DebugDraw.line(debug, hit, hit + right, Color.CRIMSON)
		DebugDraw.square(debug, hit, 0.5, Color.GHOST_WHITE - Color(0,0,0,0.9), base)
