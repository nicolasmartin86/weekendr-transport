# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'open-uri'
require "net/http"
require 'json'
require 'nokogiri'


# "http://flags.fmcdn.net/data/flags/w1160/af.png"

puts "Fetching all transport One-way ticket prices from Numbeo..."
puts "---------------------------------"
puts "---------------------------------"

url = "https://www.numbeo.com/cost-of-living/prices_by_city.jsp?itemId=18&displayCurrency=EUR"
cities = []

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)


html_doc.search('#t2 tbody tr').each do |element|
  hash_city = {}
  hash_city[:city_full_name] = element.search('td')[1].text
  hash_city[:transport_price] = element.search('td')[2].text.to_f
  cities << hash_city
end

puts "Fetching over!"
puts "---------------------------------"
puts "---------------------------------"


url_country_codes = open("https://pkgstore.datahub.io/core/country-list/data_json/data/8c458f2d15d9f2119654b29ede6e45b8/data_json.json").read
country_json = JSON.parse(url_country_codes)


cities.each do |city|
  full_names = city[:city_full_name].split(',')
  city[:city] = full_names.first.strip
  clean_country_name = full_names.last.strip
  city[:country] = clean_country_name
  found_country = country_json.select { |element| element["Name"].upcase == clean_country_name.upcase }
  almost_found_country = country_json.select { |element| element["Name"].upcase.include?(clean_country_name.upcase) }
  if found_country == []
    unless almost_found_country == []
      city[:code_country] = almost_found_country[0]["Code"]
    end
  else
    city[:code_country] = found_country[0]["Code"]
  end
end

cities_clean = cities.select { |e| e[:code_country] != nil }



puts 'Cleaning database...'
Destination.destroy_all


puts 'Creating awesome destinations...'


cities_clean.each do |city|
  if city[:city].scan(" ")
    city_name_photo = city[:city].downcase.gsub(" ", "-")
  else
    city_name_photo = city[:city].downcase
  end

  url_photo = "https://images.kiwi.com/photos/600x600/#{city_name_photo}_#{city[:code_country].downcase}.jpg"
  uri_photo = URI(url_photo)

  if Net::HTTP.get_response(uri_photo).code == "200"
    Destination.create!( {
        destination_name: city[:city_full_name],
        transport_price: city[:transport_price],
        photo_link: url_photo
    })
    puts "#{city[:city_full_name]} created!"
  else
    puts "#{city[:city_full_name]} KO, picture not found!"
  end
end

number = Destination.all.size

puts "--------------------------------"
puts "--------------------------------"
puts "#{number} destinations created!"
puts "--------------------------------"
puts "--------------------------------"
puts "Creation Finished!"
puts "--------------------------------"



