module Lita
  module Handlers
    class TrafficCams < Handler
    
      route(/What is the traffic like at\s(.+)/, command: true, help: {"What is the traffic like at [location]" => "Displays the traffic status of [location]"}) do |response|
        response.reply(response.matches)
      end
    end

    Lita.register_handler(TrafficCams)
  end
end
