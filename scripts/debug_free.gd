@tool
extends Node3D

func _process(delta: float) -> void:
	for child in get_children():
		child.queue_free()
