require 'test_helper'
require 'purchase_import'
require 'csv'

class PurchaseImportTest < ActiveSupport::TestCase
  
  # open a csv file
  def get_csv_file(f)
    file_stream = File.new('test/csv_test_files/' + f)
    csv = CSV.new(file_stream.read)
    
    return csv
  end
  
  # open a valid csv file
  def get_valid_csv
    return get_csv_file('valid_csv.csv')
  end
  
  # open a invalid csv file with only headers
  def get_invalid_csv_no_header
    return get_csv_file('invalid_csv_only_header.csv')
  end
  
  # open a invalid csv file with no purchaser
  def get_invalid_csv_no_purchaser
    return get_csv_file('invalid_csv_invalid_purchaser.csv')
  end
  
  # open a invalid csv file with invalid item description
  def get_invalid_csv_invalid_item_description
    return get_csv_file('invalid_csv_invalid_item_description.csv')
  end
  
  # open a invalid csv file with invalid item price
  def get_invalid_csv_invalid_item_price
    return get_csv_file('invalid_csv_invalid_item_price.csv')
  end
  
  # open a invalid csv file with invalid purchase count
  def get_invalid_csv_invalid_purchase_count
    return get_csv_file('invalid_csv_invalid_purchase_count.csv')
  end
  
  # open a invalid csv file with invalid merchant address
  def get_invalid_csv_invalid_merchant_address
    return get_csv_file('invalid_csv_invalid_merchant_address.csv')
  end
  
  # open a invalid csv file with invalid merchant name
  def get_invalid_csv_invalid_merchant_name
    return get_csv_file('invalid_csv_invalid_merchant_name.csv')
  end
  
  # open a valid csv file with 1000 records
  def get_valid_csv_massive
    return get_csv_file('valid_csv_mega_massive.csv')
  end
    
  ########################
  # PurchaseImport tests #
  ########################
  test "PurchaseImport.import() nil file" do
    i = PurchaseImport.new
        
    expected = true
    expected_error = "Please provide a non-null file."  
    
    i.import(nil, "test.csv")
    
    actual = i.has_error && i.errors.include?(expected_error)
            
    assert expected == actual
  end
  
  test "PurchaseImport.import() only header has error" do
    import = PurchaseImport.new
        
    expected = true
    
    import.import(get_invalid_csv_no_header, "test.csv")
            
    actual = import.has_error
        
    assert expected == actual
    
  end

  test "PurchaseImport.import() only header error msg" do
    import = PurchaseImport.new
        
    expected = true
    expected_error = "No records to import."
    
    import.import(get_invalid_csv_no_header, "test.csv")
            
    actual = import.errors.include?(expected_error)
        
    msg = import.errors.first.to_s
        
    assert expected == actual
    
  end 
  
  test "PurchaseImport.import() valid file has no errors" do
    import = PurchaseImport.new
        
    expected = false
            
    import.import(get_valid_csv, "test.csv")
            
    actual = import.has_error
        
    assert expected == actual
    
  end
  
  test "PurchaseImport.import() nil file name has error" do
    import = PurchaseImport.new
    
    expected = true
    expected_error = "Please provide a file."
        
    import.import(get_valid_csv, nil)
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() empty file name has error" do
    import = PurchaseImport.new
    
    expected = true
    expected_error = "Please provide a file."
    
    import.import(get_valid_csv, '')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() non-csv file name has error" do
    import = PurchaseImport.new
    
    expected = true
    expected_error = "Please provide a .CSV file."
    
    import.import(get_valid_csv, 'test.file')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() invalid purchaser name has error" do
    import = PurchaseImport.new
      
    expected = true
    expected_error = ": Row #1; purchaser name value '' should be a non-empty string."
    
    import.import(get_invalid_csv_no_purchaser, 'test.csv')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() invalid item description" do
    import = PurchaseImport.new
      
    expected = true
    expected_error = ": Row #1; item description value '' should be a non-empty string."
    
    import.import(get_invalid_csv_invalid_item_description, 'test.csv')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() invalid item price" do
    import = PurchaseImport.new
      
    expected = true
    expected_error = ": Row #1; item price value ' 1hjjhjhjhjh' should be a non-empty, valid American currency (e.g. $4.00, 5.04, 4.0, or 3000)."
    
    import.import(get_invalid_csv_invalid_item_price, 'test.csv')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() invalid purchase count" do
    import = PurchaseImport.new
      
    expected = true
    expected_error = ": Row #1; purchase count value ' jajaja ' should be a non-empty, positive, valid integer greater than 0."
    
    import.import(get_invalid_csv_invalid_purchase_count, 'test.csv')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() invalid merchant address" do
    import = PurchaseImport.new
      
    expected = true
    expected_error = ": Row #1; merchant address value '' should be a non-empty string."
    
    import.import(get_invalid_csv_invalid_merchant_address, 'test.csv')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() invalid merchant name" do
    import = PurchaseImport.new
      
    expected = true
    expected_error = ": Row #1; merchant name value '' should be a non-empty string."
    
    import.import(get_invalid_csv_invalid_merchant_name, 'test.csv')
    
    actual = import.has_error && import.errors.include?(expected_error)
        
    assert expected == actual
  end
  
  test "PurchaseImport.import() valid massive file no errors" do
    import = PurchaseImport.new
      
    expected = false
    
    import.import(get_valid_csv_massive, 'test.csv')
    
    actual = import.has_error
    
    assert expected == actual
  end
  
  ################################
  # generate_error_message tests #
  ################################
  test "generate_error_message() generates properly" do
    row_index = 2
    field = 'test field' 
    invalid_value = 'invalid value'
    expected_value = 'expected value'
    
    
    expected = ": Row #" + row_index.to_s + "; " + field + " value '" + invalid_value + "' should be a " + expected_value + "."
    
    actual = generate_error_message(row_index, field, invalid_value, expected_value)
    
    assert expected == actual
  end
end
