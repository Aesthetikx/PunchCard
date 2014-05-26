require 'sinatra'
require 'sinatra/activerecord'

require 'punch_card/punch'
require 'punch_card/version'

set :database, {adapter: "sqlite3", database: "punch.sqlite3"}

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

  def self.last_duration name
    in_punch = Punch.where(name: name, direction: "in").last
    out_punch = Punch.where(name: name, direction: "out").last

    out_punch.time.to_i - in_punch.time.to_i
  end

end
