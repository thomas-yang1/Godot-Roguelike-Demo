extends Control

onready var playerStats = PlayerStats
onready var max_hearts = playerStats.health setget set_max_hearts
onready var hearts = max_hearts setget set_hearts

onready var full = $Full
onready var empty = $Empty


func set_hearts(value: int) -> void:
	hearts = clamp(value, 0, max_hearts)
	if full != null:
		full.rect_size.x = hearts * 15
		

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	
	if empty != null:
		empty.rect_size.x = max_hearts * 15

	
func _ready() -> void:
	self.max_hearts = playerStats.max_health
	self.hearts = playerStats.health
	playerStats.connect("health_changed", self, "set_hearts")
	playerStats.connect('max_health_changed', self, "set_max_hearts")
