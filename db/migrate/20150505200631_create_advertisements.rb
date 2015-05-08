class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
	  t.integer :type
      t.string :currency
      t.float :course
	  t.integer :sum
      t.string :region
      t.string :tel      
	  t.timestamps null: false
    end
  end
end
