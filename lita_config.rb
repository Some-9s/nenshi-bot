require 'yaml'

def load_config (config)
  $config_yaml = begin
    YAML.load(File.open("config.yml"))
  rescue ArgumentError => e
    puts "Could not parse YAML: #{e.message}"
  end

  config.adapters.twitter.api_key = $config_yaml["twitter"]["api_key"]
  config.adapters.twitter.api_secret = $config_yaml["twitter"]["api_secret"]
  config.adapters.twitter.access_token = $config_yaml["twitter"]["access_token"]
  config.adapters.twitter.access_token_secret = $config_yaml["twitter"]["access_token_secret"]

end

Lita.configure do |config|
  # The name your robot will use.
  config.robot.name = "Nenshi_bot"

  # The locale code for the language to use.
  # config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  # config.robot.admins = ["1", "2"]

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
<<<<<<< HEAD
   config.robot.adapter = :shell
   #config.robot.adapter = :twitter
=======
  config.robot.adapter = :shell
  # config.robot.adapter = :twitter
>>>>>>> dd45b69182ab3612f3f4462417941bfa62caf358


  # Uncomment to use the Twitter adapter
  # You will need the config.yml which is stored outside of git. Ask brksrly 
  # config.robot.adapter = :twitter
  load_config(config)

  ## Example: Set options for the chosen adapter.
  # config.adapter.username = "myname"
  # config.adapter.password = "secret"

  ## Example: Set options for the Redis connection.
  # config.redis.host = "127.0.0.1"
  # config.redis.port = 1234

  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"
end


