extends ScrollContainer

@export var scroll_value := 50

var is_mouse_entered := false

func _on_mouse_entered() -> void:is_mouse_entered=true
func _on_mouse_exited() -> void:is_mouse_entered=false

func _physics_process(_delta: float) -> void:
	#print(Input.is_action_just_pressed("zoom_in_cam"),Input.is_action_just_pressed("zoom_out_cam"))
	if is_mouse_entered:
		if Input.is_action_just_pressed("zoom_in_cam"):
			get_v_scroll_bar().value -= scroll_value
		if Input.is_action_just_pressed("zoom_out_cam"):
			get_v_scroll_bar().value += scroll_value
