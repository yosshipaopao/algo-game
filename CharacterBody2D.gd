@tool
extends CharacterBody2D

@export var Title = ""

var zoom : Vector2:
	get:
		return get_parent().zoom

var is_mouse_drag_area_enterd := false
var dragging := false
var mouse_start:Vector2
var start_pos:Vector2
var start_path_pos:Vector2
@onready var path_2d = $Path2D
@onready var area_2d = $Area2D

func _on_drag_area_mouse_entered()->void:is_mouse_drag_area_enterd = true
func _on_drag_area_mouse_exited()->void:is_mouse_drag_area_enterd = false

func _input(event:InputEvent)->void:
	if event is InputEventMouseButton:
		if is_mouse_drag_area_enterd && event.is_pressed() && !area_2d.is_mouse_entered:
			mouse_start = get_viewport().get_mouse_position()
			start_pos = position
			start_path_pos = area_2d.global_position
			dragging = true
		else:
			dragging = false

func _physics_process(delta:float)->void:
	if dragging:
		var mouse_now := get_viewport().get_mouse_position()
		mouse_now = mouse_now.clamp(Vector2(0,0),get_viewport().size)
		position = start_pos + (mouse_now - mouse_start) / zoom
		if !area_2d.is_following_parent:
			area_2d.global_position = start_path_pos
			path_2d.queue_redraw()
			path_2d.curve.set_point_position(1,area_2d.position)

func redraw_path(show:bool=true)->void:
	if !show:
		path_2d.visible=false
	else:
		path_2d.visible=true
	if path_2d.curve.get_point_position(1)!=area_2d.position:
		path_2d.curve.set_point_position(1,area_2d.position)
		path_2d.queue_redraw()
