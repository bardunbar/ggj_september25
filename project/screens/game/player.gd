
class_name Player
extends Node2D

@onready var control_0 : Node2D = $Control0
@onready var control_1 : Node2D = $Control1

@export var text_offset_angle : float = PI/6
@export var text_offset_distance : float = 80.0

@export var starting_node : RouteNode = null
@export var travel_speed : float = 900.0

var current_node : RouteNode = null

func _ready() -> void:
	if starting_node != null:
		position = starting_node.position
		set_route_node(starting_node)
	
	$PlayerTexture.scale = Vector2(1.0, 0.0)
	var tween = get_tree().create_tween()
	tween.tween_property($PlayerTexture, "scale", Vector2(1.0, 1.0), 0.5).set_trans(Tween.TRANS_ELASTIC).set_delay(0.25)

func _process(delta: float) -> void:
	if current_node != null:
		if Input.is_action_just_pressed("process_zero"):
			if current_node.connection_0 != null:
				do_travel(current_node.connection_0)
		if Input.is_action_just_pressed("process_one"):
			if current_node.connection_1 != null:
				do_travel(current_node.connection_1)

func set_route_node(route_node : RouteNode) -> void:
	current_node = route_node
	
	if current_node != null:
		if current_node.connection_0 != null:
			control_0.visible = true
			var delta = current_node.connection_0.position - position
			var normal = delta.normalized()
			control_0.position = normal.rotated(-text_offset_angle) * text_offset_distance
		else:
			control_0.visible = false
		
		if current_node.connection_1 != null:
			control_1.visible = true
			var delta = current_node.connection_1.position - position
			var normal = delta.normalized()
			control_1.position = normal.rotated(text_offset_angle) * text_offset_distance
		else:
			control_1.visible = false
	else:
		control_0.visible = false
		control_1.visible = false

func do_travel(destination_node : RouteNode) -> void:
	set_route_node(null)
	var delta = destination_node.global_position - global_position
	var time = delta.length() / travel_speed
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", destination_node.global_position, time).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func(): set_route_node(destination_node))
