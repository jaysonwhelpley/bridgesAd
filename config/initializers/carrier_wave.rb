# require 'fog/aws'
# require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  if Rails.env.test?
    config.asset_host = 'http://localhost:3000'
  else
    # Configuration for Amazon S3 should be made available through an Environment variable.
    # For local installations, export the env variable through the shell OR
    # if using Passenger, set an Apache environment variable.
    #
    # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
    #
    # $ heroku config:add S3_KEY=your_s3_access_key S3_SECRET=your_s3_secret S3_REGION=eu-west-1 S3_ASSET_URL=http://assets.example.com/ S3_BUCKET_NAME=s3_bucket/folder

    # Configuration for Amazon S3


    config.fog_use_ssl_for_aws = true
    config.fog_directory  = ENV['S3_BUCKET_NAME']
    config.fog_public     = true
    config.fog_attributes = { 'Cache-Control': 'max-age=315576000' }
    config.asset_host = 'https://s3-us-east-2.amazonaws.com/bridges-app'
    config.fog_provider = 'fog-aws'

    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
      path_style:             ENV['FOG_PATH_STYLE'],
      region:                 'us-east-2'
    }

    config.cache_dir = "#{Rails.root}/tmp/uploads"

    config.storage = :fog
  end
end
