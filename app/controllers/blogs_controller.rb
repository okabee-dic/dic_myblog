class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:edit, :new, :confirm, :destroy, :update, :create]  
  def index
    @blogs = Blog.all
    
    #binding.pry
    #raise
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    
    if @blog.save
      #メール送信
      ContactMailer.contact_mail(@blog).deliver
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
    
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end
  
  def check_login
    if logged_in?
      
    else
      redirect_to new_session_path
    end
      
  end
  
  # idをキーとして値を取得するメソッド
  def set_blog
    @blog = Blog.find(params[:id])
  end
end