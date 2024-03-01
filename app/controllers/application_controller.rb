class ApplicationController < ActionController::Base
    helper_method :current_user

    private

    def current_user
        # 세션에 user_id가 있으면 @current_user에 User 객체를 할당하거나 반환
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
end
