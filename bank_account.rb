
class BankAccount

  @@interest_rate = 0.02
  @@accounts = []

  def initialize
    @balance = 0
  end

  def self.create
    my_account = BankAccount.new
    @@accounts << my_account
      # puts @@accounts
    return my_account
  end

  #Attribute Readers (getter)
  def balance
      @balance
  end

  #Attribute Writers (setter)
  def balance=(balance)
      @balance = balance
  end

  #Instance methods
  def deposit(balance)
    @balance += balance
  end

  def withdraw(balance)
    @balance -= balance
  end

  def self.total_funds
    total_funds = 0
    @@accounts.each do |account|
              total_funds += account.balance
            end
      return total_funds
  end

  def self.interest_time

     @@accounts.each do |account|
              account.balance = account.balance * (1 + @@interest_rate)
            end
  end

end

# my_bank_account = Bank.new
#
# my_account = BankAccount.new
# your_account = BankAccount.new

# puts BankAccount.create

rbc_account = BankAccount.create
td_account = BankAccount.create
# puts rbc_account.balance
# puts td_account.balance
# puts BankAccount.total_funds
rbc_account.deposit(200)
td_account.deposit(1000)
# puts rbc_account.balance
# puts td_account.balance
puts BankAccount.total_funds

BankAccount.interest_time
puts rbc_account.balance # 202.0
puts td_account.balance # 1010.0
puts BankAccount.total_funds # 1212.0

rbc_account.withdraw(50)
puts rbc_account.balance # 152.0
puts BankAccount.total_funds # 1162.0
