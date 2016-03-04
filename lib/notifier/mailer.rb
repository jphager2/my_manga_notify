require 'mail'
require 'yaml'

module MyManga
  module Notifier
    module Mailer
      CONFIG_PATH = File.expand_path('../../../config/mail.yml', __FILE__)

      def self.config(reload = false)
        @config = nil if reload

        @config ||= YAML.load(File.read(CONFIG_PATH))
      end

      def self.default_sender
        @default_sender
      end

      def self.default_receiver
        @default_receiver
      end

      def self.load_config
        if config(:reload)["mail"]
          setup_mail_defaults(config["mail"])
        else
          raise "invalid mail config: #{CONFIG_PATH}"
        end
      end

      def self.setup_mail_defaults(config)
        options = {}
        receiver = {}
        config["sender"].each do |opt, val| options[opt.to_sym] = val end
        config["receiver"].each do |opt, val| receiver[opt.to_sym] = val end
        @default_sender = "#{options[:user_name]}@#{options[:domain]}"
        @default_receiver = receiver

        ::Mail.defaults do delivery_method(:smtp, options) end
      end
      private_class_method :setup_mail_defaults

      def self.deliver
        options = yield(@default_receiver)
        options[:to] ||= @default_receiver[:email]
        options[:from] ||= @default_sender

        Mail.deliver do
          to options[:to]
          from options[:from]
          subject options [:subject]
          body options[:body]
        end
      end
    end
  end
end
