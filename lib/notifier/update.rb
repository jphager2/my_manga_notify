module MyManga
  module Notifier
    class Update
      include Notifier::Scheduleable
      include Notifier::Persistable

      def initialize(*manga, **options)
        @manga = manga
        @every = options[:every]
        @schedule = Schedule.new(recurrence: :daily, interval: 1)
      end

      def execute
        # look up the manga in the database
        # look up the manga online
        # compare manga read vs. manga total
        # send an email if the difference is greater than provided by user
        puts "[Email][Update][#{@manga.join('][')}]"
      end

      def valid?
        @every && @every > 0
      end
    end
  end
end
