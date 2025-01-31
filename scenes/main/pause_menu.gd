extends Control
@onready var langSetter:OptionButton = $Bg/VBoxContainer/LangSettings
const localeCode = [
	"en","cn","en","molanguage"
]
@onready var settingScreen:SettingScreen = $SettingsScreen
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0,localeCode.size()):
		langSetter.set_item_metadata(i,localeCode[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggleVisibility()

func _on_bg_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		hide()

func _on_visibility_changed() -> void:
	if visible:
		Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	else:
		Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
		get_tree().paused = false

func toggleVisibility() -> void:
	settingScreen.hide()
	if visible == false:
		show()
	else:
		hide()


func _on_btn_resume_pressed() -> void:
	hide()


func _on_btn_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()


func _on_lang_settings_item_selected(index: int) -> void:
	TranslationServer.set_locale(langSetter.get_item_metadata(index))
	GlobalOptionServer.set_option("language",langSetter.get_item_metadata(index))
	GlobalOptionServer.SaveData()


func _on_btn_config_pressed() -> void:
	settingScreen.show()
	pass#add_child()
