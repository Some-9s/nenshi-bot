module Lita
  module Handlers
    class FireStations < Handler

      route(/on fire/, :emergency)

      route(/fire station[s]? around\s+(.+)/, :lookup)

      route(/fire station[s]? near me$/, :geolookup)

      route(/(all fire stations)|(^(?=.*\bstations\b)(?=.*\bmap\b).*$)/,:map)

      def emergency(response)
        response.reply "Something's on FIRE?!?!\n I can't beleive I have to say this but, call 911!"
      end

      def lookup(response)
        address = response.matches[0].to_s[2...-2]
        quad = address.split(//).last(2).join.upcase
        response.reply "Looking for nearest fire stations near #{address}.."
        case quad
        when "SE"
          response.reply "Fire stations in SE: "
        when "SW"
          response.reply "Fire stations in SW: "
        when "NE"
          response.reply "Fire stations in NE: "
        when "NW"
          response.reply "Fire stations in SE: "
        else
          response.reply "Address doesn't have a valid quadrant (NE,NW,SE,SW)!"
        end
      end

      def map(response)
          response.reply "Calgary fire station locations: https://www.google.com/maps/d/view?mid=zg5QuGLLX0bo.kVz7Y6bmQ4rI"
      end

      def geolookup(response)
          response.reply "I don't know where you are!"
      end

    end

    Lita.register_handler(FireStations)
  end
end
