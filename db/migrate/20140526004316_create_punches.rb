class CreatePunches < ActiveRecord::Migration
  def change
    create_table :punches do |t|
      t.string :name
      t.timestamp :time
      t.string :direction
    end
  end
end
