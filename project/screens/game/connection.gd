@tool
class_name Connection

extends Node2D

@export var node_a: Node2D = null
@export var node_b: Node2D = null

func _process(delta: float) -> void:
	queue_redraw()
	
func _draw():
	if node_a != null and node_b != null:
		draw_line(node_a.position, node_b.position, Color.WHITE, 2.5, false)
