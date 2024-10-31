class_name LerpTargetFocusCamera
extends CameraControllerBase

@export var lead_speed : float = target.BASE_SPEED * 0.5
@export var catchup_delay_duration : float = 0.5
@export var catchup_speed: float = target.BASE_SPEED * 0.1
@export var leash_distance : float = 10.0
# Declare timer here, so it retains its value across frames
var timer : float = 0.0

func _ready() -> void:
	super()
	position = target.position
	
func _process(delta: float) -> void:
	if !current:
		return
	
	# Show camera
	if draw_camera_logic:
		draw_logic()
		
	var target_position : Vector3 = target.global_position
	var target_velocity_direction = target.velocity.normalized()
	var camera_position : Vector3 = global_position
	var distance_camera_to_target : float = target_position.distance_to(camera_position)
	# Use lerp(), since I didn't use it previously
	# Target moving
	if target.velocity:
		timer = 0.0
		var camera_lead: Vector3 = target_position + target_velocity_direction * leash_distance
		camera_position = camera_position.lerp(camera_lead, lead_speed * delta)
	# Target not moving
	else:
		timer += delta
		if timer >= catchup_delay_duration:
			camera_position = camera_position.lerp(target_position, catchup_speed * delta)
	
	global_position = camera_position
	
	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# Horizontal line
	immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))
	# Vertical line
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))

	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	# Follow the camera
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
