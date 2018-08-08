extends Node2D

var position_begin_map = Vector2()
var type = int()
var position_end_map = Vector2()
onready var sprite = $"sprite"

func _ready():
	var big_dict = {}

#	randomize()
#	for i in range (4):
#		var match_dict = {}
#		for j in floor(rand_range(0, 6)):
#			match_dict[j] = floor(rand_range(0, 4))
#		big_dict[i] = match_dict
#		print(str(i) + " " + str(match_dict))
#	print(big_dict)
#
#	print("**")
#	print(big_dict[3])
#	for i in range (4):
#		var match_arr = []
#		for j in floor(rand_range(0, 6)):
#			match_arr.append(floor(rand_range(0, 4)))
#		big_dict[i] = match_arr
#		print(str(i) + " " + str(match_arr))
#	print(big_dict)
#
#	print("**")
#	print(big_dict[3])