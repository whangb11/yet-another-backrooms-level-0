class_name Level0Wall
extends Node3D
@onready var wallmesh:MeshInstance3D = $MeshInstance3D
@onready var colliShape:BoxShape3D = $StaticBody3D/CollisionShape3D.get_shape()
@onready var wallplug = $wallplug

const POSITION_LIMIT:Vector2i = Vector2i(-16,16)
const SIZE_LIMIT:Vector2i = Vector2i(1,16)
const WALL_PLUG_SPAWN_CHANCE:int = 25 #1/p
const WALL_PLUG_Y_LIMIT = Vector2(0.5,4.5)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass#randomize.call_deferred()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func randomizel() -> void:
	var yRotate:int = randi_range(0,1) * 90
	var length:int = randi_range(SIZE_LIMIT.x,SIZE_LIMIT.y)
	wallmesh.scale.x = length
	colliShape.size.x = length
	rotation.y=deg_to_rad(yRotate)
	position.x=randi_range(POSITION_LIMIT.x,POSITION_LIMIT.y)
	position.z=randi_range(POSITION_LIMIT.x,POSITION_LIMIT.y)
	
	#sometimes the wallplug floats, i surrender🙌
	#if randi_range(1,WALL_PLUG_SPAWN_CHANCE) == WALL_PLUG_SPAWN_CHANCE:
	#	var side:int = randi_range(0,1) * 2 - 1
	#	wallplug.position = Vector3((randi_range(0,1) * 2 - 1) * randf_range(0,length - 1) / 2,randf_range(WALL_PLUG_Y_LIMIT.x,WALL_PLUG_Y_LIMIT.y),side * 0.5)
