#https://godotengine.org/qa/24585/how-to-loop-a-tween-solved
extends '_state.gd'
var matching_functions
var tween_values_scale = [Vector2(0.95,0.95), Vector2(1.05, 1.05)]
var popping_time = 1.0
var number_of_bounces = 0
var total_number_of_bounces = 5
var matchlist = []

# Initialize the state. E.g. change the animation
func enter():
	matching_functions = board.get_node("functions/match")
	#tween the two tiles and set the timer for the
	#tween time to exit this state
	board.tween.remove_all ( )
	board.timer.wait_time = popping_time
	board.timer.start()
	matchlist = matching_functions.matches( board.board , [0, 1, 2, 3 ] )
	#animate_removal( board.board, matchlist )
	tween_start( board.board, matchlist )
	board.tween.repeat = true
	board.tween.start()
	pass


func update(delta):
	
	pass


func handle_input(event):
	#if event.is_action_pressed('attack'):
	#	return 
	pass

func tween_start( arr, list ):
	for item in list:
		if arr[item.x][item.y] != null:
			board.tween.interpolate_property(arr[item.x][item.y].get_ref(), 'scale', tween_values_scale[0], tween_values_scale[1], 0.5, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
		
#func tween_start( arr, list ):
#	#print(tween_values_scale)
#	board.tween.stop_all()
#	list = matching_functions.remove_duplicates_from_list ( list )
#	for item in list:
#		if arr[item.x][item.y] != null:
#			board.tween.interpolate_property(arr[item.x][item.y].get_ref(), 'scale', tween_values_scale[0], tween_values_scale[1], 0.5, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
#	#board.tween.stop_all()
#	#board.tween.remove_all ( )
#	if board.timer.is_stopped() == true:
#		#board.timer.start()
#		#print("Timer stopped")
#		pass

#func pop_tiles( arr, list ):
#	return "IDLE"

func on_tween_completed( object, key ):

	tween_values_scale.invert()
	#var matchlist = board.matches( board.board , [0, 1, 2, 3 ] )
	#tween_start( board.board, matchlist )
	#pop_tiles ( board.board, matchlist )
	
func on_timer_timeout():
	board.tween.stop_all()
	return "REMOVING"
	pass

# Clean up the state. Reinitialize values like a timer
func exit():
	board.timer.stop()
#	print( "from matching.gd exit() matches : " + str(  [Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(0, 2), Vector2(1, 2), Vector2(2, 2), Vector2(3, 2)] ) )
#	print( "from matching.gd exit() dupes : " + str(matching_functions.get_duplicates_from_list(  [Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(0, 2), Vector2(1, 2), Vector2(2, 2), Vector2(3, 2)] )))
#	print( "from matching.gd exit() dupes : " + str(matching_functions.remove_duplicates_from_list(  [Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(0, 2), Vector2(1, 2), Vector2(2, 2), Vector2(3, 2)] )))
#	var test_board 	=	[
#							[0, 1, 0],
#							[1, 1, 1],
#							[0, 1, 0]
#						]

#	var temp_list = [Vector2(0, 1), Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 1), Vector2(2, 1)]
#	print( "from matching.gd exit() dupes : " + str(matching_functions.remove_duplicates_from_list( temp_list ) ))
	
	#remove_tiles( board.board, matchlist )
	#board.tween.stop_all()
	#board.tween.remove_all ( )
	pass


#func animate_

func animate_removal ( arr, list ):
	board.tween.repeat = true
	for item in list:
		if arr[item.x][item.y] != null:
			#board.tween.interpolate_property(arr[item.x][item.y].get_ref(), 'scale', arr[item.x][item.y].get_ref().scale, arr[item.x][item.y].get_ref().scale*1.25, popping_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			board.tween.interpolate_property(arr[item.x][item.y].get_ref(), 'scale', tween_values_scale[0], tween_values_scale[1], popping_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			arr[item.x][item.y].get_ref()
	board.tween.start()