class User < ApplicationRecord
  # email이 3글자 이상이어야 한다는 유효성 검사 추가
  validates :email, length: { minimum: 3 }
  # password가 4글자 이상이어야 한다는 유효성 검사 추가
  validates :password, length: { minimum: 4 }
  has_secure_password
end
