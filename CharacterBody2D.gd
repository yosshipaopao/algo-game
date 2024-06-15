extends CharacterBody2D

var is_mouse_drag_area_enterd := false

var dragging := false
var mouse_start:Vector2
var start_pos:Vector2
var start_path_pos:Vector2
@onready var path_2d = $Path2D
@onready var area_2d = $Area2D

func _on_drag_area_mouse_entered():is_mouse_drag_area_enterd = true
func _on_drag_area_mouse_exited():is_mouse_drag_area_enterd = false

func _input(event:InputEvent):
	if event is InputEventMouseButton:
		if is_mouse_drag_area_enterd && event.is_pressed() && !area_2d.is_mouse_entered:
			mouse_start = get_viewport().get_mouse_position()
			start_pos = position
			start_path_pos = area_2d.global_position
			dragging = true
		else:
			dragging = false

func _physics_process(delta):
	if dragging:
		var mouse_now := get_viewport().get_mouse_position()
		mouse_now = mouse_now.clamp(Vector2(0,0),get_viewport().size)
		var window_pos_diff := mouse_now - mouse_start
		position = start_pos + window_pos_diff
		area_2d.global_position = start_path_pos
		path_2d.queue_redraw()
		path_2d.curve.set_point_position(1,area_2d.position)
	elif path_2d.curve.get_point_position(1)!=area_2d.position:
		path_2d.curve.set_point_position(1,area_2d.position)
		path_2d.queue_redraw()
