extends Node2D

@onready var camera_2d = $Camera2D

var zoom : Vector2:
	get:
		return camera_2d.zoom
