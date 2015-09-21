module TasksHelper
  include ActsAsTaggableOn::TagsHelper

  def get_author_email_or_nick(id)
    user = User.where({id: id}).first
    if user.nickname == ""
      return user.email
    else
      return user.nickname
    end
  end

  def check_on_set_task(task)
    return ((Attempt.where({user_id: current_user.id, task_id: task.id})).empty? or (Attempt.where({user_id: current_user.id, task_id: task.id})).last.set_mark)
  end

  def get_solved(id)
    Attempt.where({ task_id: id, status: true }).count
  end

  def get_unsolved(id)
    Attempt.where({ task_id: id, status: false }).count
  end

  def check_answer
    Attempt.where({ task_id: @task.id, user_id: current_user.id }).empty? or !(Attempt.where({ task_id: @task.id, user_id: current_user.id })).last.status
  end

  def check_mark
    (Attempt.where({ task_id: @task.id, user_id: current_user.id })).last.status and
        current_user.id != @task.author_id and
        !(Attempt.where({ task_id: @task.id, user_id: current_user.id })).last.set_mark
  end



end
