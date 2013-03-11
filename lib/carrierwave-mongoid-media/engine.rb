require 'carrierwave'

module CarrierWave
  module Mongoid
    class Media < ::Rails::Engine
      DEFAULT_PREFIX = :media

      config.autoload_paths << File.expand_path("../../../app/behaviors", __FILE__)

      class << self
        attr_writer :prefix
      end

      def self.prefix
        @prefix ||= DEFAULT_PREFIX
      end

      def self.routes(router, options = {})
        options = {
          :prefix => :media,
          :controller => "carrierwave/mongoid_media"
        }.merge(options)

        self.prefix = options[:prefix]

        CarrierWave.configure do |c|
          c.grid_fs_access_url = "/#{options[:prefix]}"
        end

        router.instance_exec do
          get "#{options[:prefix]}/:id" => "#{options[:controller]}#show", :as => :media, :id => /.*/
        end
      end
    end
  end
end

