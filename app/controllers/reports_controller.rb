class ReportsController < ApplicationController

  def balance
    ReportsMailer.run(current_user.email).deliver_later
    redirect_to root_path, notice: 'Você receberá o relatório por e-mail em breve.'
  end
end
