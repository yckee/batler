extends Node2D
class_name Piece

const MOVE_DIRACTIONS = {
	"up"    : Vector2( 0, -1),
	"down"  : Vector2( 0,  1),
	"left"  : Vector2(-1,  0),
	"right" : Vector2( 1,  0)  
}

var texture_size : get = get_texture_size, set = set_texture_size

var placed_at


func _ready():
#	self.texture_size = 80
	pass
	

func set_texture_size(_size):
	scale = Vector2(_size, _size) / $Sprite2D.texture.get_size()

func get_texture_size():
	return round($Sprite2D.texture.get_width() * scale.x)

func move_piece(dir, num_tiles):
	var dest = MOVE_DIRACTIONS[dir] * Vector2(self.texture_size, self.texture_size) * num_tiles + position
	var tween := create_tween()
	tween.tween_property(
		self, "position", dest, 0.55
	).set_trans(Tween.TRANS_CUBIC)

	
	await tween.finished
	SignalBus.emit_signal("move_piece_finished")

	
