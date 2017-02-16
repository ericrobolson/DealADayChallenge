# Description: Get the associated purchase data from the most recent import, or all purchase data from the beggining of time
# Functions:
  # last_import_purchases: get the purchase data from the last import
  # all_purchases: get all associated purchase data from the beggining of time
  # revenue: get the calculated total revenue from the loaded purchases
class ImportHistory
  @purchases = nil
  
  # Get the last import's purchase data 
  def last_import_purchases
  	last_import_id = Import.maximum(:id)
  		
  	@purchases = Purchase.joins(:purchaser, :item, :merchant).where(imports_id: last_import_id)
  
  	puts @purchases.count
  
  	return @purchases
  end
  
  # Get all the purchase data
  def all_purchases
  	@purchases = Purchase.joins(:purchaser, :item, :merchant).all
  	
  	return @purchases	
  end
  
  # Get the revenue from the loaded purchases
  def revenue
  	total_revenue = 0.0
  	
  	@purchases.each do |purchase|
  		total_revenue += purchase.item.price * purchase.purchase_count
  	end
    
  	return total_revenue
  end	
end
