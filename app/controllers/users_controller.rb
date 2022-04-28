class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit,:update,:info]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users=User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  
  end
  def new
    @user=User.new
  end
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "unnamed (1).png",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def login_form
  end
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードがまちがっています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to request.referer
    else
      render("users/edit")
    end
  end


  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
 
  def info 
    @post = Post.find_by(id: params[:id])
    @user=User.find_by(id: params[:id])
    @user_post_ranks = User.where(id: Post.group(:user_id).order('count(user_id) desc').limit(7).pluck(:user_id))
  
    post_like_count = {}
    User.all.each do |user|
      post_like_count.store(user, Like.where(post_id: Post.where(user_id: user.id).limit(7).pluck(:id)).count)
    end
    @user_post_like_ranks = post_like_count.sort_by { |_, v| v }.reverse.to_h.keys
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
  def likes 
    @user=User.find_by(id: params[:id])
    @likes=Like.where(user_id: @user.id)
    @user_post_ranks = User.where(id: Post.group(:user_id).order('count(user_id) desc').limit(7).pluck(:user_id))
  
    post_like_count = {}
    User.all.each do |user|
      post_like_count.store(user, Like.where(post_id: Post.where(user_id: user.id).limit(7).pluck(:id)).count)
    end
    @user_post_like_ranks = post_like_count.sort_by { |_, v| v }.reverse.to_h.keys
  end
end
