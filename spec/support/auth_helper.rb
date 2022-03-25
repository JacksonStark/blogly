module AuthHelper
    def login_user(user)
        post login_url, params: { user: { email: user.email, password: user.password } }
    end
  end