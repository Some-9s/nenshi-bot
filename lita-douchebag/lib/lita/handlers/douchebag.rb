module Lita
  module Handlers
    class Douchebag < Handler

      # Catch any bad actors potentially trying to sabotage the presentation
      route(/(fuck)|(shit)|([\s]ass)|(f\*ck)|(piss)|(cock)|(penis)/i, :handle_cursing)

      def handle_cursing(response)
        response.reply_with_mention "#neshinouns"
      end
    end


    Lita.register_handler(Douchebag)
  end
end
