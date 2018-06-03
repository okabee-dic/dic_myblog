class ApplicationMailer < ActionMailer::Base
  default from: 'from@myblog.com'
  layout 'mailer'
end
