module UsersHelper

  def get_achiv_boss
    AchievementsUsers.where({user_id: current_user.id, achievement_id: 1}).count
  end

  def get_inventor_level
    @ach = AchievementsUsers.where({user_id: current_user.id, achievement_id: 2..6}).first
     if !@ach
       return 0
     else @ach.achievement_id
     end
  end

  def get_inventor_type
    @ach = AchievementsUsers.where({user_id: current_user.id, achievement_id: 7..10}).first
    if !@ach
      return 0
    else @ach.achievement_id
    end
  end

  def get_achievement_name(id)
    Achievement.find_by_id(id).name
  end

  def get_discoverer
    AchievementsUsers.where({user_id: current_user.id, achievement_id: 11}).count
  end

  def set_name(id)
    str = "inventor" + id.to_s + ".jpg"
    return str
  end

  def check_dull_boring
    AchievementsUsers.where({user_id: current_user.id, achievement_id: 12}).empty?
  end









end
