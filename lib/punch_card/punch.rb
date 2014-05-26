module PunchCard

  class Punch < ActiveRecord::Base

    validates_presence_of :name
    validates_presence_of :time
    validates :direction, inclusion: { in: ["in", "out"] }

  end

end
