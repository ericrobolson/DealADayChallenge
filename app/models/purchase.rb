class Purchase < ApplicationRecord
  belongs_to :purchaser, :foreign_key => 'purchasers_id'
  belongs_to :item, :foreign_key => 'items_id'
  belongs_to :merchant, :foreign_key => 'merchants_id'
  belongs_to :import, :foreign_key => 'imports_id'
end
