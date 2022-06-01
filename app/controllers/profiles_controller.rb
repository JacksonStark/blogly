class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update ]

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
        redirect_to profile_url(@profile), notice: "Profile was successfully updated."
    else
        render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_profile
        @profile = Profile.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path, notice: "Profile not found."
    end

    # Only allow a list of trusted parameters through.
    def profile_params
        params.require(:profile).permit(
            :first_name,
            :last_name,
            :image_url,
            :bio,
            :user_id
        )
    end
end
