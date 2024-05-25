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
    Debt.where(person_id: active_people_ids).sum(:amount)
  end

  def payments
    Payment.where(person_id: active_people_ids).sum(:amount)
  end

  def balance
    payments - debts
  end

  def my_people
    Person.where(user: user).order(:created_at).limit(10)
  end  

  def last_payments
    last_payments = Payment.order(created_at: :desc).limit(10).map do |payment|
      [payment.id, payment.amount]
    end
  end  

  def last_debts
    last_debts = Debt.order(created_at: :desc).limit(10).map do |debt|
      [debt.id, debt.amount]
    end
  end

  def bottom_person
    Person.order(:balance).first
  end  

  def top_person
    Person.order(:balance).last
  end

  def active_people_ids
    Person.where(active: true).select(:id)
  end  

  def active_people_pie_chart
    {
      active: Person.where(active: true).count,
      inactive: Person.where(active: false).count
    }
  end  
end
