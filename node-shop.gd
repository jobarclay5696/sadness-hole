extends CSGMesh3D

@onready var area_node: Area3D = $Area3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_node.connect("item_collected", _hide_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _hide_item() -> void:
	print("work")
	hide()
	queue_free()
