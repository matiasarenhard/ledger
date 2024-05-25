class ReportsMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def run(email) 
    attachments['report.csv'] = {
      mime_type: 'text/csv',
      content: GenerateCsvReportService.new.call
    }

    mail(to: email, subject: 'CSV com informações do usuário', body: 'Em anexo segue o csv com as informações dos usuários.')
  end
end
