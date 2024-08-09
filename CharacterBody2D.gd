@tool
class_name BlockNode extends Node2D

@onready var title := %Title

@export var Title := "":
	set(v):
		if title: title.text = v
	get:
		return title.text
@export var moveable := true
@export var reset_pos := false
@export var limit_viewport := true

signal moved(pos:Vector2)

var zoom: Vector2:
	get: return get_parent().zoom

var dragging := false
var mouse_start: Vector2
var start_pos := Vector2.ZERO
var start_path_pos: Vector2

func _physics_process(_delta: float) -> void:
	if dragging&&!Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		dragging = false
		if reset_pos:
			position = Vector2.ZERO
	if dragging&&moveable:
		var mouse_now := get_viewport().get_mouse_position()
		if limit_viewport:
			mouse_now = mouse_now.clamp(Vector2(0, 0), get_viewport().size)
		position = start_pos + (mouse_now - mouse_start) / zoom
		moved.emit(global_position)

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
