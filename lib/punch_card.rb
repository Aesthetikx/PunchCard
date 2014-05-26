require 'sinatra/activerecord'

require_relative './punch_card/punch.rb'
require_relative './punch_card/version.rb'
require_relative './punch_card/web_app/app.rb'

require 'action_view'
include ActionView::Helpers::DateHelper

module PunchCard

  def self.current_git
    `git status`
    if $?.exitstatus == 0
      return Dir.pwd.split("/").last
    end
    nil
  end

  def self.punch_in name
    Punch.create(name: name, time: Time.now, direction: "in")
  end

  def self.punch_out name
    Punch.create(name: name, time: Time.now, direction: "out")
  end

  def self.punch_status name
    if Punch.last.direction == "out"
      puts "PunchCard: not punched in."
    else
      in_punch = Punch.where(name: name, direction: "in").last

      duration = time_ago_in_words(in_punch.time, include_minutes: true)
      puts "PunchCard: punched into #{name} for #{duration}."
    end
  end

  def self.last_duration name
    in_punch = Punch.where(name: name, direction: "in").last
    out_punch = Punch.where(name: name, direction: "out").last

    out_punch.time.to_i - in_punch.time.to_i
  end

end
