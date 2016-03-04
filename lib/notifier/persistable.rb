module MyManga
  module Notifier
    module Persistable
      def self.included(base)
        base.extend(ClassMethods)
      end

      def save
        raise "#{name} is invalid!" unless valid?

        @id ? update : create
      end
      
      def create
        record = self.to_yaml

        self.class.store << record 
        @id = self.class.store.index(record)

        self
      end

      def update
        record = self.to_yaml

        self.class.store[@id] = record

        self
      end

      module ClassMethods
        def all
          store.map { |record| YAML.load(record) }
        end

        def store
          @store ||= []
        end

        def find(id)
          if store[id]
            YAML.load(store[id])
          else
            raise "No #{name} found with id=#{id.inspect}"
          end
        end
      end
    end
  end
end
