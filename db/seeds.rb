cities = []
countries = []

File.readlines("#{ Rails.root }/db/IATA_airports.csv").each do |line|
  iata, type, name_ru, name, coordinates, timezone, parent_name = line.split(';').map(&:strip)
  latitude, longitude = coordinates.split(':') if coordinates

  case type
  when "city"
    cities << { iata: iata, name: name, parent_name: parent_name, timezone: timezone }
  when "country"
    countries << { iata: iata, name: name }
  end
end

Country.create countries

cities = cities.group_by { |c| c[:parent_name] }

cities.each do |name, ccities|
  country = Country.find_by_name name
  ccities.each do |city_attr|
    city_attr[:country_id] = country.id
    city_attr.delete :parent_name
    City.create city_attr
  end
end
