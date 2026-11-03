@icon( "res://player/States/state.svg" )

class_name PlayerState extends Node

var player:Player
var next_state : PlayerState
 #region \\\ state referneces
@onready var Idle:PlayerStateIdle=%Idle
@onready var Run:PlayerStateRun=%Run
@onready var Jump:PlayerStateJump=%Jump
@onready var Fall:PlayerStateFall=%Fall
@onready var Crouch:PlayerStateCrouch=%Crouch
#endregion

func  _init () -> void:
	
	pass 



func enter () -> void:
	
	pass 



func exit () -> void:
	
	pass 

func handled_input(_event: InputEvent) -> PlayerState:
	
	return next_state


func process(_delta: float) -> PlayerState:
		
	return next_state



func physics_process(_delta: float) -> PlayerState :
	
	return next_state
