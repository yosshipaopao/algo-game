@tool
class_name BlockNode extends CharacterBody2D

@onready var path_2d = $Path2D
@onready var area_2d = $Area2D
@onready var title := %Title

@export var Title := "":
	set(v):
		if title: title.text = v
	get:
		return title.text
@export var moveable := true
@export var path_moveable := true
@export var reset_pos := false
@export var limit_viewport := true

var zoom: Vector2:
	get: return get_parent().zoom

var is_mouse_drag_area_enterd := false
var dragging := false
var mouse_start: Vector2
var start_pos := Vector2.ZERO
var start_path_pos: Vector2

func _on_mouse_entered() -> void: is_mouse_drag_area_enterd = true
func _on_mouse_exited() -> void: is_mouse_drag_area_enterd = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if is_mouse_drag_area_enterd&&event.is_pressed()&&!area_2d.is_mouse_entered:
			mouse_start = get_viewport().get_mouse_position()
			start_pos = position
			start_path_pos = area_2d.global_position
			dragging = true
		else:
			dragging = false
			if reset_pos:
				position = Vector2.ZERO

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
		if !area_2d.is_following_parent:
			area_2d.global_position = start_path_pos
			path_2d.queue_redraw()
			path_2d.curve.set_point_position(1, area_2d.position)

func redraw_path(is_show: bool=true) -> void:
	path_2d.visible = is_show
	if path_2d.curve.get_point_position(1) != area_2d.position:
		path_2d.curve.set_point_position(1, area_2d.position)
		path_2d.queue_redraw()
