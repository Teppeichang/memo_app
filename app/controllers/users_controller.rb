class UsersController < ApplicationController
before_action :authenticate_user,{only:[:edit,:update]}
before_action :forbid_login_user,{only:[:new,:create,:login_form,:login_form]}
before_action :ensure_correct_user,{only:[:edit,:update]}

def ensure_correct_user
  #params[:id]で取得できる値は文字列として扱われるので、to_iメソッドで数値に変換！
  if @current_user.id != params[:id].to_i
    flash[:notice] = "権限がありません"
    redirect_to("/posts/index")
  end
end

  #新規ユーザー登録
  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name],email: params[:email],password: params[:password],image_name: "default_user.jpeg")
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録に成功しました。"
      redirect_to("/posts/index")
    else
      flash[:notice] = "エラー！：ユーザー情報を正しく入力してください"
      render("users/new")
    end  
  end

  #ユーザー一覧
  def index
    @users = User.all
  end

  #ユーザー詳細
  def show
    @user = User.find_by(id: params[:id])
  end

  #ログイン機能
  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] ="ログインしました"
      redirect_to("/users/#{@user.id}")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  #ログアウト
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  #ユーザー情報の編集
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpeg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")

    else
      render("users/edit")
    end
  end

  #完了したタスクの一覧表示
  def tasks
    @user = User.find_by(id: params[:id])
    @tasks = Task.where(user_id: @user.id)
  end 

end
