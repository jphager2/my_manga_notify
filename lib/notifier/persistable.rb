module MyManga
  module Notifier
    module Persistable
      def self.all
        @all ||= []
      end

      def save
        self.class.all << self
      end
    end
  end
end
