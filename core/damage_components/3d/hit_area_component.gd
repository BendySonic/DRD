class_name HitAreaComponent3D extends Area3D

@export var health_component: HealthComponent

func damage(attack: Attack):
	health_component.damage(attack)

