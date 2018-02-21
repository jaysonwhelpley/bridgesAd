require 'carrierwave/orm/activerecord'
require 'fog/aws'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => 'AKIAJHI3BRVWVFS774SA',
      :aws_secret_access_key => '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'
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
end
