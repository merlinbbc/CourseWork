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
    else
      flash[:success] = "Task was created!"
      set_dull_boring
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
    Attempt.where({task_id: @task.id}).each do |a|
      a.destroy
    end
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
        attempt = Attempt.new({task_id: @task.id, user_id: current_user.id, attempts_count: 1, status: true })
        attempt.save
      else
        attempt = Attempt.where({ task_id: @task.id, user_id: current_user.id }).first
        attempt.status = true
        attempt.attempts_count += 1
        attempt.save
      end
      user = current_user
      user.rating += @task.rating.to_i * 10 - attempt.attempts_count + 1
      user.save
      set_achievements
      render json: {flag: "correct"}
    else
      if Attempt.where({ task_id: @task.id, user_id: current_user.id }).empty?
        attempt = Attempt.new
        attempt.task_id = @task.id
        attempt.user_id = current_user.id
        attempt.attempts_count += 1
        attempt.save
      else
        attempt = Attempt.where({ task_id: @task.id, user_id: current_user.id }).first
        attempt.attempts_count += 1
        attempt.save
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

  def set_boss_achievement
    if ( current_user.id == User.order(rating: :desc).first.id )
      AchievementsUsers.new({achievement_id: 1, user_id: current_user.id}).save
    end
  end

  def check_achievements(id)
    if AchievementsUsers.where({achievement_id: id, user_id: current_user.id}).empty?
      achievement_user = AchievementsUsers.new({achievement_id: id, user_id: current_user.id})
      achievement_user.save
    else
      achievement_user = AchievementsUsers.where({achievement_id: id, user_id: current_user.id}).first
      if achievement_user.achievement_id != id
        achievement_user.update(achievement_id: id)
      end
    end
  end

  def set_level_achievement
    case Attempt.where({user_id: current_user.id, status: true}).count
      when 2..5
        check_achievements 7
      when 5..10
        check_achievements 8
      when 10..20
        check_achievements 9
      when 20..1000
        check_achievements 10
    end
  end

  def set_type_achievement
    case current_user.rating
      when 100..250
        check_achievements 2
      when 250..500
        check_achievements 3
      when 500..1000
        check_achievements 4
      when 1000..2500
        check_achievements 5
      when 2500..100000
        check_achievements 6
    end
  end

  def set_discover
    if( current_user.id == Attempt.where({status: true}).order(created_at: :desc).first.user_id )
      AchievementsUsers.new({achievement_id: 11, user_id: current_user.id}).save
    end
  end

  def set_achievements
    set_boss_achievement
    set_level_achievement
    set_type_achievement
    set_discover
  end

  def set_dull_boring
    if Task.where({author_id: current_user.id}).count == 10
      AchievementsUsers.new({achievement_id: 12, user_id: current_user.id}).save
    end
  end



end
