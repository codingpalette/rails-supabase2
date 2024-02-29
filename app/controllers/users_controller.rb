class UsersController < ApplicationController
  def index
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
            @user.save
            # User.create(@user)
            render json: { status: 'success', message: 'User created successfully'}
        end
    else
        render json: { status: 'error', message: 'User not created'}, status: :unprocessable_entity
    end

  end
end

private
def user_params
  params.require(:user).permit(:email, :password)
end
