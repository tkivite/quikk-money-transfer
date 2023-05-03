class TransactionMailer < ApplicationMailer
  default from: ''
  def send_csv(email, csv_data)
    attachments['transactions.csv'] = csv_data
    mail(to: email, subject: 'Transactions CSV')
  end
end
