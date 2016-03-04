module MyManga
  module Notifier
    class Schedule

      def initialize(options)
        if options
          @day = options[:day]
          @interval = options[:interval]
          @recurrence = options[:recurrence]
        end
      end

      def occurs_on?(date)
        # This gets out of sync due to leap years, but w/e
        case @recurrence
        when :daily
          date.yday % @interval == 0
        when :weekly
          (date.yday / 7) % @interval == 0 && date.wday == @day
        when :monthly
          date.month % @interval == 0 && date.mday == mday(date)
        end
      end

      def mday(date)
        if @day < 0
          last_day = nil
          day = 31
          while last_day.nil?
            begin
              last_day = Date.new(date.year, date.month, day)
            rescue ArgumentError
              day -= 1
            end
          end
          day + @day + 1
        elsif @day == 0
          1
        else
          @day
        end
      end
    end
  end
end
