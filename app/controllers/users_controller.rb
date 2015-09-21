class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_action :set_user, only: [:show,:update,:edit]
  respond_to :html, :json

  def index
    @users = User.limit(10).order(rating: :desc)
    @tasks = Task.limit(10).order(mark: :desc)
  end

  def show

  end

  def edit

  end

  def update
    @user.update(user_params)
    respond_with @user
  end


  def check_achievement(n)
    case n
      when 0
        if !AchievementsUsers.where({user_id: current_user.id, achievement_id: 1}).empty?
          return generate_medal generate_label_boss
        else
          false
        end
      when 1
        if !((a=AchievementsUsers.where({user_id: current_user.id, achievement_id: 2..6})).empty?)
          return generate_medal_inventor generate_label_inventor Achievement.where({id: a.first.achievement_id}).first.name
        else
          false
        end
      when 2
        if !((a=AchievementsUsers.where({user_id: current_user.id, achievement_id: 7..10})).empty?)
          return generate_medal_inventor generate_label_inventor Achievement.where({id: a.first.achievement_id}).first.name
        else
          false
        end
      when 3
        if !AchievementsUsers.where({user_id: current_user.id, achievement_id: 11}).empty?
          return generate_medal generate_label_discoverer
        else
          false
        end
      when 4
        if !AchievementsUsers.where({user_id: current_user.id, achievement_id: 12}).empty?
          return generate_medal generate_label_taskman
        else
          false
        end
    end
  end

  def generate_label_boss
    image = MiniMagick::Image.new("achievement_images/1.png")
    label = MiniMagick::Image.new("achievement_images/boss.png")
    image = image.composite(label) do |cc|
      cc.compose "Over"
      cc.background "transparent"
      cc.pointsize "30"
      cc.geometry "+110+5"
      cc.label number_for_label 1
    end
  end

  def generate_label_discoverer
    image = MiniMagick::Image.new("achievement_images/1.png")
    label = MiniMagick::Image.new("achievement_images/discoverer.png")
    image = image.composite(label) do |cc|
      cc.compose "Over"
      cc.background "transparent"
      cc.pointsize "17"
      cc.geometry "+115+2"
      cc.label number_for_label 11
    end
  end

  def generate_medal(image)
    label = MiniMagick::Image.new("achievement_images/2.png")
    label = label.composite(image) do |cc|
      cc.compose "Over"
      cc.geometry "+100+90"
    end
  end

  def number_for_label(id)
    AchievementsUsers.where({user_id: current_user.id, achievement_id: id}).count.to_s
  end

  def generate_medal_inventor(image)
    label = MiniMagick::Image.new("achievement_images/2.png")
    label = label.composite(image) do |cc|
      cc.compose "Over"
      cc.geometry "+120+85"
    end
  end

  def generate_label_inventor(text)
    image = MiniMagick::Image.new("achievement_images/1.png")
    label = MiniMagick::Image.new("achievement_images/inventor.png")
    image = image.composite(label) do |cc|
      cc.compose "Over"
      cc.background "transparent"
      cc.pointsize "20"
      cc.geometry "+0+0"
      cc.label text.sub(" ","\n")
    end
  end

  def generate_label_taskman
    image = MiniMagick::Image.new("achievement_images/1.png")
    label = MiniMagick::Image.new("achievement_images/inventor.png")
    image = image.composite(label) do |cc|
      cc.compose "Over"
      cc.background "transparent"
      cc.pointsize "25"
      cc.geometry "+0+0"
      cc.label "Dull boring"
    end
  end


  def generate_achievements_image
    number = 0
    coordinate = 0
    image = MiniMagick::Image.open("achievement_images/1.png")
    while number < 5
      if (medal=check_achievement number)
        image = image.composite(medal) do |c|
          c.compose "Over"    # OverCompositeOp
          c.geometry "+"+(333*coordinate).to_s+"+50" # copy second_image onto first_image from (20, 20)
        end
        coordinate+=1
      end
      number+=1
    end
    #image.resize "800x200>"
    image.write("app/assets/images/" + current_user.email + ".png")
    render json: { flag: "good" , email: current_user.email }
  end

  private
  def set_user
    @user = User.find(params[:id]);
  end

  def user_params
    params.require(:user).permit(:nickname, :locale);
  end



end
