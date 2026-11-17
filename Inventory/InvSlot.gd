extends Control
class_name InvSlot

@export var IconSlot : TextureRect

var InvSlotID : int = -1
var SlotFilled : bool = false

var SlotData : ItemData

func FillSlot(data : ItemData):
	SlotData = data
	SlotFilled = true
	IconSlot.texture = data.Icon
