class AddPurchaseForeignKeys < ActiveRecord::Migration[5.0]
  def change
	
	  add_foreign_key :purchases, :imports
	  add_foreign_key :purchases, :purchasers
	  add_foreign_key :purchasers, :items
	  add_foreign_key :purchasers, :merchants
	  
  end
end
