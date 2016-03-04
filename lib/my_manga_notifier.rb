require 'yaml'
require 'pathname'

require_relative '../../my_manga/db/environment'

require_relative 'notifier/schedule'
require_relative 'notifier/scheduleable'
require_relative 'notifier/persistable'
require_relative 'notifier/update'
require_relative 'notifier/summary'
require_relative 'notifier/mailer'

module MyManga
  module Notifier
    TASK_LOAD_PATH = Pathname.new(Dir.home).join('.my_manga_notifications') 
    TASK_TEMPLATE_PATH = Pathname.new(
      File.expand_path('../../tasks.rb', __FILE__))

    def self.scheduled_tasks(date)
      tasks = []
      tasks.concat(Update.scheduled_on(date))
      tasks.concat(Summary.scheduled_on(date))
    end


    def self.load_tasks
      if File.exist? TASK_LOAD_PATH
        load(TASK_LOAD_PATH)
      else
        template = File.read(TASK_TEMPLATE_PATH)
        File.open(TASK_LOAD_PATH, 'w') { |f| f.write(template) }
      end
    end
  end
end

MyManga::Notifier.load_tasks
