extends Camera3D


func _process(delta):
	look_at(Globais.personagem.global_position)
