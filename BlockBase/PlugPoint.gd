class_name Plug extends Node2D


var is_following := true

var connect_to : InputPort
signal disconnect_port

@onready var parent_block := get_parent()
@onready var main :Main= get_parent().get_parent().get_parent()
var dragging := false
var mouse_start: Vector2
var start_pos: Vector2

func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_start = get_viewport().get_mouse_position()
			start_pos = position
			dragging = true
			main.dragging_connection = self
		else:
			dragging = false
			if connect_to and (connect_to.global_position - global_position).length() > 50:
				disconnect_port.emit()
				connect_to = null
				get_parent().remove_child(self)
				parent_block.add_child(self)
			position = Vector2.ZERO
				

func _process(_delta: float) -> void:
	if dragging:
		var mouse_now := get_viewport().get_mouse_position()
		mouse_now = mouse_now.clamp(Vector2(0, 0), get_viewport().size)
		position = start_pos + (mouse_now - mouse_start) / get_viewport().get_camera_2d().zoom
	
func request_connect(input_port:InputPort)->bool:
	if not connect_to and get_parent().plug_mode == input_port.plug_mode:
		get_parent().remove_child(self)
		input_port.add_child(self)
		position = Vector2.ZERO
		connect_to = input_port
		return true
	return false
