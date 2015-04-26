module Lita
  module Handlers
    class Douchebag < Handler

      # Catch any bad actors potentially trying to sabotage the presentation
      route(/(fuck)|(shit)|([\s]ass)|(f\*ck)|(piss)|(cock)|(penis)/i, :handle_cursing)

      def handle_cursing(response)
        response.reply_with_mention "#neshinouns\nhttp://www.provedplusprobable.com/wp-content/uploads/2013/06/1302220757143_ORIGINAL.jpg"
      end
    end


    Lita.register_handler(Douchebag)
  end
end
