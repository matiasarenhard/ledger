require 'csv'
class GenerateCsvReportService
  def call
    CSV.generate do |csv|
      csv << ['Name', 'Email', 'Balance']
      Person.joins(:user).select('users.email', :name, :balance).order(name: :asc).each do |client|
        csv << [client.name, client.email, client.balance]  
      end
    end
  end  
end  
