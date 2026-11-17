extends Node3D
class_name InteractableItem

# Use forward slashes (/) to point to nested child nodes
@onready var item_highlight_mesh: MeshInstance3D = $MeshInstance3D/outline
@onready var item_name: Label = $MeshInstance3D/Label # Change to Label if you aren't using Label3D yet

func _ready() -> void:
	# Quick debug print statements to make sure Godot locates them perfectly
	if not item_highlight_mesh:
		print_debug("ERROR: Could not find 'outline' inside MeshInstance3D!")
	if not item_name:
		print_debug("ERROR: Could not find 'label' inside MeshInstance3D!")
		
	# Hide the outline and text when the game starts
	_set_visuals(false)

func GainFocus():
	_set_visuals(true)

func LoseFocus():
	_set_visuals(false)

func _set_visuals(is_visible: bool):
	if item_highlight_mesh:
		item_highlight_mesh.visible = is_visible
	if item_name:
		item_name.visible = is_visible
