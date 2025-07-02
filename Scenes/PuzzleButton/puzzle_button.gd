extends Area2D

@export var is_single_use: bool = false

var bodies_on_top: int = 0
signal pressed
signal unpressed



func _on_body_entered(body: Node2D) -> void:
	bodies_on_top += 1
	if body.is_in_group("pushable") or body is Player:
		if bodies_on_top == 1:
			$AudioStreamPlayer2D.pitch_scale = 1.0
			$AudioStreamPlayer2D.play()
			pressed.emit()
			$AnimatedSprite2D.play("pressed")
		
		
		


func _on_body_exited(body: Node2D) -> void:
	if is_single_use:
		return
	
	bodies_on_top -= 1
	if body.is_in_group("pushable") or body is Player:
		if bodies_on_top == 0:
			$AudioStreamPlayer2D.pitch_scale = 0.7
			$AudioStreamPlayer2D.play()
			unpressed.emit()
			$AnimatedSprite2D.play("unpressed")
