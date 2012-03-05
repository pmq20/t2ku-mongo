class DeviseMailer < Devise::Mailer
  default :sender => Setting.email_sender
  layout "mailer"
end