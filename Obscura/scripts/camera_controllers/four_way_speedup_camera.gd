class_name FourWaySpeedupCamera
extends CameraControllerBase

@export var push_ratio : float = target.BASE_SPEED * 0.5
@export var pushbox_top_left : Vector2 = Vector2(-8,8)
@export var pushbox_bottom_right : Vector2 = Vector2(8,-8)
@export var speedup_zone_top_left : Vector2 = Vector2(-5,5)
@export var speedup_zone_bottom_right : Vector2 = Vector2(5,-5)

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
	var camera_position : Vector3 = global_position
	var box_width : float = pushbox_bottom_right.x - pushbox_top_left.x
	var box_height : float = pushbox_top_left.y - pushbox_bottom_right.y
	# pushbox
	#left
	var diff_between_left_edges = (target_position.x - target.WIDTH / 2.0) - (camera_position.x - box_width / 2.0)
	if diff_between_left_edges < 0:
		camera_position.x += diff_between_left_edges
	#right
	var diff_between_right_edges = (target_position.x + target.WIDTH / 2.0) - (camera_position.x + box_width / 2.0)
	if diff_between_right_edges > 0:
		camera_position.x += diff_between_right_edges
	#top
	var diff_between_top_edges = (target_position.z - target.HEIGHT / 2.0) - (camera_position.z - box_height / 2.0)
	if diff_between_top_edges < 0:
		camera_position.z += diff_between_top_edges
	#bottom
	var diff_between_bottom_edges = (target_position.z + target.HEIGHT / 2.0) - (camera_position.z + box_height / 2.0)
	if diff_between_bottom_edges > 0:
		camera_position.z += diff_between_bottom_edges
		
	# speedup zone boundary
	var speedup_zone_left : float = global_position.x + speedup_zone_top_left.x
	var speedup_zone_top : float = global_position.z + speedup_zone_top_left.y
	var speedup_zone_right : float = global_position.x + speedup_zone_bottom_right.x
	var speedup_zone_bottom : float = global_position.z + speedup_zone_bottom_right.y
	var direction : Vector3 = (target_position - camera_position).normalized()
	# check if target is in speedup zone
	if (target_position.x < speedup_zone_left 
	or target_position.z > speedup_zone_top
	or target_position.x > speedup_zone_right
	or target_position.z < speedup_zone_bottom):
		# follow player until out of speedup zone
		camera_position += direction * push_ratio * delta
		
	# Keep container box moving with camera
	var pushbox_container_left : float = global_position.x + pushbox_top_left.x
	var pushbox_container_top : float = global_position.z + pushbox_top_left.y
	var pushbox_container_right : float = global_position.x + pushbox_bottom_right.x
	var pushbox_container_bottom : float = global_position.z + pushbox_bottom_right.y
	
	# Keep target inside container box
	if target.position.x < pushbox_container_left:
		target.position.x = pushbox_container_left

	if target.position.x > pushbox_container_right:
		target.position.x = pushbox_container_right
		
	if target.position.z > pushbox_container_top:
		target.position.z = pushbox_container_top
		
	if target.position.z < pushbox_container_bottom:
		target.position.z = pushbox_container_bottom
		
	global_position = camera_position

	super(delta)
	
func draw_logic() -> void:
	# pushbox container
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = pushbox_top_left.x
	var right:float = pushbox_bottom_right.x
	var top:float = pushbox_top_left.y
	var bottom:float = pushbox_bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.YELLOW
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# speedup zone
	var speedup_mesh_instance := MeshInstance3D.new()
	var speedup_immediate_mesh := ImmediateMesh.new()
	var speedup_material := ORMMaterial3D.new()
	
	speedup_mesh_instance.mesh = speedup_immediate_mesh
	speedup_mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var speedup_left:float = speedup_zone_top_left.x
	var speedup_right:float = speedup_zone_bottom_right.x
	var speedup_top:float = speedup_zone_top_left.y
	var speedup_bottom:float = speedup_zone_bottom_right.y
	
	speedup_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, speedup_material)
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_top))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_bottom))
	
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_bottom))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_bottom))
	
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_bottom))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_top))
	
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_top))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_top))
	speedup_immediate_mesh.surface_end()

	speedup_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	speedup_material.albedo_color = Color.WHITE
	
	add_child(speedup_mesh_instance)
	speedup_mesh_instance.global_transform = Transform3D.IDENTITY
	speedup_mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	speedup_mesh_instance.queue_free()
