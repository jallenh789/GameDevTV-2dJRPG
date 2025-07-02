extends StaticBody2D

var can_interact: bool = false
var dialouge_index: int = 0 

@export var dialouge_lines: Array[String] = ["Hi!","How are you?","Bye"]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and can_interact:
		$AudioStreamPlayer2D.play()
		if dialouge_index < dialouge_lines.size():
			$CanvasLayer.visible = true
			get_tree().paused = true
			
			$CanvasLayer/DialogueLabel.text = dialouge_lines[dialouge_index]
			dialouge_index += 1
		else:
			$CanvasLayer.visible = false
			get_tree().paused = false
			dialouge_index = 0
