class UsersController < ApplicationController
  def index
      puts "user_session: #{session[:user_id]}"
      puts "user: #{current_user.inspect}"
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
        # 동일한 이메일 주소를 가진 사용자가 데이터베이스에 존재하는지 확인
        existing_user = User.find_by(email: @user.email)
        if existing_user
            # 동일한 이메일 주소를 가진 사용자가 이미 존재함
            render json: { status: 'error', message: 'Email already taken' }, status: :unprocessable_entity
        else
            # 사용자 생성
            if @user.save
                # @user.save
                # User.create(@user)
                render json: { status: 'success', message: 'User created successfully'}
            else
                render json: { status: 'error', message: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity
            end
        end
    else
        render json: { status: 'error', message: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end

  end
  # create and

  def login
        @user = User.find_by(email: user_params[:email])

        if @user && @user.authenticate(user_params[:password])
            # 로그인 성공: 사용자 ID를 세션에 저장
            session[:user_id] = @user.id
            render json: { state: 'success', message: 'User logged in successfully' }
        else
            render json: { state: 'error', message: 'Invalid email or password' }, status: :unauthorized
        end




  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    render json: { state: 'success', message: 'Logged out successfully' }
  end

end

private
def user_params
  params.require(:user).permit(:email, :password)
end
