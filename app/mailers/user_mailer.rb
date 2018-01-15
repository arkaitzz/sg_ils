class UserMailer < ActionMailer::Base
  default :from => "no-reply@euskal-gorrak.org"

  def forgot_password(user, key)
    @user, @key = user, key
    @app_name = APP_NAME 
    mail( :subject => "[#{@app_name}] #{I18n.t('mailers.user.forgoten_password')}",
          :to      => user.email_address )
  end

  def new_user(user, key)
    @user, @key = user, key
    @app_name = APP_NAME 
    mail( :subject => "[#{@app_name}] #{I18n.t('mailers.user.new_user')}",
          :to      => user.email_address )
  end

end
