extends Camera2D

@export var zoom_speed: float = 10.

@onready var zoom_target: Vector2 = zoom
var zoom_pos_target: Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / zoom

func _process(delta: float) -> void:
	if Vector2.ZERO > get_viewport().get_mouse_position()||get_viewport().get_mouse_position() > Vector2(get_viewport().size):
		return
	var before := zoom_target
	if Input.is_action_just_pressed("zoom_in_cam"):
		zoom_target *= 1.1
	if Input.is_action_just_pressed("zoom_out_cam"):
		zoom_target /= 1.1
	zoom_target = zoom_target.clamp(Vector2(.2, .2), Vector2(5, 5))
	
	if Input.is_action_just_pressed("zoom_in_cam")||Input.is_action_just_pressed("zoom_out_cam"):
		var zoom_point_pos = get_viewport().get_mouse_position() - Vector2(get_viewport().size) / 2
		zoom_pos_target += zoom_point_pos / before - zoom_point_pos / zoom_target
	
	zoom = zoom.slerp(zoom_target, zoom_speed * delta)
	position += Vector2.ZERO.slerp(zoom_pos_target, zoom_speed * delta)
	zoom_pos_target -= Vector2.ZERO.slerp(zoom_pos_target, zoom_speed * delta)
