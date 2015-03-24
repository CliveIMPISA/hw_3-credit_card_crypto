# Luhn Validator modulerese
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct

  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    nums_a = nums_a.reverse
    account_number = nums_a.drop(1)
    sum = 0
    counter = 1
    valid = true
    account_number.each do |p|
      if counter.even?
        sum += p
      else
        if (p * 2) > 9
          sum += (p * 2).to_s.chars.map(&:to_i).inject(:+)
        else
          sum += (p * 2)
        end
      end
      counter += 1
    end
    sum *= 9

    if sum % 10 == nums_a.first
      valid = true
    else
      valid = false
    end
    # TODO: use the integers in nums_a to validate its last check digit
    valid
  end
end
