Rails.application.routes.draw do

  #getルーティング：データベースの中身を変更しないアクション（例：index,show,edit,home,top）
  #postルーティング：データベースの中身を変更する・フォームの値を送信するアクション（例：create,update,destroy,login,logout）

  #localhost:3000で、トップページにアクセス（非ログイン時）
  root to: 'home#top'


  #ToDo機能に関するルーティング
  post 'tasks/:post_id/create' => 'tasks#create'
  post 'tasks/:post_id/destroy' => 'tasks#destroy'

  #ユーザー機能（users）に関するルーティング
  get 'users/:id/tasks' => 'users#tasks'
  post 'users/:id/update' => 'users#update'
  get 'users/:id/edit' => 'users#edit'
  post 'users/create' => 'users#create'
  get 'signup' => 'users#new'
  get 'users/index' => 'users#index'
  get 'users/:id' => 'users#show'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  get 'login' => 'users#login_form'

  #投稿（posts）に関するルーティング
  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

  #トップページとアプリ概要ページ（about）に関するルーティング
  get 'home/top'
  get 'home/about'

end
