class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :create,:update,:edit]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
    post_like_count = {}
    User.all.each do |user|
      post_like_count.store(user, Like.where(post_id: Post.where(user_id: user.id).limit(7).pluck(:id)).count)
    end
    @user_post_like_ranks = post_like_count.sort_by { |_, v| v }.reverse.to_h.keys
  
    @user_post_ranks = User.where(id: Post.group(:user_id).order('count(user_id) desc').limit(7).pluck(:user_id))
  end
  def show 
    @post = Post.find_by(id: params[:id])
    @user=@post.user
    @likes_count = Like.where(post_id: @post.id).count
    post_like_count = {}
    User.all.each do |user|
      post_like_count.store(user, Like.where(post_id: Post.where(user_id: user.id).limit(7).pluck(:id)).count)
    end
    @user_post_like_ranks = post_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    @user_post_ranks = User.where(id: Post.group(:user_id).order('count(user_id) desc').limit(7).pluck(:user_id))
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
 
  end
  def create
    @post=Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    @post.save
    redirect_to("/posts/index")
  end
  

  def edit
    @post= Post.find_by(id: params[:id])
    @user_post_ranks = User.where(id: Post.group(:user_id).order('count(user_id) desc').limit(7).pluck(:user_id))
    post_like_count = {}
    User.all.each do |user|
      post_like_count.store(user, Like.where(post_id: Post.where(user_id: user.id).limit(7).pluck(:id)).count)
    end
    @user_post_like_ranks = post_like_count.sort_by { |_, v| v }.reverse.to_h.keys
  end
  def update
    @post= Post.find_by(id: params[:id])
    @post.content= params[:content]
    @post.save
    redirect_to("/posts/#{@post.id}")
  end
  def destroy
    @post = Post.find_by(id: params[:id])
    @likes = Like.where(post_id: @post.id)
    @likes.each do |like|
      like.destroy
    end
    @comments = Comment.where(post_id: @post.id)
    @comments.each do |comment|
      comment.destroy
    end
    @post.destroy
    redirect_to("/posts/index")
    end
  
  


  end
