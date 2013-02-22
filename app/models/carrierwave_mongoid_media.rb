require 'delegate'

class CarrierwaveMongoidMedia < SimpleDelegator
  def self.find(path)
    obj = Mongoid::GridFS[path]

    raise Mongoid::Errors::DocumentNotFound.new(Mongoid::GridFS, :path => path) if !obj

    new(obj)
  end

  def self.force_downloads_on(&block)
    if block
      @block = block
    else
      @block
    end
  end

  def attachment_filename
    File.basename(self.filename)
  end

  def initialize(gridfs_object)
    @gridfs_object = gridfs_object
  end

  def __getobj__
    @gridfs_object
  end

  def force_download?
    if block = self.class.force_downloads_on
      block.call(self.filename)
    else
      false
    end
  end
end

