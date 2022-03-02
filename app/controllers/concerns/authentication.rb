module Authentication
    # provides an interface for logging the user in and out
    extend ActiveSupport::Concern

    included do
        before_action :current_user # to have access to current_user before each request
        helper_method :current_user # for access in our views
        helper_method :user_signed_in?
    end

    def login(user)
        reset_session # necessary to prevent session fixation
        session[:current_user_id] = user.id
    end

    def logout 
        reset_session
    end

    def redirect_if_authenticated
        # useful on pages an authenticated user should not be able to access, such as the login page.
        redirect_to root_path, alert: "You are already loggin in." if user_signed_in?
    end

    def current_user
        Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end

    def user_signed_in?
        Current.user.present?
    end
end