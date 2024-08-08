extends Node2D


var is_following_parent := true
var following_position := Vector2(55, -10)

var dragging := false
var mouse_start: Vector2
var start_pos: Vector2

var locked_position := following_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_start = get_viewport().get_mouse_position()
			start_pos = position
			dragging = true
		else:
			dragging = false

func _physics_process(_delta: float) -> void:
	if dragging:
		var mouse_now := get_viewport().get_mouse_position()
		mouse_now = mouse_now.clamp(Vector2(0, 0), get_viewport().size)
		position = start_pos + (mouse_now - mouse_start) / get_parent().zoom
		is_following_parent = false
		if (position - Vector2(65, 0)).abs() < Vector2(65, 65):
			is_following_parent = true
			get_parent().redraw_path(false)
		else:
			get_parent().redraw_path()
		locked_position = global_position
		
	
	if is_following_parent:
		position = following_position
	elif get_parent().dragging:
		global_position = locked_position
