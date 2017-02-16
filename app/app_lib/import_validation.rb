# Eric Olson - Renewable challenge

# Description: Check that a string is valid
# Parameters:
  # str: the string to validate
# Returns: A bool for whether it is a non-empty string; invalid if only whitespace
def is_valid_string(str)
  # valid inputs:
  # anything other than ''
  
  # invalid inputs:
  # ''

  if (str.nil? || str.to_s.strip.length == 0)
    return false
  end
  
  return true
end

# Description: Check that a currency is valid
# Parameters;
  # currency: the value to check for a valid currency
# Returns: A bool for whether the currency is actually valid
def is_valid_currency(currency)
  # valid inputs:
  # $200
  # 200
  # 200.0
  # 300.01
  
  # invalid inputs:
  # .0001
  # ''
  # '0..0'
  # '777 777'
  # -1

  str_currency = currency.to_s.strip

  # If it's only whitespace, it's invalid
  if (str_currency.strip.length == 0)
    return false
  end
  
  # If the first character is a '$', remove it as it's valid
  if (str_currency[0] == '$')
    str_currency = str_currency[1..-1]
  end 
    
  # If str contains more than one period, it's an error
  if (str_currency.count('.') > 1)
    return false
  end
    
  # If str contains anything other than number and ., it's invalid
  if (str_currency =~ /[^0-9\.]/)
    return false
  end
        
  # If str contains more than two decimal places, it's invalid  
  if (str_currency.count('.') > 0)
    decimal_places = str_currency.split('.')[1]
    if (decimal_places.length > 2)
      return false
    end
  end
    
  return true
end

# Description: Check that a purchase amount is valid
# Parameters;
  # i: the value to check for a purchase amount
# Returns: A bool for whether the purchase amount is actually valid
def is_valid_purchase_amount(i)
  str_int = i.to_s.strip

  # Whitespace is invalid
  if (str_int.length == 0)
    return false
  end

  # If str contains anything other than number, it's invalid
  if (str_int =~ /[^0-9]/)
    return false
  end
  
  # Purchase of 0 items is invalid
  if (str_int == "0")
    return false
  end

  return true
end
