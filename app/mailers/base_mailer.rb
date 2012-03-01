class BaseMailer < ActionMailer::Base
  # include Resque::Mailer
  default :from => Setting.email_sender, :content_type => "text/html", :charset => "utf-8"
  helper :all
  layout "mailer"
  # ActionMailer::Base.default_url_options[:host] = with_subdomain(request.subdomain)
  def self.deliver_delayed(mail)
    begin
      user = User.where(email:mail.to[0].downcase).first
      if user
        user.current_mails ||= []
        user.current_mails << [mail.subject.to_s,mail.body.to_s]
        user.save!
      else
        mail.deliver
      end
    rescue Exception=>e
      p e
    end
  end

end
