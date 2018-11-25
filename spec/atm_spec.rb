
require './lib/atm.rb'
describe Atm do
  it 'has 1000$ on initialize' do
    expect(subject.funds).to eq 1000
  end
  it 'funds are reduced at withdraw' do
    subject.withdraw 50
    expect(subject.funds).to eq 950
  end
end
