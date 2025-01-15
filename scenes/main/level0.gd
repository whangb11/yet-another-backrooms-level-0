extends Node3D
const CHUNK_UPDATE_SECOND_INTERVAL:float = 5
const CHUNK_HOLD_RANGE:int = 4
const CHUNK_SC:PackedScene = preload("res://scenes/chunk/chunk.tscn")

@onready var chunkContainer:Node3D = $ChunkContainer
@onready var worldEnvironment:Environment = $WorldEnvironment.environment
@onready var player:Player = $player
var deltaT:float=CHUNK_UPDATE_SECOND_INTERVAL


# Called when the node enters the scene tree for the first time.
var chunkRegList:Dictionary = { }
func _ready() -> void:
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	TranslationServer.set_locale(GlobalOptionServer.get_option("language","en"))
	worldEnvironment.set_sdfgi_enabled(GlobalOptionServer.checkOption("enableSDFGI",false))
	worldEnvironment.set_ssao_enabled(GlobalOptionServer.checkOption("enableSSAO",false))
	worldEnvironment.set_ssil_enabled(GlobalOptionServer.checkOption("enableSSIL",false))
	worldEnvironment.set_glow_enabled(GlobalOptionServer.checkOption("enableGlow",true))
	if GlobalOptionServer.checkOption("fullScreen",false):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		var wresolution=GlobalOptionServer.resolutionDetails.get(GlobalOptionServer.WINDOW_RESOLUTION.get(GlobalOptionServer.get_option("fullScreenResolution",GlobalOptionServer.WINDOW_RESOLUTION.W1600H900),GlobalOptionServer.WINDOW_RESOLUTION.W1600H900))
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	match GlobalOptionServer.get_option("antiAliashing",1):
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	deltaT += delta
	if deltaT >= CHUNK_UPDATE_SECOND_INTERVAL:
		deltaT -= CHUNK_UPDATE_SECOND_INTERVAL
		
		var playerChunkPos:Vector2 = Vector2(floor(player.position.x/32),floor(player.position.z/32))
		print(player.position)
		print(playerChunkPos)
		for cx in range(-CHUNK_HOLD_RANGE,CHUNK_HOLD_RANGE):
			for cy in range(-CHUNK_HOLD_RANGE,CHUNK_HOLD_RANGE):
				var chunkPosToCheck:Vector2 = Vector2(playerChunkPos.x+cx,playerChunkPos.y+cy)

				if chunkRegList.has(str(chunkPosToCheck)) != true:
					var chunkToGen:Chunk = CHUNK_SC.instantiate()
					chunkToGen.chunkPos = chunkPosToCheck
					chunkToGen.regListRef = chunkRegList
					chunkContainer.add_child(chunkToGen)
