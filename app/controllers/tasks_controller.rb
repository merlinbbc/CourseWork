class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_task, only: [:show,:update,:edit,:destroy,:decision]

  def tag_cloud
    @tasks = Task.tag_counts_on(:tags)
  end

  def index
    if params[:tag]
      @tasks = Task.tagged_with(params[:tag]).order(created_at: :desc).page(params[:page]).per(5)
    else
      @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def user_task
    @tasks = Task.where({author_id: current_user.id}).order(created_at: :desc).page(params[:page]).per(5)

  end

  def new
    @task = Task.new(answers: Array.new())
    @task.section
  end

  def create

    @task = Task.new(task_params)
    @task.author_id = current_user.id
    if @task.section_id == nil or !@task.save or @task.answers == [""]
      flash[:danger] = "Task wasn't created!"
      render 'new'
    #binding.pry
    else
      flash[:success] = "Task was created!"
      redirect_to @task
    end
  end

  def update
    if task_params[:answers] == nil
      flash[:danger] = "Task wasn't updated!"
      render 'edit'
    elsif @task.answers.count > task_params[:answers].count or true
      @task.answers = ""
      @task.update(task_params)
      flash[:success] = "Task was updated!"
      redirect_to @task
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Task was destroyed!"
    redirect_to tasks_path
  end

  def edit
  end

  def show
  end

  def decision
    if @task.answers.include?(params[:answer])
      if Attempt.where({ task_id: @task.id, user_id: current_user.id }).empty?
        #new_attempt true
        @attempt = Attempt.new
        @attempt.task_id = @task.id
        @attempt.user_id = current_user.id
        @attempt.attempts_count += 1
        @attempt.status = true
        @attempt.save
      else
        #update_attempt true
        @attempt = Attempt.where({ task_id: @task.id, user_id: current_user.id }).first
        @attempt.status = true
        @attempt.attempts_count += 1
        @attempt.save
      end
      @user = current_user
      @user.rating += @task.rating.to_i * 10 - @attempt.attempts_count + 1
      @user.save
      render json: {flag: "correct"}
    else
      if Attempt.where({ task_id: @task.id, user_id: current_user.id }).empty?
        #new_attemt false
        @attempt = Attempt.new
        @attempt.task_id = @task.id
        @attempt.user_id = current_user.id
        @attempt.attempts_count += 1
        @attempt.save
      else
        #update_attempt false
        @attempt = Attempt.where({ task_id: @task.id, user_id: current_user.id }).first
        @attempt.attempts_count += 1
        @attempt.save
      end
      render json: {flag: "incorect"}
    end
  end

  def marks
    if !(params[:mark].to_i < 1 or params[:mark].to_i > 10)
      @task = Task.find(params[:id])
      @attempt = Attempt.where({ task_id: @task.id, user_id: current_user.id }).first
      @task.mark = (@task.mark * @task.number_of_marks.to_f + params[:mark].to_f) / (@task.number_of_marks.to_f + 1.to_f )
      @task.number_of_marks += 1
      @attempt.set_mark = true
      @task.save
      @attempt.save
      render json: {flag: "correct"}
    else
      render json: {flag: "incorrect"}
    end
  end


  private
  def set_task
    @task = Task.find(params[:id]);
  end

  def task_params
    params.require(:task).permit(:title,:text, :rating, :section_id, :tag_list, answers: []);
  end

  def new_attempt(st)
    #binding.pry
    @attempt = Attempt.new
    @attempt.task_id = @task.id
    @attempt.user_id = current_user.id
    @attempt.attempts_count += 1
    @attempt.status = true if st
    @attempt.save
  end

  def update_attempt(st)
    @attempt = Attempt.where({ task_id: @task.id, user_id: current_user.id }).first
    @attempt.status = true if st
    @attempt.attempts_count += 1
    @attempt.save
  end




end
