module MyManga
  module Notifier
    class Summary
      include Notifier::Scheduleable
      include Notifier::Persistable

      def initialize(*manga, **options)
        @manga = manga.map { |manga|
          Manga.find_by_uri(manga)
        }.compact
        options = process_options(options)
        @schedule = Schedule.new(options)
      end

      def execute
        # Basically just an email with the output from my_manga list
        puts "[Email][Summary][#{@manga.join('][')}]"
        @manga.each do |manga|
          puts `my_manga list "#{manga.name}"`
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
