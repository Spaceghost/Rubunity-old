class CreateConferences < ActiveRecord::Migration
  def self.up
    create_table :conferences do |t|
      t.string :name
      t.string :speaker
      t.datetime :startdate
      t.datetime :enddate
      t.integer :seats
      t.text :description
      t.string :permalink
      t.timestamps
    end
  end

  def self.down
    drop_table :conferences
  end
end
