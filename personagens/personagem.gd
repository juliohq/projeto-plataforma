extends CharacterBody3D


const GRAVIDADE = 64.0
const VELOCIDADE = 16.0
const VELOCIDADE_GIRO = 2.0 * PI
const ALTURA_PULO = 24.0

var olhar = Vector2()

@onready var Modelo = $Modelo
@onready var Animacao = $Modelo/AnimationPlayer


func _ready():
	Globais.personagem = self
	
	# Na Godot 4, as animações de alguns formatos de modelo 3D (GLTF, por exemplo) não se repetem automaticamente
	# Essa parte do código corrige esse problema
	for anim in Animacao.get_animation_list():
		Animacao.get_animation(anim).loop_mode = Animation.LOOP_LINEAR


func _unhandled_input(event):
	if event.is_action_released("pulo") and not is_on_floor() and velocity.y > 0.0:
		# Consumir o evento e evitar que ele se progague para outros nós
		get_viewport().set_input_as_handled()
		
		velocity.y = 0.0


func _physics_process(delta):
	# Movimentação do personagem
	var direcao = Input.get_vector("esquerda", "direita", "frente", "tras")
	
	velocity.x = direcao.x * VELOCIDADE
	velocity.z = direcao.y * VELOCIDADE
	
	# Girar o personagem
	if direcao:
		olhar = direcao
		
		if Animacao.current_animation != "Running_A":
			Animacao.play("Running_A")
	elif is_on_floor() and Animacao.current_animation != "Idle":
		Animacao.play("Idle")
	
	Modelo.rotation.y = lerp_angle(Modelo.rotation.y, -olhar.angle() + (PI / 2.0), VELOCIDADE_GIRO * delta)
	
	# Aplicar a gravidade ao personagem
	if is_on_floor():
		if Input.is_action_pressed("pulo"):
			velocity.y = ALTURA_PULO
		else:
			velocity.y = 0.0
	else:
		# F = m * a (gravidade é uma aceleração, não uma velocidade)
		velocity.y -= GRAVIDADE * delta
		
		if Animacao.current_animation != "Jump_Idle":
			Animacao.play("Jump_Idle")
	
	move_and_slide()
