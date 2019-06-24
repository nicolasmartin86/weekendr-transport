# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


puts 'Cleaning database...'
Destination.destroy_all


puts 'Creating awesome destinations...'

Destination.create!( {
    destination_name: "Madrid Espagne",
    transport_price: 10.0,
    photo_link: "https://images.kiwi.com/photos/600x600/madrid_es.jpg"
})


Destination.create!( {
    destination_name: "Barcelona Espagne",
    transport_price: 8.50,
    photo_link: "https://images.kiwi.com/photos/600x600/barcelona_es.jpg"
})


number = Destination.all.size

puts "--------------------------------"
puts "--------------------------------"
puts "#{number} destinations created!"
puts "--------------------------------"
puts "--------------------------------"
puts "Creation Finished!"
puts "--------------------------------"
