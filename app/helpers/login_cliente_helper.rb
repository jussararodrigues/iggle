module LoginClienteHelper
    def sign_in(user)
        session[:user_id] = user.id
    end

    def sign_out
        session.delete(:user_id)
    end

    def current_normal_user
        @current_normal_user ||= NormalUser.find_by(id: session[:user_id])
    end

    def normal_user_signed_in?
        !current_normal_user.nil?
    end
end
