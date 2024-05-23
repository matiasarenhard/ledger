puts "Destroying existing records..."
User.destroy_all
Debt.destroy_all
Person.destroy_all

User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

init = Time.now

def threads(threads_count, &block)
  Array.new(threads_count) do
    Thread.new(&block)
  end.each(&:join)
end

def create_users(number_of_users)
  number_of_users.times do |counter|
    puts "creating user #{counter}"
    User.create email: Faker::Internet.email, password: '111111'
  end
end

def create_debts(person_id)
  debts = Array.new(3) do
    {
      person_id: person_id,
      amount: Faker::Number.between(from: 1, to: 200),
      observation: Faker::Lorem.paragraph 
    }
  end

  Debt.insert_all(debts)
  puts "creating debts"
end

def create_payments(person_id)
  payments = Array.new(3) do
    { 
      person_id: person_id, 
      amount: Faker::Number.between(from: 1, to: 200),
      paid_at: Faker::Date.between(from: 1.year.ago, to: Date.today) 
    }
  end

  Payment.insert_all(payments)
  puts "creating payments"
end

def create_persons(number_of_persons)
  number_of_persons.times do |counter|
    ActiveRecord::Base.transaction do
      puts "creating person #{counter}"

      person = Person.create(
        name: Faker::Name.name,
        phone_number: Faker::PhoneNumber.phone_number,
        national_id: CPF.generate,
        active: [true, false].sample,
        user: User.order('random()').first
      )

      create_debts(person.id)
      create_payments(person.id)
    end  
  rescue ActiveRecord::StatementInvalid => e
    puts "Error: #{e.message}"
    sleep(1)
    retry
  end
end

2.times do
  threads(5) { create_users(1000) }
end

2.times do
  threads(5) { create_persons(2500) }  
end

end_time = Time.now
puts "init: #{init}"
puts "end: #{end_time}"
puts "result: #{(end_time - init) / 60} minutes"
puts "users: #{User.all.size}"
puts "person: #{Person.all.size}"
puts "payments: #{Payment.all.size}"
puts "debts: #{Debt.all.size}"