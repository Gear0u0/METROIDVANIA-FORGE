
class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICTOR = preload("res://player/debug_jump_indicator.tscn")


#region /// on ready Variables
@onready var sprite : Sprite2D =$Sprite2D
@onready var collision_stand : CollisionShape2D = $CollisionStand
@onready var collision_crouch : CollisionShape2D = $CollisionCrouch
@onready var animation_player : AnimationPlayer =$AnimationPlayer
@onready var one_way_platform_shape_cast : ShapeCast2D =$OneWayPlatformShapeCast2D
#endregion

#region /// @exort Variables
@export var move_speed = 150
@export var max_fall_speed:float=600.0
#endregion

#region /// State Machine Variables

var states: Array[ PlayerState ]
var current_state: PlayerState:
	get:return states.front()
var previous_state : PlayerState:
	get: return states[1]

#endregion


#region /// Standard Variables

var direction: Vector2 = Vector2.ZERO
var gravity: float = 980.0
var gravity_multiplayer : float = 1.0
#endregion


func _ready()-> void:
	initialize_states()
	Engine.time_scale=0.5
	pass

 
func _unhandled_input(_event: InputEvent) -> void:
	update_direction()
	change_state(current_state.handled_input(_event))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	change_state(current_state.process(_delta))
	pass


func _physics_process(_delta: float) -> void:
	velocity.y += gravity *_delta * gravity_multiplayer
	velocity.y= clampf(velocity.y,-1000.0,max_fall_speed)
	move_and_slide()
	change_state(current_state.physics_process(_delta))
	pass


func initialize_states()->void:
	states =[]
	for C in $States.get_children():
		if C is PlayerState:
			states.append( C )
			C.player = self
		pass
	if states.size() == 0 :
		return 
	
	for state in states :
		state._init()
	
	change_state(current_state)
	current_state.enter()
	$Label.text = current_state.name
	pass




func change_state(new_state : PlayerState )-> void:
	if new_state == null : 
		return
	
	elif new_state == current_state:
		return
	 
	
	if current_state:
		current_state.exit()
	
	states.push_front( new_state )
	current_state.enter()
	states.resize(3)
	$Label.text = current_state.name
	pass

func update_direction() -> void:
	var prev_direction : Vector2 = direction
	var x_axis: float = Input.get_axis("left", "right")
	var y_axis: float = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	if prev_direction.x != direction.x:
		if direction.x < 0:
			sprite.flip_h= true
		elif direction.x >0:
			sprite.flip_h =false
	pass

func add_debug_indicator(color:Color = Color.RED)-> void:
	var d :Node2D = DEBUG_JUMP_INDICTOR.instantiate()
	get_tree().root.add_child(d)
	d.global_position =global_position
	d.modulate =color
	await get_tree().create_timer(3.0).timeout
	d.queue_free()
	pass
