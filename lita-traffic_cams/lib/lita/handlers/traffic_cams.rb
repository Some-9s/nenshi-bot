require 'json'
module Lita
  module Handlers
    class TrafficCams < Handler

      # $intersections = {"http://trafficcam.calgary.ca/loc34.jpg"}

      $location_data = {"city hall" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "bow trail" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "deerfoot" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "deerfoot" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "deerfoot" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "deerfoot" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "deerfoot" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "deerfoot" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},
                        "deerfoot" => {'url' => ['http://trafficcam.calgary.ca/loc53.jpg', 'http://trafficcam.calgary.ca/loc54.jpg', 'http://trafficcam.calgary.ca/loc56.jpg']},

      }

      route(/What.+traffic\s+(like\s)?((at)|(on))\s(.+)[?]?/i, :traffic_at, command: false, help: {"What is the traffic like at [location]?" => "Displays the traffic status of [location]"})

      route(/What.+traffic\s+(like\s)?near me?/i, :traffic_at_city_hall, command: false, help: {"What is the traffic like near me?" => "Displays the traffic status of [location]"})

      route(/where are all of the (available\s)?traffic cams[?]?/i, command: false, help: {"Where are all of the traffic cams?" => "Displays a map of the available traffic cams"}) do |response|
        response.reply_with_mention "http://tinyurl.com/n39lkx2"
      end

      def traffic_at_city_hall(response)
        location_data = get_location_at(response, "city hall")

        # return response.reply_with_mention("#{location_data.to_yaml} at #{location}")
        location_data['url'].each do |url|
          response.reply_with_mention(url)
        end unless location_data.nil?
      end

      def traffic_at(response)
        response.reply_with_mention("#{response.matches.to_json}\n\n")
        location = response.matches[0][4]

        location_data = get_location_at(response, location)

        # return response.reply_with_mention("#{location_data.to_yaml} at #{location}")
        return response.reply_with_mention("You know what? I can't figure out where \"#{location}\" is, but how about a selfie instead?") if location_data.nil? or location_data.empty?
        location_data['url'].each do |url|
          response.reply_with_mention(url)
        end unless location_data.nil?
      end

      def get_location_at(response, location)

        return if location.nil?
        response.reply_with_mention "Looks like you're at #yychackathon, the traffic looks alright to me but here are the closest traffic cams" if location.eql? 'city hall'
        $location_data[location]
      end
    end

    Lita.register_handler(TrafficCams)
  end
end
