extends StaticBody2D

@export var buttons_needed: int = 1

@export var door_name: String 

@export var can_stay_open: bool = false

var button_pressed: int = 0


func _on_puzzle_button_pressed() -> void:
	button_pressed += 1
	
	if button_pressed >= buttons_needed:
		visible = false
		$AudioStreamPlayer2D.play()
		$CollisionShape2D.set_deferred("disabled", true)
	


func _on_puzzle_button_unpressed() -> void:
	button_pressed -= 1
	
	if button_pressed < buttons_needed:
		visible = true
		$CollisionShape2D.set_deferred("disabled", false)


func _on_single_use_puzzle_button_pressed() -> void:
	visible = false
	$AudioStreamPlayer2D.play()
	$CollisionShape2D.set_deferred("disabled", true)
