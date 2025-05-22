extends RigidBody2D

var min_speed = 150.0
var max_speed = 250.0

func _ready() -> void:
	$AnimatedSprite2D.play()
	var mob_types = ["walk", "swim", "fly"]
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]  


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
