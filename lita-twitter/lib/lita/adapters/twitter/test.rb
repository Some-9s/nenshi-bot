module Lita
  module Adapters
    class Twitter
      def hello
        puts "hi"
      end
    end
  end
end

a = Lita::Adapters::Twitter.new
puts a.instance_of?(::Lita::Adapters::Twitter)
puts a.class.to_s