class RemoveCityZipFromHome < ActiveRecord::Migration
  def self.up
    remove_column :homes, :city
    remove_column :homes, :zip
  end

  def self.down
    add_column :homes, :city, :string
    add_column :homes, :zip, :string
  end
end
