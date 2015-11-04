module MyManga
  module Notifier
    class Summary
      include Notifier::Scheduleable
      include Notifier::Persistable

      def initialize(*manga, **options)
        @manga = manga
        @schedule = Schedule.new(options)
      end
    end
  end
end
