extends Area2D

@onready var laber_interacao: Label =$Labelinteracao
@onready var caixa_dialogo: Label = $CanvasLayer/caixa_dialogo
@onready var texto_dialogo: Label = $CanvasLayer/texto_Dialogo

var player_in_area=false
var falando = false
var pode_avansar = false
var fala_index= 0

var falas = [
	"Ola pode me ajudar...",
	"pressiso de ajuda"
]

func _ready() -> void:
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	laber_interacao.visible = false
	

func _process(_delta)->void:
	if player_in_area and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avansar and Input.is_action_just_pressed("interact"):
		proxima_fala()

func _on_body_entered(body) -> void:
	if body.name =="player":
		player_in_area = true
		laber_interacao.tex= "Pressione 'E' para interagir"
		laber_interacao.visible = true
		

func _on_body_exited(body) -> void:
	if body.name =="player":
		player_in_area = false
		laber_interacao.visible = false
		if falando:
			encerrar_dialogo()

func iniciar_dialogo():
	falando = true
	laber_interacao.visible= false
	caixa_dialogo.visible = true
	texto_dialogo.visible = true
	fala_index = 0
	proxima_fala()


func proxima_fala():
	if fala_index < falas.size():
		pode_avansar = false
		texto_dialogo.texto = ""
		var texto = falas[fala_index]
		fala_index += 1
		mostrar_texto_com_efeito(texto)
	else:
		encerrar_dialogo()

func mostrar_texto_com_efeito(texto: String):
	await get_tree().create_timer(0.1).tineout
	for letra in texto:
		texto_dialogo.texto += letra
	await get_tree().create_timer(0.02).tineout
	pode_avansar = true


func encerrar_dialogo():
	falando = false
	pode_avansar = false
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
