class_name settingScreen
extends Control
var _isready:bool = false
@export var environment:WorldEnvironment
@onready var fullScreenOptionBtn:CheckButton = $Panel/VBoxContainer/fullscreenOption
@onready var ssaoOptionBtn:CheckButton = $Panel/VBoxContainer/ssaoOptionBtn
@onready var ssilOptionBtn:CheckButton = $Panel/VBoxContainer/ssilOptionBtn
@onready var sdfgiOptionBtn:CheckButton = $Panel/VBoxContainer/sdfgiOptionBtn
@onready var adlightngOptionBtn:CheckButton = $Panel/VBoxContainer/advancedLighting
@onready var aaOptionBtn:OptionButton = $Panel/VBoxContainer/OptionButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_isready = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visibility_changed() -> void:
	if _isready:
		fullScreenOptionBtn.set_pressed_no_signal(GlobalOptionServer.get_option("fullScreen",true))
		ssaoOptionBtn.set_pressed_no_signal(GlobalOptionServer.get_option("enableSSAO",false))
		ssilOptionBtn.set_pressed_no_signal(GlobalOptionServer.get_option("enableSSIL",false))
		sdfgiOptionBtn.set_pressed_no_signal(GlobalOptionServer.get_option("enableSDFGI",false))
		adlightngOptionBtn.set_pressed_no_signal(GlobalOptionServer.get_option("enableAdvancedLighting",false))
		aaOptionBtn.select(GlobalOptionServer.get_option("antiAliashing",1))
		
		if visible == false:
			GlobalOptionServer.SaveData()


func _on_btn_close_pressed() -> void:
	hide()


func _on_fullscreen_option_toggled(toggled_on: bool) -> void:
	if toggled_on:
		GlobalOptionServer.set_option("fullScreen",true)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		GlobalOptionServer.set_option("fullScreen",false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_ssao_option_btn_toggled(toggled_on: bool) -> void:
	GlobalOptionServer.setOption("enableSSAO",toggled_on)
	environment.environment.ssao_enabled=toggled_on


func _on_ssil_option_btn_toggled(toggled_on: bool) -> void:
	GlobalOptionServer.setOption("enableSSIL",toggled_on)
	environment.environment.ssil_enabled=toggled_on


func _on_sdfgi_option_btn_toggled(toggled_on: bool) -> void:
	GlobalOptionServer.setOption("enableSDFGI",toggled_on)
	environment.environment.sdfgi_enabled=toggled_on


func _on_advanced_lighting_toggled(toggled_on: bool) -> void:
	GlobalOptionServer.setOption("enableAdvancedLighting",toggled_on)
	$Panel/VBoxContainer2/needRestartHint.show()


func _on_option_button_item_selected(index: int) -> void:
	GlobalOptionServer.set_option("antiAliashing",index)
	match index:
		1:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d","off")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d","off")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/use_taa",false)
		2:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d","2x")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d","2x")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/use_taa",false)
		3:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d","4x")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d","4x")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/use_taa",false)
		4:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d","8x")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d","8x")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/use_taa",false)
		5:
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d","off")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d","off")
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/use_taa",true)
