@tool

class_name RouteNode
extends Node2D

@export var connection_0 : RouteNode = null
@export var connection_1 : RouteNode = null
@export var text_offset_angle : float = PI/8
@export var text_offset_distance : float = 80.0

func _process(delta: float) -> void:
	queue_redraw()
	
func _draw() -> void:
	if connection_0 != null:
		var delta = connection_0.position - position
		var normal = delta.normalized()
		draw_line(Vector2.ZERO, delta, Color.WHITE, 2.5, false)
		
		if Engine.is_editor_hint():
			draw_string(ThemeDB.fallback_font, normal.rotated(text_offset_angle) * text_offset_distance, "0", HORIZONTAL_ALIGNMENT_FILL, )
		
	if connection_1 != null:
		var delta = connection_1.position - position
		var normal = delta.normalized()
		draw_line(Vector2.ZERO, delta, Color.WHITE, 2.5, false)
		
		if Engine.is_editor_hint():
			draw_string(ThemeDB.fallback_font, normal.rotated(text_offset_angle) * text_offset_distance, "1", HORIZONTAL_ALIGNMENT_FILL, )
