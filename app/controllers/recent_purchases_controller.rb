class RecentPurchasesController < ApplicationController
  def index
    import_history = ImportHistory.new
  
    @purchases = import_history.last_import_purchases
	
    @total_revenue = import_history.revenue	
  end    
end
