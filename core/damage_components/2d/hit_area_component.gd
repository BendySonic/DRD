class_name HitAreaComponent2D extends Area2D

@export var health_component: HealthComponent

func damage(attack: Attack):
	health_component.damage(attack)

