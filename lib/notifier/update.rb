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
        subject = "Update - #{@manga.map(&:name).join(', ')} - #{Date.today}"
        body = ""

        @manga.each do |manga|
          md_manga = manga.to_md
          chapters = md_manga.chapters
          current_chapters = manga.chapters.pluck(:uri)
          new_chapters = chapters.reject { |c| 
            current_chapters.include?(c.uri) 
          }
          if new_chapters.length >= @every
            body << <<-MANGA
              <hr>
              <div>
                <h2>#{manga.name}</h2>
                <strong>New Chapters:</strong>
                <em>#{new_chapters.count}</em>
                <ul> #{ new_chapters.map { |c| "<li>#{c.name}</li>" }.join }
                </ul>

                <strong>Unread Chapters:</strong>
                <em>#{manga.chapters.unread.count}</em>
                <ul> #{ manga.chapters.unread.map { |c| "<li>#{c.name}</li>" }.join }
                </ul>
              </div>
            MANGA
          end
        end

        if body.length > 0
          Mailer.deliver do |receiver| 
            { subject: subject,
              body: "<p>Hi, #{receiver[:first_name]}...</p>#{body}" }
          end
        end
      end

      def valid?
        @every && @every > 0
      end
    end
  end
end
