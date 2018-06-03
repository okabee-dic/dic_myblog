class ContactMailer < ApplicationMailer
  def contact_mail(blog)
    @blog = blog

    mail to: "okabee326@yahoo.co.jp", subject: "ブログ作成の確認メール"
  end
end
