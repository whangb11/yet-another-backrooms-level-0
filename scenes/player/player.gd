class_name Player
extends CharacterBody3D


const WALK_SPEED:float = 5.0
const RUSH_SPEED:float = 11.0
const RUSH_ACCEL:float = 5.0

const WALK_FOV:float = 70
const RUSH_FOV:float = 90

const MUTATE_AXIS:float = 0.995

const JUMP_VELOCITY:float = 4.5
const MOUSE_SENSITIVITY:float = 0.2
const VERTICAL_ROTATION_LIMIT:Vector2 = Vector2(-89,89)

var currentVerticalRotation = 0.0
var currentSpeed = WALK_SPEED
var currentFov = WALK_FOV
var isFlying = false
@onready var camera:Camera3D = $Camera3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not isFlying:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("gp_run"):
		currentSpeed = (1 - MUTATE_AXIS * delta) * currentSpeed + MUTATE_AXIS * delta * RUSH_SPEED
		currentFov = (1 - MUTATE_AXIS * delta) * currentFov + MUTATE_AXIS * delta * RUSH_FOV
	else:
		currentSpeed = (1 - MUTATE_AXIS * delta) * currentSpeed + MUTATE_AXIS * delta * WALK_SPEED
		currentFov = (1 - MUTATE_AXIS * delta) * currentFov + MUTATE_AXIS * delta * WALK_FOV
	
	if direction:
		velocity.x = direction.x * currentSpeed
		velocity.z = direction.z * currentSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed)
		velocity.z = move_toward(velocity.z, 0, currentSpeed)
	
	camera.fov = currentFov
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		var newVerticalRotation = currentVerticalRotation - event.relative.y * MOUSE_SENSITIVITY
		newVerticalRotation = clamp(newVerticalRotation,VERTICAL_ROTATION_LIMIT.x,VERTICAL_ROTATION_LIMIT.y)
		camera.rotate_x(deg_to_rad(newVerticalRotation - currentVerticalRotation))
		currentVerticalRotation = newVerticalRotation
