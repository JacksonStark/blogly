class UploadsController < ApplicationController
    def presigned_url
        storage_service = Services::StorageService.new
        
        presigned_url = storage_service.presigned_url
        download_url = storage_service.download_url

        render json: {presigned_url: presigned_url, download_url: download_url}
    end
end