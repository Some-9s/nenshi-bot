module Lita
  module Handlers
    class SportsEquipment < Handler
   		route(/^wanna play\s+(hockey|basketball|baseball)/, :sports, help: { "echo TEXT" => "Echoes back TEXT." })
      def sports(response)
        if response.matches[0] == "hockey"
        	response.reply(response.matches)
    	else
    		response.reply("get outside!")
    		response.reply(response.matches.inspect)
    	end
      end

    end

    Lita.register_handler(SportsEquipment)
  end
end
