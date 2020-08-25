require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? #本番環境
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'FM_log'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/FM_log'
  else # 開発環境
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end

end