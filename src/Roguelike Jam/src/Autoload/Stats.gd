class_name Stats
extends Node

export var max_health :int
onready var health :int setget set_health

signal no_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
