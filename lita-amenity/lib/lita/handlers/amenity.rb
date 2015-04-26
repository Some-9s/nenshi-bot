module Lita
  module Handlers
    class Amenity < Handler
        route(/.*batter.*/) do |response|
          response.reply_with_mention("Please find Hazardous waste here ")
        end
        route(/.*golf.*/) do |response|
          response.reply_with_mention("Please golf at Confederation")
        end
        route(/.*echo(.*)/) do |response|
          response.reply_with_mention(response.matches[0][0].to_s)
        end
     end
    Lita.register_handler(Amenity)
  end
end
