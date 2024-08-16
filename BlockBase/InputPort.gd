class_name InputPort extends Node2D


@export_enum("variable","process") var plug_mode := 0
@onready var main : Main = get_parent().get_parent()

var connect_to : Plug

func _process(_delta: float) -> void:
	if not connect_to and to_local(get_global_mouse_position()).length() < 30 and Input.is_action_just_released("click"):
		if main.dragging_connection:
			if main.dragging_connection.request_connect(self):
				connect_to = main.dragging_connection
				connect_to.disconnect_port.connect(disconnect_port)

func disconnect_port()->void:
	connect_to.disconnect_port.disconnect(disconnect_port)
	connect_to = null
