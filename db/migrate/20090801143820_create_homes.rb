class CreateHomes < ActiveRecord::Migration
  def self.up
    create_table :homes do |t|
      t.integer :mls_number
      t.integer :price
      t.integer :square_feet
      t.boolean :short_sale
      t.string :address
      t.string :city
      t.string :zip
      t.boolean :favorite

      t.timestamps
    end
  end

  def self.down
    drop_table :homes
  end
end
