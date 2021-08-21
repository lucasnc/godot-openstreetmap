extends GridContainer

onready var map = get_node("Map")

var loc
var country_index

signal new_location(lat, lon)

func _ready():
	var f : File = File.new()
	f.open("res://openstreetmap_demos/pg.json", File.READ)
	loc = parse_json(f.get_as_text())
	f.close()
	$Country.add_item(loc[0].country)
	$City.clear()
	$City.add_item(loc[0].city)
	$Latitude.text = str(loc[0].lat)
	$Longitude.text = str(loc[0].lon)
	commit_location()
	
#	select_country(0)
#
#func select_country(i):
#	country_index = i
#	$City.clear()
#	for c in city[i].cities:
#		$City.add_item(c.city)
#	select_city(0)
#
#func select_city(i):
#	$Latitude.text = str(cities[country_index].cities[i].lat)
#	$Longitude.text = str(cities[country_index].cities[i].lon)
#	commit_location()

func commit_location(unused_param = null):
	emit_signal("new_location", float($Latitude.text), float($Longitude.text))
