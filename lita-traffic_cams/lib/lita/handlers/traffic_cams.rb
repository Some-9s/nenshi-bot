require 'json'
module Lita
  module Handlers
    class TrafficCams < Handler

      # route(/how\s(the\s)?(.)/)

      route(/What.+traffic\s+(look\s)?(like\s)?((at\s)|(on\s))(the\s)?(.+)[?]?/i, :traffic_at, command: false, help: {"What is the traffic like at LOCATION?" => "Displays the traffic status of LOCATION"})

      route(/What.+traffic\s+(look\s)?(like\s)?near me?/i, :traffic_at_city_hall, command: false, help: {"What is the traffic like near me?" => "Displays the traffic status near by"})

      route(/((where)|(what)) are all (of the\s)?(available\s)?traffic cams[?]?/i, command: false, help: {"Where are all of the traffic cams?" => "Displays a map of the available traffic cams"}) do |response|
        response.reply_with_mention "Honestly, I think we need more! http://tinyurl.com/n39lkx2"
      end

      def traffic_at_city_hall(response)
        traffic_at(response, '11 Avenue')
      end

      def traffic_at(response,location = nil)
        reply = ''

        location ||= response.matches[0][6]

        location_data = get_location_at(response, location.split('?').first, reply)

        return response.reply_with_mention("No traffic cam at #{location}, how about a #selfie instead?\nhttp://i.huffpost.com/gen/2851982/images/o-NENSHI-NPH-facebook.jpg") if location_data.nil? or location_data.empty?

        reply << "traffic looks good!\n"
        response.reply_with_mention "#{get_pictures(reply, location_data)}"
      end

      def get_opts()
        opts = {}
        opts['client_id'] = $config_yaml['bigquery']['client_id']
        opts['service_email'] = $config_yaml['bigquery']['service_email']
        opts['key'] = $config_yaml['bigquery']['key']
        opts['project_id'] = $config_yaml['bigquery']['project_id']
        opts['dataset'] = $config_yaml['bigquery']['dataset']
        opts
      end

      def get_location_at(response, location, reply)

        bq = BigQuery::Client.new(get_opts)

        reply << "Looks like you're at #yychackathon, " if location.eql? '11 Avenue'

        data = bq.query("SELECT url FROM [firestations.traffic_cams] where lower(intersection_1) like lower('%#{ location }%') or lower(intersection_2) like lower('%#{ location }%')")
        return if location.nil? or data['rows'].nil?
        return data['rows']
      end

      def get_pictures(reply, location_data)
        location_data.each do |row|
          reply << "#{row['f'][0]['v'].lstrip}\n"
        end

        reply.chomp()
      end

    end

    Lita.register_handler(TrafficCams)
  end
end
