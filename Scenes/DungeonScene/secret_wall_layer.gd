extends TileMapLayer


func enable_secret_wall():
	visible = true
	collision_enabled = true
	

func disable_secret_wall():
	visible = false
	collision_enabled = false
	$AudioStreamPlayer2D.play()
