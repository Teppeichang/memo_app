class PostsController < ApplicationController
  #before_actionで、edit,update,destoryの３アクションは投稿したユーザーのみの権限となる
  before_action :ensure_correct_user,{only:[:edit,:update,:destroy]}


  #投稿一覧
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  #投稿詳細
  def show
    #postsテーブルのidカラムの値とpostsテーブルのuser_idカラムの値を用い、「どのユーザーがどの投稿をしたか」紐付ける
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  #新規投稿
  def new
    @post = Post.new(content: params[:content])
  end

  def create
    #新規投稿時、postsテーブルのuser_idカラムに投稿したユーザーの値を加える
    @post = Post.new(content: params[:content],user_id: @current_user.id)
    if @post.save
      redirect_to("/posts/index")
    else
      flash[:notice] = "エラー！：タイトルまたは投稿内容を入力してください"
      redirect_to("/posts/#{@post.id}/new")
    end  
  end

  #投稿の編集
  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to("/posts/index")
    else
      flash[:notice] = "エラー！：タイトルまたは投稿内容を入力してください"
      redirect_to("/posts/#{@post.id}/edit")
    end
  end
  
  #投稿の削除
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    @post.save
    redirect_to("/posts/index")
  end

  #投稿者のみ、投稿の編集/削除ができるようにする
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
