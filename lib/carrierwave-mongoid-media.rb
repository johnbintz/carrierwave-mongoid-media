require "carrierwave-mongoid-media/version"

if defined?(Rails::Engine)
  require 'carrierwave-mongoid-media/engine'
  require 'carrierwave/mongoid/media/controller_behavior'
end
