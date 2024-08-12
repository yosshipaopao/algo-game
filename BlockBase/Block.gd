class_name BlockNode extends Node2D

@onready var title := %Title

@export var Title := ""
@export var moveable := true
@export var reset_pos := false
@export var limit_viewport := true

var dragging := false
var mouse_start: Vector2
var start_pos := Vector2.ZERO

func _process(_delta: float) -> void:
	if dragging&&!Input.is_action_pressed("click"):
		dragging = false
		if reset_pos:
			position = Vector2.ZERO
	if dragging&&moveable:
		var mouse_now := get_viewport().get_mouse_position()
		if limit_viewport:
			mouse_now = mouse_now.clamp(Vector2(0, 0), get_viewport().size)
		position = start_pos + (mouse_now - mouse_start) / get_viewport().get_camera_2d().zoom

func _on_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			get_parent().move_child(self,get_parent().get_child_count()-1)
			mouse_start = get_viewport().get_mouse_position()
			start_pos = position
			dragging = true
		else:
			dragging = false
			if reset_pos:
				position = Vector2.ZERO
