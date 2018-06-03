class ContactMailer < ApplicationMailer
  def contact_mail(blog)
    @blog = blog

    mail to: blog.user.email , subject: "ブログ作成の確認メール"
  end
end
