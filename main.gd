extends Node

var mob_scene = preload("res://mob.tscn")
var score = 0

func _ready() -> void:
	randomize()

func new_game():
	score = 0
	$HUD.update_score(score)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	$StartTimer.start()
	$Music.play()
	
	$HUD.show_message("Get Ready...")
	
	$ScoreTimer.start()
	$MobTimer.start()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func _on_mob_timer_timeout() -> void:
	# Get the MobPath/MobSpawnLocation node
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation") as PathFollow2D
	
	# Verify the node exists and is the correct type
	if not mob_spawn_location:
		push_error("MobSpawnLocation not found or not a PathFollow2D")
		return
	
	# Set a random position along the path
	mob_spawn_location.progress_ratio = randf()
	
	# Create and position the mob
	var mob = mob_scene.instantiate()
	add_child(mob)
	
	mob.position = mob_spawn_location.global_position
	
	# Calculate direction with some randomness
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Set velocity
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
