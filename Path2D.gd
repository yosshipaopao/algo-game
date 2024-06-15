extends Path2D

func _draw():
	draw_polyline(curve.get_baked_points(), Color("#ff0000"), 4.0)
