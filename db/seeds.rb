# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'
require 'net/http'

#data = '{"name":"resturangkartan","frequency":"Manual Crawl","version":2,"thisversionrun":"Tue Feb 10 2015 15:41:15 GMT+0000 (UTC)","newdata":true,"lastrunstatus":"partial","lastsuccess":"Tue Feb 10 2015 15:47:28 GMT+0000 (UTC)","nextrun":"","results":{"collection1":[{"Name":{"href":"http://www.restaurangkartan.se/0471203/Pizzeria_Saloniki","text":"Pizzeria Saloniki"},"Address":"Gamla Strandavägen 2, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/471203_71132113.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0178160/Sparta_Pizzabutik","text":"Sparta Pizzabutik"},"Address":"Lille Bullens Väg 1, Norrlidens centrum","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/011036/Kebabben","text":"Kebabben"},"Address":"Larmgatan 11, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/11036_321632157879979.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/013562/Tallhagens_Pizzeria_KB","text":"Tallhagens Pizzeria KB"},"Address":"Tallhagsvägen, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/012076/Pizzeria_Restaurang_Capri","text":"Pizzeria Restaurang Capri"},"Address":"Smedbyvägen, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0159/Kama_Sushi","text":"Kama Sushi"},"Address":"Västra Sjögatan 13, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/159_89971379.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0473704/Tandoori_House","text":"Tandoori House"},"Address":"Storgatan 24, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/473704_139308846254022.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/08746/Stekhuset_Kom_Snart_Igen","text":"Stekhuset Kom Snart Igen"},"Address":"Skeppsbron 1, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/8746_66609437.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/013054/Rosenlundska_Källaren","text":"Rosenlundska Källaren"},"Address":"Östra Sjögatan 3, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/13054_149193858624623.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/010651/Hanssons_Krog_i_Kalmar","text":"Hanssons Krog i Kalmar"},"Address":"Norra Långgatan 1, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/10651_544230279002690.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0481134/Tomas_och_Charlottas_Matrum","text":"Tomas och Charlottas Matrum"},"Address":"Kalmar slott, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/481134_77686223.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0472237/OReillys_Irish_Pub_Kalmar","text":"OReillys Irish Pub Kalmar"},"Address":"Larmgatan 6, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/472237_119729674849535.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0470003/Koppalas_Restaurang","text":"Koppalas Restaurang"},"Address":"Trångsundsvägen 20, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/470003_353004698077795.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0400340/Bremersons","text":"Bremersons"},"Address":"Esplanaden 30, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/400340_372195202845160.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0400252/Arontorpsfilialen","text":"Arontorpsfilialen"},"Address":"Verkstadsgatan 6, Giraffen Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/400252_30479802.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0179945/Restaurang_Zegel","text":"Restaurang Zegel"},"Address":"Landgången 4, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/179945_10150266562369954.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0400325/Hamnkrogen","text":"Hamnkrogen"},"Address":"Skeppsbrogatan 30, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0470300/Restaurang_Harrys_Kalmar","text":"Restaurang Harrys Kalmar"},"Address":"Norra Långgatan 7, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/05707/Restaurang_Källaren_Kronan","text":"Restaurang Källaren Kronan"},"Address":"Ölandsgatan 7, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0476055/Restaurang_Manana_Manana","text":"Restaurang Manana Manana"},"Address":"Larm Gatan, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/06479/Restaurang_Athena","text":"Restaurang Athena"},"Address":{"href":"","text":"Norra Långgatan 8, Kalmar"},"Image":{"src":"http://www.allakartor.se/venue_images_50/6479_33978412.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/08205/Restaurang_Larmgatan_10","text":"Restaurang Larmgatan 10"},"Address":{"href":"","text":"Södra Långgatan 6, Kalmar"},"Image":{"src":"http://www.allakartor.se/venue_images_50/8205_11277163.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/014137/Venezia_Pizzeria","text":"Venezia Pizzeria"},"Address":{"href":"","text":"Esplanaden 26, Kalmar"},"Image":{"src":"http://www.allakartor.se/venue_images_50/14137_794727837257117.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/018527/Calmar_Hamnkrog","text":"Calmar Hamnkrog"},"Address":[{"href":"http://www.restaurangkartan.se/018527/boka_bord/","text":"Boka bord online"},{"href":"","text":"Skeppsbrogatan, Kalmar"}],"Image":{"src":"http://www.allakartor.se/venue_images_50/18527_452249088155412.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/01198/Cafe_Lotsutkiken","text":"Café Lotsutkiken"},"Address":{"href":"","text":"Tjärhovsgatan 8, Kalmar"},"Image":{"src":"http://www.allakartor.se/venue_images_50/1198_76794055.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0252396/Sushi_City","text":"Sushi City"},"Address":{"href":"","text":"Storgatan 22, Kalmar"},"Image":{"src":"http://www.allakartor.se/venue_images_50/252396_48874691.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0179214/Subway","text":"Subway"},"Address":{"href":"","text":"Storgatan 11, Kalmar"},"Image":{"src":"http://www.allakartor.se/venue_images_50/179214_165055156853094.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/014259/Pizzabutiken_Ängö","text":"Pizzabutiken Ängö"},"Address":{"href":"","text":"Bjelkegatan 11, Kalmar"},"Image":{"src":"http://www.allakartor.se/venue_images_50/14259_82601634.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/019100/McDonald´s","text":"McDonald´s"},"Address":"Skeppsbrogatan 12, Baronens köpcenter, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0355787/Gröna_Stugan_i_Kalmar","text":"Gröna Stugan i Kalmar"},"Address":"Larmgatan 1, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/355787_442777242438327.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/049835/Kallskänken","text":"Kallskänken"},"Address":"Esplanaden 33, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/49835_100176350062496.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/012018/Pizzeria_och_Grill_Berga_Centrum","text":"Pizzeria och Grill Berga Centrum"},"Address":"Rimsmedsvägen 25, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/08843/Table_20","text":"Table 20"},"Address":"Unionsgatan 20, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/06320/Thai_Taste_Esplanaden","text":"Thai Taste Esplanaden"},"Address":"Esplanaden 6, Kalmar","Image":{"src":"http://www.allakartor.se/graphics/no_image_50.gif","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/06990/Gerds_Mat","text":"Gerds Mat"},"Address":"Polhemsgatan 15, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/6990_381268738667590.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0471319/Restaurang_Italia","text":"Restaurang Italia"},"Address":"Storgatan 20, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/471319_436036619790507.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/0469422/Stars_and_Stripes_Grill_and_Sportsbar","text":"Stars and Stripes Grill and Sportsbar"},"Address":"Skeppsbrogatan 12, Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/469422_324594364288410.jpg","alt":"","text":""}},{"Name":{"href":"http://www.restaurangkartan.se/011161/Restaurang_Krysset","text":"Restaurang Krysset"},"Address":"Husmorsvägen 1 , Kalmar","Image":{"src":"http://www.allakartor.se/venue_images_50/11161_200467443361883.jpg","alt":"","text":""}}]},"count":38}'
#data = JSON.parse data

Encoding.default_external = Encoding::UTF_8

# data['results']['collection1'].each do |result|
#   result['Address'] = result['Address']['text'] if result['Address'].is_a? Hash
#   result['Address'] = result['Address'].last['text'] if result['Address'].is_a? Array
#   restaurant = Place.new(
#       name: result['Name']['text'],
#       street: result['Address'].split(', ')[0..-2].join(', '),
#       city: result['Address'].split(', ').last
#   )
#   # restaurant.type = Place.types['Restaurant']
#   restaurant.save!
#
#   # path1 = result['Name']['href'].split('/')[-2]
#   # path2 = result['Name']['href'].split('/').last
#   #             .tr('ä', '%C3%A4')
#   #             .tr('Ä', '%C3%84')
#   #             .tr('ö', '%C3%B6')
#   #             .tr('´', '%C2%B4')
#   #
#   # if File.readlines('myfile.out').grep(/\/#{path1}\//).any?
#   #   puts "skip #{path1}/#{path2}"
#   # else
#   #   puts "down #{path1}/#{path2}"
#   #   url = "https://www.kimonolabs.com/api/2mfjm12m?apikey=AgQpKw4Kqkl0hCH4pKKPROG9nZhfsBvC&kimpath1=#{path1}&kimpath2=#{path2}"
#   #
#   #   #puts url
#   #
#   #   result = Net::HTTP.get(URI.parse(url))
#   #   open('myfile.out', 'a') do |f|
#   #     f << result.force_encoding('UTF-8')
#   #   end
#   #
#   #   sleep 0.5
#   # end
#   #data = JSON.parse result
#
#   #puts result
#
#   sleep 0.25
# end

pizza = Cuisine.create!(
  name: 'Pizza'
)

data = File.readlines('myfile.out').join
data = JSON.parse data

data.each do |d|
  place = d['results']['collection1'][0]
  restaurant = Place.where(name: place['Name']).first
  next if restaurant.present?

  if place['Image']['src'] == 'http://www.allakartor.se/graphics/no_image_100.gif'
    image = nil
  else
    image = place['Image']['src'].tr('venue_images_100', 'venue_images_475')
  end

  restaurant = Place.create!(
      name: place['Name'],
      street: place['Street'],
      zip: place['Zip'],
      city: place['City'],
      telephone: place['Tel'],
      description: place['Description'],
      image_url: image,
  )

  restaurant.cuisines << pizza if restaurant.description.downcase.include? 'pizz'

  d['results']['collection3'].each do |review|
    next if review['ReviewName']['text'].empty?

    user = User.where(name: review['ReviewName']['text']).first
    if user.nil?
      user = User.create!(
        name: review['ReviewName']['text'],
        password: 'seed'
      )
    end
    Review.create!(
      place: restaurant,
      user: user,
      rating: review['ReviewRate'].split(' ').last.to_i,
      description: review['ReviewTest'],
      created_at: Time.parse(review['ReviewDate']),
    )
  end

  sleep 0.25
end
