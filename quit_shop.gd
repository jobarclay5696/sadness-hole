extends Button

@onready var shop: Control = $Shop/Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	
	

func _on_pressed():
	print("you pressed it!")
	set_visibility_layer_bit(0, false)
	
	#visible = false
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
