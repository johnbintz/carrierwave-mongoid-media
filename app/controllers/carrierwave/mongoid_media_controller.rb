class Carrierwave::MongoidMediaController < ApplicationController
  include CarrierwaveMongoidMediaController

  private
  def resource
    @carrierwave_mongoid_media ||= CarrierwaveMongoidMedium.find(params[:id])
  end
end

