class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string  :topic
      t.string  :description
      t.string  :speaker
      t.integer :seat_count, :default => 0
      t.date    :event_date
      t.time    :start_time
      t.time    :end_time


      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
