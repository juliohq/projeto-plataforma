extends CharacterBody3D


const GRAVIDADE = 16.0


func _ready():
	Globais.personagem = self


func _physics_process(delta):
	# Aplicar a gravidade ao personagem
	if is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y -= GRAVIDADE
	
	move_and_slide()
