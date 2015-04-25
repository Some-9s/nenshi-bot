module Lita
  module Handlers
    class FireStations < Handler
      route(/fire/, :fire) 

      def fire(response)
        response.reply "The closest fire stations is _____!"
      end
    end

    Lita.register_handler(FireStations)
  end
end
