class_name PlayerStateJump extends PlayerState

@export var jump_velocity: float = 450


func enter () -> void:
	player.animation_player.pause()
	player.animation_player.play("jamp")
	#player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -jump_velocity
	
	
	
	if player.previous_state== Fall and not Input.is_action_pressed("jump"):
		await get_tree().physics_frame
		player.velocity.y *=0.5
		player.change_state(Fall)

		pass
	pass


func exit () -> void:
	player.add_debug_indicator(Color.YELLOW)
	pass


func handled_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return Fall
		
	return next_state

func process(_delat:float)->PlayerState:
	set_jump_frame()
	return next_state

func physics_process(_delta: float) -> PlayerState :


	if player.is_on_floor():
		return Idle
		
	elif player.velocity.y >= 0:
		return Fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state



func set_jump_frame()->void:
	var frame :float =remap(player.velocity.y,-jump_velocity,0.0,0.0,0.5)
	player.animation_player.seek(frame,true)
	pass
