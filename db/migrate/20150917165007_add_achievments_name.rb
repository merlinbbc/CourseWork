class AddAchievmentsName < ActiveRecord::Migration
  def up
    Achievement.create(name: "Boss")
    Achievement.create(name: "Inventor 1st level")
    Achievement.create(name: "Inventor 2nd level")
    Achievement.create(name: "Inventor 3rd level")
    Achievement.create(name: "Inventor 4th level")
    Achievement.create(name: "Inventor 5th level")
    Achievement.create(name: "Inventor: kindergarten")
    Achievement.create(name: "Inventor: schoolboy")
    Achievement.create(name: "Inventor: student")
    Achievement.create(name: "Inventor: professor")
    Achievement.create(name: "Discoverer")
    Achievement.create(name: "Dull boring")
  end
end
