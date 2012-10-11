class MediaController < ApplicationController
  def show
    path = params[:path] + '.' + params[:format]
    obj = Mongoid::GridFS[path]

    raise Mongoid::Errors::DocumentNotFound.new(Mongoid::GridFS, :path => path) if !obj

    self.content_type = obj.content_type
    self.response_body = obj
  end
end

