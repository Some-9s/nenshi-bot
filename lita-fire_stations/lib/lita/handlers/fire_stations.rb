module Lita
  module Handlers
    class FireStations < Handler

      route(/on fire/, :emergency, help: {"on fire" => "You need advice on this?"})

      route(/fire station[s]? around\s+(.+)/, :lookup, help: {"fire station(s) around ADDRESS" => "Returns fire stations near given address."})

      route(/fire station[s]? near me/, :geolookup, help: {"fire station(s) near me" => "Returns fire stations around your location."})

      route(/(all fire stations)|(^(?=.*\bstations\b)(?=.*\bmap\b).*$)/,:map, help: {"Map all stations" => "Returns link to map of all fire stations."})

      route(/services.*station\s([0-9]{1,2})/, :services, help: {"What services are offered at station \#\#?" => "Returns services at specific station."})

      def emergency(response)
        response.reply "Something's on FIRE?!?!\n I can't beleive I have to say this but, call 911!"
      end

      def lookup(response)
        address = response.matches[0][0]
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
          response.reply "I can't believe I have to say this but, addresses usually end with a quadrant (NE,NW,SE,SW)!"
        end
      end

      def map(response)
          response.reply "Calgary fire station locations: https://www.google.com/maps/d/view?mid=zg5QuGLLX0bo.kVz7Y6bmQ4rI"
      end

      def geolookup(response)
          response.reply "Looks like you're near City Hall - the closet fire stations are:\n Station 1 - 450 1 ST SE\n Station 2 - 1010 10 AV SW"
      end

      def services(response)
        station = response.matches[0].last.to_s
        response.reply "Services at Station #{station}:"
      end

    end

    Lita.register_handler(FireStations)
  end
end
