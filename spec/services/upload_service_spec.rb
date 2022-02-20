require 'aws-sdk-s3'
require 'rails_helper'

RSpec.describe "upload service", type: :service do
    before :each do
        stubbed_client = Aws::S3::Client.new(stub_responses: true)
        @upload_service = Services::UploadService.new(stubbed_client)
    end

    describe "instantiation" do
        it "assigns a valid s3 client upon instantiation" do
            expect(@upload_service.client).to be_an_instance_of(Aws::S3::Client)
        end
    end

    describe "get_presigned_url" do
        it "returns a valid presigned URL" do
            url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

            expect(@upload_service.get_presigned_url).to match(url_regexp)
        end
    end

    describe "get_download_url" do
        it "returns a valid download URL" do
            url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
            
            expect(@upload_service.get_download_url).to match(url_regexp)
        end
    end
end
