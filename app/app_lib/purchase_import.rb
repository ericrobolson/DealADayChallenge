# Eric Olson - Renewable challenge

require 'import_validation'

# Description: Generate an preformatted error message given certain inputs
# Parameters:
  # row_index: The row that the error occured on
  # field: the field that had the error
  # invalid_value: the value that was invalid
  # expected_value: the expected value
# Return value: Returns a preformatted string telling the user what went wrong
def generate_error_message(row_index, field, invalid_value, expected_value)
  return ": Row #" + row_index.to_s + "; " + field + " value '" + invalid_value.to_s + "' should be a " + expected_value + "."
end

# Description: Manage a purchase and all associated content
# Functions:
    # initialize: Initialize a new purchase with the given objects
    # save: Save all associated objects and then create and save the purchase
class PurchaseContainer
  @purchaser = nil
  @item = nil
  @merchant = nil
  @purchase_count = 0
  
  # Initialize a new object with the given objects
  def initialize(purchaser, item, merchant, purchase_count)
    @purchaser = purchaser
    @item = item
    @merchant = merchant
    @purchase_count = purchase_count
  end
  
  # Save the purchase and all associated objects to the database
  def save(import_id)
    # Save or load the associated data for the purchase
    @purchaser = Purchaser.where(name: @purchaser.name).first_or_create
    @item = Item.where(description: @item.description, price: @item.price).first_or_create
    @merchant = Merchant.where(name: @merchant.name, address: @merchant.address).first_or_create
        
    purchase = Purchase.new
    
    purchase.purchase_count = @purchase_count
    purchase.purchasers_id = @purchaser.id
    purchase.items_id = @item.id
    purchase.merchants_id = @merchant.id
    purchase.imports_id = import_id
    
    purchase.save
  end
end

# Description: The class to keep track of purchases and to import purchases
# Functions:
  # has_error(): Returns whether there was an error with the import
  # save(): Saves the created import to the database and returns the ID of it
  # import(): Attempts to import the CSV file and create all objects
# Fields:
  # errors: The messages given by the importer if there were errors
class PurchaseImport
  @file_name = ""
  @time_run = ""
  @has_error = false
  @imported = false
  @purchases = Array.new
  @errors = Array.new
  
  def has_error  
    if (@has_error || (!@errors.nil? && @errors.count > 0))
      return true;
    end
    
    return false
  end
    
  def errors
    return @errors
  end
  
  # Save the import
  def save
    # Save the import and purchases
    import = Import.new
    import.time_run = @time_run
    import.import_file = @file_name
    
    import.save
    
    # Go through all purchases and save them
    @purchases.each do |purchase|
      purchase.save(import.id)        
    end
  end
    
  #  Import the given CSV file, validating all purchases
  def import(csv_file, file_name)
    @time_run = Time.now.getutc
    @purchases = Array.new
    @errors = Array.new
    @file_name = file_name
    
    # If file_name is nil or empty, give an error
    if (file_name.nil? || file_name.length == 0)
      @has_error = true
      @errors.push("Please provide a file.")
      
      return
    end
        
    # If file_name does not have a .csv extension, give an error
    if (file_name.split('.').last != 'csv')
      @has_error = true
      @errors.push("Please provide a .CSV file.")
      
      return
    end
    
    # If the file is nil, give an error
    if (csv_file.nil?)
      @has_error = true
      @errors.push("Please provide a non-null file.")
      
      return
    end
    
    # Create and validate the purchases
    row_index = 0
    csv_file.each do |row|
      # Skip the header row
      if (row_index == 0)
        row_index +=1
        next
      end
          
      purchaser_name = row[0]
      item_description = row[1]
      item_price = row[2]
      purchase_count = row[3]
      merchant_address = row[4]
      merchant_name = row[5]
          
      # Validate purchaser name
      if (!is_valid_string(purchaser_name))
        @has_error = true
        @errors.push(generate_error_message(row_index, "purchaser name", purchaser_name, "non-empty string"))
        
        next
      end
      
      # Validate item_description
      if (!is_valid_string(item_description))
        @has_error = true
        @errors.push(generate_error_message(row_index, "item description", item_description, "non-empty string"))
        
        next
      end
      
      # Validate merchant_address
      if (!is_valid_string(merchant_address))
        @has_error = true
        @errors.push(generate_error_message(row_index, "merchant address", merchant_address, "non-empty string"))
        
        next
      end
            
      # Validate merchant_name
      if (!is_valid_string(merchant_name))
        @has_error = true
        @errors.push(generate_error_message(row_index, "merchant name", merchant_name, "non-empty string"))
        
        next
      end
      
      # Validate item_price
      if (!is_valid_currency(item_price))
        @has_error = true
        @errors.push(generate_error_message(row_index, "item price", item_price, "non-empty, valid American currency (e.g. $4.00, 5.04, 4.0, or 3000)"))
        
        next
      end
      
      # Validate purchase_count
      if (!is_valid_purchase_amount(purchase_count))
        @has_error = true
        @errors.push(generate_error_message(row_index, "purchase count", purchase_count, "non-empty, positive, valid integer greater than 0"))
        
        next
      end

      # Create the purchaser
      purchaser = Purchaser.new
      purchaser.name = purchaser_name

      # Create the item
      item = Item.new
      item.description = item_description
      item.price = item_price
    
      # Create the merchant
      merchant = Merchant.new
      merchant.address = merchant_address
      merchant.name = merchant_name
      
      # Create the purchase container
      purchase = PurchaseContainer.new(purchaser, item, merchant, purchase_count)
          
      # Add the purchase to the purchases
      @purchases.push(purchase)
      
      row_index += 1
    end
    
    # If no purchases were imported, then it has an error
    if (@purchases.nil? || @purchases.length == 0 && !@has_error)
      @has_error = true;
      @errors.push("No records to import.")
      
      return
    end
    
    @imported = true
  end
end
