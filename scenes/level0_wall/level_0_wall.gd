class_name Level0Wall
extends Node3D
@onready var wallmesh:MeshInstance3D = $MeshInstance3D
@onready var colliShape:BoxShape3D = $StaticBody3D/CollisionShape3D.get_shape()

const POSITION_LIMIT = Vector2i(-16,16)
const SIZE_LIMIT = Vector2i(1,16)
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
