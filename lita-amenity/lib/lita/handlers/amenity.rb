module Lita
  module Handlers
    class Amenity < Handler
        $plug = 'Brought to by tiny.cc/afpgxx'
        # Routes:
        route(/run$|run /i,:athletic, help: {'Run' => "Let's go for a jog"})
        route(/poo |leak |crap |poo$|leak$|crap$/i,:poop)
        route(/golf |golf$/i,:golf, help: {'Golf' => 'What\'s the best golf course?'})
        route(/garbage |garbage$/i,:garbage, help: {'Garbage' => 'Help, I need a landfill'})

        def athletic(response)
          name = 'Glenmore Athletic Park'
          location = 'https://www.google.ca/maps/place/5300+19+St+SW'
          response.reply_with_mention('Out for a run? Congrats on the active lifestyle!! check out the nearby '+ name +' '+ location + ' ' + $plug)
        end

        def poop(response)
          name = 'Automated Public Toilet'
          location = 'https://www.google.ca/maps/place/7+ST+17+AV+SW'
          response.reply_with_mention('You are either calling me a #nenshinoun or have an emergency. May I reccomend the nearby '+ name +' '+ location + ' ' + $plug)
        end

        def golf(response)
          name = 'Confederation Park Golf Course'
          location = 'https://www.google.ca/maps/place/3204+COLLINGWOOD+DR+NW'
          response.reply_with_mention('Hey! you should check out the nearby '+ name +' '+ location + ' ' + $plug)
        end

        def garbage(response)
          name = 'East Calgary Landfill'
          location = 'https://www.google.ca/maps/place/68+ST+17+AV+SE'
          response.reply_with_mention('Spring Cleaning? Your best bet is to take your waste to the nearby '+ name +' '+ location + ' ' + $plug)
        end
    end
    Lita.register_handler(Amenity)
  end
end
