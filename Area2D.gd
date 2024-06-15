extends Area2D

var is_mouse_entered := false
var dragging := false
var mouse_start:Vector2
var start_pos:Vector2

func _mouse_enter():is_mouse_entered=true
func  _mouse_exit():is_mouse_entered=false

func _input(event:InputEvent):
	if event is InputEventMouseButton:
		if is_mouse_entered && event.is_pressed():
			mouse_start = get_viewport().get_mouse_position()
			start_pos = position
			dragging = true
		else:
			dragging = false

func _physics_process(delta):
	if dragging:
		var mouse_now := get_viewport().get_mouse_position()
		mouse_now = mouse_now.clamp(Vector2(0,0),get_viewport().size)
		var window_pos_diff := mouse_now - mouse_start
		position = start_pos + window_pos_diff
	if (position-Vector2(33,0)).abs() < Vector2(33,33):
		position=Vector2(33,0)
	

