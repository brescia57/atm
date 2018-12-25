require 'date'
class Account
  attr_accessor :balance, :account_status, :owner
  attr_reader :pin_code, :exp_date
  STANDARD_VALIDITY_YRS = 5



  def initialize(attrs = {})
    @account_status = :active
    @pin_code = generate_pin
    @balance = attrs[:balance] || 0
    @exp_date = set_exp_date
    @owner = set_owner(attrs[:owner])
  end

  def deactivate
    #object.deactivate
    @account_status = :deactivated
  end

  private

  def set_exp_date
    Date.today.next_year(Account::STANDARD_VALIDITY_YRS).strftime('%m/%Y')
  end

  def generate_pin
    rand(1000..9999)
  end

  def set_owner(obj)
    obj == nil ? missing_owner : @owner = obj
  end

  def missing_owner
    raise 'An Account owner is required'
  end
end
