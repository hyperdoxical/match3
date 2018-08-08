extends Node

onready var board = $"../.."

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
	var matches = false
	#print("Matches from match.gd/test_match(): " + str(matches( arr , [0, 1, 2, 3 ] )))
	for cell in matches( arr , [0, 1, 2, 3 ] ):
		if cell == cell01 or cell == cell02:
			matches == true
	
	if matches == true:
		#prepare values to swap
		arr[cell01.x][cell01.y].get_ref().position_end_map = arr[cell02.x][cell02.y].get_ref().position_begin_map
		arr[cell02.x][cell02.y].get_ref().position_end_map = arr[cell01.x][cell01.y].get_ref().position_begin_map
		board.move_tiles()
		#set begin to end pos
		arr[cell01.x][cell01.y].get_ref().position_begin_map = arr[cell01.x][cell01.y].get_ref().position_end_map
		arr[cell02.x][cell02.y].get_ref().position_begin_map = arr[cell02.x][cell02.y].get_ref().position_end_map
		return true
	else:
		#swap back
		arr[cell01.x][cell01.y] = cell01_original
		arr[cell02.x][cell02.y] = cell02_original
		return false

func test_matchWITHOUTCHECKINGIFCELL01or02AREINVOLVED ( arr, cell01, cell02 ):
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
	#need to changeabove to make sure the either cell01 or cell02 are in the matches

		#prepare values to swap
		arr[cell01.x][cell01.y].get_ref().position_end_map = arr[cell02.x][cell02.y].get_ref().position_begin_map
		arr[cell02.x][cell02.y].get_ref().position_end_map = arr[cell01.x][cell01.y].get_ref().position_begin_map
		board.move_tiles()
		#set begin to end pos
		arr[cell01.x][cell01.y].get_ref().position_begin_map = arr[cell01.x][cell01.y].get_ref().position_end_map
		arr[cell02.x][cell02.y].get_ref().position_begin_map = arr[cell02.x][cell02.y].get_ref().position_end_map
		return true
	else:
		#swap back
		arr[cell01.x][cell01.y] = cell01_original
		arr[cell02.x][cell02.y] = cell02_original
		return false

func matches( arr, items ):
	var match_list = []
	var matches = 0
	for item in items:
		##Check horizontal
		for row in range(arr.size()):
			matches = 0
			for column in range(arr[0].size()):
				#if arr[row][column] == item:
				if arr[row][column] != null:
					if arr[row][column].get_ref().type == item:
						matches = matches + 1
					else:
						matches = 0
					if matches == 3:
						match_list.append(Vector2(row,column-2))
						match_list.append(Vector2(row,column-1))
						match_list.append(Vector2(row,column))
					if matches > 3:
						match_list.append(Vector2(row,column))
				else:
					matches = 0
					
		##Check vertical
		matches = 0
		for column in range(arr[0].size()):
			matches = 0
			for row in range(arr.size()):
				if arr[row][column] != null:
					if arr[row][column].get_ref().type == item:
						matches = matches + 1
					else:
						matches = 0
					if matches == 3:
						match_list.append(Vector2(row-2,column))
						match_list.append(Vector2(row-1,column))
						match_list.append(Vector2(row,column))
					if matches > 3:
						match_list.append(Vector2(row,column))
				else:
					matches = 0
	return match_list

func integer_matches( arr, items ):
	var match_list = []
	var matches = 0
	for item in items:
		##Check horizontal
		for row in range(arr.size()):
			matches = 0
			for column in range(arr[0].size()):
				#if arr[row][column] == item:
				if arr[row][column] != null:
					if arr[row][column] == item:
						matches = matches + 1
					else:
						matches = 0
					if matches == 3:
						match_list.append(Vector2(row,column-2))
						match_list.append(Vector2(row,column-1))
						match_list.append(Vector2(row,column))
					if matches > 3:
						match_list.append(Vector2(row,column))
				else:
					matches = 0
					
		##Check vertical
		matches = 0
		for column in range(arr[0].size()):
			matches = 0
			for row in range(arr.size()):
				if arr[row][column] != null:
					if arr[row][column] == item:
						matches = matches + 1
					else:
						matches = 0
					if matches == 3:
						match_list.append(Vector2(row-2,column))
						match_list.append(Vector2(row-1,column))
						match_list.append(Vector2(row,column))
					if matches > 3:
						match_list.append(Vector2(row,column))
				else:
					matches = 0
	return match_list

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

func get_duplicates_from_list( list ):
	var new_list = []
	for list_item in list.size():
		var in_list = false
		var number_of_repeats = 0
		for second_pass_list_item in list.size():
			if list[list_item] == list[second_pass_list_item]:
				number_of_repeats = number_of_repeats + 1
		if number_of_repeats > 1:
			new_list.append(list[list_item])
	return remove_duplicates_from_list( new_list )
	#return new_list
	
func is_tile ( arr, cell ):
	#check cell is potentially within array
	var valid = false
	if cell.x >= 0 and cell.x < arr.size():
		if cell.y >= 0 and cell.y < arr[0].size():
			if arr[cell.x][cell.y] != null:
				valid = true
	return valid

func matches_from_swap( arr, cell01, cell02, complete_the_swap):
	#returns an array of matches resulting from a swap
	#takes into account "match with any colour" universal tiles array
	#if complete_the_swap is true then swap update tile.tscn positions
	var match_list
	var matches = false
	if is_tile ( arr, cell01 ) and is_tile ( arr, cell02 ):
		var cell01_original = arr[cell01.x][cell01.y]
		var cell02_original = arr[cell02.x][cell02.y]
		#swap_cells
		arr[cell01.x][cell01.y] = cell02_original
		arr[cell02.x][cell02.y] = cell01_original
		#check for matches
		match_list = matches( arr, [0,1,2,3])
		matches = false
		#do any of the matches correspond to the moved tiles?
		for cell in match_list:
			if (str(cell) == str(cell01)) or (str(cell) == str(cell02)):
				matches = true
		#if match_list.size() > 0:
		if matches == true:
			#prepare values to swap
			if complete_the_swap:
				arr[cell01.x][cell01.y].get_ref().position_end_map = arr[cell02.x][cell02.y].get_ref().position_begin_map
				arr[cell02.x][cell02.y].get_ref().position_end_map = arr[cell01.x][cell01.y].get_ref().position_begin_map
		if complete_the_swap == false or matches == false:
			#swap tiles back
			arr[cell01.x][cell01.y] = cell01_original
			arr[cell02.x][cell02.y] = cell02_original
	return matches

func matches_from_swapOLD( arr, cell01, cell02, complete_the_swap):
	#returns an array of matches resulting from a swap
	#takes into account "match with any colour" universal tiles array
	#if complete_the_swap is true then swap update tile.tscn positions
	var match_list
	if is_tile ( arr, cell01 ) and is_tile ( arr, cell02 ):
		var cell01_original = arr[cell01.x][cell01.y]
		var cell02_original = arr[cell02.x][cell02.y]
		#swap_cells
		arr[cell01.x][cell01.y] = cell02_original
		arr[cell02.x][cell02.y] = cell01_original
		#check for matches
		match_list = matches( arr, [0,1,2,3])
#		var matches = false
#		print("Matches from match.gd/matces_from_swap(): " + str(matches( arr , [0, 1, 2, 3 ] )))
#		for cell in match_list:
#			if cell == cell01 or cell == cell02:
#				matches == true
#		print(matches)
		if match_list.size() > 0:
		#if matches == true:
			#prepare values to swap
			if complete_the_swap:
				arr[cell01.x][cell01.y].get_ref().position_end_map = arr[cell02.x][cell02.y].get_ref().position_begin_map
				arr[cell02.x][cell02.y].get_ref().position_end_map = arr[cell01.x][cell01.y].get_ref().position_begin_map
		if complete_the_swap == false or match_list.size() == 0:
			#swap tiles back
			arr[cell01.x][cell01.y] = cell01_original
			arr[cell02.x][cell02.y] = cell02_original
	return match_list

func check_for_potential_moves( arr ):
	var list = []
	for row in range(arr.size()):
		for column in range(arr[0].size()):
			#check N
			if matches_from_swap( arr, Vector2(row, column), Vector2(row-1, column), false):
				list.append(Vector2( row, column ))
			#check E
			if matches_from_swap( arr, Vector2(row, column), Vector2(row, column+1), false):
				list.append(Vector2( row, column ))
			#check S
			if matches_from_swap( arr, Vector2(row, column), Vector2(row+1, column), false):
				list.append(Vector2( row, column ))
			#check W
			if matches_from_swap( arr, Vector2(row, column), Vector2(row, column-1), false):
				list.append(Vector2( row, column ))
	return remove_duplicates_from_list( list )

func detailed_matches ( arr, items ):
	var match_list = []
	var temp_list = []
	var results = []
	var match_dict = {}
	var matches = 0
	var runs = 0
	for item in items:
#		print ( items.size() )
#		print("ITEM " + str(items) )
		##Check horizontal
		for row in range(arr.size()):
			matches = 0
			match_list = []
			for column in range(arr[0].size()):
				if arr[row][column] != null:
					if arr[row][column].get_ref().type == item:
						matches = matches + 1
					else:
						if matches > 2:
							results.append(match_list)
							match_list = []
						matches = 0
					if matches == 3:
#						for i in range( 3 ):
#							match_list.append(Vector2(row,column-(2-i) ))
						match_list.append(Vector2(row,column-2))
						match_list.append(Vector2(row,column-1))
						match_list.append(Vector2(row,column))
					if matches > 3:
						match_list.append(Vector2(row,column))
					if matches > 2:
						#print("from match.gd - detailed matches of type " + str(item) + ": " + str(matches))
						pass
				else: #needed if hitting an empty space
					matches = 0
			if matches > 2: #when finishing the row 
				results.append(match_list)			
		##Check vertical
		matches = 0
		for column in range(arr[0].size()):
			matches = 0
			match_list = []
			for row in range(arr.size()):
				if arr[row][column] != null:
					if arr[row][column].get_ref().type == item:
						matches = matches + 1
					else:
						if matches > 2:
							results.append(match_list)
							match_list = []
						matches = 0
					if matches == 3:
#						for i in range( 3 ):
#							print(2-i)
#							match_list.append(Vector2(row,column-(2-i) ))
						match_list.append(Vector2(row-2,column))
						match_list.append(Vector2(row-1,column))
						match_list.append(Vector2(row,column))
					if matches > 3:
						match_list.append(Vector2(row,column))
					if matches > 2:
						#print("from match.gd - detailed matches of type " + str(item) + ": " + str(matches))
						pass
				else: #needed if hitting an empty space
					matches = 0
			if matches > 2: #when finishing the column
				results.append(match_list)
				match_list = []

#	somehow we need to account for the cross type
#	maybe checking adjacent vector2 results for each type
#	if when doing by type we get duplicates we check horiz
#	and vert from the dupe and we use that number
#	results = []
#	results.append([Vector2(1,0),Vector2(1,0)])
#	results.append([Vector2(9,0)])
	#results = [ [Vector2(1,0),Vector2(1,0)], [Vector2(1,0)] ]
	#print ("results: " + str(results))
	
	return results

#func process_detailed_matches ( arr ):
#	print( "process " + str(detailed_matches ( arr, [0] ) ) )
#	pass

func process_detailed_matches ( arr, tiles_to_check ):
	#get tile 1 details
	var final_results = {}
	
	#var tiles_to_check = [0,1,2,3]
#	for tile in tiles_to_check:
#		print(tile)
	for tile in tiles_to_check:
		#print( "tiles to check: " + str(tile) + str(detailed_matches ( arr, 8 ).size()) )
		var results = {}
		if detailed_matches ( arr, [tile] ).size() > 0:
			#print("Checking against tile ref " + str(tile) )
			var matching_tile_list = detailed_matches ( arr, [tile] ) #array of every horiz and vert run > 2
			#print( matching_tile_list )
			#matching_tile_list = [ [1,2,3],[4,2,5],[6,2,7], [11, 12 ], [22,23],[22,24]]
			#matching_tile_list = [ [1,2,3] ]
			var orig_list = [] + matching_tile_list
			var cell_list = [] #a list (single array) to hold all the individual cells (not but match groups)
			var duplicate_list = []
			var aggregated_list = []
			
			#print ("matching_tile_list: " + str( matching_tile_list ) )
			#get all items to a list
			for matching_items in matching_tile_list:
				for item in matching_items:
					cell_list.append(item)
			#print(cell_list)
			#duplicate_list = get_duplicates_from_list(cell_list)
			#print(duplicate_list)
			#for cell in duplicate_list:
			for cell in get_duplicates_from_list(cell_list):
				var temp_array_for_matches_containing_dupes = []
#				print("-=matching=-")
#				print("Cells containing " + str( cell ) )
				#create a new list of cells from matches that have
				#this cell in it and delete those array values
				var matching_tile_list_counter = 0
				#var counter = 0
				for matching_items in matching_tile_list:
					var contains_duplicate = false
					for item in matching_items:
						if item == cell:
							contains_duplicate = true
#							print("matched " + str(matching_items) )
							aggregated_list.append(matching_items)
							temp_array_for_matches_containing_dupes.append(matching_items)
							matching_tile_list[matching_tile_list_counter] = []
							#matching_tile_list_counter = matching_tile_list_counter - 1
						
					matching_tile_list_counter = matching_tile_list_counter + 1
				results[cell] = temp_array_for_matches_containing_dupes
			
	
			
			#print ( matching_tile_list )
			#print ( aggregated_list )
			#print ( results )
		#	for key in results.keys():
		#		print(key)
			var new_arr = []
			for value in results: 	#get the keys for matches which overlap/have dupes
				#print(value)
				#print(results[value])
				var temp_list = [] #get all the values for each match with dupe
				for item in results[value]:
				#	print(item)
					for cell in item:
						#print(cell)
						temp_list.append(cell) #push them all into a single list
				new_arr.append( remove_duplicates_from_list( temp_list ) ) #remove the dupes
				#print ( str(tile) + "  " + str( new_arr ) )
				#finally need to add the non-dup matches!
				
			for item in matching_tile_list:
				if item != []:
					new_arr.append( item )
			#print (new_arr)
			new_arr = remove_duplicates_from_list( new_arr )
			final_results[tile] = new_arr 
			#print(matching_tile_list)
#			print(tile)
			#print ("new:"  + str(new_arr))
#			print ("orig: " + str(orig_list))
#	print( final_results )
#	print("Blue:")
#	for value in final_results[0]:
#		print(value)
#	print("Red:")
#	for value in final_results[1]:
#		print(value)

	#print(results)
#	print("dict_to_list()")
#	dict_to_list( final_results )
	return final_results
	
func dict_to_list ( dict ):
#	for key in dict:
#		print("key: " + str(key))
#		for arr in key:
#			print("arr:: " + str(arr))
#			for item in arr:
#				print("item: " + str(item))
	var list = []
	for key in dict:
		#print("key: " + str(key))
		for arr in dict[key]:
			#print("arr:: " + str(arr))
			for item in arr:
				#print("item: " + str(item))
				list.append(item)
#	print( list )
	return list


func process_matches( list, items ):
	#checks for contiguous matches which would
	#ordinarily show up as separate matches.
	#ie: cross formations
	#will only process a single type
	var number_of_duplicates = get_duplicates_from_list( list )
	#so we need to process all the tiles from a SINGLE type
	#these should be exported as an array
	#eg [ 
	#		[ Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(0, 2), Vector2(1, 2), Vector2(2, 2), Vector2(3, 2) ]
	#		[ Vector2(1, 0), Vector2(1, 1), Vector2(1, 2),
	#	]
	#next, create a 1D array of all the values
	#then extract any duplicates.
	#combine elements which share a duplicate.

func display_results ( dict ):
	for key in dict:
		match key:
			0: print("Blue:")
			1: print("Red:")
			2: print("Green:")
			3: print("Yellow:")
		for value in dict[key]:
			print("Number of matches: " + str(value.size()) + " (Score: " + str(calc_match_score(value.size())) + ")") 

func calc_match_score( value ):
	var score
	var modifier =  floor( (pow( ( value - 3 ), 2))/2 )
	return value + modifier