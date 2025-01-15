extends Node
const OPTION_FILE_PATH="user://config.json"
var options:Dictionary = {}

enum WINDOW_RESOLUTION {
	W1920H1080,
	W1600H900,
	W2560H1440,
	W3840H2160,
	W960H720,
	W1280H960
}

const resolutionDetails = {
	WINDOW_RESOLUTION.W1920H1080:Vector2i(1920,1080),
	WINDOW_RESOLUTION.W1600H900:Vector2i(1600,900),
	WINDOW_RESOLUTION.W2560H1440:Vector2i(2560,1440),
	WINDOW_RESOLUTION.W3840H2160:Vector2i(3840,2160),
	WINDOW_RESOLUTION.W960H720:Vector2i(960,720),
	WINDOW_RESOLUTION.W1280H960:Vector2i(1280,960),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var error = LoadData()
	if error == FAILED:
		var errorGen = NewData()
		if errorGen == FAILED:
			printerr("failedToCreate")
			get_tree().quit()
		LoadData()


func LoadData() -> int:
	var optionFile=FileAccess.open(OPTION_FILE_PATH,FileAccess.READ)
	if optionFile==null:
		return FAILED

	var json = JSON.new()
	var saveFileString = optionFile.get_as_text()
	var error = json.parse(saveFileString)
	if error != OK:
		optionFile.close()
		return FAILED
	
	options=json.data
	optionFile.close()
	return OK
	
func NewData() -> int:
	options={
		"enableSSAO":false,
		"enableAdvancedLighting":false,
		"enableLightShadow":false,
		"enableSSIL":false,
		"enableGlow":true,
		"enableSDFGI":false,
		"fullScreen":false,
		"fullScreenResolution":WINDOW_RESOLUTION.W1600H900,
		"antiAliashing":1,
		"language":"en"
	}
	return SaveData()
	
func SaveData() -> int:
	var optionFile=FileAccess.open(OPTION_FILE_PATH,FileAccess.WRITE)
	if optionFile==null:
		return FAILED
		
	var dataToSave = JSON.stringify(options)
	optionFile.store_string(dataToSave)
	optionFile.close()
	return OK
	
func checkOption(optionName:String,default = null):
	return options.get(optionName,default)

func setOption(optionName:String,optionData) -> void:
	options[optionName] = optionData

func get_option(optionName:String,default = null):
	return checkOption(optionName,default)

	
func set_option(optionName:String,optionData) -> void:
	options[optionName] = optionData
