class_name HurtAreaComponent2D extends Area2D

@export var attack: Attack

signal hurted(area)

func _ready():
	var on_entered = (
	func(area):
		if area is HitAreaComponent2D:
			area.damage(attack)
			hurted.emit(area)
	)
	
	area_entered.connect(on_entered)
