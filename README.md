Make it very easy to accept Carrierwave uploads to a Mongoid GridFS-backed data store and then deliver them.

Add this to your `config/routes.rb`:

``` ruby
My::Application.routes.draw do
  CarrierWave::Mongoid::Media.routes(self)
end
```

And you'll have a `/media/:id` route that just delivers whatever Carrierwave uploads to this app, as long as
you're using [carrierwave-mongoid](https://github.com/jnicklas/carrierwave-mongoid) to do the uploads. CarrierWave's
`grid_fs_access_url` will be set correctly for you, too.

You can specify if any of the paths should respond with `Content-Disposition: attachment` headers with an initializer:

``` ruby
# config/initializers/carrierwave_mongoid_media.rb

CarrierwaveMongoidMedium.force_downloads_on do |path|
  # return true if the file should get Content-Disposition: attachment
end
```

