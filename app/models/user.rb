class User < ApplicationRecord
  validates :email,{uniqueness:true}
  validates :password,{presence:true}
  has_secure_password

  def posts
    #ユーザー情報に紐づく複数の投稿を取得し、戻り値として返す
    return Post.where(user_id: self.id)
  end
end
