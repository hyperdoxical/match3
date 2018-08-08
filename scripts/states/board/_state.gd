extends Node

#enum STATE_IDS {NULL, PREVIOUS_STATE,IDLE, GROUND, JUMP_UP, JUMP_DOWN, HIT, DEATH, INACTIVE}
var board = null



func _ready():
	
	# Store a reference to the FSM
	board = $'../..'

	# In 3.0 alpha, these functions are on by default for every node
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	

# Initialize the state. E.g. change the animation
func enter():
	pass


# Clean up the state. Reinitialize values like a timer
func exit():
	pass


func handle_input(event):
	pass


func update(delta):
	pass
