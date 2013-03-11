require 'virtus'

class CarrierwaveMongoidMedium
  include Virtus

  attribute :id
  attribute :data

  def self.find(id)
    medium = new(:id => id)

    raise_not_found(id) if !medium.gridfs_object

    medium
  end

  def self.raise_not_found(id)
    raise Mongoid::Errors::DocumentNotFound.new(Mongoid::GridFS, :filename => id)
  end

  def raise_not_found
    self.class.raise_not_found(id)
  end

  def self.force_downloads_on(&block)
    if block
      @block = block
    else
      @block
    end
  end

  def update_attributes(new_attributes = {})
    self.attributes = new_attributes

    save
  end

  def content_type
    gridfs_object.content_type
  end

  def self.create(attributes = {})
    new(attributes).save
  end

  def destroy
    gridfs_object.destroy

    @gridfs_object = nil
  end

  def save
    attrs = attributes.dup

    file = attrs.delete(:data)
    filename = attrs.delete(:id) || attrs.delete(:filename)

    @gridfs_object = Mongoid::GridFS.put(file, attrs.merge(:filename => filename))
  end

  def attachment_filename
    ::File.basename(id)
  end

  def gridfs_object
    @gridfs_object ||= Mongoid::GridFS[id]
  end

  def force_download?
    if block = self.class.force_downloads_on
      block.call self
    else
      false
    end
  end

  def as_response_for(controller_instance)
    controller_instance.content_type = self.content_type
    controller_instance.response_body = self.gridfs_object
    if self.force_download?
      controller_instance.response.headers['Content-Disposition'] = "attachment; filename='#{self.attachment_filename}'"
    end
  end
end

