CarrierWave::Mongoid::Media.routes.draw do
  get 'media/*path' => 'media#show'
end

