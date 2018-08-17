class Club < ActiveRecord::Base
  belongs_to :user

  def self.banned_roles
  ["droid", "ganster"]
  end 
end
