extends CharacterBody3D


const GRAVIDADE = 16.0
const VELOCIDADE = 16.0


func _ready():
	Globais.personagem = self


func _physics_process(delta):
	# Movimentação do personagem
	var direcao = Input.get_vector("esquerda", "direita", "frente", "tras")
	
	velocity.x = direcao.x * VELOCIDADE
	velocity.z = direcao.y * VELOCIDADE
	
	# Aplicar a gravidade ao personagem
	if is_on_floor():
		velocity.y = 0.0
	else:
		# F = m * a (gravidade é uma aceleração, não uma velocidade)
		velocity.y -= GRAVIDADE * delta
	
	move_and_slide()
