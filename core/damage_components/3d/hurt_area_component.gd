class_name HurtAreaComponent3D extends Area3D

@export var attack: Attack

signal hurted(area)

func _ready():
	var on_entered = (
	func(area):
		if area is HitAreaComponent3D:
			area.damage(attack)
			hurted.emit(area)
	)
	
	area_entered.connect(on_entered)
