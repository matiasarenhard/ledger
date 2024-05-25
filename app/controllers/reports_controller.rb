class ReportsController < ApplicationController

  def balance
    ReportsMailer.run(current_user.email).deliver_now
    redirect_to root_path, notice: 'Não implementado'
  end
end
