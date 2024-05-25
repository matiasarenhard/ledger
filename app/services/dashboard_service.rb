class DashboardService
  attr_reader :user, :active_people_ids

  def initialize(user)
    @user = user
    @active_people_ids = active_people_ids
  end

  def call
    {
      active_people_pie_chart: active_people_pie_chart,
      total_debts: debts,
      total_payments: payments,
      balance: balance,
      last_debts: last_debts,
      last_payments: last_payments,
      my_people: my_people,
      top_person: top_person,
      bottom_person: bottom_person
    }
  end

  private

  def debts
    Rails.cache.fetch('debts', expires_in: 10.minutes) do
      Debt.where(person_id: active_people_ids).sum(:amount)
    end  
  end

  def payments
    Rails.cache.fetch('payments', expires_in: 10.minutes) do
      Payment.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def balance
    Rails.cache.fetch('balance', expires_in: 10.minutes) do
      payments - debts
    end
  end

  def my_people
    Person.where(user: user).order(:created_at).limit(10)
  end  

  def last_payments
    Rails.cache.fetch('last_debts', expires_in: 10.minutes) do
      last_payments = Payment.order(created_at: :desc).limit(10).map do |payment|
        [payment.id, payment.amount]
      end
    end 
  end  

  def last_debts
    Rails.cache.fetch('last_debts', expires_in: 10.minutes) do
      last_debts = Debt.order(created_at: :desc).limit(10).map do |debt|
        [debt.id, debt.amount]
      end
    end
  end

  def bottom_person
    Rails.cache.fetch('bottom_person', expires_in: 10.minutes) do
      Person.order(:balance).first
    end
  end  

  def top_person
    Rails.cache.fetch('top_person', expires_in: 10.minutes) do
      Person.order(:balance).last
    end
  end

  def active_people_ids
    Rails.cache.fetch('active_people_ids', expires_in: 10.minutes) do
      Person.where(active: true).select(:id)
    end
  end  

  def active_people_pie_chart
    Rails.cache.fetch('active_people_pie_chart', expires_in: 10.minutes) do
      {
        active: Person.where(active: true).count,
        inactive: Person.where(active: false).count
      }
    end
  end  
end
