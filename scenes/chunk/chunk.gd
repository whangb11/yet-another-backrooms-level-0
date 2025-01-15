class_name Chunk
extends Node3D
var wallClass:PackedScene = preload("res://scenes/level0_wall/level0_wall.tscn")
@onready var walls:Node3D = $walls
var chunkPos:Vector2i = Vector2i(0,0)
@onready var MAX_WALL_COUNT:int=GlobalOptionServer.get_option("wallPerChunk",24)
var regListRef:Dictionary
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lateInit.call_deferred()

func lateInit() -> void:
	for i in range(MAX_WALL_COUNT):
		var wallInstance:Level0Wall = wallClass.instantiate()
		walls.add_child(wallInstance)
	
	if regListRef == null:
		queue_free()
	else:
		regListRef[str(chunkPos)] = true
		position.x = chunkPos.x * 32
		position.z = chunkPos.y * 32
	
	randomizel()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_visibility_screen_entered() -> void:
	$cell.show()

func randomizel() -> void:
	for child in walls.get_children():
		(child as Level0Wall).randomizel()

func _on_visibility_screen_exited() -> void:
	randomizel()
	$cell.hide()

func _on_out_of_bound_detector_body_exited(body: Node3D) -> void:
	queue_free()


func _on_tree_exiting() -> void:
	if regListRef != null:
		regListRef.erase(str(chunkPos))
