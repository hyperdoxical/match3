extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var timer = $"timer"
onready var tween = $"tween"
var time_swap = 0.5
#var cell_type = {"row": 0, "column": 0}
#var cell = cell_type
var tile_selected = Vector2(-1,-1)
#var tile_selected = cell_type
var tile = preload("res://scenes/tile.tscn")
var tile_size = Vector2(48,48)
var tile_details	= 	{	"00":		{
										image_normal		= "res://sprites/tiles/tile1.png",
										type				= 0
										},
							"01":		{
										image_normal		= "res://sprites/tiles/tile2.png",
										type				= 1
										},
							"02":		{
										image_normal		= "res://sprites/tiles/tile3.png",
										type				= 2
										},
							"03":		{
										image_normal		= "res://sprites/tiles/tile4.png",
										type				= 3
										}

					}

var board

var matching_functions
# STATE MACHINE
var states = []
var States = {}


#signals
signal no_moves_available
signal matches (dict_of_matches)

func create_states():
	if has_node("states"):
		States = {}
		var STATES = get_node("states")
		#var count = 2
		for node in STATES.get_children():
			#print(node.name + ":" + str(node))
			#print(node.name.to_upper() + ":" + str(node))
			#States[count] = node
			States[node.name.to_upper()] = node
		#	count = count + 1

func set_tile_size():
	print(tile_details["00"].image_normal )

func test():
	print("no matches")

func matches ( value ):
	#print(" scored: " + str(value) )
	print("===========")
	print("= RESULTS =")
	print("===========")
	print(" ")
	var results = matching_functions.process_detailed_matches ( board, [0, 1, 2, 3] )
	matching_functions.display_results ( results )
	print("===========")

func _ready():
	matching_functions = get_node("functions/match")
	connect("no_moves_available", self, "test")
	connect("matches", self, "matches")
	var temp = 	[
					[ 1, 1, 1, null ],
					[ 5, 2, 3, null ],
					[ 1, 1, 1, null ],
					[ 1, 1, 1, null ]
				]
	print(get_node("functions/match").is_tile( temp, Vector2( 0, 3)))
	position = tile_size/2
	#OS.window_size = Vector2(500,500)
	OS.window_position = Vector2(0,0)
	timer.connect("timeout", self, "_on_timer_timeout")
	tween.connect("tween_completed", self, "_on_tween_completed")
	create_states()
	states.push_front(States["INITIALISE"])
	states[0].enter()
	set_as_toplevel(true)


	

func _physics_process(delta):
	var new_state = states[0].update(delta)
	if new_state:
		go_to_state(new_state)


func _input(event):
	var new_state = states[0].handle_input(event)
	if new_state:
		go_to_state(new_state)


func go_to_state(new_state):
	if new_state == "PREVIOUS_STATE":
		states.pop_front()
	else:
		if States.has(new_state):
			states[0].exit()
			states[0] = States[new_state]
			states[0].enter()
			print("State changed to " + states[0].get_name())
		else:
			print("Unable to locate state " + str(new_state))
			print("State unchanged")
	

	

func _on_timer_timeout():
	if not states[0].has_method('on_timer_timeout'):
		return
	var new_state = states[0].on_timer_timeout()
	if new_state:
		go_to_state(new_state)

func _on_tween_completed( object, key ):
	if not states[0].has_method('on_tween_completed'):
		return
	var new_state = states[0].on_tween_completed( object, key )
	if new_state:
		go_to_state(new_state)

func position_to_coordinate( pos, arr, cell_size ):
	return Vector2((floor(pos.y/cell_size.y) ) , (floor(pos.x/cell_size.x) ) )

func can_match ( arr, cell01, cell02, tiles_to_match ):
	#check if values work in array
	if cell01.y >= arr[0].size() or cell01.y < 0:
		return false
	if cell01.x >= arr.size() or cell01.x < 0:
		return false
	if cell02.y >= arr[0].size() or cell02.y < 0:
		return false
	if cell02.x >= arr.size() or cell02.x < 0:
		return false
	
	#check if cells contain a tile
	if arr[cell01.x][cell01.y] ==null: #redundant as logic check prevents this
		return false
	if arr[cell02.x][cell02.y] ==null: #redundant as logic check prevents this
		return false
	
	var cell01_original = arr[cell01.x][cell01.y]
	var cell02_original = arr[cell02.x][cell02.y]

	#swap_cells
	arr[cell01.x][cell01.y] = cell02_original
	arr[cell02.x][cell02.y] = cell01_original
	#check for matches
	if matches( arr , [0, 1, 2, 3 ] ).size() > 0:
		return true
	else:
		return false

func test_match ( arr, cell01, cell02 ):
	#check if values work in array
	if cell01.y >= arr[0].size() or cell01.y < 0:
		return false
	if cell01.x >= arr.size() or cell01.x < 0:
		return false
	if cell02.y >= arr[0].size() or cell02.y < 0:
		return false
	if cell02.x >= arr.size() or cell02.x < 0:
		return false
	
	#check if cells contain a tile
	if arr[cell01.x][cell01.y] ==null: #redundant as logic check prevents this
		return false
	if arr[cell02.x][cell02.y] ==null: #redundant as logic check prevents this
		return false
	
	var cell01_original = arr[cell01.x][cell01.y]
	var cell02_original = arr[cell02.x][cell02.y]

	#swap_cells
	arr[cell01.x][cell01.y] = cell02_original
	arr[cell02.x][cell02.y] = cell01_original
	#check for matches
	if matches( arr , [0, 1, 2, 3 ] ).size() > 0:
		#prepare values to swap
		arr[cell01.x][cell01.y].get_ref().position_end_map = arr[cell02.x][cell02.y].get_ref().position_begin_map
		arr[cell02.x][cell02.y].get_ref().position_end_map = arr[cell01.x][cell01.y].get_ref().position_begin_map
		move_tiles()
		#set begin to end pos
		arr[cell01.x][cell01.y].get_ref().position_begin_map = arr[cell01.x][cell01.y].get_ref().position_end_map
		arr[cell02.x][cell02.y].get_ref().position_begin_map = arr[cell02.x][cell02.y].get_ref().position_end_map
		return true
	else:
		#swap back
		arr[cell01.x][cell01.y] = cell01_original
		arr[cell02.x][cell02.y] = cell02_original
		return false

#func matches( arr, items ):
#	var match_list = []
#	var matches = 0
#	for item in items:
#		##Check horizontal
#		for row in range(arr.size()):
#			matches = 0
#			for column in range(arr[0].size()):
#				#if arr[row][column] == item:
#				if arr[row][column] != null:
#					if arr[row][column].get_ref().type == item:
#						matches = matches + 1
#					else:
#						matches = 0
#					if matches == 3:
#						match_list.append(Vector2(row,column-2))
#						match_list.append(Vector2(row,column-1))
#						match_list.append(Vector2(row,column))
#					if matches > 3:
#						match_list.append(Vector2(row,column))
#				else:
#					matches = 0
#
#		##Check vertical
#		matches = 0
#		for column in range(arr[0].size()):
#			matches = 0
#			for row in range(arr.size()):
#				if arr[row][column] != null:
#					if arr[row][column].get_ref().type == item:
#						matches = matches + 1
#					else:
#						matches = 0
#					if matches == 3:
#						match_list.append(Vector2(row-2,column))
#						match_list.append(Vector2(row-1,column))
#						match_list.append(Vector2(row,column))
#					if matches > 3:
#						match_list.append(Vector2(row,column))
#				else:
#					matches = 0
#	return match_list

func remove_duplicates_from_list( list ):
	var new_list = []
	for list_item in list.size():
		var in_list = true
		for new_list_item in new_list.size():
			if list[list_item] == new_list[new_list_item]:
				in_list = false
		if in_list == true:
			new_list.append(list[list_item])
	return new_list

func move_tiles():
	var time = 0
	
	for column in range(board[0].size()):
		for row in range(board.size()):
			if board[row][column] != null:
				tween.interpolate_property(board[row][column].get_ref(), 'position',
					Vector2(board[row][column].get_ref().position_begin_map.y * tile_size.x, board[row][column].get_ref().position_begin_map.x * tile_size.y), Vector2(board[row][column].get_ref().position_end_map.y * tile_size.x, board[row][column].get_ref().position_end_map.x * tile_size.y), time_swap,
        Tween.TRANS_SINE, Tween.EASE_IN_OUT, time)
				#board[row][column].get_ref().position_end_map =board[row][column].get_ref().position_begin_map
		#time=time+0.25
				board[row][column].get_ref().position_begin_map = board[row][column].get_ref().position_end_map
	tween.start()

func single_match ( arr, cell ):
	pass