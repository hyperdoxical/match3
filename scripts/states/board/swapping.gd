extends '_state.gd'


# Initialize the state. E.g. change the animation
func enter():
	#tween the two tiles and set the timer for the
	#tween time to exit this state
	board.timer.wait_time = board.tween.get_runtime() 
	board.timer.start()
	pass


func update(delta):
	
	pass


func handle_input(event):
	#if event.is_action_pressed('attack'):
	#	return 
	pass

#func on_tween_completed( object, key ):
#	if board.board[board.tile_selected.x][board.tile_selected.y] != null:
#		if board.board[board.tile_selected.x][board.tile_selected.y].get_ref() == object:
#			board.board[board.tile_selected.x][board.tile_selected.y].get_ref().scale = Vector2(1,1)
#			board.board[board.tile_selected.x][board.tile_selected.y].get_ref().z_index= 0
#			print(str(board.tile_selected.x) + str(board.tile_selected.y) )

func on_timer_timeout():
	
	return "MATCHING"
	pass

# Clean up the state. Reinitialize values like a timer
func exit():
	board.tween.remove_all ( )
	board.timer.stop()
	for column in range(board.board[0].size()):
		for row in range(board.board.size()):
			if board.board[row][column] != null:
				board.board[row][column].get_ref().scale = Vector2(1,1)
				board.board[row][column].get_ref().z_index = 0
	pass