class AlterLinksAddWorking < ActiveRecord::Migration
  def self.up
    add_column :links, :working, :boolean, :default => false
  end

  def self.down
    remove_column :links, :working
  end
end
