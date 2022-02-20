require 'aws-sdk-s3'
require 'securerandom'

module Services
    class UploadService
        attr_accessor :client

        def initialize(client = make_s3_client, filename = SecureRandom.hex(10))
            @client = client
            @filename = filename
        end

        def get_download_url
            "https://#{ENV['AWS_S3_BUCKET']}.s3.#{ENV['AWS_S3_REGION']}.amazonaws.com/#{@filename}"
        end
        
        def get_presigned_url
            signer = make_s3_presigner
            presigned_url, headers = signer.presigned_request(:put_object, bucket: ENV['AWS_S3_BUCKET'], key: @filename)
            presigned_url
        end

        private
            def make_s3_client
                Aws::S3::Client.new(
                    region: ENV['AWS_S3_REGION'],
                    access_key_id: Rails.application.credentials.config[:aws][:access_key_id],
                    secret_access_key: Rails.application.credentials.config[:aws][:secret_access_key],
                )
            end

            def make_s3_presigner
                Aws::S3::Presigner.new(client: @client)
            end
    end
end