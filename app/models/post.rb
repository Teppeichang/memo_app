class Post < ApplicationRecord
  validates :content,{presence:true}
  validates :user_id,{presence:true}


  def user
    #投稿に紐づいたuserインスタンスを戻り値として返す
    return User.find_by(id: self.user_id)
  end

end
