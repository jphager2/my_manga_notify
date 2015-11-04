module MyManga
  module Notifier
    module Scheduleable
      attr_reader :schedule 

      def self.scheduled_on(date)
        all.select { |event| event.scheduled_on?(date) }
      end

      def scheduled_on?(date)
        schedule.occurs_on?(date)
      end
    end
  end
end
