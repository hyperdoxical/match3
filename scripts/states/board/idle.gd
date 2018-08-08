extends '_state.gd'

var swipe_start
var minimum_swipe_length
var detecting_swipe = false
var lmb = false
var matching_functions
var board_functions

func enter():
	
	
	
	
	matching_functions = board.get_node("functions/match")
	board_functions = board.get_node("functions/manage_board")
	
	var test = 	[
					[ null, null, null ],
					[ null, null, null ],
					[ null, null, null ]
				]

	test = board_functions.get_test_board ( board.board )
	#print(test)
	board_functions.fill_test_board( test )
	#print(test)
	board_functions.fill_board( board.board, test )
	
	minimum_swipe_length = board.tile_size.x/4
	if matching_functions.check_for_potential_moves( board.board ).size() == 0:
		board.emit_signal("no_moves_available")
	pass

func update(delta):
	pass

func handle_input(event):
	if event.is_action_pressed("LMB"):
		lmb = true
		detecting_swipe = true
		swipe_start = board.get_local_mouse_position()+board.tile_size/2
		#only accept if within the board as defined by the array board
		if swipe_start.x > 0 and swipe_start.x < board.tile_size.x * board.board[0].size():
			if swipe_start.y > 0 and swipe_start.y < board.tile_size.y * board.board.size():
				board.tile_selected = Vector2( board.position_to_coordinate( swipe_start, board.board, board.tile_size ) )
				if board.board[board.tile_selected.x][board.tile_selected.y] != null:
					board.board[board.tile_selected.x][board.tile_selected.y].get_ref().scale = Vector2(1.25,1.25)
					board.board[board.tile_selected.x][board.tile_selected.y].get_ref().z_index= 5
	if event is InputEventMouseMotion:
		if lmb:
			var mouse_position =  get_local_mouse_position()+(board.tile_size/2)
			if ( abs( swipe_start.x - mouse_position.x ) > minimum_swipe_length + 5 ) or ( abs( swipe_start.y - mouse_position.y ) > minimum_swipe_length ):
				if detecting_swipe:
					var direction_modifier = Vector2()
					if abs( swipe_start.x - mouse_position.x ) > abs( swipe_start.y - mouse_position.y ):
						if (swipe_start.x- mouse_position.x) > (minimum_swipe_length):
							direction_modifier = Vector2( 0, -1 ) #in row/colum NOT x/y
						if (swipe_start.x- mouse_position.x) < -(minimum_swipe_length):
							direction_modifier = Vector2( 0, 1 )
					else: #vertical
						if (swipe_start.y - mouse_position.y) > (minimum_swipe_length):
							direction_modifier = Vector2( -1, 0 )
						if (swipe_start.y - mouse_position.y) < -(minimum_swipe_length):
							direction_modifier = Vector2( 1, 0 )
					detecting_swipe = false
#					if matching_functions.test_match( board.board, board.tile_selected, board.tile_selected + direction_modifier ):
					if matching_functions.matches_from_swap( board.board, board.tile_selected, board.tile_selected + direction_modifier, true ):#.size() > 0:
						board.move_tiles()
						return "SWAPPING"
	if event.is_action_released("LMB"):
		lmb = false
		swipe_start = null
		if board.tile_selected != Vector2(-1,-1):
			if board.board[board.tile_selected.x][board.tile_selected.y] != null:
				board.board[board.tile_selected.x][board.tile_selected.y].get_ref().scale = Vector2(1,1)
				board.board[board.tile_selected.x][board.tile_selected.y].get_ref().z_index= 0
				board.tile_selected = Vector2(-1,-1)
	pass

func on_timer_timeout():
	pass

func exit():
	board.timer.stop()
	pass