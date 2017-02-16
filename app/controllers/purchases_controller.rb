class PurchasesController < ApplicationController
  def index
    import_history = ImportHistory.new
    
    @purchases = import_history.all_purchases
    
    @total_revenue = import_history.revenue	
  end    
end
