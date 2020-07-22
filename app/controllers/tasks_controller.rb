class TasksController < ApplicationController

def create
  @task = Task.new(user_id: @current_user.id,post_id: params[:post_id])
  @task.save
  redirect_to("/posts/#{params[:post_id]}")
end

def destroy
  @task = Task.find_by(user_id: @current_user.id,post_id: params[:post_id])
  @task.destroy
  redirect_to("/posts/#{params[:post_id]}")
end

end