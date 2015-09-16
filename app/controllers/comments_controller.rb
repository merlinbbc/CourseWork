class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    #@task = Task.find(params[:task_id])
    @comment = current_user.comments.create(comment_params)
    @comment.save
    id = @comment.id
    render json: {text: @comment.this_comment, email: current_user.email, id: id}
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    id = @comment.id
    @comment.destroy
    render json: {id: id}
  end

  private
  def comment_params
    params.require(:comment).permit(:this_comment, :task_id)
  end

end
