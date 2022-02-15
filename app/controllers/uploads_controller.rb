class UploadsController < ApplicationController
    def presigned_url
        filename = SecureRandom.hex(10) # for obfuscation purposes
        upload_service = Services::UploadService.new
        
        presigned_url = upload_service.get_presigned_url(filename)
        download_url = upload_service.get_download_url(filename)

        render json: {presigned_url: presigned_url, download_url: download_url}
    end
end