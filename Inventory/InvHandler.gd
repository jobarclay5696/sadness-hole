extends Control
class_name InvHandler

@export var ItemSlotsCount : int = 20
@export var InvGrid : GridContainer
@export var InvSlotPrefab : PackedScene = preload("res://Inventory/InvSlot.tscn")

var InvSlots : Array[InvSlot] = []

func _ready() -> void:
	
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	for i in ItemSlotsCount:
		var slot = InvSlotPrefab.instantiate() as InvSlot
		if InvGrid != null:
			InvGrid.add_child(slot)
		InvSlots.append(slot)

func PickupItem(item : ItemData):
	for slot in InvSlots:
		if (!slot.SlotFilled):
			slot.FillSlot(item)
			break

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		if visible:
			# Inventory opened -> Free the mouse cursor to use the inventory
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			# Inventory closed -> Lock the mouse cursor back into the game
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
