extends SubViewportContainer

@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	sub_viewport.handle_input_locally = true
