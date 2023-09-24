extends Control


func _ready():
	get_tree().paused = true


func _exit_tree():
	get_tree().paused = false


func _on_reiniciar_pressed():
	get_tree().reload_current_scene()
