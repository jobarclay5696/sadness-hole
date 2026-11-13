extends CSGBox3D

@onready var prompt: Label3D = $Label3D 
signal item_collected
var player_nearby: bool = false
var hardcodingfunny: int = -1
func _ready() -> void:
	print("ready")
	prompt.hide() 
	
	

func _process(_delta: float) -> void:
	if hardcodingfunny <= 0:
		player_nearby = false
		prompt.hide()
		
	if player_nearby and Input.is_action_just_pressed("use"):
		collect()

func _on_body_entered(_body: Node3D) -> void:
	hardcodingfunny += 1
	print("on body entered")
	player_nearby = true
	prompt.show()
	

func _on_body_exited(_body: Node3D) -> void:
	print("on body exited")
	player_nearby = false
	prompt.hide()

func collect() -> void:
	item_collected.emit()
	print("Item collected")
