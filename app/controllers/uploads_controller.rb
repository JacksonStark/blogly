require 'aws-sdk-s3'
require 'securerandom'

class UploadsController < ApplicationController
    def presigned_url
        s3 = Aws::S3::Client.new(
            region: 'us-west-2',
            access_key_id: Rails.application.credentials.config[:aws][:access_key_id],
            secret_access_key: Rails.application.credentials.config[:aws][:secret_access_key],
        )
        
        signer = Aws::S3::Presigner.new(client: s3)
        filename = "#{SecureRandom.hex(10)}.png"
        presigned_url, headers = signer.presigned_request(:put_object, bucket: "bl0gly", key: filename)
        download_url = "https://bl0gly.s3.us-west-2.amazonaws.com/#{filename}"

        render json: {presigned_url: presigned_url, download_url: download_url}, content_type: "application/json"
    end
end

