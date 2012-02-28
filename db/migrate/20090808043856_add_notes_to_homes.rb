class AddNotesToHomes < ActiveRecord::Migration
  def self.up
    add_column :homes, :notes, :text
  end

  def self.down
    remove_column :homes, :notes
  end
end
