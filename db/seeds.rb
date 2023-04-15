puts "Seeding database"
puts "Create Artists"

OrderDetail.destroy_all
Song.destroy_all
Artist.destroy_all
Album.destroy_all
Order.destroy_all
Customer.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('albums')
ActiveRecord::Base.connection.reset_pk_sequence!('artists')
ActiveRecord::Base.connection.reset_pk_sequence!('songs')
ActiveRecord::Base.connection.reset_pk_sequence!('customers')
ActiveRecord::Base.connection.reset_pk_sequence!('orders')
ActiveRecord::Base.connection.reset_pk_sequence!('order_details')
10.times do |number|
  artist = Artist.create(
    name: Faker::Music.band,
    nationality: Faker::Nation.nationality,
    birth_date: "#{rand(1..30)}-#{rand(1..12)}-199#{number}",
    biography: "Biography text #{number +1}"
  )
  print "."

end
puts "\nCreate Albums"
  
Artist.all.each do |artist| 
  rand(2..6).times do
  album = Album.create(
  artist: artist,
  name: Faker::Music.album,
  price: "#{rand(20...50)}99")
  end
  print "."
end

puts "\nCreate Songs"

Album.all.each do |album|
  album_duration = 0
  rand(4..10).times do
    song = Song.create(
      name: Faker::Music::RockBand.song,
      duration: rand(60..240),
      album: album,
    )
  album_duration += song.duration
  print "."
  end
  print "*"
  album.update(duration: album_duration)
end

puts "\nCreate Customers"

15.times do
  customer = Customer.new(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "#{Faker::Internet.password(min_length: 7, max_length: 15, mix_case: true)}#{rand(1..9)}",
    name: Faker::Name.unique.name,
    active: true
  )
  if customer.save
    print "."
  else
    puts customer.errors.full_messages
  end
end

puts "\nCreate Orders"

Customer.all.each do |customer|

  rand(1..5).times do
    order = Order.create(
      customer: customer,
      total: rand(10..90),
      date: Time.zone.today-1
    )
    if order.save
      print "."
    else
      puts order.errors.full_messages
    end
  end
end

puts "\nCreate Order_details"

Order.all.each do |order|
  total = 0
  rand(1..4).times do
    order_detail = OrderDetail.create(
    quantity: rand(1..3),
    order: order,
    album: Album.all.sample
    )
    p order_detail.quantity*order_detail.album.price
    total += order_detail.quantity*order_detail.album.price
    if order_detail.save
      print "."
    else
      puts order_detail.errors.full_messages
    end
  end
  p total
  order.update(total: total)
  print "*"
  
end


