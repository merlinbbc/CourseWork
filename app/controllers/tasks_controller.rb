class TasksController < ApplicationController

  before_action :set_task, only: [:show]


  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new(answers: Array.new(5,""))
    @task.section
  end

  def create
    @task = Task.new(task_params)
    @task.author_id = current_user.id
    #binding.pry
    if @task.save
      flash[:success] = "Task was created!"
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = "Task was updated!"
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "Task was destroyed!"
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def show
    @task.section
  end

  private
  def set_task
    @task = Task.find(params[:id]);
  end

  def task_params
    params.require(:task).permit(:title,:text, :rating, :section_id, answers: []);
  end

end
