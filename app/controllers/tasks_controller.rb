class TasksController < ApplicationController

  before_action :set_task, only: [:show]

  def new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @tasks = Task.all
  end

  private
  def set_task
    @task = Task.find(params[:id]);
  end

  def task_params
    params.require(:task).permit(:title,:text, :rating);
  end

end
