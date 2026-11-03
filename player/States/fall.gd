class_name PlayerStateFall extends PlayerState

@export var fall_gravity_multiplayer :float =1
@export var coyote_time  : float = 0.4
@export var jump_buffer_time : float =0.2

var coyote_timer : float =0
var buffer_timer : float =0

func  _init () -> void:
	
	pass 


func enter () -> void:
	player.animation_player.pause()
	player.animation_player.play("jamp")
	player.gravity_multiplayer = fall_gravity_multiplayer
	if player.previous_state==Jump or player.previous_state == Crouch:
		coyote_timer =0
	else:
		coyote_timer = coyote_time

	pass 



func exit () -> void:
	player.gravity_multiplayer= 1.0
	buffer_timer =0
	pass 

func handled_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if coyote_timer > 0 :
			return Jump
		else :
			buffer_timer = jump_buffer_time
			
	return next_state


func process(_delta: float) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -=_delta
	set_jump_frame()
	return next_state



func physics_process(_delta: float) -> PlayerState :
	if player.is_on_floor():
		player.add_debug_indicator()
		#if buffer_timer > 0 and Input.is_action_pressed("Jump"):
		if buffer_timer > 0 :
			return Jump
		return Idle
	
	
	player.velocity.x = player.direction.x * player.move_speed
	return next_state


func set_jump_frame()->void:
	var frame :float =remap(player.velocity.y,0.0,player.max_fall_speed,0.5,0.1)
	player.animation_player.seek(frame,true)
	pass
