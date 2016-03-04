module MyManga
  module Notifier
    class Summary
      include Notifier::Scheduleable
      include Notifier::Persistable

      def initialize(*manga, **options)
        @manga = manga.map { |manga| Manga.find_by_uri(manga) }.compact
        options = process_options(options)
        @schedule = Schedule.new(options)
      end

      def execute
        # Basically just an email with the output from my_manga list
        subject = "Summary - #{@manga.map(&:name).join(', ')}"
        body = "" 
        @manga.each do |manga|
          body << `my_manga list "#{manga.name}"` + "\n"
        end

        Mailer.deliver do |receiver| 
          { subject: subject,
            body: body }
        end
      end

      def valid?
        true
      end

      private
      def process_options(options)
        processed = {
          recurrence: options.fetch(:recurrence, :weekly),
          day: options.fetch(:on, 0),
          interval: options.fetch(:interval, 1),
        }
      end
    end
  end
end
