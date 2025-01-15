extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lateInit.call_deferred()

func lateInit() -> void:
	for child in $Cube_002.get_children():
		(child as OmniLight3D).set_visible(GlobalOptionServer.checkOption("enableAdvancedLighting",false))
		(child as OmniLight3D).set_shadow(GlobalOptionServer.checkOption("enableLightShadow",false))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
