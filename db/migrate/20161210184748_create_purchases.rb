class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.integer :purchase_count

	  t.references :purchasers
	  t.references :items
	  t.references :merchants
	  t.references :imports
	  
      t.timestamps
    end
  end
end
