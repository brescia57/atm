
class Atm
  attr_accessor :funds
  #initialize is a constructor method that will run every time an instance of a class is created
  def initialize
    @funds = 1000
  end
  def withdraw(amount, pin_code, account) 
      #send a message if there are not enough funds
    case
    when insufficient_funds_in_account?(amount, account)
      { status: false, message: 'insufficient funds in account', date: Date.today }
    when insufficient_funds_in_atm?(amount)
      { status: false, message: 'insufficient funds in ATM', date: Date.today }
    when incorrect_pin?(pin_code, account.pin_code)
      { status: false, message: 'wrong pin', date: Date.today }
    else
      perform_transaction(amount, account)
    end
  end
  private
  def insufficient_funds_in_account?(amount, account)
    amount > account.balance
  end
  private
  def insufficient_funds_in_atm?(amount)
    @funds < amount
  end
  private
  def incorrect_pin?(pin_code, actual_pin)
    pin_code != actual_pin
  end
  def perform_transaction(amount, account)
    @funds -= amount
    account.balance = account.balance - amount
    { status: true, message: 'success', date: Date.today, amount: amount }
  end
end
