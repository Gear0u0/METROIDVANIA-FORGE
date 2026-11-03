class_name PlayerStateCrouch extends PlayerState

@export var declertion_rate : float = .1



func  _init () -> void:
	
	pass 



func enter () -> void:
	player.animation_player.play("crouch")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false

	pass 



func exit () -> void:

	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true

	pass 

func handled_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		player.one_way_platform_shape_cast.force_shapecast_update()
		if player.one_way_platform_shape_cast.is_colliding()==true:
			player.position.y += 4
			return Fall
		return Jump
	return next_state


func process(_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return Idle
	return next_state

func physics_process(_delta: float) -> PlayerState :
	player.velocity.x-=player.velocity.x*declertion_rate*_delta
	if player.is_on_floor()==false:
		return Fall
	return next_state
