class CreateConferencesUsers < ActiveRecord::Migration
  def self.up
    create_table :conferences_users, :id => false do |t|
      t.references :conference
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :conferences_users
  end
end
