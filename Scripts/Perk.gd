extends MarginContainer

var PerkDB = preload("res://Assets/Perks/PerkDB.gd")

var perk_type : set = set_perk, get = get_perk
var _clickable := true
signal perk_clicked

func _ready():
	set_blank()
	
func set_perk(_perk):
	perk_type = _perk
	$TextureRect.texture = PerkDB.PERK_SPRITES[_perk]
	if _perk == PerkDB.PERKS.blank:
		_clickable = false
	else:
		_clickable = true
	
func set_blank():
	self.perk_type = PerkDB.PERKS.blank

func get_perk():
	return perk_type


func _on_gui_input(event):
	if event.is_action_pressed("left_click") and _clickable:
		emit_signal("perk_clicked", self)
