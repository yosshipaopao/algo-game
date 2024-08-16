extends Path2D

@export_enum("variable","process") var plug_mode := 0

@onready var point: Plug = $Point

func _ready() -> void:
	curve = Curve2D.new()
	if plug_mode == 0:
		curve.add_point(Vector2(0,0),Vector2.ZERO,Vector2(200,0))
		curve.add_point(Vector2(0,0),Vector2(-200,0),Vector2.ZERO)
	else:
		curve.add_point(Vector2(0,0),Vector2.ZERO,Vector2(0,200))
		curve.add_point(Vector2(0,0),Vector2(0,-200),Vector2.ZERO)
		
func _draw():
	if point.connect_to or point.dragging:
		draw_polyline(curve.get_baked_points(), Color("#ff0000"), 4.0)

func _process(_delta: float) -> void:
	curve.set_point_position(1, to_local(point.global_position))
	queue_redraw()
