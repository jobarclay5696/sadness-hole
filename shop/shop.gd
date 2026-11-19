extends Control

@onready var shop: Control = $Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("open"):
		print("something")
		visible = !visible
		if visible:
			# Inventory opened -> Free the mouse cursor to use the inventory
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			# Inventory closed -> Lock the mouse cursor back into the game
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#get_tree().change_scene_to_file("res://main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
