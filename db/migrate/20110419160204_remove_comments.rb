class RemoveComments < ActiveRecord::Migration
  def self.up
    drop_table :comments
  end

  def self.down
    #No way back. Disqus is the way of the future.
  end
end
