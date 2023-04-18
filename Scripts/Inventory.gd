extends Control



func add_perk(perk_type):
	var blank_perk = first_blank_perk()
	if blank_perk:
		blank_perk.perk_type = perk_type
	else:
		print("no free slots") 
	
func first_blank_perk():
	for row in $Grid.get_children():
		for perk in row.get_children():
			if perk.perk_type == PerkDB.PERKS.blank: return perk
	return null
