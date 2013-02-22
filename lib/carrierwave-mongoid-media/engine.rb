require 'carrierwave'

module CarrierWave
  module Mongoid
    class Media < ::Rails::Engine
      DEFAULT_PREFIX = :media

      class << self
        attr_writer :prefix
      end

      def self.prefix
        @prefix ||= DEFAULT_PREFIX
      end

      def self.routes(router, options = {})
        options = {
          :prefix => :media,
          :controller => :media
        }.merge(options)

        self.prefix = options[:prefix]

        CarrierWave.configure do |c|
          c.grid_fs_access_url = "/#{options[:prefix]}"
        end

        router.instance_exec do
          get "#{options[:prefix]}/*path" => "#{options[:controller]}#show", :as => :media
        end
      end
    end
  end
end

