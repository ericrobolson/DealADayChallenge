require 'test_helper'
require 'import_validation'

class ImportValidationTest < ActiveSupport::TestCase
  ###################################
  # is_valid_purchase_amount() test #
  ###################################
  
  test "is_valid_purchase_amount() fails empty" do
    data = ''
    
    expected = false
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
  test "is_valid_purchase_amount() fails nil" do
    data = nil
    
    expected = false
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
  test "is_valid_purchase_amount() fails non-numbers"do
    data = 'abc234lk;asdljfkjlvlkjjlk4j5'
    
    expected = false
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
  test "is_valid_purchase_amount() fails negative numbers"do
    data = '-2'
    
    expected = false
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
  test "is_valid_purchase_amount() fails whitespace in middle"do
    data = '1 2'
    
    expected = false
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
  test "is_valid_purchase_amount() fails 0" do
    data = '0'
    
    expected = false
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
  
  test "is_valid_purchase_amount() passes numbers"do
    data = '01234567890'
    
    expected = true
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
    
  test "is_valid_purchase_amount() passes leading whitespace"do
    data = '  4'
    
    expected = true
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
    
  test "is_valid_purchase_amount() passes trailing whitespace"do
    data = '4         '
    
    expected = true
    actual = is_valid_purchase_amount(data)
    
    assert expected == actual
  end
  
  #############################
  # is_valid_currency() tests #
  #############################
  test "is_valid_currency() passes american currency " do
    data = '$200'
    
    expected = true
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  test "is_valid_currency() passes int" do
    data = '999000'
    
    expected = true
    actual = is_valid_currency(data)
    
    assert expected == actual
  end

  test "is_valid_currency() passes 1 decimal place" do
    data = '12345.9'
    
    expected = true
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  test "is_valid_currency() passes leading whitespace" do
    data = '       12345.9'
    
    expected = true
    actual = is_valid_currency(data)
    
    assert expected == actual
  end 
  
  test "is_valid_currency() passes trailing whitespace" do
    data = '12345.9             '
    
    expected = true
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  test "is_valid_currency() passes 2 decimal places" do
    data = '0.92'
    
    expected = true
    actual = is_valid_currency(data)
    
    assert expected == actual
  end

  test "is_valid_currency() fails more than 2 decimal places" do
    data = '0.92000093'
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end

  test "is_valid_currency() fails 3 decimal places" do
    data = '99090.906'
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end

  test "is_valid_currency() fails empty string" do
    data = ''
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  test "is_valid_currency() fails nil" do
    data = nil
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  test "is_valid_currency() fails more than 1 period" do
    data = '00..0011'
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  test "is_valid_currency() fails more than 1 period broken up" do
    data = '1100..0.011..3'
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  
  test "is_valid_currency() fails spaces" do
    data = '777 777'
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
    
  test "is_valid_currency() fails negative numbers" do
    data = '-1'
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end  
  
  test "is_valid_currency() fails non numbers" do
    data = '1222222a'
    
    expected = false
    actual = is_valid_currency(data)
    
    assert expected == actual
  end
  
  ###########################
  # is_valid_string() tests #
  ###########################
  test "is_valid_string() fails empty" do
    data = ''
    
    expected = false
    actual = is_valid_string(data)
    
    assert expected == actual
  end
  
  test "is_valid_string() fails spaces" do
    data = '       '
    
    expected = false
    actual = is_valid_string(data)
    
    assert expected == actual
  end
  
  test "is_valid_string() fails nil" do
    data = nil
    
    expected = false
    actual = is_valid_string(data)
    
    assert expected == actual
  end
  
  test "is_valid_string() passes non-empty string" do
    data = 'abc 123'
    
    expected = true
    actual = is_valid_string(data)
    
    assert expected == actual
  end
end
