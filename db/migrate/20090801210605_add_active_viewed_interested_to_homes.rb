class AddActiveViewedInterestedToHomes < ActiveRecord::Migration
  def self.up
    add_column :homes, :active, :boolean
    add_column :homes, :viewed, :date
    add_column :homes, :interested, :boolean
  end

  def self.down
    remove_column :homes, :interested
    remove_column :homes, :viewed
    remove_column :homes, :active
  end
end
