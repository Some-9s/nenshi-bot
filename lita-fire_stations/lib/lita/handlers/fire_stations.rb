require 'big_query'

module Lita
  module Handlers
    class FireStations < Handler

      @@opts = {}
      @@opts['client_id']     = #
      @@opts['service_email'] = #
      @@opts['key']           = '/vagrant/supersecret_bigquery.p12'
      @@opts['project_id']    = 'robotic-sphere-92619'
      @@opts['dataset']       = 'firestations'

      route(/on fire/, :emergency, help: {"on fire" => "You need advice on this?"})

      route(/fire station[s]? around\s+(.+)/, :lookup, help: {"fire station(s) around ADDRESS" => "Returns fire stations near ADDRESS."})

      route(/fire station[s]? near me/, :geolookup, help: {"fire station(s) near me" => "Returns fire stations around your location."})

      route(/(all fire stations)|(^(?=.*\bstations\b)(?=.*\bmap\b).*$)/,:map, help: {"Map all stations" => "Returns link to map of all fire stations."})

      route(/station[s]?.*offer[s]?\s+(.+)/, :servlookup, help: {"What station offers SERVICE?" => "Returns list of stations that offer SERVICE."})

      def emergency(response)
        response.reply "Something's on FIRE?!?!\n I can't beleive I have to say this but, call 911!"
      end

      def lookup(response)
        bq = BigQuery::Client.new(@@opts)
        address = response.matches[0][0]
        quad = address.split(//).last(2).join.upcase
        response.reply "Looking for nearest fire stations near #{address}.."
        case quad
        when "SE"
          response.reply "Fire stations in SE: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%SE'")

          print(data,response)

        when "SW"
          response.reply "Fire stations in SW: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%SW'")

          print(data,response)

        when "NE"
          response.reply "Fire stations in NE: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%NE'")

          print(data,response)

        when "NW"
          response.reply "Fire stations in SW: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%NW'")

          print(data,response)

        else
          response.reply "I can't believe I have to say this but, addresses usually end with a quadrant (NE,NW,SE,SW)!"
        end
      end

      def map(response)
        # Google map overlayed with CoC KMZ data
        response.reply "Calgary fire station locations: https://www.google.com/maps/d/view?mid=zg5QuGLLX0bo.kVz7Y6bmQ4rI"
      end

      def geolookup(response)
        # Hard coded for Hackathon demo
        response.reply "Looks like you're near City Hall - the closet fire stations are:\n Station 1 - 450 1 ST SE\n Station 2 - 1010 10 AV SW"
      end

      def servlookup(response)
        service = response.matches[0][0].split('?').first.to_s

        bq = BigQuery::Client.new(@@opts)

        case service.downcase
        when "tours"
          response.reply "Stations with tours:"

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE StnTours = 'YES'")

          print(data,response)

        when "chemical drop"
          response.reply "Stations with chemical drop:"

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE Chem_Drop = 'YES'")

          print(data,response)

        else
          response.reply "Unknown service - how about a selfie"
        end

      end

      def print(data,response)
        data['rows'].each do |row|
          response.reply "#{row['f'][0]['v']} - #{row['f'][1]['v']}"
        end
      end

    end

    Lita.register_handler(FireStations)
  end
end
