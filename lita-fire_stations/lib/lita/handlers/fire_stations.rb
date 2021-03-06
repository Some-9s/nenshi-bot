require 'big_query'

module Lita
  module Handlers
    class FireStations < Handler

      route(/test/) do |response |
        response.reply_with_mention($config_yaml.to_json)
        response.reply_with_mention($config_yaml["firestations"]["client_id"])
      end

      route(/on fire/i, :emergency, help: {"on fire" => "You need advice on this?"})

      route(/fire station[s]? around\s+(.+)/i, :lookup, help: {"fire station(s) around ADDRESS" => "Returns fire stations near ADDRESS."})

      route(/fire station[s]? near me/i, :geolookup, help: {"fire station(s) near me" => "Returns fire stations around your location."})

      route(/(all fire stations)|(^(?=.*\bstations\b)(?=.*\bmap\b).*$)/i,:map, help: {"Map all stations" => "Returns link to map of all fire stations."})

      route(/station[s]?.*offer[s]?\s+(.+)/i, :servlookup, help: {"What station offers SERVICE?" => "Returns list of stations that offer SERVICE."})

      def emergency(response)
        response.reply_with_mention "Something's on FIRE?!?!\n I can't believe I have to say this but, call 911!"
      end

      def get_opt()
        opts = {}
        opts['client_id']     = $config_yaml['bigquery']['client_id']
        opts['service_email'] = $config_yaml['bigquery']['service_email']
        opts['key']           = $config_yaml['bigquery']['key']
        opts['project_id']    = $config_yaml['bigquery']['project_id']
        opts['dataset']       = $config_yaml['bigquery']['dataset']
        opts
      end

      def lookup(response)
        bq = BigQuery::Client.new(get_opt)
        address = response.matches[0][0]
        quad = address.split(//).last(2).join.upcase
        case quad
        when "SE"
          base_reply = "Fire stations in SE: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%SE'")

          print(data,response,base_reply)

        when "SW"
          base_reply = "Fire stations in SW: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%SW'")

          print(data,response,base_reply)

        when "NE"
          base_reply = "Fire stations in NE: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%NE'")

          print(data,response,base_reply)

        when "NW"
          base_reply = "Fire stations in NW: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE address like '%NW'")

          print(data,response,base_reply)

        else
          response.reply_with_mention "I can't believe I have to say this but, addresses usually end with a quadrant (NE,NW,SE,SW)!"
        end
      end

      def map(response)
        # Google map overlayed with CoC KMZ data
        response.reply_with_mention "Calgary fire station locations: https://www.google.com/maps/d/view?mid=zg5QuGLLX0bo.kVz7Y6bmQ4rI"
      end

      def geolookup(response)
        # Hard coded for Hackathon demo
        response.reply_with_mention "Looks like you're near City Hall - the closest fire stations are:\n Station 1 - 450 1 ST SE\n Station 2 - 1010 10 AV SW"
      end

      def servlookup(response)
        service = response.matches[0][0].split('?').first.to_s

        bq = BigQuery::Client.new(get_opt)

        case service.downcase
        when "tours"
          base_reply = "Stations with tours: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE StnTours = 'YES'")

          print(data,response,base_reply)

        when "chemical drop"
          base_reply = "Stations with chemical drop: "

          data = bq.query("SELECT station_name,address FROM [firestations.firestation_services] WHERE Chem_Drop = 'YES'")

          print(data,response,base_reply)

        else
          response.reply_with_mention "Unknown service - how about a selfie"
        end

      end

      def print(data,response,reply)
        reply += "\n"
        data['rows'].each do |row|
          reply +="#{row['f'][0]['v']} - #{row['f'][1]['v']}\n"
        end
        response.reply_with_mention "#{reply}"
      end

    end

    Lita.register_handler(FireStations)
  end
end
