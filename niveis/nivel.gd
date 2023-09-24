extends Node


func _ready():
	Globais.game_over.connect(_game_over)


func _game_over():
	add_child(preload("res://ui/game_over.tscn").instantiate())
