module Lita
  module Handlers
    class TrafficCams < Handler
    
      route(/What is the traffic like on\s(.+)/, command: true) do |response|
        response.reply(response.matches)
      end
    end

    Lita.register_handler(TrafficCams)
  end
end
