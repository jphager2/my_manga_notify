require_relative 'notifier/schedule'
require_relative 'notifier/scheduleable'
require_relative 'notifier/update'
require_relative 'notifier/summary'
require_relative 'notifier/mailer'

module MyManga
  module Notifier
    def self.scheduled_tasks(date)
      tasks = []
      tasks.concat(Update.scheduled_on(date))
      tasks.concat(Summary.scheduled_on(date))
    end
  end
end
