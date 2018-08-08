extends '_state.gd'

var matching_functions
var board_functions
var tween_values_scale = [Vector2(1,1), Vector2(1.2, 1.2)]
var hang_time = 1
var matchlist = []
var processed = false

func enter():
	#need to have here are exit of prev is called after this
	processed = false
	matching_functions = board.get_node("functions/match")
	board_functions = board.get_node("functions/manage_board")
	board.tween.stop_all()
	board.tween.remove_all ( )
	board.timer.wait_time = board.tween.get_runtime() + 5
	board.timer.stop()
	#board.tween.start()
	pass



func update(delta):
	if processed == false:
		processed = true
		process_movement()
#		board.timer.wait_time = board.tween.get_runtime() + 1
#		board.timer.start()
		
	pass

func handle_input(event):
	#if event.is_action_pressed('attack'):
	#	return 
	pass

func process_movement():
	board.board = board_functions.refill_columns(board.board)
	board_functions.move_tiles( board.board, board.tween, board.tile_size, board.time_swap )


func on_timer_timeout():
#	print(matching_functions.matches( board.board , [0, 1, 2, 3 ] ).size())
#	if matching_functions.matches( board.board , [0, 1, 2, 3 ] ).size() > 0:
#		return "MATCHING"
#	else:
#		return "IDLE"
	pass

func on_tween_completed( object, key ):
	#print(matching_functions.matches( board.board , [0, 1, 2, 3 ] ).size())
	if matching_functions.matches( board.board , [0, 1, 2, 3 ] ).size() > 0:
		return "MATCHING"
	else:
		return "IDLE"

func exit():
	board.timer.stop()
	#board_functions.remove_tiles( board.board, board.get_node("functions/match").matches( board.board , [0, 1, 2, 3 ] ) )
	board.tween.stop_all()
	board.tween.remove_all ( )
	pass