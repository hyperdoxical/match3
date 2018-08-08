extends '_state.gd'

var board_functions

# Initialize the state. E.g. change the animation
func enter():
	board_functions = board.get_node("functions/manage_board")
	randomize()
	board.board = board_functions.create_board( 3, 3)
	#print(board.board)
	#fill_board( board )
	var test = 	[]
	test = board_functions.get_test_board ( board.board )
	#print(test)
	board_functions.fill_test_board( test )
	#print(test)
	board_functions.fill_board( board.board, test )
	pass


func update(delta):
	return "IDLE"
	pass


func handle_input(event):
	#if event.is_action_pressed('attack'):
	#	return 
	pass

func on_timer_timeout():
	pass

# Clean up the state. Reinitialize values like a timer
func exit():
	board.timer.stop()
	pass


#func create_board ( rows, columns ):
#	var arr = Array()
#	for row in range(rows):
#		arr.append([])
#		for column in range(columns):
#			arr[row].append(null)
#	return arr

#func fill_board ( arr ):
#	for row in range(board.board.size()):
#		for column in range(board.board[0].size()):
#			if board.board[row][column] != null:
#				board.board[row][column].get_ref().queue_free()
#	#print_board(board)
#	for row in range(board.board.size()):
#		for column in range(board.board[0].size()):
#			if round(rand_range(2,3)) != 1:
#				var tile_instance = board.tile.instance()
#				##set tile details
#
#				board.board[row][column] = weakref(tile_instance)
#				board.add_child(tile_instance)
#				var tile_key = "0" + str( floor(rand_range(0, board.tile_details.size())) ) 
#				tile_instance.sprite.texture = load(board.tile_details[tile_key].image_normal )
#				tile_instance.type = board.tile_details[tile_key].type
#				board.board[row][column].get_ref().position_begin_map = Vector2(row,column)
#				board.board[row][column].get_ref().position_end_map = board.board[row][column].get_ref().position_begin_map
#			else:
#				board.board[row][column] = null
#
#	for row in range(board.board.size()):
#		for column in range(board.board[0].size()):
#			if board.board[row][column] != null:
#				board.board[row][column].get_ref().position.x = board.board[row][column].get_ref().position_begin_map.y * board.tile_size.x
#				board.board[row][column].get_ref().position.y = board.board[row][column].get_ref().position_begin_map.x * board.tile_size.y