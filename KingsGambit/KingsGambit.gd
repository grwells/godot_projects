extends Node
# you are a lone chess piece who must defend the King while eliminating the opposing players
class_name KingsGambit, "res://art/KingsGambit_tiles/temp_icon.png"

enum Type {PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING}
enum SIDE {ENEMY, FRIEND, PLAYER}


class Piece:
	#piece type
	var id
	#location of piece on board 
	var x 
	var y

	var data_files = ["res://DataFiles/pawn_data.json", "res://DataFiles/knight_data.json"]

	# id, x, y, 
	func _init(id, x = 0, y = 0):
		self.id = id
		x = 0
		y = 0

	# move piece to new index if possible according to it's movement profile
	func move():
		pass

	func load_data():
		var file = File.new()

		match id:
			Type.PAWN:
				file.open(data_files[Type.PAWN], file.READ)

			Type.KNIGHT:
				file.open(data_files[Type.KNIGHT], file.READ)

		var json = file.get_as_text()
		var json_result = JSON.parse(json).result
		file.close()

		var movement_direction = json_result["pawn"]["movement_direction"]
		print(movement_direction)

var board #board of all pieces in play at beginning of the game
var rng #RandomNumberGenerator

func _init():
	rng = RandomNumberGenerator.new()
	var num_opp = rng.randi_range(1, 16)
	#TODO: create opponents and place them at indices on board
	fill_board(num_opp)
	#TODO: set king's spawn point
	var randInd_X = rng.randi_range(0, 8)
	var randInd_Y = rng.randi_range(0, 8)

	#TODO: set player spawn point
	var new_pawn = Piece.new(Type.PAWN)

#place new pieces on the board and store them in the board array
func fill_board(num):
	pass
