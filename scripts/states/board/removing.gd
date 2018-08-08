#https://godotengine.org/qa/24585/how-to-loop-a-tween-solved
extends '_state.gd'
var matching_functions
var board_functions
var tween_values_scale = [Vector2(1,1), Vector2(1.2, 1.2)]
var popping_time = 0.1
var matchlist = []

func enter():
	matching_functions = board.get_node("functions/match")
	board_functions = board.get_node("functions/manage_board")
	board.tween.remove_all ( )
	matchlist = matching_functions.dict_to_list ( matching_functions.process_detailed_matches ( board.board, [0,1,2,3]  ) )  
	tween_tiles ( board.board, matchlist)
#	tween_tiles ( board.board, board.get_node("functions/match").matches( board.board , [0, 1, 2, 3 ] ))
	pass

func update(delta):
	pass

func handle_input(event):
	#if event.is_action_pressed('attack'):
	#	return 
	pass

func tween_tiles( arr, list ):
	for item in list:
		if arr[item.x][item.y] != null:
			board.tween.interpolate_property(arr[item.x][item.y].get_ref(), 'scale', tween_values_scale[0], tween_values_scale[1], popping_time, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	board.tween.repeat = false
	board.tween.start()

func on_tween_completed( object, key ):
	return "CASCADE"

func exit():
	board.timer.stop()
	#if matching_functions.matches( board.board , [0, 1, 2, 3 ] ).size() > 0:
	if matchlist.size() > 0:
#		print("from exit() in removing.gd")
#		print("Type")
#		print(matching_functions.detailed_matches ( board.board, [0, 1, 2, 3 ] ))
		board.emit_signal("matches", matchlist.size())
#	matching_functions.process_detailed_matches ( board.board )
	#matching_functions.process_detailed_matches (board.board )
	board_functions.remove_tiles( board.board, matching_functions.matches( board.board , [0, 1, 2, 3 ] ) )
#	board.tween.stop_all()
#	board.tween.remove_all ( )
	pass