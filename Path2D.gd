extends Path2D

@onready var connection: Node2D = $"../connection"

func _draw():
	draw_polyline(curve.get_baked_points(), Color("#ff0000"), 4.0)

func _process(_delta: float) -> void:
	curve.set_point_position(1, connection.position)
	queue_redraw()
