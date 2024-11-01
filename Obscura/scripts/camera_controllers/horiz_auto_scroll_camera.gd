class_name HorizAutoScrollCamera
extends CameraControllerBase

@export var top_left : Vector2 = Vector2(-5, 5)
@export var bottom_right : Vector2 = Vector2(5, -5)
@export var autoscroll_speed : Vector3 = Vector3(0.5,0.5,0)
@export var box_width:float = 15.0
@export var box_height:float = 15.0

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
	
	# Autoscroll camera
	global_position += autoscroll_speed
	
	# Keep container box moving with camera
	var container_left : float = global_position.x + top_left.x
	var container_top : float = global_position.z + top_left.y
	var container_right : float = global_position.x + bottom_right.x
	var container_bottom : float = global_position.z + bottom_right.y
	
	# Keep target inside container box
	if target.position.x < container_left:
		target.position.x = container_left

	if target.position.x > container_right:
		target.position.x = container_right
		
	if target.position.z > container_top:
		target.position.z = container_top
		
	if target.position.z < container_bottom:
		target.position.z = container_bottom

	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = top_left.x
	var right:float = bottom_right.x
	var top:float = top_left.y
	var bottom:float = bottom_right.y
	
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
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
