extends Path2D

@onready var plug: Plug = $"../Plug"

func _ready() -> void:
	curve = Curve2D.new()
	curve.add_point(Vector2(65,0),Vector2.ZERO,Vector2(200,0))
	curve.add_point(Vector2(0,0),Vector2(-200,0),Vector2.ZERO)

func _draw():
	draw_polyline(curve.get_baked_points(), Color("#ff0000"), 4.0)

func _process(_delta: float) -> void:
	if plug.connect_to or plug.dragging:
		visible = true
		curve.set_point_position(1, to_local(plug.global_position))
		queue_redraw()
	else:
		visible = false
