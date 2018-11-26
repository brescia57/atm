
require './lib/atm.rb'
require 'date'
describe Atm do
  let(:account){ instance_double('Account', pin_code: '1234') }
  before do
    # Before each test, add an attribute of balance
    #to the account object and set value
    allow(account).to receive(:balance).and_return(100)
    #allow account to receive balance with setter method 'balance='
    allow(account).to receive(:balance=)
  end
  it 'has 1000$ on initialize' do
    expect(subject.funds).to eq 1000
  end
  it 'funds are reduced at withdraw' do
    subject.withdraw(50,'1234', account)
    expect(subject.funds).to eq 950
  end
  it 'allow withdraw if account has enough balance.' do
    expected_output = { status: true, message: 'success', date: Date.today, amount: 45 }
    expect(subject.withdraw(45,'1234', account)).to eq expected_output
  end
  it 'reject withdraw if account has insufficient funds' do
    expected_output = { status: false, message: 'insufficient funds in account', date: Date.today }
    expect(subject.withdraw(105,'1234', account)).to eq expected_output
  end
  it 'reject withdraw if ATM has insufficient funds' do
    subject.funds = 50
    expected_output = { status: false, message: 'insufficient funds in ATM', date: Date.today }
    expect(subject.withdraw(100,'1234', account)).to eq expected_output
  end
  it 'reject withdraw if pin is wrong' do
    expected_output = { status: false, message: 'wrong pin', date: Date.today }
    expect(subject.withdraw(50, 9999, account)).to eq expected_output
  end

end
