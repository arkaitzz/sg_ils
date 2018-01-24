class UserMailer < ActionMailer::Base
  default :from => FROM_EMAIL

  def forgot_password(user, key)
    @user, @key = user, key
    @app_name = APP_NAME 
    mail( :subject => "[#{@app_name}] #{I18n.t('mailers.user.forgoten_password')}",
          :to      => user.email_address )
  end

  def new_user(user)
    @user = user
    @app_name = APP_NAME 
    @app_url = APP_URL
    @contact_email = CONTACT_EMAIL
    mail( :subject => "[#{@app_name}] #{I18n.t('mailers.user.new_user')}",
          :to      => user.email_address )
  end

end
