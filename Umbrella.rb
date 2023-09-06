require "http"
require "json"

puts "Will you need an Umbrella today?"

puts "Where are you?"

location = gets.chomp
puts "#{location}"
#parsing gmaps
gmaps_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_key}"
raw_gmaps = HTTP.get(gmaps_url)
parsed_gmaps = JSON.parse(raw_gmaps)
gmaps_array = parsed_gmaps.fetch("results");
first_hash_results = gmaps_array.at(0)
geo_hash = first_hash_results.fetch("geometry")
location_hash = geo_hash.fetch("location")
long = location_hash.fetch("lng")
lat = location_hash.fetch("lat");
#parsing pirate
pirate_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_url = "https://api.pirateweather.net/forecast/#{pirate_key}/#{long},#{lat}"
raw_pirate_data = HTTP.get(pirate_url)
parsed_pirate_data = JSON.parse(raw_pirate_data)
current_pirate = parsed_pirate_data.fetch("currently")
current_temp = current_pirate.fetch("temperature")
puts "The Current Tempature in #{location} is #{current_temp}"
