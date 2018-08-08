extends Node

onready var matching_functions = $"../match"
onready var board = $"../.."

func create_board ( rows, columns ):
	var arr = Array()
	for row in range(rows):
		arr.append([])
		for column in range(columns):
			arr[row].append(null)
	return arr

func get_test_board ( arr ):
	var rows = arr.size()
	var columns = arr[0].size()
	var test_board = []
	test_board = create_board( rows, columns )
	for row in range(rows):
		for column in range(columns):
			if arr[row][column] != null:
				test_board[row][column] = arr[row][column].get_ref().type
	return test_board


func fill_test_board ( arr ):
	var items = [0,1,2,3]
	for column in range(arr[0].size()):
		for row in range(arr.size()):
			if arr[row][column] == null:
				while arr[row][column] == null:
					arr[row][column] = floor(rand_range(0, 4))
					if matching_functions.integer_matches( arr, items ).size() > 0:
						arr[row][column] = null

func fill_board ( arr, test_arr ):
	for row in range(arr.size()):
		for column in range(arr[0].size()):
			if arr[row][column] == null:
				var tile_instance = board.tile.instance()
				##set tile details
				arr[row][column] = weakref(tile_instance)
				board.add_child(tile_instance)
				var tile_key = "0" + str(test_arr[row][column]) #"0" + str( floor(rand_range(0, board.tile_details.size())) ) 
				tile_instance.sprite.texture = load(board.tile_details[tile_key].image_normal )
				#print(board.tile_details[tile_key].image_normal)
				tile_instance.type = board.tile_details[tile_key].type
				arr[row][column].get_ref().position_begin_map = Vector2(row,column)
				arr[row][column].get_ref().position_end_map = arr[row][column].get_ref().position_begin_map
	for row in range(arr.size()):
		for column in range(arr[0].size()):
			if arr[row][column] != null:
				arr[row][column].get_ref().position.x = arr[row][column].get_ref().position_begin_map.y * board.tile_size.x
				arr[row][column].get_ref().position.y = arr[row][column].get_ref().position_begin_map.x * board.tile_size.y

func move_tiles( arr, tween_node, tile_size, time_swap ):
	var time = 0
	for column in range(arr[0].size()):
		for row in range(arr.size()):
			if arr[row][column] != null:
				tween_node.interpolate_property(arr[row][column].get_ref(), 'position',
					Vector2(arr[row][column].get_ref().position_begin_map.y * tile_size.x, arr[row][column].get_ref().position_begin_map.x * tile_size.y), Vector2(arr[row][column].get_ref().position_end_map.y * tile_size.x, arr[row][column].get_ref().position_end_map.x * tile_size.y), time_swap,
        Tween.TRANS_SINE, Tween.EASE_IN_OUT, time)
				#board[row][column].get_ref().position_end_map =board[row][column].get_ref().position_begin_map
		#time=time+0.25
				arr[row][column].get_ref().position_begin_map = arr[row][column].get_ref().position_end_map
	tween_node.start()

func remove_tiles( arr, list ):
	for item in list:
		if arr[item.x][item.y] != null:
			arr[item.x][item.y].get_ref().queue_free()
			arr[item.x][item.y] = null

func reset_scale_and_z ( arr ):
	for column in range(arr.board[0].size()):
		for row in range(arr.board.size()):
			if arr.board[row][column] != null:
				arr.board[row][column].get_ref().scale = Vector2(1,1)
				arr.board[row][column].get_ref().z_index = 0

func refill_columns ( arr ):
	for column in range(arr[0].size()):
		for row in range(arr.size()):
			if arr[arr.size()-row-1][column] == null:
				var test = 0
				var length = 0
				#determin the number of tiles to the next
				#non empty square
				while (arr.size()-row-1) - test > 0 and arr[(arr.size()-row-1) - test][column] == null:
					length += 1
					test += 1
				#swap the above found tile with the empty space
				#add the tiles which have been moved to another array
				#which we will use to animate later
				#maybe an array where the indices hold the new location
				#maybe have an array of dict where we have key called position_start
				#and position_finish
				#maybe send positional data to the tile object
				#of start and finish. then at end of move start = finish
				arr[arr.size()-row-1][column] = arr[arr.size()-row-1-length][column]
				arr[arr.size()-row-1-length][column] = null
				if arr[arr.size()-row-1][column] != null:
					arr[arr.size()-row-1][column].get_ref().position_end_map = Vector2(arr.size()-row-1,column)
					#arr[arr.size()-row-1][column].get_ref().position_end_map = arr[arr.size()-row-1][column].get_ref().position_begin_map
	return arr