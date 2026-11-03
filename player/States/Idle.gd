class_name PlayerStateIdle extends PlayerState


func  _init () -> void:
	
	pass 



func enter () -> void:
	player.animation_player.play("idle")
	pass 



func exit () -> void:
	
	pass 

func handled_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return Jump
	return next_state


func process(_delta: float) -> PlayerState:
	if player.direction.x!=0:
		return Run
	elif  player.direction.y > 0.5:
		return Crouch
	return null

func physics_process(_delta: float) -> PlayerState :
	player.velocity.x=0 
	if player.is_on_floor()==false:
		return Fall
	return next_state
