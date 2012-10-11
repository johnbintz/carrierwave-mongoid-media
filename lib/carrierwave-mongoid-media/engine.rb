module CarrierWave
  module Mongoid
    class Media < ::Rails::Engine
      initializer 'carrierwave_mongoid_media.carrierwave' do
        CarrierWave.configure do |c|
          c.grid_fs_access_url = '/media'
        end
      end
    end
  end
end

