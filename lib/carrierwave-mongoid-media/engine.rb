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

      def self.routes(router, prefix = :media)
        self.prefix = prefix

        CarrierWave.configure do |c|
          c.grid_fs_access_url = "/#{prefix}"
        end

        router.instance_exec do
          get "#{prefix}/*path" => "media#show", :as => :media
        end
      end
    end
  end
end

