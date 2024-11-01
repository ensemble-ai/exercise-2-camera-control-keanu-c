class_name PositionLockLerpCamera
extends CameraControllerBase

@export var follow_speed : float = target.BASE_SPEED * 0.85
@export var catchup_speed : float = target.BASE_SPEED
@export var leash_distance : float = 20.0

func _ready() -> void:
	super()
	position = target.position
	draw_camera_logic = true
	
func _process(delta: float) -> void:
	if !current:
		return
	
	# Show camera
	if draw_camera_logic:
		draw_logic()
		
	var target_position : Vector3 = target.global_position
	var camera_position : Vector3 = global_position
	var distance_camera_to_target : float = target_position.distance_to(camera_position)
	var direction : Vector3 = (target_position - camera_position).normalized()
	
	# Follow when target is moving
	if target.velocity:
		camera_position += direction * follow_speed * delta
	# Catch up when target is not moving
	else:
		camera_position += direction * catchup_speed * delta
	# Don't let the target get further from leash_distance
	if distance_camera_to_target > leash_distance:
		# move camera to keep leash distance
		camera_position = target_position - direction * leash_distance
		
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
