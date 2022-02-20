class UploadsController < ApplicationController
    def presigned_url
        upload_service = Services::UploadService.new
        
        presigned_url = upload_service.get_presigned_url()
        download_url = upload_service.get_download_url()

        render json: {presigned_url: presigned_url, download_url: download_url}
    end
end