extends CharacterBody2D

var target: Node2D

@export var speed: float = 30
@export var acceleration: float = 5
@export var HP: int = 2



func _physics_process(delta: float) -> void:
	if HP <= 0:
		return
	
	chase_target()
	
	animate_enemy()
	
	move_and_slide()
		

func chase_target():
	if target:
		var distance_to_player: Vector2
		distance_to_player = target.global_position - global_position
		
		var direction_normal: Vector2 = distance_to_player.normalized()
		
		
		velocity = velocity.move_toward(direction_normal * speed, acceleration)
		
		
func animate_enemy():
	var normal_velosity: Vector2 = velocity.normalized()
	
	if normal_velosity.x > 0.707:
		#moving right
		$AnimatedSprite2D.play("move_right")
	elif normal_velosity.x < -0.707:
		#moving left
		$AnimatedSprite2D.play("move_left")
	elif normal_velosity.y > 0.707:
		#moving down
		$AnimatedSprite2D.play("move_down")
	elif normal_velosity.y < -0.707:
		#moving up
		$AnimatedSprite2D.play("move_up")
		
func take_damage():
	
	HP -= 1
	if HP <= 0:
		die()
		
	play_damage_sfx()
	
	var flash_red_color:Color = Color(25,0.5,0.5)
	modulate = flash_red_color
	
	await get_tree().create_timer(0.2).timeout
	
	if is_instance_valid(self):
		var original_color:Color = Color(1,1,1)
		modulate = original_color
	
	

func _on_player_detect_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
		

func play_damage_sfx():
	$DamageSFX.play()
	
func die():
	$GPUParticles2D.emitting = true
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	
	await get_tree().create_timer(1).timeout
	
	queue_free()
