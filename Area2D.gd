extends Area2D

var is_following_parent := true
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
		position = start_pos + (mouse_now - mouse_start)/get_parent().zoom
		is_following_parent = false
		if (position-Vector2(65,0)).abs() < Vector2(65,65):
			is_following_parent=true
			get_parent().redraw_path(false)
		else:
			get_parent().redraw_path()
	if is_following_parent:
		position=Vector2(65,0)
		
