module CarrierwaveMongoidMediaController
  def show
    resource.as_response_for(self)
  end

  def create
    with_ok { create! }
  end

  def create!
    resource.update_attributes(params)
  end

  def destroy
    with_ok { destroy! }
  end

  def destroy!
    resource.destroy
  end

  private
  def with_ok
    yield

    head :ok
  end
end

