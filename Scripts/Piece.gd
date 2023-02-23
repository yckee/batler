extends Node2D

const MOVE_DIRACTIONS = {
	"up"    : Vector2( 0, -1),
	"down"  : Vector2( 0,  1),
	"left"  : Vector2(-1,  0),
	"right" : Vector2( 1,  0)  
}
var texture_size setget set_texture_size, get_texture_size

var placed_at


# Called when the node enters the scene tree for the first time.
func _ready():
#	self.texture_size = 80
	pass
	

func set_texture_size(_size):
	scale = Vector2(_size, _size) / $Sprite.texture.get_size()

func get_texture_size():
	print(round(scale.x *$Sprite.texture.get_width()))
	return round($Sprite.texture.get_width() * scale.x)

func move_piece(dir, num_tiles):
	var dest = MOVE_DIRACTIONS[dir] * Vector2(self.texture_size, self.texture_size) * num_tiles + position
	var tween := create_tween()
	tween.tween_property(
		self, "position", dest, 0.7
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	

	
