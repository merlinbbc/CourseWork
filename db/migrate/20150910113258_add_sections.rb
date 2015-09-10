class AddSections < ActiveRecord::Migration
  def up
    Section.create(name: "Ruby")
    Section.create(name: "Python")
    Section.create(name: "C#")
    Section.create(name: "Java")

  end
end
