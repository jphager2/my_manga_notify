module MyManga
  module Notifier
    class Update
      include Notifier::Scheduleable
      include Notifier::Persistable

      def initialize(*manga, **options)
        @manga = manga.map { |manga| Manga.find_by_uri(manga) }.compact
        @every = options[:every]
        @schedule = Schedule.new(recurrence: :daily, interval: 1)
      end

      def execute
        # look up the manga in the database
        # look up the manga online
        # compare manga read vs. manga total
        # send an email if the difference is greater than provided by user

        Mailer.deliver do |receiver| 
          { subject: "[Email][Update][#{@manga.map(&:name).join('][')}]",
            body: "Nothing yet, #{receiver[:first_name]}..." }
        end
      end

      def valid?
        @every && @every > 0
      end
    end
  end
end
