class Club < ActiveRecord::Base
  belongs_to :user

  def self.allowed_roles
    ["wizard", "hobbit"]
  end
end
