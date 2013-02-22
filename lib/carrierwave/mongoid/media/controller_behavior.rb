module CarrierWave::Mongoid::Media::ControllerBehavior
  def show
    obj = CarrierwaveMongoidMedia.find(path)

    self.content_type = obj.content_type
    self.response_body = obj
    if obj.force_download?
      response.headers['Content-Disposition'] = "attachment; filename='#{obj.attachment_filename}'"
    end
  end

  private
  def path
    @path ||= params[:path] + '.' + params[:format]
  end
end

