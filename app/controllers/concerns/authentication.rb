module Authentication
    # provides an interface for logging the user in and out
    extend ActiveSupport::Concern

    included do
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
        # useful on pages an authenticated user should not be able to access, such as the login page
        redirect_to root_path, alert: "You are already loggin in." if user_signed_in?
    end

    def authenticate_user!
        # useful on routes an unauthenticated user should not be able to access, such as the articles#create
        redirect_to login_path, alert: "You need to login to access that page." unless user_signed_in?
    end

    def current_user
        Current.user ||= User.find_by(id: session[:current_user_id])
    end

    def user_signed_in?
        current_user.present?
    end
end