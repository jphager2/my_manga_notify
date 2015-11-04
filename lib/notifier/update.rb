module MyManga
  module Notifier
    class Update
      include Notifier::Scheduleable
      include Notifier::Persistable

      def initialize(*manga, **options)
        @manga = manga
        @schedule = Schedule.new(options)
      end

      def execute
        # look up the manga in the database
        # look up the manga online
        # compare manga read vs. manga total
        # send an email if the difference is greater than provided by user
      end
    end
  end
end
