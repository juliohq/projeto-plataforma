extends CharacterBody3D


const GRAVIDADE = 16.0
const VELOCIDADE = 16.0
const VELOCIDADE_GIRO = 2.0 * PI

var olhar = Vector2()

@onready var Modelo = $Modelo


func _ready():
	Globais.personagem = self


func _physics_process(delta):
	# Movimentação do personagem
	var direcao = Input.get_vector("esquerda", "direita", "frente", "tras")
	
	velocity.x = direcao.x * VELOCIDADE
	velocity.z = direcao.y * VELOCIDADE
	
	# Girar o personagem
	if direcao:
		olhar = direcao
	
	Modelo.rotation.y = lerp_angle(Modelo.rotation.y, -olhar.angle() + (PI / 2.0), VELOCIDADE_GIRO * delta)
	
	# Aplicar a gravidade ao personagem
	if is_on_floor():
		velocity.y = 0.0
	else:
		# F = m * a (gravidade é uma aceleração, não uma velocidade)
		velocity.y -= GRAVIDADE * delta
	
	move_and_slide()
