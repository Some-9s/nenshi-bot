module Lita
  module Handlers
    class Selfie < Handler

      URL = "https://ajax.googleapis.com/ajax/services/search/images"

      route(/selfie\?/, :fetch, help: {
        "How about a selfie?" => "Displays a random selfie from Google Images for Nenshi."
      })

      def fetch(response)
        query = "nenshi selfie"

        http_response = http.get(
          URL,
          v: "1.0",
          q: query,
          safe: :active,
          rsz: 8
        )

        data = MultiJson.load(http_response.body)

        if data["responseStatus"] == 200
          choice = data["responseData"]["results"].sample
          if choice
            response.reply_with_mention "Social Medium time!\n#{ensure_extension(choice["unescapedUrl"])}"
          else
            response.reply_with_mention %{No images found for "#{query}".}
          end
        else
          reason = data["responseDetails"] || "unknown error"
          Lita.logger.warn(
            "Couldn't get image from Google: #{reason}"
          )
        end
      end

      private

      def ensure_extension(url)
        if [".gif", ".jpg", ".jpeg", ".png"].any? { |ext| url.end_with?(ext) }
          url
        else
          "#{url}#.png"
        end
      end

    end

    Lita.register_handler(Selfie)
  end
end
